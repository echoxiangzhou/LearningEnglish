"""
Quality Validation Service

Provides comprehensive quality validation for generated sentences using
LanguageTool API and other validation mechanisms.
"""

import requests
import spacy
from typing import List, Dict, Tuple, Optional
from dataclasses import dataclass
from enum import Enum
import logging
import re
import time

from .sentence_generation_service import GeneratedSentence, DifficultyLevel

logger = logging.getLogger(__name__)


class ValidationSeverity(Enum):
    """Validation issue severity levels"""
    LOW = "low"
    MEDIUM = "medium"
    HIGH = "high"
    CRITICAL = "critical"


@dataclass
class ValidationIssue:
    """Represents a validation issue found in a sentence"""
    type: str
    severity: ValidationSeverity
    message: str
    position: int
    length: int
    suggestions: List[str]
    rule_id: str


@dataclass
class ValidationResult:
    """Result of sentence validation"""
    sentence: str
    is_valid: bool
    overall_score: float
    grammar_score: float
    readability_score: float
    appropriateness_score: float
    issues: List[ValidationIssue]
    processing_time: float


class QualityValidationService:
    """Service for validating sentence quality"""
    
    def __init__(self, languagetool_url: Optional[str] = None):
        self.languagetool_url = languagetool_url or "https://api.languagetool.org/v2"
        self.nlp = None
        self.word_frequency_dict = {}
        self._initialize_nlp()
        self._load_word_frequencies()
    
    def _initialize_nlp(self):
        """Initialize spaCy model for validation"""
        try:
            self.nlp = spacy.load("en_core_web_sm")
            logger.info("spaCy model loaded for validation")
        except OSError:
            logger.error("spaCy model not available for validation")
    
    def _load_word_frequencies(self):
        """Load word frequency data for appropriateness checking"""
        # Common words for elementary level (1000 most frequent words)
        elementary_words = [
            "the", "a", "an", "and", "or", "but", "in", "on", "at", "to", "for", "of", "with",
            "by", "from", "up", "about", "into", "through", "during", "before", "after",
            "above", "below", "between", "among", "i", "you", "he", "she", "it", "we", "they",
            "me", "him", "her", "us", "them", "my", "your", "his", "her", "its", "our", "their",
            "this", "that", "these", "those", "am", "is", "are", "was", "were", "being", "been",
            "be", "have", "has", "had", "do", "does", "did", "will", "would", "could", "should",
            "may", "might", "must", "can", "shall", "go", "come", "get", "make", "see", "know",
            "take", "think", "want", "give", "use", "find", "tell", "ask", "work", "seem",
            "feel", "try", "leave", "call", "good", "new", "first", "last", "long", "great",
            "little", "own", "other", "old", "right", "big", "high", "different", "small",
            "large", "next", "early", "young", "important", "few", "public", "bad", "same",
            "able", "man", "woman", "child", "people", "person", "family", "friend", "house",
            "home", "school", "car", "book", "water", "food", "tree", "dog", "cat", "run",
            "walk", "eat", "play", "read", "write", "sleep", "happy", "sad", "big", "small"
        ]
        
        # Assign frequency scores
        for i, word in enumerate(elementary_words):
            self.word_frequency_dict[word.lower()] = 1000 - i
    
    def validate_with_languagetool(self, text: str, language: str = "en-US") -> List[ValidationIssue]:
        """Validate text using LanguageTool API"""
        issues = []
        
        try:
            # Prepare request
            data = {
                'text': text,
                'language': language,
                'enabledOnly': 'false'
            }
            
            # Make API request with timeout
            response = requests.post(
                f"{self.languagetool_url}/check",
                data=data,
                timeout=10
            )
            
            if response.status_code == 200:
                result = response.json()
                
                for match in result.get('matches', []):
                    severity = self._map_languagetool_severity(match)
                    
                    issue = ValidationIssue(
                        type=match.get('rule', {}).get('category', {}).get('name', 'Unknown'),
                        severity=severity,
                        message=match.get('message', ''),
                        position=match.get('offset', 0),
                        length=match.get('length', 0),
                        suggestions=[rep.get('value', '') for rep in match.get('replacements', [])[:3]],
                        rule_id=match.get('rule', {}).get('id', '')
                    )
                    issues.append(issue)
            
            else:
                logger.warning(f"LanguageTool API request failed: {response.status_code}")
        
        except requests.exceptions.RequestException as e:
            logger.error(f"LanguageTool API error: {str(e)}")
        except Exception as e:
            logger.error(f"Unexpected error in LanguageTool validation: {str(e)}")
        
        return issues
    
    def _map_languagetool_severity(self, match: Dict) -> ValidationSeverity:
        """Map LanguageTool issue types to our severity levels"""
        rule_category = match.get('rule', {}).get('category', {}).get('name', '').lower()
        issue_type = match.get('rule', {}).get('issueType', '').lower()
        
        # Critical issues
        if any(keyword in rule_category for keyword in ['grammar', 'syntax']):
            return ValidationSeverity.CRITICAL
        
        # High severity
        if any(keyword in issue_type for keyword in ['misspelling', 'capitalization']):
            return ValidationSeverity.HIGH
        
        # Medium severity
        if any(keyword in rule_category for keyword in ['style', 'redundancy']):
            return ValidationSeverity.MEDIUM
        
        # Default to low severity
        return ValidationSeverity.LOW
    
    def validate_grammar_with_spacy(self, text: str) -> Tuple[float, List[ValidationIssue]]:
        """Validate grammar using spaCy analysis"""
        if not self.nlp:
            return 0.5, []
        
        doc = self.nlp(text)
        issues = []
        score = 1.0
        
        # Check for basic grammatical structures
        has_subject = any(token.dep_ in ["nsubj", "nsubjpass", "csubj"] for token in doc)
        has_verb = any(token.pos_ == "VERB" for token in doc)
        has_proper_punctuation = text.strip().endswith(('.', '!', '?'))
        
        # Deduct points for missing elements
        if not has_subject:
            score -= 0.3
            issues.append(ValidationIssue(
                type="Grammar",
                severity=ValidationSeverity.HIGH,
                message="Sentence appears to be missing a subject",
                position=0,
                length=len(text),
                suggestions=["Add a subject to the sentence"],
                rule_id="MISSING_SUBJECT"
            ))
        
        if not has_verb:
            score -= 0.3
            issues.append(ValidationIssue(
                type="Grammar",
                severity=ValidationSeverity.HIGH,
                message="Sentence appears to be missing a verb",
                position=0,
                length=len(text),
                suggestions=["Add a verb to the sentence"],
                rule_id="MISSING_VERB"
            ))
        
        if not has_proper_punctuation:
            score -= 0.2
            issues.append(ValidationIssue(
                type="Punctuation",
                severity=ValidationSeverity.MEDIUM,
                message="Sentence should end with proper punctuation",
                position=len(text.strip()),
                length=0,
                suggestions=["Add a period, exclamation mark, or question mark"],
                rule_id="MISSING_PUNCTUATION"
            ))
        
        # Check for sentence fragments
        if len([token for token in doc if token.dep_ == "ROOT"]) == 0:
            score -= 0.2
            issues.append(ValidationIssue(
                type="Grammar",
                severity=ValidationSeverity.MEDIUM,
                message="Sentence may be a fragment",
                position=0,
                length=len(text),
                suggestions=["Ensure the sentence is complete"],
                rule_id="SENTENCE_FRAGMENT"
            ))
        
        return max(score, 0.0), issues
    
    def calculate_readability_score(self, text: str, target_difficulty: DifficultyLevel) -> float:
        """Calculate readability score based on target difficulty"""
        words = text.split()
        sentences = len(re.findall(r'[.!?]+', text)) or 1
        
        # Calculate basic metrics
        avg_words_per_sentence = len(words) / sentences
        avg_syllables_per_word = sum(self._count_syllables(word) for word in words) / len(words) if words else 0
        
        # Simple readability score (Flesch-like)
        base_score = 206.835 - 1.015 * avg_words_per_sentence - 84.6 * avg_syllables_per_word
        normalized_score = max(0, min(100, base_score)) / 100.0
        
        # Adjust for target difficulty
        if target_difficulty == DifficultyLevel.ELEMENTARY:
            # Prefer shorter sentences and simpler words
            if avg_words_per_sentence <= 8 and avg_syllables_per_word <= 1.5:
                normalized_score += 0.2
        elif target_difficulty == DifficultyLevel.INTERMEDIATE:
            # Allow moderate complexity
            if 6 <= avg_words_per_sentence <= 12 and avg_syllables_per_word <= 2.0:
                normalized_score += 0.1
        # Advanced allows more complexity without penalty
        
        return min(normalized_score, 1.0)
    
    def _count_syllables(self, word: str) -> int:
        """Simple syllable counting heuristic"""
        word = word.lower().strip()
        if not word:
            return 0
        
        vowels = "aeiouy"
        syllables = 0
        prev_was_vowel = False
        
        for char in word:
            is_vowel = char in vowels
            if is_vowel and not prev_was_vowel:
                syllables += 1
            prev_was_vowel = is_vowel
        
        # Handle silent 'e'
        if word.endswith('e') and syllables > 1:
            syllables -= 1
        
        return max(syllables, 1)
    
    def calculate_appropriateness_score(self, text: str, target_difficulty: DifficultyLevel) -> float:
        """Calculate appropriateness score based on vocabulary level"""
        words = [word.lower().strip('.,!?;:"()[]') for word in text.split()]
        word_scores = []
        
        for word in words:
            if word in self.word_frequency_dict:
                # High frequency words get high scores for elementary
                freq_score = self.word_frequency_dict[word] / 1000.0
                word_scores.append(freq_score)
            else:
                # Unknown words get different scores based on difficulty
                if target_difficulty == DifficultyLevel.ELEMENTARY:
                    word_scores.append(0.2)  # Penalize unknown words
                elif target_difficulty == DifficultyLevel.INTERMEDIATE:
                    word_scores.append(0.6)  # Moderate penalty
                else:
                    word_scores.append(0.8)  # Advanced allows complex words
        
        return sum(word_scores) / len(word_scores) if word_scores else 0.5
    
    def validate_sentence(self, sentence: GeneratedSentence) -> ValidationResult:
        """Comprehensive sentence validation"""
        start_time = time.time()
        
        all_issues = []
        
        # Grammar validation with LanguageTool
        lt_issues = self.validate_with_languagetool(sentence.text)
        all_issues.extend(lt_issues)
        
        # Grammar validation with spaCy
        spacy_grammar_score, spacy_issues = self.validate_grammar_with_spacy(sentence.text)
        all_issues.extend(spacy_issues)
        
        # Calculate scores
        grammar_score = max(sentence.grammar_score, spacy_grammar_score)
        
        # Adjust grammar score based on critical issues
        critical_issues = [issue for issue in all_issues if issue.severity == ValidationSeverity.CRITICAL]
        if critical_issues:
            grammar_score *= 0.5
        
        readability_score = self.calculate_readability_score(sentence.text, sentence.difficulty)
        appropriateness_score = self.calculate_appropriateness_score(sentence.text, sentence.difficulty)
        
        # Calculate overall score
        overall_score = (
            grammar_score * 0.4 +
            readability_score * 0.3 +
            appropriateness_score * 0.2 +
            sentence.confidence * 0.1
        )
        
        # Determine if sentence is valid
        is_valid = (
            overall_score >= 0.6 and
            grammar_score >= 0.5 and
            len(critical_issues) == 0
        )
        
        processing_time = time.time() - start_time
        
        return ValidationResult(
            sentence=sentence.text,
            is_valid=is_valid,
            overall_score=overall_score,
            grammar_score=grammar_score,
            readability_score=readability_score,
            appropriateness_score=appropriateness_score,
            issues=all_issues,
            processing_time=processing_time
        )
    
    def batch_validate_sentences(self, sentences: List[GeneratedSentence]) -> List[ValidationResult]:
        """Validate multiple sentences"""
        results = []
        
        for sentence in sentences:
            try:
                result = self.validate_sentence(sentence)
                results.append(result)
            except Exception as e:
                logger.error(f"Error validating sentence '{sentence.text}': {str(e)}")
                # Create a failed validation result
                results.append(ValidationResult(
                    sentence=sentence.text,
                    is_valid=False,
                    overall_score=0.0,
                    grammar_score=0.0,
                    readability_score=0.0,
                    appropriateness_score=0.0,
                    issues=[],
                    processing_time=0.0
                ))
        
        return results
    
    def get_validation_summary(self, results: List[ValidationResult]) -> Dict:
        """Get summary statistics for validation results"""
        if not results:
            return {}
        
        valid_count = sum(1 for r in results if r.is_valid)
        
        return {
            "total_sentences": len(results),
            "valid_sentences": valid_count,
            "validation_rate": valid_count / len(results),
            "average_scores": {
                "overall": sum(r.overall_score for r in results) / len(results),
                "grammar": sum(r.grammar_score for r in results) / len(results),
                "readability": sum(r.readability_score for r in results) / len(results),
                "appropriateness": sum(r.appropriateness_score for r in results) / len(results)
            },
            "total_issues": sum(len(r.issues) for r in results),
            "issues_by_severity": {
                severity.value: sum(
                    len([issue for issue in r.issues if issue.severity == severity])
                    for r in results
                )
                for severity in ValidationSeverity
            },
            "average_processing_time": sum(r.processing_time for r in results) / len(results)
        }