"""
Comprehensive Analytics Models for Smart English Learning Platform

This module provides database models for tracking user progress, achievements,
error analysis, and learning recommendations across all learning modules
(dictation, vocabulary, and reading comprehension).
"""

from sqlalchemy import Enum
from app import db
from datetime import datetime, timedelta
from enum import Enum as PyEnum
from typing import Dict, Any, List, Optional
import json


class ModuleType(PyEnum):
    """Learning module types"""
    DICTATION = 'dictation'
    VOCABULARY = 'vocabulary'
    READING = 'reading'


class ActivityType(PyEnum):
    """Activity types within each module"""
    PRACTICE = 'practice'
    QUIZ = 'quiz'
    REVIEW = 'review'
    TEST = 'test'
    READING_SESSION = 'reading_session'
    COMPREHENSION_QUIZ = 'comprehension_quiz'


class CompletionStatus(PyEnum):
    """Session completion status"""
    IN_PROGRESS = 'in_progress'
    COMPLETED = 'completed'
    ABANDONED = 'abandoned'
    FAILED = 'failed'


class AchievementType(PyEnum):
    """Achievement categories"""
    STREAK = 'streak'
    ACCURACY = 'accuracy'
    MASTERY = 'mastery'
    VOLUME = 'volume'
    IMPROVEMENT = 'improvement'
    CONSISTENCY = 'consistency'
    EXPLORATION = 'exploration'


class ErrorCategory(PyEnum):
    """Error categorization for learning gap analysis"""
    SPELLING = 'spelling'
    GRAMMAR = 'grammar'
    VOCABULARY = 'vocabulary'
    PRONUNCIATION = 'pronunciation'
    COMPREHENSION = 'comprehension'
    LISTENING = 'listening'
    SPEED = 'speed'
    CONCENTRATION = 'concentration'


class RecommendationType(PyEnum):
    """Types of learning recommendations"""
    REVIEW_DUE = 'review_due'
    IMPROVE_ACCURACY = 'improve_accuracy'
    BUILD_STREAK = 'build_streak'
    LEARN_NEW_WORDS = 'learn_new_words'
    READ_MORE = 'read_more'
    PRACTICE_DICTATION = 'practice_dictation'
    TARGET_WEAKNESS = 'target_weakness'
    INCREASE_DIFFICULTY = 'increase_difficulty'


class UserProgress(db.Model):
    """
    Comprehensive progress tracking for all learning activities
    """
    __tablename__ = 'user_progress'
    
    id = db.Column(db.Integer, primary_key=True)
    user_id = db.Column(db.Integer, db.ForeignKey('users.id'), nullable=False)
    module_type = db.Column(Enum(ModuleType), nullable=False)
    activity_type = db.Column(Enum(ActivityType), nullable=False)
    session_start = db.Column(db.DateTime, default=datetime.utcnow)
    session_end = db.Column(db.DateTime)
    accuracy_rate = db.Column(db.Float, default=0.0)
    time_spent = db.Column(db.Integer, default=0)  # seconds
    mistakes_count = db.Column(db.Integer, default=0)
    hints_used = db.Column(db.Integer, default=0)
    completion_status = db.Column(Enum(CompletionStatus), default=CompletionStatus.IN_PROGRESS)
    
    # Module-specific data stored as JSON
    session_data = db.Column(db.JSON)
    
    # Performance metrics
    items_attempted = db.Column(db.Integer, default=0)
    items_correct = db.Column(db.Integer, default=0)
    difficulty_level = db.Column(db.Integer, default=1)
    
    # Timestamps
    created_at = db.Column(db.DateTime, default=datetime.utcnow)
    updated_at = db.Column(db.DateTime, default=datetime.utcnow, onupdate=datetime.utcnow)
    
    # Relationships
    user = db.relationship('User', backref='progress_sessions')
    
    # Indexes for performance
    __table_args__ = (
        db.Index('idx_user_module_date', 'user_id', 'module_type', 'session_start'),
        db.Index('idx_user_activity', 'user_id', 'activity_type'),
    )
    
    def to_dict(self) -> Dict[str, Any]:
        return {
            'id': self.id,
            'user_id': self.user_id,
            'module_type': self.module_type.value,
            'activity_type': self.activity_type.value,
            'session_start': self.session_start.isoformat() if self.session_start else None,
            'session_end': self.session_end.isoformat() if self.session_end else None,
            'accuracy_rate': self.accuracy_rate,
            'time_spent': self.time_spent,
            'mistakes_count': self.mistakes_count,
            'hints_used': self.hints_used,
            'completion_status': self.completion_status.value,
            'items_attempted': self.items_attempted,
            'items_correct': self.items_correct,
            'difficulty_level': self.difficulty_level,
            'session_data': self.session_data
        }
    
    def complete_session(self):
        """Mark session as completed and calculate final metrics"""
        self.session_end = datetime.utcnow()
        self.completion_status = CompletionStatus.COMPLETED
        if self.session_start and self.session_end:
            self.time_spent = int((self.session_end - self.session_start).total_seconds())
        if self.items_attempted > 0:
            self.accuracy_rate = (self.items_correct / self.items_attempted) * 100


class LearningStats(db.Model):
    """
    Aggregated learning statistics for efficient dashboard queries
    """
    __tablename__ = 'learning_stats'
    
    id = db.Column(db.Integer, primary_key=True)
    user_id = db.Column(db.Integer, db.ForeignKey('users.id'), nullable=False)
    
    # Aggregate metrics
    total_sessions = db.Column(db.Integer, default=0)
    total_time_spent = db.Column(db.Integer, default=0)  # seconds
    total_items_practiced = db.Column(db.Integer, default=0)
    total_correct_items = db.Column(db.Integer, default=0)
    average_accuracy = db.Column(db.Float, default=0.0)
    
    # Streak tracking
    current_streak = db.Column(db.Integer, default=0)
    longest_streak = db.Column(db.Integer, default=0)
    last_activity_date = db.Column(db.Date)
    
    # Module-specific stats
    dictation_sessions = db.Column(db.Integer, default=0)
    vocabulary_sessions = db.Column(db.Integer, default=0)
    reading_sessions = db.Column(db.Integer, default=0)
    
    dictation_accuracy = db.Column(db.Float, default=0.0)
    vocabulary_accuracy = db.Column(db.Float, default=0.0)
    reading_accuracy = db.Column(db.Float, default=0.0)
    
    # Improvement tracking
    improvement_trend = db.Column(db.Float, default=0.0)  # percentage change
    last_trend_calculation = db.Column(db.DateTime, default=datetime.utcnow)
    
    # Timestamps
    created_at = db.Column(db.DateTime, default=datetime.utcnow)
    updated_at = db.Column(db.DateTime, default=datetime.utcnow, onupdate=datetime.utcnow)
    
    # Relationships
    user = db.relationship('User', backref='learning_statistics')
    
    def to_dict(self) -> Dict[str, Any]:
        return {
            'id': self.id,
            'user_id': self.user_id,
            'total_sessions': self.total_sessions,
            'total_time_spent': self.total_time_spent,
            'total_items_practiced': self.total_items_practiced,
            'total_correct_items': self.total_correct_items,
            'average_accuracy': self.average_accuracy,
            'current_streak': self.current_streak,
            'longest_streak': self.longest_streak,
            'last_activity_date': self.last_activity_date.isoformat() if self.last_activity_date else None,
            'module_stats': {
                'dictation': {
                    'sessions': self.dictation_sessions,
                    'accuracy': self.dictation_accuracy
                },
                'vocabulary': {
                    'sessions': self.vocabulary_sessions,
                    'accuracy': self.vocabulary_accuracy
                },
                'reading': {
                    'sessions': self.reading_sessions,
                    'accuracy': self.reading_accuracy
                }
            },
            'improvement_trend': self.improvement_trend
        }
    
    def update_from_session(self, session: UserProgress):
        """Update aggregated stats from a completed session"""
        self.total_sessions += 1
        self.total_time_spent += session.time_spent
        self.total_items_practiced += session.items_attempted
        self.total_correct_items += session.items_correct
        
        # Recalculate average accuracy
        if self.total_items_practiced > 0:
            self.average_accuracy = (self.total_correct_items / self.total_items_practiced) * 100
        
        # Update module-specific stats
        if session.module_type == ModuleType.DICTATION:
            self.dictation_sessions += 1
            if self.dictation_sessions > 0:
                # Update module accuracy (simple moving average)
                self.dictation_accuracy = ((self.dictation_accuracy * (self.dictation_sessions - 1)) + 
                                         session.accuracy_rate) / self.dictation_sessions
        elif session.module_type == ModuleType.VOCABULARY:
            self.vocabulary_sessions += 1
            if self.vocabulary_sessions > 0:
                self.vocabulary_accuracy = ((self.vocabulary_accuracy * (self.vocabulary_sessions - 1)) + 
                                          session.accuracy_rate) / self.vocabulary_sessions
        elif session.module_type == ModuleType.READING:
            self.reading_sessions += 1
            if self.reading_sessions > 0:
                self.reading_accuracy = ((self.reading_accuracy * (self.reading_sessions - 1)) + 
                                       session.accuracy_rate) / self.reading_sessions
        
        # Update streak
        today = datetime.utcnow().date()
        if self.last_activity_date == today:
            # Same day, no streak change
            pass
        elif self.last_activity_date == today - timedelta(days=1):
            # Consecutive day, extend streak
            self.current_streak += 1
            self.longest_streak = max(self.longest_streak, self.current_streak)
        elif self.last_activity_date and self.last_activity_date < today - timedelta(days=1):
            # Streak broken, reset
            self.current_streak = 1
        else:
            # First activity
            self.current_streak = 1
            self.longest_streak = max(self.longest_streak, 1)
        
        self.last_activity_date = today
        self.updated_at = datetime.utcnow()


class UserAchievements(db.Model):
    """
    User achievements and badges system
    """
    __tablename__ = 'user_achievements'
    
    id = db.Column(db.Integer, primary_key=True)
    user_id = db.Column(db.Integer, db.ForeignKey('users.id'), nullable=False)
    achievement_type = db.Column(Enum(AchievementType), nullable=False)
    badge_name = db.Column(db.String(100), nullable=False)
    badge_description = db.Column(db.Text)
    badge_icon = db.Column(db.String(50))  # emoji or icon class
    unlocked_at = db.Column(db.DateTime, default=datetime.utcnow)
    progress_percentage = db.Column(db.Float, default=100.0)  # For partially completed achievements
    
    # Achievement criteria (stored as JSON)
    criteria = db.Column(db.JSON)
    
    # Achievement metadata
    points_awarded = db.Column(db.Integer, default=10)
    tier = db.Column(db.String(20), default='bronze')  # bronze, silver, gold, platinum
    is_displayed = db.Column(db.Boolean, default=True)
    
    # Timestamps
    created_at = db.Column(db.DateTime, default=datetime.utcnow)
    
    # Relationships
    user = db.relationship('User', backref='achievements')
    
    # Unique constraint
    __table_args__ = (
        db.UniqueConstraint('user_id', 'badge_name'),
    )
    
    def to_dict(self) -> Dict[str, Any]:
        return {
            'id': self.id,
            'user_id': self.user_id,
            'achievement_type': self.achievement_type.value,
            'badge_name': self.badge_name,
            'badge_description': self.badge_description,
            'badge_icon': self.badge_icon,
            'unlocked_at': self.unlocked_at.isoformat(),
            'progress_percentage': self.progress_percentage,
            'criteria': self.criteria,
            'points_awarded': self.points_awarded,
            'tier': self.tier,
            'is_displayed': self.is_displayed
        }


class ErrorAnalysis(db.Model):
    """
    Detailed error analysis for learning gap identification
    """
    __tablename__ = 'error_analysis'
    
    id = db.Column(db.Integer, primary_key=True)
    user_id = db.Column(db.Integer, db.ForeignKey('users.id'), nullable=False)
    error_type = db.Column(Enum(ErrorCategory), nullable=False)
    module_type = db.Column(Enum(ModuleType), nullable=False)
    
    # Error details
    word_or_concept = db.Column(db.String(200))  # The specific word or concept with errors
    user_response = db.Column(db.Text)  # What the user entered/did
    correct_response = db.Column(db.Text)  # What should have been entered/done
    context = db.Column(db.Text)  # Sentence or context where error occurred
    
    # Error frequency and patterns
    frequency = db.Column(db.Integer, default=1)
    first_occurrence = db.Column(db.DateTime, default=datetime.utcnow)
    last_occurrence = db.Column(db.DateTime, default=datetime.utcnow)
    
    # Error analysis
    difficulty_level = db.Column(db.Integer, default=1)
    is_systematic = db.Column(db.Boolean, default=False)  # Recurring pattern
    
    # Remediation tracking
    remediation_suggested = db.Column(db.Boolean, default=False)
    remediation_completed = db.Column(db.Boolean, default=False)
    remediation_date = db.Column(db.DateTime)
    
    # Timestamps
    created_at = db.Column(db.DateTime, default=datetime.utcnow)
    updated_at = db.Column(db.DateTime, default=datetime.utcnow, onupdate=datetime.utcnow)
    
    # Relationships
    user = db.relationship('User', backref='error_analyses')
    
    # Indexes
    __table_args__ = (
        db.Index('idx_user_error_type', 'user_id', 'error_type'),
        db.Index('idx_word_concept', 'word_or_concept'),
    )
    
    def to_dict(self) -> Dict[str, Any]:
        return {
            'id': self.id,
            'user_id': self.user_id,
            'error_type': self.error_type.value,
            'module_type': self.module_type.value,
            'word_or_concept': self.word_or_concept,
            'user_response': self.user_response,
            'correct_response': self.correct_response,
            'context': self.context,
            'frequency': self.frequency,
            'first_occurrence': self.first_occurrence.isoformat(),
            'last_occurrence': self.last_occurrence.isoformat(),
            'difficulty_level': self.difficulty_level,
            'is_systematic': self.is_systematic,
            'remediation_suggested': self.remediation_suggested,
            'remediation_completed': self.remediation_completed
        }
    
    def update_frequency(self):
        """Update error frequency and last occurrence"""
        self.frequency += 1
        self.last_occurrence = datetime.utcnow()
        self.updated_at = datetime.utcnow()
        
        # Mark as systematic if it occurs frequently
        if self.frequency >= 3:
            self.is_systematic = True


class LearningRecommendations(db.Model):
    """
    Personalized learning recommendations based on performance analysis
    """
    __tablename__ = 'learning_recommendations'
    
    id = db.Column(db.Integer, primary_key=True)
    user_id = db.Column(db.Integer, db.ForeignKey('users.id'), nullable=False)
    recommendation_type = db.Column(Enum(RecommendationType), nullable=False)
    
    # Recommendation details
    title = db.Column(db.String(200), nullable=False)
    description = db.Column(db.Text)
    action_url = db.Column(db.String(500))  # URL to recommended action
    
    # Content targeting
    content_id = db.Column(db.Integer)  # ID of specific content to practice
    module_type = db.Column(Enum(ModuleType))
    difficulty_level = db.Column(db.Integer)
    
    # Priority and scheduling
    priority = db.Column(db.String(20), default='medium')  # low, medium, high
    estimated_time_minutes = db.Column(db.Integer)
    
    # Recommendation lifecycle
    is_active = db.Column(db.Boolean, default=True)
    is_completed = db.Column(db.Boolean, default=False)
    completed_at = db.Column(db.DateTime)
    expires_at = db.Column(db.DateTime)
    
    # Analytics
    times_shown = db.Column(db.Integer, default=0)
    times_clicked = db.Column(db.Integer, default=0)
    
    # Timestamps
    created_at = db.Column(db.DateTime, default=datetime.utcnow)
    updated_at = db.Column(db.DateTime, default=datetime.utcnow, onupdate=datetime.utcnow)
    
    # Relationships
    user = db.relationship('User', backref='learning_recommendations')
    
    # Indexes
    __table_args__ = (
        db.Index('idx_user_active_recs', 'user_id', 'is_active'),
        db.Index('idx_user_priority', 'user_id', 'priority'),
    )
    
    def to_dict(self) -> Dict[str, Any]:
        return {
            'id': self.id,
            'user_id': self.user_id,
            'recommendation_type': self.recommendation_type.value,
            'title': self.title,
            'description': self.description,
            'action_url': self.action_url,
            'content_id': self.content_id,
            'module_type': self.module_type.value if self.module_type else None,
            'difficulty_level': self.difficulty_level,
            'priority': self.priority,
            'estimated_time_minutes': self.estimated_time_minutes,
            'is_active': self.is_active,
            'is_completed': self.is_completed,
            'completed_at': self.completed_at.isoformat() if self.completed_at else None,
            'expires_at': self.expires_at.isoformat() if self.expires_at else None,
            'times_shown': self.times_shown,
            'times_clicked': self.times_clicked
        }
    
    def mark_shown(self):
        """Record that this recommendation was shown to the user"""
        self.times_shown += 1
        self.updated_at = datetime.utcnow()
    
    def mark_clicked(self):
        """Record that this recommendation was clicked by the user"""
        self.times_clicked += 1
        self.updated_at = datetime.utcnow()
    
    def mark_completed(self):
        """Mark this recommendation as completed"""
        self.is_completed = True
        self.completed_at = datetime.utcnow()
        self.is_active = False
        self.updated_at = datetime.utcnow()


class AnalyticsCache(db.Model):
    """
    Cache for expensive analytics calculations
    """
    __tablename__ = 'analytics_cache'
    
    id = db.Column(db.Integer, primary_key=True)
    cache_key = db.Column(db.String(255), unique=True, nullable=False)
    cache_data = db.Column(db.JSON, nullable=False)
    user_id = db.Column(db.Integer, db.ForeignKey('users.id'))
    
    # Cache metadata
    expires_at = db.Column(db.DateTime, nullable=False)
    cache_type = db.Column(db.String(50))  # dashboard, timeline, stats, etc.
    
    # Timestamps
    created_at = db.Column(db.DateTime, default=datetime.utcnow)
    updated_at = db.Column(db.DateTime, default=datetime.utcnow, onupdate=datetime.utcnow)
    
    # Relationships
    user = db.relationship('User', backref='analytics_cache')
    
    # Indexes
    __table_args__ = (
        db.Index('idx_cache_key_expires', 'cache_key', 'expires_at'),
        db.Index('idx_user_cache_type', 'user_id', 'cache_type'),
    )
    
    @classmethod
    def get_cached_data(cls, cache_key: str) -> Optional[Dict[str, Any]]:
        """Get cached data if it hasn't expired"""
        cache_entry = cls.query.filter(
            cls.cache_key == cache_key,
            cls.expires_at > datetime.utcnow()
        ).first()
        
        return cache_entry.cache_data if cache_entry else None
    
    @classmethod
    def set_cached_data(cls, cache_key: str, data: Dict[str, Any], 
                       user_id: int = None, cache_type: str = None,
                       ttl_minutes: int = 15):
        """Set cached data with expiration"""
        expires_at = datetime.utcnow() + timedelta(minutes=ttl_minutes)
        
        # Remove existing cache entry
        cls.query.filter(cls.cache_key == cache_key).delete()
        
        # Create new cache entry
        cache_entry = cls(
            cache_key=cache_key,
            cache_data=data,
            user_id=user_id,
            cache_type=cache_type,
            expires_at=expires_at
        )
        
        db.session.add(cache_entry)
        db.session.commit()
    
    @classmethod
    def clear_user_cache(cls, user_id: int, cache_type: str = None):
        """Clear cache for a specific user"""
        query = cls.query.filter(cls.user_id == user_id)
        if cache_type:
            query = query.filter(cls.cache_type == cache_type)
        query.delete()
        db.session.commit()
    
    @classmethod
    def cleanup_expired(cls):
        """Remove expired cache entries"""
        cls.query.filter(cls.expires_at < datetime.utcnow()).delete()
        db.session.commit()