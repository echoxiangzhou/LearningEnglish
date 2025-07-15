"""
Dictation Practice Model

Database models for storing dictation practice sessions and progress.
"""

from datetime import datetime
from sqlalchemy import Column, Integer, String, Text, Float, Boolean, DateTime, Enum as SQLEnum, ForeignKey, JSON
from sqlalchemy.orm import relationship
import enum

from .. import db


class DictationDifficulty(enum.Enum):
    """Dictation difficulty levels"""
    BEGINNER = "beginner"
    ELEMENTARY = "elementary"
    INTERMEDIATE = "intermediate"
    ADVANCED = "advanced"


class HintType(enum.Enum):
    """Types of hints available"""
    FIRST_LETTER = "first_letter"
    PHONETIC = "phonetic"
    DEFINITION = "definition"
    FULL_WORD = "full_word"


class DictationSession(db.Model):
    """Model for dictation practice sessions"""
    __tablename__ = 'dictation_sessions'
    
    id = Column(Integer, primary_key=True)
    user_id = Column(Integer, ForeignKey('users.id'), nullable=False, index=True)
    sentence_id = Column(Integer, ForeignKey('generated_sentences.id'), nullable=False)
    
    # Session configuration
    difficulty = Column(SQLEnum(DictationDifficulty), nullable=False)
    playback_speed = Column(Float, default=1.0)  # 0.5x, 0.75x, 1.0x
    blank_percentage = Column(Float, default=0.3)  # Percentage of words blanked
    
    # Session performance
    total_words = Column(Integer, nullable=False)
    blanked_words = Column(Integer, nullable=False)
    correct_words = Column(Integer, default=0)
    incorrect_words = Column(Integer, default=0)
    hints_used = Column(Integer, default=0)
    
    # Timing
    start_time = Column(DateTime, default=datetime.utcnow, nullable=False)
    end_time = Column(DateTime)
    duration_seconds = Column(Integer)
    
    # Audio playback tracking
    play_count = Column(Integer, default=0)
    total_playback_time = Column(Float, default=0.0)
    
    # Session state
    is_completed = Column(Boolean, default=False)
    is_abandoned = Column(Boolean, default=False)
    session_data = Column(JSON)  # Store detailed session state
    
    # Scoring
    accuracy_score = Column(Float, default=0.0)
    speed_score = Column(Float, default=0.0)
    overall_score = Column(Float, default=0.0)
    
    # Timestamps
    created_at = Column(DateTime, default=datetime.utcnow, nullable=False)
    updated_at = Column(DateTime, default=datetime.utcnow, onupdate=datetime.utcnow, nullable=False)
    
    # Relationships
    user = relationship("User", backref="dictation_sessions")
    sentence = relationship("GeneratedSentence", backref="dictation_sessions")
    word_attempts = relationship("DictationWordAttempt", backref="session", cascade="all, delete-orphan")
    
    def __repr__(self):
        return f'<DictationSession {self.id}: User {self.user_id}>'
    
    def calculate_scores(self):
        """Calculate session scores"""
        if self.blanked_words > 0:
            self.accuracy_score = (self.correct_words / self.blanked_words) * 100
        
        # Speed score based on completion time vs expected time
        if self.duration_seconds and self.total_words > 0:
            expected_seconds = self.total_words * 3  # 3 seconds per word baseline
            self.speed_score = min(100, (expected_seconds / self.duration_seconds) * 100)
        
        # Overall score factors in accuracy, speed, and hint usage
        hint_penalty = min(self.hints_used * 5, 30)  # Max 30% penalty for hints
        self.overall_score = (self.accuracy_score * 0.7 + self.speed_score * 0.3) - hint_penalty
        self.overall_score = max(0, self.overall_score)  # Ensure non-negative
    
    def complete_session(self):
        """Mark session as completed and calculate final scores"""
        self.is_completed = True
        self.end_time = datetime.utcnow()
        
        if self.start_time:
            delta = self.end_time - self.start_time
            self.duration_seconds = int(delta.total_seconds())
        
        self.calculate_scores()


class DictationWordAttempt(db.Model):
    """Model for individual word attempts in dictation"""
    __tablename__ = 'dictation_word_attempts'
    
    id = Column(Integer, primary_key=True)
    session_id = Column(Integer, ForeignKey('dictation_sessions.id'), nullable=False, index=True)
    
    # Word information
    word_position = Column(Integer, nullable=False)  # Position in sentence
    original_word = Column(String(100), nullable=False)
    is_blanked = Column(Boolean, default=False)
    
    # User attempts
    user_input = Column(String(100))
    is_correct = Column(Boolean)
    attempt_count = Column(Integer, default=0)
    
    # Hints used
    hints_used = Column(JSON)  # List of hint types used
    hint_count = Column(Integer, default=0)
    
    # Timing
    first_attempt_time = Column(DateTime)
    correct_attempt_time = Column(DateTime)
    time_to_correct = Column(Integer)  # Seconds
    
    # Timestamps
    created_at = Column(DateTime, default=datetime.utcnow, nullable=False)
    updated_at = Column(DateTime, default=datetime.utcnow, onupdate=datetime.utcnow, nullable=False)
    
    def __repr__(self):
        return f'<DictationWordAttempt {self.id}: {self.original_word}>'
    
    def record_attempt(self, user_input):
        """Record a user attempt for this word"""
        self.attempt_count += 1
        self.user_input = user_input
        
        if not self.first_attempt_time:
            self.first_attempt_time = datetime.utcnow()
        
        # Check correctness (case-insensitive)
        self.is_correct = user_input.lower().strip() == self.original_word.lower().strip()
        
        if self.is_correct and not self.correct_attempt_time:
            self.correct_attempt_time = datetime.utcnow()
            if self.first_attempt_time:
                delta = self.correct_attempt_time - self.first_attempt_time
                self.time_to_correct = int(delta.total_seconds())
        
        return self.is_correct
    
    def use_hint(self, hint_type: HintType):
        """Record hint usage"""
        if not self.hints_used:
            self.hints_used = []
        
        if hint_type.value not in self.hints_used:
            self.hints_used.append(hint_type.value)
            self.hint_count += 1


class DictationProgress(db.Model):
    """Model for tracking user's overall dictation progress"""
    __tablename__ = 'dictation_progress'
    
    id = Column(Integer, primary_key=True)
    user_id = Column(Integer, ForeignKey('users.id'), unique=True, nullable=False, index=True)
    
    # Overall statistics
    total_sessions = Column(Integer, default=0)
    completed_sessions = Column(Integer, default=0)
    total_words_practiced = Column(Integer, default=0)
    total_words_correct = Column(Integer, default=0)
    
    # Performance metrics
    average_accuracy = Column(Float, default=0.0)
    average_speed_score = Column(Float, default=0.0)
    average_overall_score = Column(Float, default=0.0)
    
    # Difficulty progression
    current_difficulty = Column(SQLEnum(DictationDifficulty), default=DictationDifficulty.BEGINNER)
    beginner_sessions = Column(Integer, default=0)
    elementary_sessions = Column(Integer, default=0)
    intermediate_sessions = Column(Integer, default=0)
    advanced_sessions = Column(Integer, default=0)
    
    # Word-specific tracking
    problem_words = Column(JSON)  # List of frequently missed words
    mastered_words = Column(JSON)  # List of consistently correct words
    
    # Streak tracking
    current_streak = Column(Integer, default=0)
    longest_streak = Column(Integer, default=0)
    last_practice_date = Column(DateTime)
    
    # Achievement milestones
    achievements = Column(JSON)  # List of unlocked achievements
    milestone_data = Column(JSON)  # Additional milestone tracking
    
    # Timestamps
    created_at = Column(DateTime, default=datetime.utcnow, nullable=False)
    updated_at = Column(DateTime, default=datetime.utcnow, onupdate=datetime.utcnow, nullable=False)
    
    # Relationships
    user = relationship("User", backref="dictation_progress", uselist=False)
    
    def __repr__(self):
        return f'<DictationProgress {self.id}: User {self.user_id}>'
    
    def update_from_session(self, session: DictationSession):
        """Update progress based on completed session"""
        if not session.is_completed:
            return
        
        # Update session counts
        self.total_sessions += 1
        self.completed_sessions += 1
        
        # Update word counts
        self.total_words_practiced += session.blanked_words
        self.total_words_correct += session.correct_words
        
        # Update difficulty-specific counts
        if session.difficulty == DictationDifficulty.BEGINNER:
            self.beginner_sessions += 1
        elif session.difficulty == DictationDifficulty.ELEMENTARY:
            self.elementary_sessions += 1
        elif session.difficulty == DictationDifficulty.INTERMEDIATE:
            self.intermediate_sessions += 1
        elif session.difficulty == DictationDifficulty.ADVANCED:
            self.advanced_sessions += 1
        
        # Recalculate averages
        if self.completed_sessions > 0:
            # Calculate weighted averages
            weight = 1.0 / self.completed_sessions
            self.average_accuracy = (self.average_accuracy * (1 - weight) + 
                                   session.accuracy_score * weight)
            self.average_speed_score = (self.average_speed_score * (1 - weight) + 
                                      session.speed_score * weight)
            self.average_overall_score = (self.average_overall_score * (1 - weight) + 
                                        session.overall_score * weight)
        
        # Update streak
        today = datetime.utcnow().date()
        if self.last_practice_date:
            last_date = self.last_practice_date.date()
            days_diff = (today - last_date).days
            
            if days_diff == 0:  # Same day
                pass
            elif days_diff == 1:  # Consecutive day
                self.current_streak += 1
                self.longest_streak = max(self.longest_streak, self.current_streak)
            else:  # Streak broken
                self.current_streak = 1
        else:
            self.current_streak = 1
        
        self.last_practice_date = datetime.utcnow()
        
        # Update difficulty progression
        if (self.average_accuracy > 85 and self.completed_sessions >= 10 and
            session.difficulty == self.current_difficulty):
            # Progress to next difficulty
            if self.current_difficulty == DictationDifficulty.BEGINNER:
                self.current_difficulty = DictationDifficulty.ELEMENTARY
            elif self.current_difficulty == DictationDifficulty.ELEMENTARY:
                self.current_difficulty = DictationDifficulty.INTERMEDIATE
            elif self.current_difficulty == DictationDifficulty.INTERMEDIATE:
                self.current_difficulty = DictationDifficulty.ADVANCED
    
    def add_problem_word(self, word: str):
        """Add a word to the problem words list"""
        if not self.problem_words:
            self.problem_words = []
        
        if word.lower() not in [w.lower() for w in self.problem_words]:
            self.problem_words.append(word.lower())
            # Keep only the most recent 50 problem words
            self.problem_words = self.problem_words[-50:]
    
    def add_mastered_word(self, word: str):
        """Add a word to the mastered words list"""
        if not self.mastered_words:
            self.mastered_words = []
        
        word_lower = word.lower()
        if word_lower not in [w.lower() for w in self.mastered_words]:
            self.mastered_words.append(word_lower)
            
            # Remove from problem words if present
            if self.problem_words and word_lower in [w.lower() for w in self.problem_words]:
                self.problem_words = [w for w in self.problem_words if w.lower() != word_lower]


class DictationSettings(db.Model):
    """Model for user's dictation practice settings"""
    __tablename__ = 'dictation_settings'
    
    id = Column(Integer, primary_key=True)
    user_id = Column(Integer, ForeignKey('users.id'), unique=True, nullable=False, index=True)
    
    # Audio settings
    default_playback_speed = Column(Float, default=1.0)
    auto_replay = Column(Boolean, default=False)
    replay_delay_seconds = Column(Integer, default=2)
    
    # Difficulty settings
    preferred_difficulty = Column(SQLEnum(DictationDifficulty), default=DictationDifficulty.ELEMENTARY)
    auto_difficulty_adjustment = Column(Boolean, default=True)
    blank_percentage = Column(Float, default=0.3)
    
    # Hint settings
    enable_hints = Column(Boolean, default=True)
    hint_delay_seconds = Column(Integer, default=5)
    max_hints_per_word = Column(Integer, default=3)
    
    # UI preferences
    show_word_count = Column(Boolean, default=True)
    show_timer = Column(Boolean, default=True)
    show_progress_bar = Column(Boolean, default=True)
    enable_keyboard_shortcuts = Column(Boolean, default=True)
    
    # Feedback settings
    enable_sound_effects = Column(Boolean, default=True)
    enable_visual_feedback = Column(Boolean, default=True)
    celebrate_completion = Column(Boolean, default=True)
    
    # Session preferences
    session_length_words = Column(Integer, default=20)
    focus_on_problem_words = Column(Boolean, default=True)
    review_mistakes_after_session = Column(Boolean, default=True)
    
    # Timestamps
    created_at = Column(DateTime, default=datetime.utcnow, nullable=False)
    updated_at = Column(DateTime, default=datetime.utcnow, onupdate=datetime.utcnow, nullable=False)
    
    # Relationships
    user = relationship("User", backref="dictation_settings", uselist=False)
    
    def __repr__(self):
        return f'<DictationSettings {self.id}: User {self.user_id}>'
    
    def to_dict(self):
        """Convert settings to dictionary"""
        return {
            'audio': {
                'default_playback_speed': self.default_playback_speed,
                'auto_replay': self.auto_replay,
                'replay_delay_seconds': self.replay_delay_seconds
            },
            'difficulty': {
                'preferred_difficulty': self.preferred_difficulty.value,
                'auto_difficulty_adjustment': self.auto_difficulty_adjustment,
                'blank_percentage': self.blank_percentage
            },
            'hints': {
                'enable_hints': self.enable_hints,
                'hint_delay_seconds': self.hint_delay_seconds,
                'max_hints_per_word': self.max_hints_per_word
            },
            'ui': {
                'show_word_count': self.show_word_count,
                'show_timer': self.show_timer,
                'show_progress_bar': self.show_progress_bar,
                'enable_keyboard_shortcuts': self.enable_keyboard_shortcuts
            },
            'feedback': {
                'enable_sound_effects': self.enable_sound_effects,
                'enable_visual_feedback': self.enable_visual_feedback,
                'celebrate_completion': self.celebrate_completion
            },
            'session': {
                'session_length_words': self.session_length_words,
                'focus_on_problem_words': self.focus_on_problem_words,
                'review_mistakes_after_session': self.review_mistakes_after_session
            }
        }