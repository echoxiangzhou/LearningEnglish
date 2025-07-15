"""
Tests for Sentence Generation System

Comprehensive test suite for sentence generation, pattern library, and quality validation.
"""

import pytest
import json
from unittest.mock import Mock, patch, MagicMock
from flask import Flask

# Import services and models
from app.services.sentence_generation_service import (
    SentenceGenerationService, DifficultyLevel, SentencePattern, GeneratedSentence
)
from app.services.pattern_library_service import (
    PatternLibraryService, ExtendedPattern, GrammarComplexity
)
from app.services.quality_validation_service import (
    QualityValidationService, ValidationResult, ValidationIssue, ValidationSeverity
)


class TestSentenceGenerationService:
    """Test cases for SentenceGenerationService"""
    
    @pytest.fixture
    def service(self):
        """Create service instance with mocked spaCy"""
        with patch('spacy.load') as mock_spacy:
            # Mock spaCy model
            mock_nlp = MagicMock()
            mock_token = MagicMock()
            mock_token.text = "test"
            mock_token.lemma_ = "test"
            mock_token.pos_ = "NOUN"
            mock_token.tag_ = "NN"
            mock_token.is_alpha = True
            mock_token.is_stop = False
            mock_token.dep_ = "nsubj"
            mock_token.has_vector = True
            mock_token.vector_norm = 1.0
            
            mock_doc = [mock_token]
            mock_nlp.return_value = mock_doc
            mock_spacy.return_value = mock_nlp
            
            service = SentenceGenerationService()
            return service
    
    def test_initialization(self, service):
        """Test service initialization"""
        assert service.nlp is not None
        assert len(service.patterns) > 0
        assert service.word_frequencies == {}
        assert service.collocations == {}
    
    def test_analyze_word(self, service):
        """Test word analysis functionality"""
        analysis = service.analyze_word("cat")
        
        assert analysis is not None
        assert analysis['text'] == "test"
        assert analysis['lemma'] == "test"
        assert analysis['pos'] == "NOUN"
        assert analysis['is_alpha'] is True
        assert analysis['is_stop'] is False
    
    def test_generate_sentences_for_word(self, service):
        """Test sentence generation for a single word"""
        sentences = service.generate_sentences_for_word(
            "cat", DifficultyLevel.ELEMENTARY, 3
        )
        
        assert isinstance(sentences, list)
        assert len(sentences) <= 3
        
        for sentence in sentences:
            assert isinstance(sentence, GeneratedSentence)
            assert sentence.target_word == "cat"
            assert sentence.difficulty == DifficultyLevel.ELEMENTARY
            assert isinstance(sentence.text, str)
            assert len(sentence.text) > 0
    
    def test_batch_generate_sentences(self, service):
        """Test batch sentence generation"""
        word_list = ["cat", "dog", "book"]
        results = service.batch_generate_sentences(
            word_list, DifficultyLevel.ELEMENTARY, 2
        )
        
        assert isinstance(results, dict)
        assert len(results) == 3
        
        for word in word_list:
            assert word in results
            assert isinstance(results[word], list)
            assert len(results[word]) <= 2
    
    def test_validate_sentence_quality(self, service):
        """Test sentence quality validation"""
        sentence = GeneratedSentence(
            text="The cat sleeps.",
            target_word="cat",
            pattern=SentencePattern.SV,
            difficulty=DifficultyLevel.ELEMENTARY,
            confidence=0.8,
            grammar_score=0.8
        )
        
        is_valid = service.validate_sentence_quality(sentence)
        assert isinstance(is_valid, bool)
    
    def test_calculate_confidence(self, service):
        """Test confidence calculation"""
        confidence = service._calculate_confidence("The cat sleeps.", "cat")
        
        assert isinstance(confidence, float)
        assert 0.0 <= confidence <= 1.0
    
    def test_evaluate_grammar(self, service):
        """Test grammar evaluation"""
        score = service._evaluate_grammar("The cat sleeps.")
        
        assert isinstance(score, float)
        assert 0.0 <= score <= 1.0


class TestPatternLibraryService:
    """Test cases for PatternLibraryService"""
    
    @pytest.fixture
    def service(self):
        """Create pattern library service instance"""
        return PatternLibraryService()
    
    def test_initialization(self, service):
        """Test service initialization"""
        assert len(service.patterns) > 0
        assert len(service.patterns_by_difficulty) > 0
        assert len(service.patterns_by_type) > 0
    
    def test_get_patterns_by_difficulty(self, service):
        """Test getting patterns by difficulty"""
        elementary_patterns = service.get_patterns_by_difficulty(DifficultyLevel.ELEMENTARY)
        
        assert isinstance(elementary_patterns, list)
        assert len(elementary_patterns) > 0
        
        for pattern in elementary_patterns:
            assert pattern.difficulty == DifficultyLevel.ELEMENTARY
    
    def test_get_patterns_by_type(self, service):
        """Test getting patterns by type"""
        svo_patterns = service.get_patterns_by_type(SentencePattern.SVO)
        
        assert isinstance(svo_patterns, list)
        
        for pattern in svo_patterns:
            assert pattern.pattern_type == SentencePattern.SVO
    
    def test_get_suitable_patterns(self, service):
        """Test getting suitable patterns for word"""
        suitable_patterns = service.get_suitable_patterns(
            "NOUN", DifficultyLevel.ELEMENTARY
        )
        
        assert isinstance(suitable_patterns, list)
        
        for pattern in suitable_patterns:
            assert pattern.difficulty == DifficultyLevel.ELEMENTARY
            # Check if NOUN fits in any slot
            fits = any("NOUN" in pos_list for pos_list in pattern.pos_requirements.values())
            assert fits
    
    def test_add_custom_pattern(self, service):
        """Test adding custom pattern"""
        custom_pattern = ExtendedPattern(
            id="test_custom",
            pattern_type=SentencePattern.SV,
            template="Test {noun} {verb}.",
            difficulty=DifficultyLevel.ELEMENTARY,
            complexity=GrammarComplexity.SIMPLE,
            pos_requirements={"noun": ["NOUN"], "verb": ["VERB"]},
            semantic_constraints={},
            example="Test cats sleep.",
            variations=[],
            weight=1.0
        )
        
        original_count = len(service.patterns)
        service.add_custom_pattern(custom_pattern)
        
        assert len(service.patterns) == original_count + 1
        assert any(p.id == "test_custom" for p in service.patterns)
    
    def test_remove_pattern(self, service):
        """Test removing pattern"""
        # Add a test pattern first
        test_pattern = ExtendedPattern(
            id="test_remove",
            pattern_type=SentencePattern.SV,
            template="Test {noun} {verb}.",
            difficulty=DifficultyLevel.ELEMENTARY,
            complexity=GrammarComplexity.SIMPLE,
            pos_requirements={"noun": ["NOUN"], "verb": ["VERB"]},
            semantic_constraints={},
            example="Test cats sleep.",
            variations=[],
            weight=1.0
        )
        
        service.add_custom_pattern(test_pattern)
        original_count = len(service.patterns)
        
        # Remove the pattern
        removed = service.remove_pattern("test_remove")
        
        assert removed is True
        assert len(service.patterns) == original_count - 1
        assert not any(p.id == "test_remove" for p in service.patterns)
    
    def test_get_pattern_stats(self, service):
        """Test getting pattern statistics"""
        stats = service.get_pattern_stats()
        
        assert isinstance(stats, dict)
        assert "total_patterns" in stats
        assert "by_difficulty" in stats
        assert "by_complexity" in stats
        assert "by_type" in stats
        
        assert stats["total_patterns"] == len(service.patterns)


class TestQualityValidationService:
    """Test cases for QualityValidationService"""
    
    @pytest.fixture
    def service(self):
        """Create validation service instance with mocked dependencies"""
        with patch('spacy.load') as mock_spacy:
            # Mock spaCy model
            mock_nlp = MagicMock()
            mock_token = MagicMock()
            mock_token.dep_ = "nsubj"
            mock_token.pos_ = "VERB"
            mock_doc = [mock_token]
            mock_nlp.return_value = mock_doc
            mock_spacy.return_value = mock_nlp
            
            service = QualityValidationService()
            return service
    
    @patch('requests.post')
    def test_validate_with_languagetool(self, mock_post, service):
        """Test LanguageTool validation"""
        # Mock LanguageTool API response
        mock_response = Mock()
        mock_response.status_code = 200
        mock_response.json.return_value = {
            'matches': [
                {
                    'rule': {
                        'category': {'name': 'Grammar'},
                        'id': 'TEST_RULE'
                    },
                    'message': 'Test error message',
                    'offset': 0,
                    'length': 4,
                    'replacements': [{'value': 'correction'}]
                }
            ]
        }
        mock_post.return_value = mock_response
        
        issues = service.validate_with_languagetool("Test sentence.")
        
        assert isinstance(issues, list)
        assert len(issues) == 1
        assert issues[0].type == "Grammar"
        assert issues[0].message == "Test error message"
    
    def test_validate_grammar_with_spacy(self, service):
        """Test spaCy grammar validation"""
        score, issues = service.validate_grammar_with_spacy("The cat sleeps.")
        
        assert isinstance(score, float)
        assert 0.0 <= score <= 1.0
        assert isinstance(issues, list)
    
    def test_calculate_readability_score(self, service):
        """Test readability score calculation"""
        score = service.calculate_readability_score(
            "The cat sleeps.", DifficultyLevel.ELEMENTARY
        )
        
        assert isinstance(score, float)
        assert 0.0 <= score <= 1.0
    
    def test_calculate_appropriateness_score(self, service):
        """Test appropriateness score calculation"""
        score = service.calculate_appropriateness_score(
            "The cat sleeps.", DifficultyLevel.ELEMENTARY
        )
        
        assert isinstance(score, float)
        assert 0.0 <= score <= 1.0
    
    def test_count_syllables(self, service):
        """Test syllable counting"""
        assert service._count_syllables("cat") == 1
        assert service._count_syllables("beautiful") >= 2
        assert service._count_syllables("") == 0
    
    @patch.object(QualityValidationService, 'validate_with_languagetool')
    @patch.object(QualityValidationService, 'validate_grammar_with_spacy')
    def test_validate_sentence(self, mock_spacy, mock_lt, service):
        """Test comprehensive sentence validation"""
        # Mock validation methods
        mock_lt.return_value = []
        mock_spacy.return_value = (0.8, [])
        
        sentence = GeneratedSentence(
            text="The cat sleeps.",
            target_word="cat",
            pattern=SentencePattern.SV,
            difficulty=DifficultyLevel.ELEMENTARY,
            confidence=0.8,
            grammar_score=0.8
        )
        
        result = service.validate_sentence(sentence)
        
        assert isinstance(result, ValidationResult)
        assert result.sentence == "The cat sleeps."
        assert isinstance(result.is_valid, bool)
        assert 0.0 <= result.overall_score <= 1.0
        assert 0.0 <= result.grammar_score <= 1.0
        assert 0.0 <= result.readability_score <= 1.0
        assert 0.0 <= result.appropriateness_score <= 1.0
    
    def test_batch_validate_sentences(self, service):
        """Test batch validation"""
        sentences = [
            GeneratedSentence(
                text="The cat sleeps.",
                target_word="cat",
                pattern=SentencePattern.SV,
                difficulty=DifficultyLevel.ELEMENTARY,
                confidence=0.8,
                grammar_score=0.8
            )
        ]
        
        with patch.object(service, 'validate_sentence') as mock_validate:
            mock_validate.return_value = ValidationResult(
                sentence="The cat sleeps.",
                is_valid=True,
                overall_score=0.8,
                grammar_score=0.8,
                readability_score=0.8,
                appropriateness_score=0.8,
                issues=[],
                processing_time=0.1
            )
            
            results = service.batch_validate_sentences(sentences)
            
            assert isinstance(results, list)
            assert len(results) == 1
            assert isinstance(results[0], ValidationResult)
    
    def test_get_validation_summary(self, service):
        """Test validation summary generation"""
        results = [
            ValidationResult(
                sentence="Test sentence.",
                is_valid=True,
                overall_score=0.8,
                grammar_score=0.8,
                readability_score=0.8,
                appropriateness_score=0.8,
                issues=[],
                processing_time=0.1
            )
        ]
        
        summary = service.get_validation_summary(results)
        
        assert isinstance(summary, dict)
        assert "total_sentences" in summary
        assert "valid_sentences" in summary
        assert "validation_rate" in summary
        assert "average_scores" in summary
        assert summary["total_sentences"] == 1
        assert summary["valid_sentences"] == 1
        assert summary["validation_rate"] == 1.0


class TestSentenceGenerationAPI:
    """Test cases for sentence generation API endpoints"""
    
    @pytest.fixture
    def client(self):
        """Create test client"""
        from app import create_app, db
        
        app = create_app()
        app.config['TESTING'] = True
        app.config['SQLALCHEMY_DATABASE_URI'] = 'sqlite:///:memory:'
        
        with app.test_client() as client:
            with app.app_context():
                db.create_all()
                yield client
    
    @pytest.fixture
    def auth_headers(self, client):
        """Create authentication headers"""
        # This would need proper JWT token generation in a real test
        return {'Authorization': 'Bearer test-token'}
    
    @patch('app.routes.sentence_generation.sentence_service')
    def test_generate_sentences_endpoint(self, mock_service, client, auth_headers):
        """Test sentence generation endpoint"""
        # Mock service response
        mock_sentence = GeneratedSentence(
            text="The cat sleeps.",
            target_word="cat",
            pattern=SentencePattern.SV,
            difficulty=DifficultyLevel.ELEMENTARY,
            confidence=0.8,
            grammar_score=0.8
        )
        mock_service.generate_sentences_for_word.return_value = [mock_sentence]
        
        # Mock JWT requirement
        with patch('flask_jwt_extended.jwt_required', lambda: lambda f: f):
            with patch('flask_jwt_extended.get_jwt_identity', return_value='test-user'):
                response = client.post('/api/sentence-generation/generate', 
                                     json={
                                         'target_word': 'cat',
                                         'difficulty': 'elementary',
                                         'count': 1,
                                         'validate_quality': False
                                     })
        
        assert response.status_code == 200
        data = json.loads(response.data)
        assert data['success'] is True
        assert data['target_word'] == 'cat'
        assert len(data['sentences']) == 1
    
    @patch('app.routes.sentence_generation.sentence_service')
    def test_batch_generate_endpoint(self, mock_service, client, auth_headers):
        """Test batch generation endpoint"""
        # Mock service response
        mock_service.batch_generate_sentences.return_value = {
            'cat': [GeneratedSentence(
                text="The cat sleeps.",
                target_word="cat",
                pattern=SentencePattern.SV,
                difficulty=DifficultyLevel.ELEMENTARY,
                confidence=0.8,
                grammar_score=0.8
            )]
        }
        
        # Mock JWT requirement
        with patch('flask_jwt_extended.jwt_required', lambda: lambda f: f):
            with patch('flask_jwt_extended.get_jwt_identity', return_value='test-user'):
                response = client.post('/api/sentence-generation/batch-generate',
                                     json={
                                         'word_list': ['cat'],
                                         'difficulty': 'elementary',
                                         'sentences_per_word': 1,
                                         'validate_quality': False
                                     })
        
        assert response.status_code == 200
        data = json.loads(response.data)
        assert data['success'] is True
        assert 'cat' in data['results']
    
    def test_health_check_endpoint(self, client):
        """Test health check endpoint"""
        with patch('app.routes.sentence_generation.sentence_service') as mock_service:
            mock_service.nlp = True  # Mock spaCy as loaded
            
            response = client.get('/api/sentence-generation/health')
            
            assert response.status_code == 200
            data = json.loads(response.data)
            assert data['success'] is True
            assert data['status'] == 'healthy'


# Integration test
class TestSentenceGenerationIntegration:
    """Integration tests for the complete sentence generation system"""
    
    @pytest.fixture
    def full_system(self):
        """Create complete system with all services"""
        with patch('spacy.load') as mock_spacy:
            # Mock spaCy
            mock_nlp = MagicMock()
            mock_token = MagicMock()
            mock_token.text = "cat"
            mock_token.lemma_ = "cat"
            mock_token.pos_ = "NOUN"
            mock_token.tag_ = "NN"
            mock_token.is_alpha = True
            mock_token.is_stop = False
            mock_token.dep_ = "nsubj"
            mock_token.has_vector = True
            mock_token.vector_norm = 1.0
            
            mock_doc = [mock_token]
            mock_nlp.return_value = mock_doc
            mock_spacy.return_value = mock_nlp
            
            sentence_service = SentenceGenerationService()
            pattern_service = PatternLibraryService()
            validation_service = QualityValidationService()
            
            return sentence_service, pattern_service, validation_service
    
    def test_complete_generation_workflow(self, full_system):
        """Test complete sentence generation workflow"""
        sentence_service, pattern_service, validation_service = full_system
        
        # 1. Analyze word
        analysis = sentence_service.analyze_word("cat")
        assert analysis is not None
        
        # 2. Get suitable patterns
        patterns = pattern_service.get_suitable_patterns(
            analysis['pos'], DifficultyLevel.ELEMENTARY
        )
        assert len(patterns) > 0
        
        # 3. Generate sentences
        sentences = sentence_service.generate_sentences_for_word(
            "cat", DifficultyLevel.ELEMENTARY, 3
        )
        assert len(sentences) > 0
        
        # 4. Validate quality
        validation_results = validation_service.batch_validate_sentences(sentences)
        assert len(validation_results) == len(sentences)
        
        # 5. Get summary
        summary = validation_service.get_validation_summary(validation_results)
        assert summary['total_sentences'] == len(sentences)