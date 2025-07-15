"""
Dictation Feedback and Analytics Service

Provides real-time feedback, performance analytics, and adaptive difficulty
adjustment for dictation practice.
"""

import statistics
from typing import List, Dict, Optional, Tuple
from datetime import datetime, timedelta
from dataclasses import dataclass
import logging

from sqlalchemy import and_, or_, func

from .. import db
from ..models.dictation_practice import (
    DictationSession, DictationWordAttempt, DictationProgress,
    DictationDifficulty, HintType
)
from ..models.word import Word

logger = logging.getLogger(__name__)


@dataclass
class WordPerformance:
    """Performance metrics for a specific word"""
    word: str
    total_attempts: int
    correct_first_attempt: int
    total_correct: int
    average_attempts: float
    hint_usage_rate: float
    difficulty_score: float


@dataclass
class SessionFeedback:
    """Feedback for a dictation session"""
    strengths: List[str]
    weaknesses: List[str]
    suggestions: List[str]
    achievement_unlocked: Optional[str] = None
    next_difficulty_recommendation: Optional[DictationDifficulty] = None


class DictationFeedbackService:
    """Service for providing feedback and analytics"""
    
    def __init__(self):
        self.achievement_thresholds = {
            'perfect_session': {'accuracy': 100, 'hints': 0},
            'speed_demon': {'speed_score': 90},
            'consistent_performer': {'sessions': 5, 'avg_accuracy': 80},
            'vocabulary_master': {'mastered_words': 100},
            'streak_warrior': {'streak': 7}
        }
    
    def generate_session_feedback(self, session_id: int) -> SessionFeedback:
        """Generate comprehensive feedback for a completed session"""
        session = DictationSession.query.get(session_id)
        if not session or not session.is_completed:
            return None
        
        # Analyze word attempts
        word_attempts = DictationWordAttempt.query.filter_by(
            session_id=session_id,
            is_blanked=True
        ).all()
        
        strengths = []
        weaknesses = []
        suggestions = []
        
        # Analyze accuracy
        if session.accuracy_score >= 90:
            strengths.append("Excellent accuracy! You got most words correct.")
        elif session.accuracy_score >= 70:
            strengths.append("Good accuracy overall.")
        else:
            weaknesses.append("Accuracy needs improvement.")
            suggestions.append("Try practicing with easier sentences first.")
        
        # Analyze speed
        if session.speed_score >= 80:
            strengths.append("Great typing speed!")
        elif session.speed_score < 50:
            weaknesses.append("Typing speed could be improved.")
            suggestions.append("Practice typing common words to increase speed.")
        
        # Analyze hint usage
        hint_rate = (session.hints_used / session.blanked_words * 100) if session.blanked_words > 0 else 0
        if hint_rate == 0:
            strengths.append("Excellent! You didn't need any hints.")
        elif hint_rate > 50:
            weaknesses.append("Heavy reliance on hints.")
            suggestions.append("Try to guess words before using hints.")
        
        # Analyze problem words
        problem_words = self._identify_problem_words(word_attempts)
        if problem_words:
            weaknesses.append(f"Struggled with: {', '.join(problem_words[:3])}")
            suggestions.append("Focus on practicing these words in future sessions.")
        
        # Check perfect words
        perfect_words = [w for w in word_attempts if w.attempt_count == 1 and w.hint_count == 0]
        if len(perfect_words) >= session.blanked_words * 0.5:
            strengths.append("Strong vocabulary knowledge shown.")
        
        # Check achievements
        achievement = self._check_session_achievements(session)
        
        # Recommend next difficulty
        next_difficulty = self._recommend_difficulty(session)
        
        return SessionFeedback(
            strengths=strengths,
            weaknesses=weaknesses,
            suggestions=suggestions,
            achievement_unlocked=achievement,
            next_difficulty_recommendation=next_difficulty
        )
    
    def _identify_problem_words(self, word_attempts: List[DictationWordAttempt]) -> List[str]:
        """Identify words that caused difficulty"""
        problem_words = []
        
        for attempt in word_attempts:
            if attempt.attempt_count > 2 or attempt.hint_count > 1 or not attempt.is_correct:
                problem_words.append(attempt.original_word)
        
        return problem_words
    
    def _check_session_achievements(self, session: DictationSession) -> Optional[str]:
        """Check if session unlocked any achievements"""
        # Perfect session
        if session.accuracy_score == 100 and session.hints_used == 0:
            return "Perfect Session! 🏆"
        
        # Speed demon
        if session.speed_score >= 90:
            return "Speed Demon! ⚡"
        
        # No hints used
        if session.hints_used == 0 and session.blanked_words >= 5:
            return "Hint-Free Hero! 💪"
        
        return None
    
    def _recommend_difficulty(self, session: DictationSession) -> Optional[DictationDifficulty]:
        """Recommend difficulty for next session based on performance"""
        # Get user's recent performance
        recent_sessions = DictationSession.query.filter(
            and_(
                DictationSession.user_id == session.user_id,
                DictationSession.is_completed == True,
                DictationSession.difficulty == session.difficulty
            )
        ).order_by(DictationSession.created_at.desc()).limit(5).all()
        
        if len(recent_sessions) < 3:
            return None  # Not enough data
        
        # Calculate average accuracy
        avg_accuracy = statistics.mean([s.accuracy_score for s in recent_sessions])
        
        # Recommend based on performance
        current_diff = session.difficulty
        
        if avg_accuracy >= 85 and session.hints_used < session.blanked_words * 0.2:
            # Recommend harder difficulty
            if current_diff == DictationDifficulty.BEGINNER:
                return DictationDifficulty.ELEMENTARY
            elif current_diff == DictationDifficulty.ELEMENTARY:
                return DictationDifficulty.INTERMEDIATE
            elif current_diff == DictationDifficulty.INTERMEDIATE:
                return DictationDifficulty.ADVANCED
        elif avg_accuracy < 60:
            # Recommend easier difficulty
            if current_diff == DictationDifficulty.ADVANCED:
                return DictationDifficulty.INTERMEDIATE
            elif current_diff == DictationDifficulty.INTERMEDIATE:
                return DictationDifficulty.ELEMENTARY
            elif current_diff == DictationDifficulty.ELEMENTARY:
                return DictationDifficulty.BEGINNER
        
        return None  # Stay at current difficulty
    
    def get_word_performance_analytics(self, user_id: int, 
                                     time_range_days: int = 30) -> List[WordPerformance]:
        """Get detailed performance analytics for words"""
        cutoff_date = datetime.utcnow() - timedelta(days=time_range_days)
        
        # Query word attempts from recent sessions
        word_data = db.session.query(
            DictationWordAttempt.original_word,
            func.count(DictationWordAttempt.id).label('total_attempts'),
            func.sum(
                (DictationWordAttempt.attempt_count == 1).cast(db.Integer)
            ).label('first_attempt_correct'),
            func.sum(
                DictationWordAttempt.is_correct.cast(db.Integer)
            ).label('total_correct'),
            func.avg(DictationWordAttempt.attempt_count).label('avg_attempts'),
            func.avg(DictationWordAttempt.hint_count).label('avg_hints')
        ).join(
            DictationSession
        ).filter(
            and_(
                DictationSession.user_id == user_id,
                DictationSession.created_at >= cutoff_date,
                DictationWordAttempt.is_blanked == True
            )
        ).group_by(
            DictationWordAttempt.original_word
        ).all()
        
        performances = []
        for word, total, first_correct, total_correct, avg_attempts, avg_hints in word_data:
            # Calculate difficulty score (0-100, higher = more difficult)
            difficulty = 100 - ((first_correct / total * 50) if total > 0 else 0) - \
                        ((total_correct / total * 30) if total > 0 else 0) - \
                        (20 / avg_attempts if avg_attempts > 0 else 0)
            
            performance = WordPerformance(
                word=word,
                total_attempts=total,
                correct_first_attempt=first_correct or 0,
                total_correct=total_correct or 0,
                average_attempts=float(avg_attempts or 0),
                hint_usage_rate=float(avg_hints or 0),
                difficulty_score=max(0, min(100, difficulty))
            )
            performances.append(performance)
        
        # Sort by difficulty score (most difficult first)
        performances.sort(key=lambda x: x.difficulty_score, reverse=True)
        
        return performances
    
    def get_learning_curve_data(self, user_id: int, days: int = 30) -> Dict:
        """Get learning curve data for visualization"""
        cutoff_date = datetime.utcnow() - timedelta(days=days)
        
        sessions = DictationSession.query.filter(
            and_(
                DictationSession.user_id == user_id,
                DictationSession.is_completed == True,
                DictationSession.created_at >= cutoff_date
            )
        ).order_by(DictationSession.created_at).all()
        
        if not sessions:
            return {'dates': [], 'accuracy': [], 'speed': [], 'difficulty': []}
        
        # Group by date
        daily_data = {}
        for session in sessions:
            date_key = session.created_at.date().isoformat()
            
            if date_key not in daily_data:
                daily_data[date_key] = {
                    'accuracy': [],
                    'speed': [],
                    'difficulty': []
                }
            
            daily_data[date_key]['accuracy'].append(session.accuracy_score)
            daily_data[date_key]['speed'].append(session.speed_score)
            daily_data[date_key]['difficulty'].append(session.difficulty.value)
        
        # Calculate daily averages
        dates = []
        accuracy = []
        speed = []
        difficulty = []
        
        for date, data in sorted(daily_data.items()):
            dates.append(date)
            accuracy.append(statistics.mean(data['accuracy']))
            speed.append(statistics.mean(data['speed']))
            # Most common difficulty
            diff_counts = {}
            for d in data['difficulty']:
                diff_counts[d] = diff_counts.get(d, 0) + 1
            difficulty.append(max(diff_counts, key=diff_counts.get))
        
        return {
            'dates': dates,
            'accuracy': accuracy,
            'speed': speed,
            'difficulty': difficulty,
            'total_sessions': len(sessions)
        }
    
    def get_time_of_day_performance(self, user_id: int) -> Dict:
        """Analyze performance by time of day"""
        sessions = DictationSession.query.filter(
            and_(
                DictationSession.user_id == user_id,
                DictationSession.is_completed == True
            )
        ).all()
        
        if not sessions:
            return {}
        
        # Group by hour
        hourly_performance = {}
        for hour in range(24):
            hourly_performance[hour] = {
                'sessions': 0,
                'avg_accuracy': 0,
                'avg_speed': 0
            }
        
        for session in sessions:
            hour = session.created_at.hour
            hourly_performance[hour]['sessions'] += 1
            
            # Running average
            n = hourly_performance[hour]['sessions']
            hourly_performance[hour]['avg_accuracy'] = (
                (hourly_performance[hour]['avg_accuracy'] * (n - 1) + session.accuracy_score) / n
            )
            hourly_performance[hour]['avg_speed'] = (
                (hourly_performance[hour]['avg_speed'] * (n - 1) + session.speed_score) / n
            )
        
        # Find best performance times
        best_accuracy_hour = max(
            [(h, d['avg_accuracy']) for h, d in hourly_performance.items() if d['sessions'] > 0],
            key=lambda x: x[1],
            default=(None, 0)
        )[0]
        
        best_speed_hour = max(
            [(h, d['avg_speed']) for h, d in hourly_performance.items() if d['sessions'] > 0],
            key=lambda x: x[1],
            default=(None, 0)
        )[0]
        
        return {
            'hourly_data': hourly_performance,
            'best_accuracy_time': best_accuracy_hour,
            'best_speed_time': best_speed_hour,
            'most_active_hour': max(
                hourly_performance.items(),
                key=lambda x: x[1]['sessions']
            )[0] if sessions else None
        }
    
    def generate_progress_report(self, user_id: int, 
                               period_days: int = 7) -> Dict:
        """Generate comprehensive progress report"""
        progress = DictationProgress.query.filter_by(user_id=user_id).first()
        if not progress:
            return {'error': 'No progress data available'}
        
        # Get recent sessions
        cutoff_date = datetime.utcnow() - timedelta(days=period_days)
        recent_sessions = DictationSession.query.filter(
            and_(
                DictationSession.user_id == user_id,
                DictationSession.is_completed == True,
                DictationSession.created_at >= cutoff_date
            )
        ).all()
        
        if not recent_sessions:
            return {
                'period_days': period_days,
                'sessions_completed': 0,
                'message': 'No sessions completed in this period'
            }
        
        # Calculate metrics
        total_words = sum(s.blanked_words for s in recent_sessions)
        total_correct = sum(s.correct_words for s in recent_sessions)
        avg_accuracy = statistics.mean([s.accuracy_score for s in recent_sessions])
        avg_speed = statistics.mean([s.speed_score for s in recent_sessions])
        
        # Difficulty distribution
        difficulty_dist = {}
        for session in recent_sessions:
            diff = session.difficulty.value
            difficulty_dist[diff] = difficulty_dist.get(diff, 0) + 1
        
        # Compare with previous period
        prev_cutoff = cutoff_date - timedelta(days=period_days)
        prev_sessions = DictationSession.query.filter(
            and_(
                DictationSession.user_id == user_id,
                DictationSession.is_completed == True,
                DictationSession.created_at >= prev_cutoff,
                DictationSession.created_at < cutoff_date
            )
        ).all()
        
        improvement = {}
        if prev_sessions:
            prev_accuracy = statistics.mean([s.accuracy_score for s in prev_sessions])
            prev_speed = statistics.mean([s.speed_score for s in prev_sessions])
            improvement['accuracy'] = avg_accuracy - prev_accuracy
            improvement['speed'] = avg_speed - prev_speed
        
        return {
            'period_days': period_days,
            'sessions_completed': len(recent_sessions),
            'total_words_practiced': total_words,
            'total_correct': total_correct,
            'average_accuracy': round(avg_accuracy, 1),
            'average_speed': round(avg_speed, 1),
            'difficulty_distribution': difficulty_dist,
            'current_streak': progress.current_streak,
            'improvement': improvement,
            'problem_words': progress.problem_words[:10] if progress.problem_words else [],
            'recently_mastered': self._get_recently_mastered_words(user_id, period_days)
        }
    
    def _get_recently_mastered_words(self, user_id: int, days: int) -> List[str]:
        """Get words mastered in recent period"""
        cutoff_date = datetime.utcnow() - timedelta(days=days)
        
        # Query words with perfect performance
        mastered = db.session.query(
            DictationWordAttempt.original_word
        ).join(
            DictationSession
        ).filter(
            and_(
                DictationSession.user_id == user_id,
                DictationSession.created_at >= cutoff_date,
                DictationWordAttempt.is_blanked == True,
                DictationWordAttempt.attempt_count == 1,
                DictationWordAttempt.hint_count == 0,
                DictationWordAttempt.is_correct == True
            )
        ).group_by(
            DictationWordAttempt.original_word
        ).having(
            func.count(DictationWordAttempt.id) >= 3  # At least 3 perfect attempts
        ).limit(10).all()
        
        return [word[0] for word in mastered]
    
    def get_realtime_feedback(self, session_id: int, word_position: int,
                            user_input: str, is_correct: bool) -> Dict:
        """Get real-time feedback for word input"""
        feedback = {
            'is_correct': is_correct,
            'feedback_type': 'positive' if is_correct else 'corrective',
            'message': '',
            'visual_effect': None,
            'audio_cue': None
        }
        
        if is_correct:
            # Positive feedback
            word_attempt = DictationWordAttempt.query.filter_by(
                session_id=session_id,
                word_position=word_position
            ).first()
            
            if word_attempt and word_attempt.attempt_count == 1 and word_attempt.hint_count == 0:
                feedback['message'] = "Perfect! First try without hints!"
                feedback['visual_effect'] = 'sparkle'
                feedback['audio_cue'] = 'success_chime'
            elif word_attempt and word_attempt.attempt_count == 1:
                feedback['message'] = "Correct!"
                feedback['visual_effect'] = 'checkmark'
                feedback['audio_cue'] = 'success'
            else:
                feedback['message'] = "Good job! You got it right."
                feedback['visual_effect'] = 'checkmark'
                feedback['audio_cue'] = 'success_soft'
        else:
            # Corrective feedback
            feedback['message'] = "Not quite. Try again!"
            feedback['visual_effect'] = 'shake'
            feedback['audio_cue'] = 'error_soft'
            
            # Add specific feedback based on error type
            error_type = self._analyze_error_type(word_attempt.original_word, user_input)
            if error_type:
                feedback['error_type'] = error_type
                feedback['hint'] = self._get_error_specific_hint(error_type)
        
        return feedback
    
    def _analyze_error_type(self, correct_word: str, user_input: str) -> Optional[str]:
        """Analyze the type of error made"""
        if not user_input:
            return 'empty'
        
        correct_lower = correct_word.lower()
        input_lower = user_input.lower()
        
        # Check for case error only
        if correct_lower == input_lower and correct_word != user_input:
            return 'capitalization'
        
        # Check for minor spelling error (1-2 character difference)
        if self._calculate_edit_distance(correct_lower, input_lower) <= 2:
            return 'minor_spelling'
        
        # Check for word confusion (similar sounding)
        if self._are_similar_sounding(correct_word, user_input):
            return 'similar_sound'
        
        return 'major_error'
    
    def _calculate_edit_distance(self, s1: str, s2: str) -> int:
        """Calculate Levenshtein distance between two strings"""
        if len(s1) < len(s2):
            return self._calculate_edit_distance(s2, s1)
        
        if len(s2) == 0:
            return len(s1)
        
        previous_row = range(len(s2) + 1)
        for i, c1 in enumerate(s1):
            current_row = [i + 1]
            for j, c2 in enumerate(s2):
                insertions = previous_row[j + 1] + 1
                deletions = current_row[j] + 1
                substitutions = previous_row[j] + (c1 != c2)
                current_row.append(min(insertions, deletions, substitutions))
            previous_row = current_row
        
        return previous_row[-1]
    
    def _are_similar_sounding(self, word1: str, word2: str) -> bool:
        """Check if two words sound similar"""
        # Simple phonetic similarity check
        # In production, use a proper phonetic algorithm
        similar_sounds = [
            ('c', 'k'), ('s', 'c'), ('f', 'ph'), ('i', 'y'),
            ('ea', 'ee'), ('ou', 'ow'), ('igh', 'i')
        ]
        
        w1_lower = word1.lower()
        w2_lower = word2.lower()
        
        for sound1, sound2 in similar_sounds:
            w1_replaced = w1_lower.replace(sound1, sound2)
            w2_replaced = w2_lower.replace(sound1, sound2)
            
            if w1_replaced == w2_lower or w1_lower == w2_replaced:
                return True
        
        return False
    
    def _get_error_specific_hint(self, error_type: str) -> str:
        """Get hint based on error type"""
        hints = {
            'empty': "Type something! Every word starts with a letter.",
            'capitalization': "Check your capitalization - is it a proper noun?",
            'minor_spelling': "You're very close! Check your spelling carefully.",
            'similar_sound': "It sounds similar, but the spelling is different.",
            'major_error': "Take another look at the word structure."
        }
        
        return hints.get(error_type, "Keep trying!")