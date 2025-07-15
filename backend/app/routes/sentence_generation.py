"""
Sentence Generation API Routes

Provides REST API endpoints for sentence generation functionality.
"""

from flask import Blueprint, request, jsonify, current_app
from flask_jwt_extended import jwt_required, get_jwt_identity
from marshmallow import Schema, fields, validate, ValidationError
import logging

from app.services.sentence_generation_service import (
    SentenceGenerationService, DifficultyLevel, SentencePattern
)
from app.services.pattern_library_service import PatternLibraryService, GrammarComplexity
from app.services.quality_validation_service import QualityValidationService
from app import db

logger = logging.getLogger(__name__)

# Create blueprint
sentence_generation_bp = Blueprint('sentence_generation', __name__, url_prefix='/api/sentence-generation')

# Initialize services
sentence_service = SentenceGenerationService()
pattern_service = PatternLibraryService()
validation_service = QualityValidationService()


# Request/Response Schemas
class GenerateSentencesSchema(Schema):
    """Schema for sentence generation request"""
    target_word = fields.Str(required=True, validate=validate.Length(min=1, max=50))
    difficulty = fields.Str(validate=validate.OneOf([d.value for d in DifficultyLevel]), 
                           load_default=DifficultyLevel.ELEMENTARY.value)
    count = fields.Int(validate=validate.Range(min=1, max=20), load_default=5)
    pattern_types = fields.List(fields.Str(validate=validate.OneOf([p.value for p in SentencePattern])), 
                               load_default=None)
    validate_quality = fields.Bool(load_default=True)


class BatchGenerateSchema(Schema):
    """Schema for batch sentence generation"""
    word_list = fields.List(fields.Str(validate=validate.Length(min=1, max=50)), 
                           required=True, validate=validate.Length(min=1, max=50))
    difficulty = fields.Str(validate=validate.OneOf([d.value for d in DifficultyLevel]), 
                           load_default=DifficultyLevel.ELEMENTARY.value)
    sentences_per_word = fields.Int(validate=validate.Range(min=1, max=10), load_default=3)
    validate_quality = fields.Bool(load_default=True)


class AnalyzeWordSchema(Schema):
    """Schema for word analysis request"""
    word = fields.Str(required=True, validate=validate.Length(min=1, max=50))


class PatternQuerySchema(Schema):
    """Schema for pattern query"""
    difficulty = fields.Str(validate=validate.OneOf([d.value for d in DifficultyLevel]), load_default=None)
    pattern_type = fields.Str(validate=validate.OneOf([p.value for p in SentencePattern]), load_default=None)
    complexity = fields.Str(validate=validate.OneOf([c.value for c in GrammarComplexity]), load_default=None)


@sentence_generation_bp.route('/generate', methods=['POST'])
@jwt_required()
def generate_sentences():
    """Generate sentences for a target word"""
    try:
        # Validate request data
        schema = GenerateSentencesSchema()
        data = schema.load(request.json)
        
        # Parse difficulty level
        difficulty = DifficultyLevel(data['difficulty'])
        
        # Parse pattern types if provided
        pattern_types = None
        if data.get('pattern_types'):
            pattern_types = [SentencePattern(pt) for pt in data['pattern_types']]
        
        # Generate sentences
        sentences = sentence_service.generate_sentences_for_word(
            target_word=data['target_word'],
            difficulty=difficulty,
            count=data['count']
        )
        
        # Filter by pattern types if specified
        if pattern_types:
            sentences = [s for s in sentences if s.pattern in pattern_types]
        
        # Validate quality if requested
        validation_results = []
        if data['validate_quality']:
            validation_results = validation_service.batch_validate_sentences(sentences)
            # Filter out invalid sentences
            valid_indices = [i for i, result in enumerate(validation_results) if result.is_valid]
            sentences = [sentences[i] for i in valid_indices]
            validation_results = [validation_results[i] for i in valid_indices]
        
        # Format response
        response_data = {
            'success': True,
            'target_word': data['target_word'],
            'difficulty': difficulty.value,
            'generated_count': len(sentences),
            'sentences': [
                {
                    'text': sentence.text,
                    'pattern': sentence.pattern.value,
                    'difficulty': sentence.difficulty.value,
                    'confidence': sentence.confidence,
                    'grammar_score': sentence.grammar_score
                }
                for sentence in sentences
            ]
        }
        
        # Add validation results if available
        if validation_results:
            response_data['validation_results'] = [
                {
                    'sentence': result.sentence,
                    'is_valid': result.is_valid,
                    'overall_score': result.overall_score,
                    'grammar_score': result.grammar_score,
                    'readability_score': result.readability_score,
                    'appropriateness_score': result.appropriateness_score,
                    'issues_count': len(result.issues),
                    'critical_issues': len([i for i in result.issues if i.severity.value == 'critical'])
                }
                for result in validation_results
            ]
        
        return jsonify(response_data), 200
        
    except ValidationError as e:
        return jsonify({'success': False, 'errors': e.messages}), 400
    except Exception as e:
        logger.error(f"Error generating sentences: {str(e)}")
        return jsonify({'success': False, 'error': 'Internal server error'}), 500


@sentence_generation_bp.route('/batch-generate', methods=['POST'])
@jwt_required()
def batch_generate_sentences():
    """Generate sentences for multiple words"""
    try:
        # Validate request data
        schema = BatchGenerateSchema()
        data = schema.load(request.json)
        
        # Parse difficulty level
        difficulty = DifficultyLevel(data['difficulty'])
        
        # Generate sentences for all words
        results = sentence_service.batch_generate_sentences(
            word_list=data['word_list'],
            difficulty=difficulty,
            sentences_per_word=data['sentences_per_word']
        )
        
        # Validate quality if requested
        validation_summary = None
        if data['validate_quality']:
            all_sentences = []
            for word_sentences in results.values():
                all_sentences.extend(word_sentences)
            
            if all_sentences:
                validation_results = validation_service.batch_validate_sentences(all_sentences)
                validation_summary = validation_service.get_validation_summary(validation_results)
                
                # Filter results to keep only valid sentences
                sentence_index = 0
                for word in results:
                    word_sentences = results[word]
                    valid_sentences = []
                    for sentence in word_sentences:
                        if sentence_index < len(validation_results) and validation_results[sentence_index].is_valid:
                            valid_sentences.append(sentence)
                        sentence_index += 1
                    results[word] = valid_sentences
        
        # Format response
        response_data = {
            'success': True,
            'difficulty': difficulty.value,
            'words_processed': len(data['word_list']),
            'results': {
                word: [
                    {
                        'text': sentence.text,
                        'pattern': sentence.pattern.value,
                        'confidence': sentence.confidence,
                        'grammar_score': sentence.grammar_score
                    }
                    for sentence in sentences
                ]
                for word, sentences in results.items()
            },
            'total_sentences_generated': sum(len(sentences) for sentences in results.values())
        }
        
        if validation_summary:
            response_data['validation_summary'] = validation_summary
        
        return jsonify(response_data), 200
        
    except ValidationError as e:
        return jsonify({'success': False, 'errors': e.messages}), 400
    except Exception as e:
        logger.error(f"Error in batch generation: {str(e)}")
        return jsonify({'success': False, 'error': 'Internal server error'}), 500


@sentence_generation_bp.route('/analyze-word', methods=['POST'])
@jwt_required()
def analyze_word():
    """Analyze a word using spaCy NLP"""
    try:
        schema = AnalyzeWordSchema()
        data = schema.load(request.json)
        
        analysis = sentence_service.analyze_word(data['word'])
        
        if not analysis:
            return jsonify({
                'success': False,
                'error': 'Could not analyze the provided word'
            }), 400
        
        # Get similar words
        similar_words = sentence_service.get_similar_words(data['word'], limit=10)
        
        response_data = {
            'success': True,
            'word': data['word'],
            'analysis': analysis,
            'similar_words': similar_words
        }
        
        return jsonify(response_data), 200
        
    except ValidationError as e:
        return jsonify({'success': False, 'errors': e.messages}), 400
    except Exception as e:
        logger.error(f"Error analyzing word: {str(e)}")
        return jsonify({'success': False, 'error': 'Internal server error'}), 500


@sentence_generation_bp.route('/patterns', methods=['GET'])
@jwt_required()
def get_patterns():
    """Get available sentence patterns"""
    try:
        schema = PatternQuerySchema()
        args = schema.load(request.args)
        
        # Get all patterns
        all_patterns = pattern_service.patterns
        
        # Filter by criteria
        filtered_patterns = all_patterns
        
        if args.get('difficulty'):
            difficulty = DifficultyLevel(args['difficulty'])
            filtered_patterns = pattern_service.get_patterns_by_difficulty(difficulty)
        
        if args.get('pattern_type'):
            pattern_type = SentencePattern(args['pattern_type'])
            if args.get('difficulty'):
                # Intersection of both filters
                type_patterns = pattern_service.get_patterns_by_type(pattern_type)
                filtered_patterns = [p for p in filtered_patterns if p in type_patterns]
            else:
                filtered_patterns = pattern_service.get_patterns_by_type(pattern_type)
        
        if args.get('complexity'):
            complexity = GrammarComplexity(args['complexity'])
            filtered_patterns = [p for p in filtered_patterns if p.complexity == complexity]
        
        # Format response
        response_data = {
            'success': True,
            'patterns': [
                {
                    'id': pattern.id,
                    'pattern_type': pattern.pattern_type.value,
                    'template': pattern.template,
                    'difficulty': pattern.difficulty.value,
                    'complexity': pattern.complexity.value,
                    'example': pattern.example,
                    'variations_count': len(pattern.variations),
                    'weight': pattern.weight
                }
                for pattern in filtered_patterns
            ],
            'total_count': len(filtered_patterns)
        }
        
        return jsonify(response_data), 200
        
    except ValidationError as e:
        return jsonify({'success': False, 'errors': e.messages}), 400
    except Exception as e:
        logger.error(f"Error getting patterns: {str(e)}")
        return jsonify({'success': False, 'error': 'Internal server error'}), 500


@sentence_generation_bp.route('/patterns/stats', methods=['GET'])
@jwt_required()
def get_pattern_stats():
    """Get pattern library statistics"""
    try:
        stats = pattern_service.get_pattern_stats()
        
        return jsonify({
            'success': True,
            'stats': stats
        }), 200
        
    except Exception as e:
        logger.error(f"Error getting pattern stats: {str(e)}")
        return jsonify({'success': False, 'error': 'Internal server error'}), 500


@sentence_generation_bp.route('/validate', methods=['POST'])
@jwt_required()
def validate_sentence_quality():
    """Validate sentence quality"""
    try:
        data = request.json
        if not data or 'sentence' not in data:
            return jsonify({'success': False, 'error': 'Sentence text is required'}), 400
        
        sentence_text = data['sentence']
        difficulty = DifficultyLevel(data.get('difficulty', DifficultyLevel.ELEMENTARY.value))
        
        # Create a mock GeneratedSentence for validation
        from app.services.sentence_generation_service import GeneratedSentence, SentencePattern
        mock_sentence = GeneratedSentence(
            text=sentence_text,
            target_word=data.get('target_word', ''),
            pattern=SentencePattern.SVO,  # Default pattern
            difficulty=difficulty,
            confidence=0.8,
            grammar_score=0.8
        )
        
        # Validate the sentence
        validation_result = validation_service.validate_sentence(mock_sentence)
        
        response_data = {
            'success': True,
            'sentence': validation_result.sentence,
            'is_valid': validation_result.is_valid,
            'scores': {
                'overall': validation_result.overall_score,
                'grammar': validation_result.grammar_score,
                'readability': validation_result.readability_score,
                'appropriateness': validation_result.appropriateness_score
            },
            'issues': [
                {
                    'type': issue.type,
                    'severity': issue.severity.value,
                    'message': issue.message,
                    'position': issue.position,
                    'length': issue.length,
                    'suggestions': issue.suggestions
                }
                for issue in validation_result.issues
            ],
            'processing_time': validation_result.processing_time
        }
        
        return jsonify(response_data), 200
        
    except Exception as e:
        logger.error(f"Error validating sentence: {str(e)}")
        return jsonify({'success': False, 'error': 'Internal server error'}), 500


@sentence_generation_bp.route('/health', methods=['GET'])
def health_check():
    """Health check endpoint"""
    try:
        # Test spaCy model
        spacy_status = sentence_service.nlp is not None
        
        # Test pattern library
        pattern_count = len(pattern_service.patterns)
        
        return jsonify({
            'success': True,
            'status': 'healthy',
            'components': {
                'spacy_model': 'loaded' if spacy_status else 'not_loaded',
                'pattern_library': f'{pattern_count} patterns loaded',
                'validation_service': 'ready'
            }
        }), 200
        
    except Exception as e:
        logger.error(f"Health check error: {str(e)}")
        return jsonify({
            'success': False,
            'status': 'unhealthy',
            'error': str(e)
        }), 500