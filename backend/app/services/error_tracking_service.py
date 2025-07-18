from datetime import datetime, timedelta
from sqlalchemy import func, and_, or_
from app import db
from app.models.word_error import WordError, ErrorPattern, ErrorReview, ErrorType
from app.models.word import Word
from app.models.sentence import Sentence
import difflib
import re
from typing import List, Dict, Tuple, Optional


class ErrorTrackingService:
    
    @staticmethod
    def record_word_error(user_id: int, expected_text: str, actual_text: str, 
                         practice_type: str, word_id: int = None, sentence_id: int = None,
                         context: str = None, session_id: str = None) -> WordError:
        """Record a word error and analyze the error type"""
        
        error_type = ErrorTrackingService._analyze_error_type(expected_text, actual_text)
        
        # Check if similar error already exists
        existing_error = WordError.query.filter_by(
            user_id=user_id,
            expected_text=expected_text,
            practice_type=practice_type,
            is_resolved=False
        ).first()
        
        if existing_error:
            # Update existing error
            existing_error.error_count += 1
            existing_error.last_error_date = datetime.utcnow()
            existing_error.actual_text = actual_text  # Update with latest attempt
            db.session.commit()
            return existing_error
        else:
            # Create new error record
            word_error = WordError(
                user_id=user_id,
                word_id=word_id,
                sentence_id=sentence_id,
                error_type=error_type,
                expected_text=expected_text,
                actual_text=actual_text,
                context=context,
                practice_type=practice_type,
                session_id=session_id
            )
            
            db.session.add(word_error)
            db.session.commit()
            
            # Analyze for patterns
            ErrorTrackingService._analyze_error_patterns(user_id, word_error)
            
            return word_error
    
    @staticmethod
    def _analyze_error_type(expected: str, actual: str) -> ErrorType:
        """Analyze the type of error based on expected vs actual text"""
        
        expected_clean = expected.lower().strip()
        actual_clean = actual.lower().strip()
        
        # Missing word (empty or significantly shorter)
        if not actual_clean or len(actual_clean) < len(expected_clean) * 0.3:
            return ErrorType.MISSING_WORD
        
        # Extra characters/words
        if len(actual_clean) > len(expected_clean) * 1.5:
            return ErrorType.EXTRA_WORD
        
        # Check for capitalization issues
        if expected.strip() == actual.strip():
            return ErrorType.CAPITALIZATION
        
        # Check for punctuation issues
        expected_no_punct = re.sub(r'[^\w\s]', '', expected)
        actual_no_punct = re.sub(r'[^\w\s]', '', actual)
        if expected_no_punct.lower() == actual_no_punct.lower():
            return ErrorType.PUNCTUATION
        
        # Word order issues
        expected_words = set(expected_clean.split())
        actual_words = set(actual_clean.split())
        if expected_words == actual_words:
            return ErrorType.WORD_ORDER
        
        # Default to spelling error
        return ErrorType.SPELLING
    
    @staticmethod
    def _analyze_error_patterns(user_id: int, word_error: WordError):
        """Analyze error for common patterns and update user's error patterns"""
        
        patterns = []
        expected = word_error.expected_text.lower()
        actual = word_error.actual_text.lower()
        
        # Silent letters pattern
        if 'silent' in ErrorTrackingService._get_phonetic_patterns(expected, actual):
            patterns.append('silent_letters')
        
        # Double consonants
        if re.search(r'(.)\1', expected) and not re.search(r'(.)\1', actual):
            patterns.append('double_consonants')
        
        # Common phonetic substitutions
        phonetic_patterns = ErrorTrackingService._check_phonetic_substitutions(expected, actual)
        patterns.extend(phonetic_patterns)
        
        # Update or create error patterns
        for pattern_type in patterns:
            existing_pattern = ErrorPattern.query.filter_by(
                user_id=user_id,
                pattern_type=pattern_type
            ).first()
            
            if existing_pattern:
                existing_pattern.frequency += 1
                existing_pattern.last_occurrence = datetime.utcnow()
            else:
                new_pattern = ErrorPattern(
                    user_id=user_id,
                    pattern_type=pattern_type,
                    description=ErrorTrackingService._get_pattern_description(pattern_type),
                    rule_or_example=f"Expected: {expected}, Got: {actual}"
                )
                db.session.add(new_pattern)
        
        db.session.commit()
    
    @staticmethod
    def _get_phonetic_patterns(expected: str, actual: str) -> List[str]:
        """Identify phonetic patterns in errors"""
        patterns = []
        
        # Common silent letter patterns
        silent_patterns = [
            ('gh', 'g'), ('kn', 'n'), ('wr', 'r'), ('mb', 'm'),
            ('alk', 'ak'), ('alf', 'af'), ('alm', 'am')
        ]
        
        for silent, spoken in silent_patterns:
            if silent in expected and spoken in actual:
                patterns.append('silent')
                break
        
        return patterns
    
    @staticmethod
    def _check_phonetic_substitutions(expected: str, actual: str) -> List[str]:
        """Check for common phonetic substitution patterns"""
        patterns = []
        
        substitutions = [
            ('ph', 'f', 'ph_to_f'),
            ('c', 'k', 'c_to_k'),
            ('s', 'z', 's_to_z'),
            ('ei', 'ie', 'ei_ie_confusion'),
            ('tion', 'sion', 'tion_sion'),
        ]
        
        for pattern1, pattern2, pattern_name in substitutions:
            if pattern1 in expected and pattern2 in actual:
                patterns.append(pattern_name)
            elif pattern2 in expected and pattern1 in actual:
                patterns.append(pattern_name)
        
        return patterns
    
    @staticmethod
    def _get_pattern_description(pattern_type: str) -> str:
        """Get description for error pattern"""
        descriptions = {
            'silent_letters': 'Difficulty with silent letters in words',
            'double_consonants': 'Difficulty with double consonant spelling',
            'ph_to_f': 'Confusion between "ph" and "f" sounds',
            'c_to_k': 'Confusion between "c" and "k" sounds',
            's_to_z': 'Confusion between "s" and "z" sounds',
            'ei_ie_confusion': 'Confusion with "ei" vs "ie" spelling',
            'tion_sion': 'Confusion between "-tion" and "-sion" endings'
        }
        return descriptions.get(pattern_type, f'Pattern: {pattern_type}')
    
    @staticmethod
    def get_user_errors(user_id: int, practice_type: str = None, 
                       include_resolved: bool = False) -> List[WordError]:
        """Get user's word errors"""
        
        query = WordError.query.filter_by(user_id=user_id)
        
        if practice_type:
            query = query.filter_by(practice_type=practice_type)
        
        if not include_resolved:
            query = query.filter_by(is_resolved=False)
        
        return query.order_by(WordError.last_error_date.desc()).all()
    
    @staticmethod
    def get_error_statistics(user_id: int) -> Dict:
        """Get comprehensive error statistics for user"""
        
        total_errors = WordError.query.filter_by(user_id=user_id).count()
        resolved_errors = WordError.query.filter_by(user_id=user_id, is_resolved=True).count()
        active_errors = total_errors - resolved_errors
        
        # Error types breakdown
        error_types = db.session.query(
            WordError.error_type,
            func.count(WordError.id).label('count')
        ).filter_by(user_id=user_id, is_resolved=False).group_by(WordError.error_type).all()
        
        # Most problematic words
        problematic_words = db.session.query(
            WordError.expected_text,
            func.sum(WordError.error_count).label('total_errors')
        ).filter_by(user_id=user_id, is_resolved=False).group_by(
            WordError.expected_text
        ).order_by(func.sum(WordError.error_count).desc()).limit(10).all()
        
        # Error patterns
        patterns = ErrorPattern.query.filter_by(user_id=user_id).order_by(
            ErrorPattern.frequency.desc()
        ).all()
        
        return {
            'total_errors': total_errors,
            'active_errors': active_errors,
            'resolved_errors': resolved_errors,
            'resolution_rate': resolved_errors / total_errors if total_errors > 0 else 0,
            'error_types': [{'type': et.value, 'count': count} for et, count in error_types],
            'problematic_words': [{'word': word, 'errors': errors} for word, errors in problematic_words],
            'patterns': [pattern.to_dict() for pattern in patterns]
        }
    
    @staticmethod
    def mark_error_resolved(error_id: int, user_id: int) -> bool:
        """Mark an error as resolved"""
        
        error = WordError.query.filter_by(id=error_id, user_id=user_id).first()
        if error:
            error.is_resolved = True
            error.resolved_date = datetime.utcnow()
            db.session.commit()
            return True
        return False
    
    @staticmethod
    def get_words_for_review(user_id: int, limit: int = 10) -> List[WordError]:
        """Get words that need review based on error frequency and recency"""
        
        # Get errors that haven't been resolved and have high frequency or recent occurrence
        errors = WordError.query.filter(
            and_(
                WordError.user_id == user_id,
                WordError.is_resolved == False,
                or_(
                    WordError.error_count >= 3,  # Frequent errors
                    WordError.last_error_date >= datetime.utcnow() - timedelta(days=7)  # Recent errors
                )
            )
        ).order_by(
            WordError.error_count.desc(),
            WordError.last_error_date.desc()
        ).limit(limit).all()
        
        return errors
    
    @staticmethod
    def create_review_session(user_id: int, word_error_ids: List[int]) -> List[ErrorReview]:
        """Create a review session for specific word errors"""
        
        reviews = []
        for word_error_id in word_error_ids:
            # Check if there's already a recent review
            recent_review = ErrorReview.query.filter(
                and_(
                    ErrorReview.user_id == user_id,
                    ErrorReview.word_error_id == word_error_id,
                    ErrorReview.review_date >= datetime.utcnow() - timedelta(days=1)
                )
            ).first()
            
            if not recent_review:
                review = ErrorReview(
                    user_id=user_id,
                    word_error_id=word_error_id,
                    was_correct=False,  # Will be updated when review is completed
                    next_review_date=datetime.utcnow() + timedelta(days=1)
                )
                db.session.add(review)
                reviews.append(review)
        
        db.session.commit()
        return reviews
    
    @staticmethod
    def update_review_result(review_id: int, was_correct: bool, 
                           response_time: float = None, confidence_level: int = None) -> ErrorReview:
        """Update the result of a review session"""
        
        review = ErrorReview.query.get(review_id)
        if review:
            review.was_correct = was_correct
            review.response_time = response_time
            review.confidence_level = confidence_level
            
            # Calculate next review date using spaced repetition
            if was_correct:
                # Increase interval for correct answers
                review.review_interval_days = min(review.review_interval_days * 2, 30)
            else:
                # Reset interval for incorrect answers
                review.review_interval_days = 1
            
            review.next_review_date = datetime.utcnow() + timedelta(days=review.review_interval_days)
            
            # If this was correct, check if we should mark the error as resolved
            if was_correct:
                # Check if user has had 3 consecutive correct reviews
                consecutive_correct = ErrorReview.query.filter(
                    and_(
                        ErrorReview.word_error_id == review.word_error_id,
                        ErrorReview.review_date >= datetime.utcnow() - timedelta(days=30)
                    )
                ).order_by(ErrorReview.review_date.desc()).limit(3).all()
                
                if len(consecutive_correct) >= 3 and all(r.was_correct for r in consecutive_correct):
                    ErrorTrackingService.mark_error_resolved(review.word_error_id, review.user_id)
            
            db.session.commit()
        
        return review