from app import db
from datetime import datetime

class LearningSession(db.Model):
    """Track individual learning sessions for dictation, vocabulary, and reading"""
    __tablename__ = 'learning_sessions'
    
    id = db.Column(db.Integer, primary_key=True)
    user_id = db.Column(db.Integer, db.ForeignKey('users.id'), nullable=False)
    session_type = db.Column(db.String(50), nullable=False)  # 'dictation', 'vocabulary', 'reading'
    status = db.Column(db.String(20), default='in_progress')  # 'in_progress', 'completed', 'abandoned'
    start_time = db.Column(db.DateTime, default=datetime.utcnow)
    end_time = db.Column(db.DateTime)
    duration_seconds = db.Column(db.Integer)
    total_items = db.Column(db.Integer, default=0)
    correct_items = db.Column(db.Integer, default=0)
    incorrect_items = db.Column(db.Integer, default=0)
    accuracy_rate = db.Column(db.Float, default=0.0)
    session_data = db.Column(db.JSON)  # Store session-specific data
    created_at = db.Column(db.DateTime, default=datetime.utcnow)
    updated_at = db.Column(db.DateTime, default=datetime.utcnow, onupdate=datetime.utcnow)
    
    # Relationships
    user = db.relationship('User', backref='learning_sessions')
    progress_records = db.relationship('Progress', back_populates='session')
    
    def to_dict(self):
        return {
            'id': self.id,
            'user_id': self.user_id,
            'session_type': self.session_type,
            'status': self.status,
            'start_time': self.start_time.isoformat() if self.start_time else None,
            'end_time': self.end_time.isoformat() if self.end_time else None,
            'duration_seconds': self.duration_seconds,
            'total_items': self.total_items,
            'correct_items': self.correct_items,
            'incorrect_items': self.incorrect_items,
            'accuracy_rate': self.accuracy_rate,
            'session_data': self.session_data
        }
    
    def calculate_accuracy(self):
        """Calculate and update accuracy rate"""
        if self.total_items > 0:
            self.accuracy_rate = (self.correct_items / self.total_items) * 100
        else:
            self.accuracy_rate = 0.0
        return self.accuracy_rate
    
    def complete_session(self):
        """Mark session as completed and calculate final stats"""
        self.status = 'completed'
        self.end_time = datetime.utcnow()
        if self.start_time and self.end_time:
            self.duration_seconds = int((self.end_time - self.start_time).total_seconds())
        self.calculate_accuracy()


class Progress(db.Model):
    """Track detailed progress for individual items within sessions"""
    __tablename__ = 'progress'
    
    id = db.Column(db.Integer, primary_key=True)
    user_id = db.Column(db.Integer, db.ForeignKey('users.id'), nullable=False)
    session_id = db.Column(db.Integer, db.ForeignKey('learning_sessions.id'), nullable=False)
    item_type = db.Column(db.String(50), nullable=False)  # 'word', 'sentence', 'article'
    item_id = db.Column(db.Integer, nullable=False)  # ID of the word/sentence/article
    attempt_number = db.Column(db.Integer, default=1)
    is_correct = db.Column(db.Boolean, default=False)
    user_answer = db.Column(db.Text)
    correct_answer = db.Column(db.Text)
    time_taken_seconds = db.Column(db.Integer)
    hints_used = db.Column(db.Integer, default=0)
    difficulty_level = db.Column(db.Integer, default=1)
    created_at = db.Column(db.DateTime, default=datetime.utcnow)
    
    # Relationships
    user = db.relationship('User', backref='progress_records')
    session = db.relationship('LearningSession', back_populates='progress_records')
    
    def to_dict(self):
        return {
            'id': self.id,
            'user_id': self.user_id,
            'session_id': self.session_id,
            'item_type': self.item_type,
            'item_id': self.item_id,
            'attempt_number': self.attempt_number,
            'is_correct': self.is_correct,
            'user_answer': self.user_answer,
            'correct_answer': self.correct_answer,
            'time_taken_seconds': self.time_taken_seconds,
            'hints_used': self.hints_used,
            'difficulty_level': self.difficulty_level,
            'created_at': self.created_at.isoformat()
        }


class UserWordProgress(db.Model):
    """Track user's progress with individual words across all sessions"""
    __tablename__ = 'user_word_progress'
    
    id = db.Column(db.Integer, primary_key=True)
    user_id = db.Column(db.Integer, db.ForeignKey('users.id'), nullable=False)
    word_id = db.Column(db.Integer, db.ForeignKey('words.id'), nullable=False)
    mastery_level = db.Column(db.Integer, default=0)  # 0-5 scale
    correct_attempts = db.Column(db.Integer, default=0)
    total_attempts = db.Column(db.Integer, default=0)
    last_practiced = db.Column(db.DateTime)
    next_review = db.Column(db.DateTime)  # For spaced repetition
    review_interval_days = db.Column(db.Integer, default=1)
    is_favorite = db.Column(db.Boolean, default=False)
    created_at = db.Column(db.DateTime, default=datetime.utcnow)
    updated_at = db.Column(db.DateTime, default=datetime.utcnow, onupdate=datetime.utcnow)
    
    # Relationships
    user = db.relationship('User', backref='word_progress')
    word = db.relationship('Word', backref='learning_progress')
    
    # Unique constraint to ensure one record per user-word combination
    __table_args__ = (db.UniqueConstraint('user_id', 'word_id'),)
    
    def to_dict(self):
        return {
            'id': self.id,
            'user_id': self.user_id,
            'word_id': self.word_id,
            'word': self.word.word if self.word else None,
            'mastery_level': self.mastery_level,
            'correct_attempts': self.correct_attempts,
            'total_attempts': self.total_attempts,
            'accuracy_rate': (self.correct_attempts / self.total_attempts * 100) if self.total_attempts > 0 else 0,
            'last_practiced': self.last_practiced.isoformat() if self.last_practiced else None,
            'next_review': self.next_review.isoformat() if self.next_review else None,
            'review_interval_days': self.review_interval_days,
            'is_favorite': self.is_favorite
        }
    
    def update_progress(self, is_correct):
        """Update progress after an attempt"""
        self.total_attempts += 1
        if is_correct:
            self.correct_attempts += 1
            # Increase mastery level and review interval
            if self.mastery_level < 5:
                self.mastery_level += 1
            self.review_interval_days = min(self.review_interval_days * 2, 30)
        else:
            # Reset review interval on incorrect answer
            self.review_interval_days = max(1, self.review_interval_days // 2)
        
        # Update timing for spaced repetition
        from datetime import timedelta
        self.last_practiced = datetime.utcnow()
        self.next_review = datetime.utcnow() + timedelta(days=self.review_interval_days)
        self.updated_at = datetime.utcnow()


class AdminSettings(db.Model):
    """Store system-wide configuration settings"""
    __tablename__ = 'admin_settings'
    
    id = db.Column(db.Integer, primary_key=True)
    setting_key = db.Column(db.String(100), unique=True, nullable=False)
    setting_value = db.Column(db.Text)
    setting_type = db.Column(db.String(20), default='string')  # 'string', 'integer', 'boolean', 'json'
    description = db.Column(db.Text)
    is_system = db.Column(db.Boolean, default=False)  # System settings cannot be deleted
    created_at = db.Column(db.DateTime, default=datetime.utcnow)
    updated_at = db.Column(db.DateTime, default=datetime.utcnow, onupdate=datetime.utcnow)
    
    def to_dict(self):
        return {
            'id': self.id,
            'setting_key': self.setting_key,
            'setting_value': self.get_typed_value(),
            'setting_type': self.setting_type,
            'description': self.description,
            'is_system': self.is_system
        }
    
    def get_typed_value(self):
        """Return the setting value in its proper type"""
        if self.setting_type == 'boolean':
            return self.setting_value.lower() in ('true', '1', 'yes', 'on')
        elif self.setting_type == 'integer':
            try:
                return int(self.setting_value)
            except (ValueError, TypeError):
                return 0
        elif self.setting_type == 'json':
            try:
                import json
                return json.loads(self.setting_value)
            except (ValueError, TypeError):
                return {}
        else:
            return self.setting_value
    
    def set_typed_value(self, value):
        """Set the setting value with proper type conversion"""
        if self.setting_type == 'boolean':
            self.setting_value = str(bool(value)).lower()
        elif self.setting_type == 'integer':
            self.setting_value = str(int(value))
        elif self.setting_type == 'json':
            import json
            self.setting_value = json.dumps(value)
        else:
            self.setting_value = str(value)