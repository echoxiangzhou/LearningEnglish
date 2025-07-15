"""
Intelligent Sentence Generation Service

This service provides comprehensive sentence generation capabilities using spaCy NLP
and pattern-based construction for educational content.
"""

import spacy
import random
import re
from typing import List, Dict, Tuple, Optional, Set
from dataclasses import dataclass
from enum import Enum
import logging

logger = logging.getLogger(__name__)


class DifficultyLevel(Enum):
    """Sentence difficulty levels based on target audience"""
    ELEMENTARY = "elementary"  # Grades 1-3
    INTERMEDIATE = "intermediate"  # Grades 4-6
    ADVANCED = "advanced"  # Grades 7-9


class SentencePattern(Enum):
    """Common sentence patterns for generation"""
    SVO = "subject_verb_object"  # The cat sleeps on the mat
    SVC = "subject_verb_complement"  # The flower is beautiful
    SVOO = "subject_verb_object_object"  # I gave him a book
    SV = "subject_verb"  # Birds fly
    SVA = "subject_verb_adverb"  # She runs quickly


@dataclass
class GenerationPattern:
    """Sentence generation pattern template"""
    pattern_type: SentencePattern
    template: str
    difficulty: DifficultyLevel
    pos_requirements: Dict[str, List[str]]
    example: str


@dataclass
class GeneratedSentence:
    """Generated sentence with metadata"""
    text: str
    target_word: str
    pattern: SentencePattern
    difficulty: DifficultyLevel
    confidence: float
    grammar_score: float


class SentenceGenerationService:
    """Core service for intelligent sentence generation"""
    
    def __init__(self):
        self.nlp = None
        self.patterns = []
        self.word_frequencies = {}
        self.collocations = {}
        self._initialize_nlp()
        self._load_patterns()
    
    def _initialize_nlp(self):
        """Initialize spaCy NLP model"""
        try:
            self.nlp = spacy.load("en_core_web_sm")
            logger.info("spaCy model loaded successfully")
        except OSError:
            logger.error("spaCy model 'en_core_web_sm' not found. Please install it with: python -m spacy download en_core_web_sm")
            raise
    
    def _load_patterns(self):
        """Load sentence generation patterns"""
        self.patterns = [
            GenerationPattern(
                pattern_type=SentencePattern.SVO,
                template="The {noun} {verb} {object}",
                difficulty=DifficultyLevel.ELEMENTARY,
                pos_requirements={
                    "noun": ["NOUN"],
                    "verb": ["VERB"],
                    "object": ["NOUN", "PRON"]
                },
                example="The cat eats fish"
            ),
            GenerationPattern(
                pattern_type=SentencePattern.SVC,
                template="The {noun} is {adjective}",
                difficulty=DifficultyLevel.ELEMENTARY,
                pos_requirements={
                    "noun": ["NOUN"],
                    "adjective": ["ADJ"]
                },
                example="The flower is beautiful"
            ),
            GenerationPattern(
                pattern_type=SentencePattern.SVA,
                template="{noun} {verb} {adverb}",
                difficulty=DifficultyLevel.INTERMEDIATE,
                pos_requirements={
                    "noun": ["NOUN", "PRON"],
                    "verb": ["VERB"],
                    "adverb": ["ADV"]
                },
                example="She runs quickly"
            ),
            GenerationPattern(
                pattern_type=SentencePattern.SVOO,
                template="{subject} {verb} {object1} {object2}",
                difficulty=DifficultyLevel.ADVANCED,
                pos_requirements={
                    "subject": ["NOUN", "PRON"],
                    "verb": ["VERB"],
                    "object1": ["NOUN", "PRON"],
                    "object2": ["NOUN"]
                },
                example="I gave him a book"
            )
        ]
    
    def analyze_word(self, word: str) -> Dict:
        """Analyze word using spaCy NLP"""
        if not self.nlp:
            raise RuntimeError("spaCy model not initialized")
        
        doc = self.nlp(word)
        token = doc[0] if doc else None
        
        if not token:
            return {}
        
        return {
            "text": token.text,
            "lemma": token.lemma_,
            "pos": token.pos_,
            "tag": token.tag_,
            "is_alpha": token.is_alpha,
            "is_stop": token.is_stop,
            "dependency": token.dep_,
            "has_vector": token.has_vector,
            "vector_norm": token.vector_norm if token.has_vector else 0
        }
    
    def get_similar_words(self, word: str, pos_filter: Optional[str] = None, limit: int = 10) -> List[str]:
        """Get similar words using spaCy word vectors"""
        if not self.nlp or not self.nlp.vocab[word].has_vector:
            return []
        
        word_vector = self.nlp.vocab[word].vector
        similar_words = []
        
        # Get most similar words from vocabulary
        for token in self.nlp.vocab:
            if (token.has_vector and 
                token.is_alpha and 
                not token.is_stop and 
                token.text.lower() != word.lower()):
                
                similarity = self.nlp.vocab[word].similarity(token)
                if similarity > 0.5:  # Threshold for similarity
                    similar_words.append((token.text, similarity))
        
        # Sort by similarity and return top results
        similar_words.sort(key=lambda x: x[1], reverse=True)
        return [word for word, _ in similar_words[:limit]]
    
    def generate_sentences_for_word(self, target_word: str, 
                                  difficulty: DifficultyLevel = DifficultyLevel.ELEMENTARY,
                                  count: int = 5) -> List[GeneratedSentence]:
        """Generate sentences for a target word"""
        if not self.nlp:
            raise RuntimeError("spaCy model not initialized")
        
        word_analysis = self.analyze_word(target_word)
        if not word_analysis:
            logger.warning(f"Could not analyze word: {target_word}")
            return []
        
        word_pos = word_analysis.get("pos", "")
        generated_sentences = []
        
        # Filter patterns by difficulty
        suitable_patterns = [p for p in self.patterns if p.difficulty == difficulty]
        
        for pattern in suitable_patterns:
            # Check if target word can fit in this pattern
            fitting_slots = self._find_fitting_slots(word_pos, pattern)
            
            for slot in fitting_slots:
                sentences = self._generate_from_pattern(target_word, word_analysis, pattern, slot)
                generated_sentences.extend(sentences)
                
                if len(generated_sentences) >= count:
                    break
            
            if len(generated_sentences) >= count:
                break
        
        return generated_sentences[:count]
    
    def _find_fitting_slots(self, word_pos: str, pattern: GenerationPattern) -> List[str]:
        """Find slots in pattern where word can fit based on POS"""
        fitting_slots = []
        
        for slot, required_pos in pattern.pos_requirements.items():
            if word_pos in required_pos:
                fitting_slots.append(slot)
        
        return fitting_slots
    
    def _generate_from_pattern(self, target_word: str, word_analysis: Dict,
                             pattern: GenerationPattern, target_slot: str) -> List[GeneratedSentence]:
        """Generate sentences from a specific pattern"""
        sentences = []
        
        # Create word bank for filling other slots
        word_bank = self._create_word_bank(pattern, target_slot)
        
        # Generate multiple variations
        for _ in range(3):  # Generate 3 variations per pattern
            sentence_parts = {target_slot: target_word}
            
            # Fill other slots
            for slot, pos_list in pattern.pos_requirements.items():
                if slot != target_slot:
                    word = self._select_appropriate_word(pos_list, word_bank, sentence_parts)
                    if word:
                        sentence_parts[slot] = word
            
            # Check if all slots are filled
            if len(sentence_parts) == len(pattern.pos_requirements):
                sentence_text = pattern.template.format(**sentence_parts)
                
                # Calculate confidence and grammar score
                confidence = self._calculate_confidence(sentence_text, target_word)
                grammar_score = self._evaluate_grammar(sentence_text)
                
                sentence = GeneratedSentence(
                    text=sentence_text,
                    target_word=target_word,
                    pattern=pattern.pattern_type,
                    difficulty=pattern.difficulty,
                    confidence=confidence,
                    grammar_score=grammar_score
                )
                sentences.append(sentence)
        
        return sentences
    
    def _create_word_bank(self, pattern: GenerationPattern, exclude_slot: str) -> Dict[str, List[str]]:
        """Create word bank for pattern generation"""
        word_bank = {
            "NOUN": ["cat", "dog", "book", "tree", "house", "car", "apple", "child", "school", "friend"],
            "VERB": ["is", "are", "runs", "walks", "eats", "plays", "reads", "writes", "sleeps", "works"],
            "ADJ": ["big", "small", "happy", "sad", "beautiful", "ugly", "fast", "slow", "good", "bad"],
            "ADV": ["quickly", "slowly", "carefully", "happily", "quietly", "loudly", "gently", "firmly"],
            "PRON": ["he", "she", "it", "they", "we", "I", "you"],
        }
        
        return word_bank
    
    def _select_appropriate_word(self, pos_list: List[str], word_bank: Dict[str, List[str]], 
                               existing_parts: Dict[str, str]) -> Optional[str]:
        """Select appropriate word for a slot"""
        for pos in pos_list:
            if pos in word_bank and word_bank[pos]:
                # Select random word that hasn't been used
                available_words = [w for w in word_bank[pos] if w not in existing_parts.values()]
                if available_words:
                    return random.choice(available_words)
        
        return None
    
    def _calculate_confidence(self, sentence: str, target_word: str) -> float:
        """Calculate confidence score for generated sentence"""
        # Simple confidence based on sentence length and word occurrence
        base_confidence = 0.8
        
        # Adjust based on sentence length (prefer medium length)
        words = sentence.split()
        length_factor = 1.0
        if len(words) < 4:
            length_factor = 0.8
        elif len(words) > 12:
            length_factor = 0.9
        
        return min(base_confidence * length_factor, 1.0)
    
    def _evaluate_grammar(self, sentence: str) -> float:
        """Evaluate grammar quality of generated sentence"""
        # Basic grammar evaluation
        # In production, this would integrate with LanguageTool API
        
        doc = self.nlp(sentence)
        
        # Check for basic grammatical features
        has_subject = any(token.dep_ in ["nsubj", "nsubjpass"] for token in doc)
        has_verb = any(token.pos_ == "VERB" for token in doc)
        proper_capitalization = sentence[0].isupper() if sentence else False
        ends_with_period = sentence.endswith('.') if sentence else False
        
        score = 0.0
        if has_subject:
            score += 0.3
        if has_verb:
            score += 0.3
        if proper_capitalization:
            score += 0.2
        if ends_with_period:
            score += 0.2
        
        return score
    
    def validate_sentence_quality(self, sentence: GeneratedSentence) -> bool:
        """Validate if generated sentence meets quality standards"""
        return (sentence.confidence >= 0.6 and 
                sentence.grammar_score >= 0.6 and
                len(sentence.text.split()) >= 3)
    
    def batch_generate_sentences(self, word_list: List[str], 
                               difficulty: DifficultyLevel = DifficultyLevel.ELEMENTARY,
                               sentences_per_word: int = 3) -> Dict[str, List[GeneratedSentence]]:
        """Generate sentences for multiple words"""
        results = {}
        
        for word in word_list:
            try:
                sentences = self.generate_sentences_for_word(word, difficulty, sentences_per_word)
                # Filter by quality
                quality_sentences = [s for s in sentences if self.validate_sentence_quality(s)]
                results[word] = quality_sentences
                
                logger.info(f"Generated {len(quality_sentences)} quality sentences for word: {word}")
                
            except Exception as e:
                logger.error(f"Failed to generate sentences for word {word}: {str(e)}")
                results[word] = []
        
        return results