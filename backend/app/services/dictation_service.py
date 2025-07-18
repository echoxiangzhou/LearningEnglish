"""
Dictation Practice Service

Core service for dictation practice functionality including word blanking,
hint generation, and session management.
"""

import random
import re
from typing import List, Dict, Tuple, Optional, Set
from datetime import datetime, timedelta
import logging
from dataclasses import dataclass

from sqlalchemy import and_, or_, func
from sqlalchemy.orm import joinedload

from .. import db
from ..models.dictation_practice import (
    DictationSession, DictationWordAttempt, DictationProgress,
    DictationSettings, DictationDifficulty, HintType
)
from ..models.generated_sentence import GeneratedSentence, ApprovalStatus, DifficultyLevel
from ..models.word import Word
from ..models.user import User

logger = logging.getLogger(__name__)


@dataclass
class DictationWord:
    """Represents a word in dictation with its state"""
    position: int
    original: str
    display: str
    is_blanked: bool
    is_completed: bool = False
    user_input: str = ""
    hints_available: List[str] = None
    hints_used: List[str] = None
    
    def __post_init__(self):
        if self.hints_available is None:
            self.hints_available = [h.value for h in HintType]
        if self.hints_used is None:
            self.hints_used = []


@dataclass
class HintContent:
    """Content for a specific hint"""
    hint_type: HintType
    content: str
    cost: int  # Penalty points for using this hint


class DictationService:
    """Core service for dictation practice"""
    
    def __init__(self):
        self.word_frequency_cache = {}
        self._load_word_frequencies()
    
    def _load_word_frequencies(self):
        """Load word frequency data for intelligent blanking"""
        # Load common words (this would be from a database or file in production)
        common_words = [
            "the", "a", "an", "and", "or", "but", "in", "on", "at", "to", "for",
            "of", "with", "by", "from", "up", "about", "into", "through", "during",
            "i", "you", "he", "she", "it", "we", "they", "me", "him", "her"
        ]
        
        for i, word in enumerate(common_words):
            self.word_frequency_cache[word.lower()] = 1000 - i
    
    def create_dictation_session(self, user_id: int, sentence_id: int,
                               difficulty: DictationDifficulty = None,
                               blank_percentage: float = None) -> DictationSession:
        """Create a new dictation session"""
        try:
            # Get user settings
            settings = DictationSettings.query.filter_by(user_id=user_id).first()
            if not settings:
                # Create default settings
                settings = DictationSettings(user_id=user_id)
                db.session.add(settings)
                db.session.flush()
            
            # Get sentence
            sentence = GeneratedSentence.query.get(sentence_id)
            if not sentence:
                raise ValueError(f"Sentence {sentence_id} not found")
            
            # Determine difficulty and blank percentage
            if difficulty is None:
                difficulty = settings.preferred_difficulty
            
            if blank_percentage is None:
                blank_percentage = settings.blank_percentage
            
            # Parse sentence into words
            words = self._parse_sentence(sentence.text)
            total_words = len(words)
            
            # Calculate words to blank
            words_to_blank = int(total_words * blank_percentage)
            # Allow full blanking when blank_percentage is high (>= 0.85)
            if blank_percentage >= 0.85:
                words_to_blank = min(words_to_blank, total_words)  # Allow all words to be blanked
            else:
                words_to_blank = max(1, min(words_to_blank, total_words - 1))  # At least 1, leave at least 1
            
            # Create session
            session = DictationSession(
                user_id=user_id,
                sentence_id=sentence_id,
                difficulty=difficulty,
                playback_speed=settings.default_playback_speed,
                blank_percentage=blank_percentage,
                total_words=total_words,
                blanked_words=words_to_blank,
                session_data={
                    'sentence_text': sentence.text,
                    'target_word': sentence.target_word,
                    'sentence_difficulty': sentence.difficulty,
                    'chinese_translation': sentence.chinese_translation
                }
            )
            
            db.session.add(session)
            db.session.flush()
            
            # Create word attempts
            blanked_positions = self._select_words_to_blank(
                words, words_to_blank, sentence.target_word, difficulty
            )
            
            for i, word in enumerate(words):
                word_attempt = DictationWordAttempt(
                    session_id=session.id,
                    word_position=i,
                    original_word=word,
                    is_blanked=(i in blanked_positions)
                )
                db.session.add(word_attempt)
            
            db.session.commit()
            logger.info(f"Created dictation session {session.id} for user {user_id}")
            
            return session
            
        except Exception as e:
            db.session.rollback()
            logger.error(f"Error creating dictation session: {str(e)}")
            raise
    
    def _parse_sentence(self, sentence: str) -> List[str]:
        """Parse sentence into words, removing trailing punctuation"""
        import string
        
        words = []
        # Split by whitespace and clean up punctuation
        raw_tokens = sentence.split()
        
        for token in raw_tokens:
            # Remove leading and trailing whitespace
            word = token.strip()
            if word:
                # Remove trailing punctuation but keep contractions like "don't"
                cleaned_word = word
                # Remove punctuation from the end (but keep apostrophes in the middle for contractions)
                while cleaned_word and cleaned_word[-1] in string.punctuation and cleaned_word[-1] != "'":
                    cleaned_word = cleaned_word[:-1]
                
                # If there's still a word after cleaning, add it
                if cleaned_word:
                    words.append(cleaned_word)
        
        return words
    
    def _parse_sentence_with_punctuation(self, sentence: str) -> List[Dict]:
        """Parse sentence into tokens including words and punctuation"""
        import string
        import re
        
        tokens = []
        # Use regex to split while preserving punctuation
        # This pattern captures words and punctuation separately
        pattern = r"(\w+(?:'\w+)?|[" + re.escape(string.punctuation) + r"])"
        matches = re.findall(pattern, sentence)
        
        word_position = 0
        for match in matches:
            if match.strip():  # Skip empty matches
                if any(c.isalnum() for c in match):  # This is a word
                    tokens.append({
                        'type': 'word',
                        'text': match,
                        'word_position': word_position
                    })
                    word_position += 1
                else:  # This is punctuation
                    tokens.append({
                        'type': 'punctuation',
                        'text': match,
                        'word_position': None
                    })
        
        return tokens
    
    def _select_words_to_blank(self, words: List[str], num_to_blank: int,
                             target_word: str, difficulty: DictationDifficulty) -> Set[int]:
        """Intelligently select which words to blank"""
        positions = set()
        word_indices = list(range(len(words)))
        
        # Priority 1: Always include target word if present
        target_positions = []
        for i, word in enumerate(words):
            if word.lower() == target_word.lower():
                target_positions.append(i)
                positions.add(i)
        
        # Adjust remaining blanks
        remaining_blanks = num_to_blank - len(positions)
        
        if remaining_blanks > 0:
            # Score words based on various factors
            word_scores = []
            for i, word in enumerate(words):
                if i in positions:
                    continue
                
                score = self._calculate_blank_score(word, i, words, difficulty)
                word_scores.append((i, score))
            
            # Sort by score (higher score = more likely to blank)
            word_scores.sort(key=lambda x: x[1], reverse=True)
            
            # Select top scoring words
            for i, score in word_scores[:remaining_blanks]:
                positions.add(i)
        
        return positions
    
    def _calculate_blank_score(self, word: str, position: int, 
                             all_words: List[str], difficulty: DictationDifficulty) -> float:
        """Calculate score for blanking a word (higher = more likely to blank)"""
        score = 0.0
        
        # Word length factor (longer words are harder)
        word_length = len(word)
        if difficulty == DictationDifficulty.BEGINNER:
            score += max(0, 5 - word_length) * 0.2  # Prefer shorter words for beginners
        else:
            score += min(word_length / 10, 1.0) * 0.3  # Prefer longer words for advanced
        
        # Frequency factor (less common words are harder)
        frequency = self.word_frequency_cache.get(word.lower(), 0)
        if difficulty == DictationDifficulty.BEGINNER:
            score += (frequency / 1000) * 0.3  # Prefer common words for beginners
        else:
            score += (1 - frequency / 1000) * 0.4  # Prefer uncommon words for advanced
        
        # Position factor (words in the middle are easier to remember from context)
        relative_position = position / len(all_words)
        if 0.3 <= relative_position <= 0.7:
            score += 0.2
        
        # Part of speech factor (content words vs function words)
        if word.lower() in ["the", "a", "an", "is", "are", "was", "were"]:
            score -= 0.3 if difficulty != DictationDifficulty.BEGINNER else 0.1
        
        # Capitalize factor (proper nouns are memorable)
        if word[0].isupper() and position != 0:
            score -= 0.2
        
        # Add randomness for variety
        score += random.random() * 0.2
        
        return max(0, score)
    
    def get_session_state(self, session_id: int) -> Dict:
        """Get current state of a dictation session"""
        session = DictationSession.query.get(session_id)
        if not session:
            return None
        
        # Get all word attempts
        word_attempts = DictationWordAttempt.query.filter_by(
            session_id=session_id
        ).order_by(DictationWordAttempt.word_position).all()
        
        # Build word list with current state
        words = []
        for attempt in word_attempts:
            hints_used = attempt.hints_used or []
            word_dict = {
                'position': attempt.word_position,
                'original': attempt.original_word,
                'word': attempt.original_word,  # Add word field for compatibility
                'display': self._get_display_word(attempt),
                'is_blanked': attempt.is_blanked,
                'is_blank': attempt.is_blanked,  # Add is_blank for compatibility
                'is_completed': attempt.is_correct or False,
                'user_input': attempt.user_input or "",
                'hints_used': [HintType(h).value for h in hints_used] if hints_used else []
            }
            words.append(word_dict)
        
        # Parse sentence with punctuation for display
        sentence_text = session.session_data.get('sentence_text', '')
        tokens_with_punctuation = self._parse_sentence_with_punctuation(sentence_text)
        
        # Calculate progress
        completed_words = sum(1 for w in words if w['is_blanked'] and w['is_completed'])
        progress = (completed_words / session.blanked_words * 100) if session.blanked_words > 0 else 0
        
        return {
            'session_id': session.id,
            'sentence_id': session.sentence_id,
            'words': words,
            'tokens_with_punctuation': tokens_with_punctuation,  # Add punctuation info
            'total_words': session.total_words,
            'blanked_words': session.blanked_words,
            'completed_words': completed_words,
            'progress': progress,
            'playback_speed': session.playback_speed,
            'play_count': session.play_count,
            'hints_used': session.hints_used,
            'is_completed': session.is_completed,
            'accuracy_score': session.accuracy_score,
            'session_data': session.session_data
        }
    
    def _get_display_word(self, attempt: DictationWordAttempt) -> str:
        """Get display version of word based on current state"""
        if not attempt.is_blanked:
            return attempt.original_word
        
        if attempt.is_correct:
            return attempt.original_word
        
        # Check hints used
        if attempt.hints_used and HintType.FULL_WORD.value in attempt.hints_used:
            return attempt.original_word
        
        # Return blanks
        return '_' * len(attempt.original_word)
    
    def submit_word(self, session_id: int, position: int, user_input: str) -> Dict:
        """Submit user input for a word"""
        try:
            # Get session and word attempt
            session = DictationSession.query.get(session_id)
            if not session or session.is_completed:
                return {'success': False, 'error': 'Invalid or completed session'}
            
            word_attempt = DictationWordAttempt.query.filter_by(
                session_id=session_id,
                word_position=position
            ).first()
            
            if not word_attempt or not word_attempt.is_blanked:
                return {'success': False, 'error': 'Invalid word position'}
            
            # Record attempt
            is_correct = word_attempt.record_attempt(user_input)
            
            # Update session counts
            if is_correct and word_attempt.attempt_count == 1:
                session.correct_words += 1
            elif is_correct and word_attempt.attempt_count > 1:
                # Was incorrect before, now correct
                session.incorrect_words = max(0, session.incorrect_words - 1)
                session.correct_words += 1
            elif not is_correct and word_attempt.attempt_count == 1:
                session.incorrect_words += 1
            
            db.session.commit()
            
            # Check if session is complete
            total_completed = session.correct_words
            if total_completed >= session.blanked_words:
                session.complete_session()
                db.session.commit()
                
                # Update user progress
                self._update_user_progress(session)
            
            return {
                'success': True,
                'is_correct': is_correct,
                'attempt_count': word_attempt.attempt_count,
                'correct_word': word_attempt.original_word if not is_correct else None,
                'session_completed': session.is_completed,
                'accuracy_score': session.accuracy_score if session.is_completed else None
            }
            
        except Exception as e:
            db.session.rollback()
            logger.error(f"Error submitting word: {str(e)}")
            return {'success': False, 'error': str(e)}
    
    def get_hint(self, session_id: int, position: int, hint_type: HintType) -> Dict:
        """Get a hint for a specific word"""
        try:
            # Get session and word attempt
            session = DictationSession.query.get(session_id)
            if not session or session.is_completed:
                return {'success': False, 'error': 'Invalid or completed session'}
            
            word_attempt = DictationWordAttempt.query.filter_by(
                session_id=session_id,
                word_position=position
            ).first()
            
            if not word_attempt or not word_attempt.is_blanked:
                return {'success': False, 'error': 'Invalid word position'}
            
            # Check if hint already used
            if word_attempt.hints_used and hint_type.value in word_attempt.hints_used:
                return {'success': False, 'error': 'Hint already used'}
            
            # Generate hint content
            hint_content = self._generate_hint(word_attempt.original_word, hint_type)
            
            # Record hint usage
            word_attempt.use_hint(hint_type)
            session.hints_used += 1
            
            db.session.commit()
            
            return {
                'success': True,
                'hint_type': hint_type.value,
                'content': hint_content.content,
                'cost': hint_content.cost,
                'total_hints_used': session.hints_used
            }
            
        except Exception as e:
            db.session.rollback()
            logger.error(f"Error getting hint: {str(e)}")
            return {'success': False, 'error': str(e)}
    
    def _generate_hint(self, word: str, hint_type: HintType) -> HintContent:
        """Generate hint content for a word"""
        if hint_type == HintType.FIRST_LETTER:
            content = word[0].upper() if word else ""
            cost = 5
        
        elif hint_type == HintType.PHONETIC:
            # In production, this would use a phonetic dictionary
            content = self._get_phonetic_spelling(word)
            cost = 10
        
        elif hint_type == HintType.DEFINITION:
            # In production, this would use a dictionary API
            content = self._get_word_definition(word)
            cost = 15
        
        elif hint_type == HintType.FULL_WORD:
            content = word
            cost = 20
        
        else:
            content = ""
            cost = 0
        
        return HintContent(hint_type=hint_type, content=content, cost=cost)
    
    def _get_phonetic_spelling(self, word: str) -> str:
        """Get phonetic spelling of a word"""
        # Simplified phonetic representation
        # In production, use a proper phonetic dictionary
        phonetic_map = {
            'a': 'æ', 'e': 'ɛ', 'i': 'ɪ', 'o': 'ɒ', 'u': 'ʌ',
            'th': 'θ', 'sh': 'ʃ', 'ch': 'tʃ', 'ng': 'ŋ'
        }
        
        result = word.lower()
        for key, value in phonetic_map.items():
            result = result.replace(key, value)
        
        return f"/{result}/"
    
    def _get_word_definition(self, word: str) -> str:
        """Get definition of a word"""
        # In production, use a dictionary API
        # For now, return a placeholder
        word_obj = Word.query.filter_by(word=word.lower()).first()
        if word_obj and word_obj.definition:
            return word_obj.definition
        
        return f"Definition of '{word}'"
    
    def update_playback_speed(self, session_id: int, speed: float) -> bool:
        """Update playback speed for a session"""
        try:
            session = DictationSession.query.get(session_id)
            if not session:
                return False
            
            session.playback_speed = max(0.5, min(2.0, speed))  # Clamp between 0.5x and 2.0x
            db.session.commit()
            return True
            
        except Exception as e:
            db.session.rollback()
            logger.error(f"Error updating playback speed: {str(e)}")
            return False
    
    def record_audio_playback(self, session_id: int, duration: float) -> bool:
        """Record audio playback event"""
        try:
            session = DictationSession.query.get(session_id)
            if not session:
                return False
            
            session.play_count += 1
            session.total_playback_time += duration
            db.session.commit()
            return True
            
        except Exception as e:
            db.session.rollback()
            logger.error(f"Error recording playback: {str(e)}")
            return False
    
    def _update_user_progress(self, session: DictationSession):
        """Update user's overall progress after session completion"""
        try:
            progress = DictationProgress.query.filter_by(user_id=session.user_id).first()
            if not progress:
                progress = DictationProgress(user_id=session.user_id)
                db.session.add(progress)
            
            # Update progress from session
            progress.update_from_session(session)
            
            # Identify problem words and mastered words
            word_attempts = DictationWordAttempt.query.filter_by(
                session_id=session.id,
                is_blanked=True
            ).all()
            
            for attempt in word_attempts:
                if attempt.attempt_count > 2 or attempt.hint_count > 1:
                    # Problem word
                    progress.add_problem_word(attempt.original_word)
                elif attempt.attempt_count == 1 and attempt.hint_count == 0:
                    # Mastered word
                    progress.add_mastered_word(attempt.original_word)
            
            db.session.commit()
            logger.info(f"Updated progress for user {session.user_id}")
            
        except Exception as e:
            logger.error(f"Error updating user progress: {str(e)}")
            # Don't raise - progress update failure shouldn't break session completion
    
    def get_user_statistics(self, user_id: int) -> Dict:
        """Get comprehensive dictation statistics for a user"""
        progress = DictationProgress.query.filter_by(user_id=user_id).first()
        if not progress:
            return {
                'total_sessions': 0,
                'completed_sessions': 0,
                'average_accuracy': 0,
                'current_difficulty': DictationDifficulty.BEGINNER.value,
                'current_streak': 0,
                'problem_words': [],
                'mastered_words': []
            }
        
        # Recent sessions
        recent_sessions = DictationSession.query.filter_by(
            user_id=user_id,
            is_completed=True
        ).order_by(DictationSession.created_at.desc()).limit(10).all()
        
        recent_performance = [
            {
                'date': session.created_at.isoformat(),
                'accuracy': session.accuracy_score,
                'difficulty': session.difficulty.value,
                'words_practiced': session.blanked_words
            }
            for session in recent_sessions
        ]
        
        return {
            'total_sessions': progress.total_sessions,
            'completed_sessions': progress.completed_sessions,
            'total_words_practiced': progress.total_words_practiced,
            'average_accuracy': progress.average_accuracy,
            'average_speed_score': progress.average_speed_score,
            'current_difficulty': progress.current_difficulty.value,
            'current_streak': progress.current_streak,
            'longest_streak': progress.longest_streak,
            'problem_words': progress.problem_words or [],
            'mastered_words': progress.mastered_words or [],
            'recent_performance': recent_performance,
            'difficulty_breakdown': {
                'beginner': progress.beginner_sessions,
                'elementary': progress.elementary_sessions,
                'intermediate': progress.intermediate_sessions,
                'advanced': progress.advanced_sessions
            }
        }
    
    def get_practice_sentences(self, user_id: int, count: int = 5,
                             focus_problem_words: bool = True, category_ids: List[int] = None) -> List[GeneratedSentence]:
        """Get sentences for practice based on user's needs"""
        try:
            # Get user progress and settings
            progress = DictationProgress.query.filter_by(user_id=user_id).first()
            settings = DictationSettings.query.filter_by(user_id=user_id).first()
            
            if not progress:
                progress = DictationProgress(user_id=user_id)
                db.session.add(progress)
                db.session.flush()
            
            # Base query for approved sentences
            query = GeneratedSentence.query.filter_by(
                approval_status=ApprovalStatus.APPROVED
            )
            
            # Filter by categories if specified
            if category_ids:
                # Get the category mapping by querying existing categories
                category_data = db.session.query(
                    GeneratedSentence.source_category,
                    func.count(GeneratedSentence.id).label('count')
                ).group_by(GeneratedSentence.source_category).all()
                
                # Convert category IDs to source_category names
                valid_source_categories = []
                for category_id in category_ids:
                    if 1 <= category_id <= len(category_data):
                        source_category = category_data[category_id - 1][0]  # ID is 1-indexed
                        valid_source_categories.append(source_category)
                
                # Filter by valid source categories
                if valid_source_categories:
                    query = query.filter(GeneratedSentence.source_category.in_(valid_source_categories))
            
            # Filter by appropriate difficulty (using string values)
            difficulty_map = {
                DictationDifficulty.BEGINNER: 'elementary',
                DictationDifficulty.ELEMENTARY: 'elementary',
                DictationDifficulty.INTERMEDIATE: 'intermediate',
                DictationDifficulty.ADVANCED: 'advanced'
            }
            
            target_difficulty = difficulty_map.get(
                progress.current_difficulty, 
                'elementary'
            )
            query = query.filter_by(difficulty=target_difficulty)
            
            # Focus on problem words if enabled
            if focus_problem_words and progress.problem_words and settings and settings.focus_on_problem_words:
                # Get sentences containing problem words
                problem_word_filter = or_(
                    *[GeneratedSentence.target_word == word.lower() 
                      for word in progress.problem_words[:10]]  # Limit to recent 10
                )
                problem_sentences = query.filter(problem_word_filter).order_by(
                    GeneratedSentence.readability_score.desc().nulls_last(),
                    func.length(GeneratedSentence.text).asc()
                ).limit(count // 2).all()
                
                # Get remaining sentences ordered by difficulty
                remaining_count = count - len(problem_sentences)
                if remaining_count > 0:
                    exclude_ids = [s.id for s in problem_sentences]
                    remaining_sentences = query.filter(
                        ~GeneratedSentence.id.in_(exclude_ids)
                    ).order_by(
                        GeneratedSentence.readability_score.desc().nulls_last(),
                        func.length(GeneratedSentence.text).asc()
                    ).limit(remaining_count).all()
                    
                    return problem_sentences + remaining_sentences
                
                return problem_sentences
            
            # Get sentences ordered from easy to difficult
            return query.order_by(
                GeneratedSentence.readability_score.desc().nulls_last(),
                func.length(GeneratedSentence.text).asc()
            ).limit(count).all()
            
        except Exception as e:
            logger.error(f"Error getting practice sentences: {str(e)}")
            return []
    
    def get_session_review(self, session_id: int) -> Dict:
        """Get detailed review data for a completed session"""
        session = DictationSession.query.get(session_id)
        if not session or not session.is_completed:
            return None
        
        # Get all word attempts
        word_attempts = DictationWordAttempt.query.filter_by(
            session_id=session_id,
            is_blanked=True
        ).order_by(DictationWordAttempt.word_position).all()
        
        # Categorize words
        perfect_words = []  # First attempt, no hints
        good_words = []     # Eventually correct
        problem_words = []  # Multiple attempts or heavy hint usage
        
        for attempt in word_attempts:
            word_data = {
                'word': attempt.original_word,
                'attempts': attempt.attempt_count,
                'hints_used': attempt.hint_count,
                'time_to_correct': attempt.time_to_correct
            }
            
            if attempt.attempt_count == 1 and attempt.hint_count == 0:
                perfect_words.append(word_data)
            elif attempt.is_correct:
                good_words.append(word_data)
            else:
                problem_words.append(word_data)
        
        return {
            'session_id': session.id,
            'sentence': session.session_data.get('sentence_text', ''),
            'duration_seconds': session.duration_seconds,
            'accuracy_score': session.accuracy_score,
            'speed_score': session.speed_score,
            'overall_score': session.overall_score,
            'total_hints_used': session.hints_used,
            'audio_play_count': session.play_count,
            'perfect_words': perfect_words,
            'good_words': good_words,
            'problem_words': problem_words,
            'summary': {
                'total_words': session.blanked_words,
                'perfect_count': len(perfect_words),
                'good_count': len(good_words),
                'problem_count': len(problem_words)
            }
        }