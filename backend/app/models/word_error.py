from datetime import datetime
from app import db
from enum import Enum


class ErrorType(Enum):
    SPELLING = "spelling"
    PRONUNCIATION = "pronunciation"
    MISSING_WORD = "missing_word"
    EXTRA_WORD = "extra_word"
    WORD_ORDER = "word_order"
    CAPITALIZATION = "capitalization"
    PUNCTUATION = "punctuation"


class WordError(db.Model):
    __tablename__ = 'word_errors'
    
    id = db.Column(db.Integer, primary_key=True)
    user_id = db.Column(db.Integer, db.ForeignKey('users.id'), nullable=False)
    word_id = db.Column(db.Integer, db.ForeignKey('words.id'), nullable=True)
    sentence_id = db.Column(db.Integer, db.ForeignKey('sentences.id'), nullable=True)
    
    # Error details
    error_type = db.Column(db.Enum(ErrorType), nullable=False)
    expected_text = db.Column(db.Text, nullable=False)
    actual_text = db.Column(db.Text, nullable=False)
    context = db.Column(db.Text)  # Full sentence or surrounding context
    
    # Practice session info
    practice_type = db.Column(db.String(50), nullable=False)  # 'word_practice' or 'sentence_practice'
    session_id = db.Column(db.String(100))  # Optional session identifier
    
    # Tracking
    error_count = db.Column(db.Integer, default=1)
    first_error_date = db.Column(db.DateTime, default=datetime.utcnow)
    last_error_date = db.Column(db.DateTime, default=datetime.utcnow)
    is_resolved = db.Column(db.Boolean, default=False)
    resolved_date = db.Column(db.DateTime)
    
    # Relationships
    user = db.relationship('User', backref='word_errors')
    word = db.relationship('Word', backref='errors')
    sentence = db.relationship('Sentence', backref='errors')
    
    def __repr__(self):
        return f'<WordError {self.expected_text} -> {self.actual_text}>'
    
    def to_dict(self):
        return {
            'id': self.id,
            'user_id': self.user_id,
            'word_id': self.word_id,
            'sentence_id': self.sentence_id,
            'error_type': self.error_type.value,
            'expected_text': self.expected_text,
            'actual_text': self.actual_text,
            'context': self.context,
            'practice_type': self.practice_type,
            'session_id': self.session_id,
            'error_count': self.error_count,
            'first_error_date': self.first_error_date.isoformat() if self.first_error_date else None,
            'last_error_date': self.last_error_date.isoformat() if self.last_error_date else None,
            'is_resolved': self.is_resolved,
            'resolved_date': self.resolved_date.isoformat() if self.resolved_date else None
        }


class ErrorPattern(db.Model):
    __tablename__ = 'error_patterns'
    
    id = db.Column(db.Integer, primary_key=True)
    user_id = db.Column(db.Integer, db.ForeignKey('users.id'), nullable=False)
    
    # Pattern details
    pattern_type = db.Column(db.String(100), nullable=False)  # e.g., "silent_letters", "double_consonants"
    description = db.Column(db.Text)
    rule_or_example = db.Column(db.Text)
    
    # Tracking
    frequency = db.Column(db.Integer, default=1)
    identified_date = db.Column(db.DateTime, default=datetime.utcnow)
    last_occurrence = db.Column(db.DateTime, default=datetime.utcnow)
    
    # Progress tracking
    practice_attempts = db.Column(db.Integer, default=0)
    success_rate = db.Column(db.Float, default=0.0)  # 0.0 to 1.0
    is_improving = db.Column(db.Boolean, default=False)
    
    # Relationships
    user = db.relationship('User', backref='error_patterns')
    
    def __repr__(self):
        return f'<ErrorPattern {self.pattern_type} for user {self.user_id}>'
    
    def to_dict(self):
        return {
            'id': self.id,
            'user_id': self.user_id,
            'pattern_type': self.pattern_type,
            'description': self.description,
            'rule_or_example': self.rule_or_example,
            'frequency': self.frequency,
            'identified_date': self.identified_date.isoformat() if self.identified_date else None,
            'last_occurrence': self.last_occurrence.isoformat() if self.last_occurrence else None,
            'practice_attempts': self.practice_attempts,
            'success_rate': self.success_rate,
            'is_improving': self.is_improving
        }


class ErrorReview(db.Model):
    __tablename__ = 'error_reviews'
    
    id = db.Column(db.Integer, primary_key=True)
    user_id = db.Column(db.Integer, db.ForeignKey('users.id'), nullable=False)
    word_error_id = db.Column(db.Integer, db.ForeignKey('word_errors.id'), nullable=False)
    
    # Review details
    review_date = db.Column(db.DateTime, default=datetime.utcnow)
    was_correct = db.Column(db.Boolean, nullable=False)
    response_time = db.Column(db.Float)  # Time taken to respond in seconds
    confidence_level = db.Column(db.Integer)  # 1-5 scale
    
    # Next review scheduling (spaced repetition)
    next_review_date = db.Column(db.DateTime)
    review_interval_days = db.Column(db.Integer, default=1)
    
    # Relationships
    user = db.relationship('User', backref='error_reviews')
    word_error = db.relationship('WordError', backref='reviews')
    
    def __repr__(self):
        return f'<ErrorReview {self.word_error_id} on {self.review_date}>'
    
    def to_dict(self):
        return {
            'id': self.id,
            'user_id': self.user_id,
            'word_error_id': self.word_error_id,
            'review_date': self.review_date.isoformat() if self.review_date else None,
            'was_correct': self.was_correct,
            'response_time': self.response_time,
            'confidence_level': self.confidence_level,
            'next_review_date': self.next_review_date.isoformat() if self.next_review_date else None,
            'review_interval_days': self.review_interval_days
        }