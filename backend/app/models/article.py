from app import db
from datetime import datetime

class Article(db.Model):
    """Store reading comprehension articles and materials"""
    __tablename__ = 'articles'
    
    id = db.Column(db.Integer, primary_key=True)
    title = db.Column(db.String(200), nullable=False)
    content = db.Column(db.Text, nullable=False)
    summary = db.Column(db.Text)
    author = db.Column(db.String(100))
    source = db.Column(db.String(200))
    topic = db.Column(db.String(100))
    grade_level = db.Column(db.Integer)
    difficulty = db.Column(db.Integer, default=1)  # 1-5 scale
    estimated_reading_time = db.Column(db.Integer)  # in minutes
    word_count = db.Column(db.Integer)
    audio_url = db.Column(db.String(500))
    image_url = db.Column(db.String(500))
    is_published = db.Column(db.Boolean, default=False)
    tags = db.Column(db.String(500))  # JSON array of tags
    created_at = db.Column(db.DateTime, default=datetime.utcnow)
    updated_at = db.Column(db.DateTime, default=datetime.utcnow, onupdate=datetime.utcnow)
    
    # Relationships
    questions = db.relationship('ComprehensionQuestion', back_populates='article', cascade='all, delete-orphan')
    reading_sessions = db.relationship('ReadingSession', back_populates='article')
    
    def to_dict(self, include_content=True):
        result = {
            'id': self.id,
            'title': self.title,
            'summary': self.summary,
            'author': self.author,
            'source': self.source,
            'topic': self.topic,
            'grade_level': self.grade_level,
            'difficulty': self.difficulty,
            'estimated_reading_time': self.estimated_reading_time,
            'word_count': self.word_count,
            'audio_url': self.audio_url,
            'image_url': self.image_url,
            'is_published': self.is_published,
            'tags': self.get_tags(),
            'created_at': self.created_at.isoformat() if self.created_at else None
        }
        
        if include_content:
            result['content'] = self.content
        
        return result
    
    def get_tags(self):
        """Parse tags from JSON string"""
        if self.tags:
            try:
                import json
                return json.loads(self.tags)
            except (ValueError, TypeError):
                return []
        return []
    
    def set_tags(self, tags_list):
        """Set tags as JSON string"""
        import json
        self.tags = json.dumps(tags_list)
    
    def calculate_reading_time(self, words_per_minute=200):
        """Calculate estimated reading time based on word count"""
        if self.word_count:
            self.estimated_reading_time = max(1, round(self.word_count / words_per_minute))
        return self.estimated_reading_time


class ComprehensionQuestion(db.Model):
    """Questions for reading comprehension exercises"""
    __tablename__ = 'comprehension_questions'
    
    id = db.Column(db.Integer, primary_key=True)
    article_id = db.Column(db.Integer, db.ForeignKey('articles.id'), nullable=False)
    question_text = db.Column(db.Text, nullable=False)
    question_type = db.Column(db.String(50), default='multiple_choice')  # 'multiple_choice', 'true_false', 'short_answer'
    options = db.Column(db.JSON)  # For multiple choice questions
    correct_answer = db.Column(db.Text, nullable=False)
    explanation = db.Column(db.Text)
    difficulty = db.Column(db.Integer, default=1)  # 1-5 scale
    order_index = db.Column(db.Integer, default=0)
    created_at = db.Column(db.DateTime, default=datetime.utcnow)
    updated_at = db.Column(db.DateTime, default=datetime.utcnow, onupdate=datetime.utcnow)
    
    # Relationships
    article = db.relationship('Article', back_populates='questions')
    
    def to_dict(self):
        return {
            'id': self.id,
            'article_id': self.article_id,
            'question_text': self.question_text,
            'question_type': self.question_type,
            'options': self.options,
            'correct_answer': self.correct_answer,
            'explanation': self.explanation,
            'difficulty': self.difficulty,
            'order_index': self.order_index
        }


class ReadingSession(db.Model):
    """Track user reading sessions for articles"""
    __tablename__ = 'reading_sessions'
    
    id = db.Column(db.Integer, primary_key=True)
    user_id = db.Column(db.Integer, db.ForeignKey('users.id'), nullable=False)
    article_id = db.Column(db.Integer, db.ForeignKey('articles.id'), nullable=False)
    start_time = db.Column(db.DateTime, default=datetime.utcnow)
    end_time = db.Column(db.DateTime)
    reading_duration = db.Column(db.Integer)  # seconds spent actually reading
    total_duration = db.Column(db.Integer)  # total session duration
    completion_percentage = db.Column(db.Float, default=0.0)
    comprehension_score = db.Column(db.Float)  # percentage score on questions
    questions_answered = db.Column(db.Integer, default=0)
    questions_correct = db.Column(db.Integer, default=0)
    bookmarks = db.Column(db.JSON)  # Array of bookmark positions
    notes = db.Column(db.Text)
    status = db.Column(db.String(20), default='in_progress')  # 'in_progress', 'completed', 'abandoned'
    created_at = db.Column(db.DateTime, default=datetime.utcnow)
    updated_at = db.Column(db.DateTime, default=datetime.utcnow, onupdate=datetime.utcnow)
    
    # Relationships
    user = db.relationship('User', backref='reading_sessions')
    article = db.relationship('Article', back_populates='reading_sessions')
    question_attempts = db.relationship('QuestionAttempt', back_populates='reading_session')
    
    def to_dict(self):
        return {
            'id': self.id,
            'user_id': self.user_id,
            'article_id': self.article_id,
            'start_time': self.start_time.isoformat() if self.start_time else None,
            'end_time': self.end_time.isoformat() if self.end_time else None,
            'reading_duration': self.reading_duration,
            'total_duration': self.total_duration,
            'completion_percentage': self.completion_percentage,
            'comprehension_score': self.comprehension_score,
            'questions_answered': self.questions_answered,
            'questions_correct': self.questions_correct,
            'bookmarks': self.bookmarks or [],
            'notes': self.notes,
            'status': self.status
        }
    
    def add_bookmark(self, position, title=None):
        """Add a bookmark at a specific position in the article"""
        if not self.bookmarks:
            self.bookmarks = []
        
        bookmark = {
            'position': position,
            'title': title or f"Bookmark {len(self.bookmarks) + 1}",
            'created_at': datetime.utcnow().isoformat()
        }
        
        bookmarks_list = self.bookmarks if isinstance(self.bookmarks, list) else []
        bookmarks_list.append(bookmark)
        self.bookmarks = bookmarks_list
        self.updated_at = datetime.utcnow()


class QuestionAttempt(db.Model):
    """Track attempts at comprehension questions"""
    __tablename__ = 'question_attempts'
    
    id = db.Column(db.Integer, primary_key=True)
    reading_session_id = db.Column(db.Integer, db.ForeignKey('reading_sessions.id'), nullable=False)
    question_id = db.Column(db.Integer, db.ForeignKey('comprehension_questions.id'), nullable=False)
    user_answer = db.Column(db.Text)
    is_correct = db.Column(db.Boolean, default=False)
    time_taken_seconds = db.Column(db.Integer)
    attempt_number = db.Column(db.Integer, default=1)
    created_at = db.Column(db.DateTime, default=datetime.utcnow)
    
    # Relationships
    reading_session = db.relationship('ReadingSession', back_populates='question_attempts')
    question = db.relationship('ComprehensionQuestion', backref='attempts')
    
    def to_dict(self):
        return {
            'id': self.id,
            'reading_session_id': self.reading_session_id,
            'question_id': self.question_id,
            'user_answer': self.user_answer,
            'is_correct': self.is_correct,
            'time_taken_seconds': self.time_taken_seconds,
            'attempt_number': self.attempt_number,
            'created_at': self.created_at.isoformat() if self.created_at else None
        }


class WordLookup(db.Model):
    """Track word lookups during reading to identify difficult vocabulary"""
    __tablename__ = 'word_lookups'
    
    id = db.Column(db.Integer, primary_key=True)
    user_id = db.Column(db.Integer, db.ForeignKey('users.id'), nullable=False)
    reading_session_id = db.Column(db.Integer, db.ForeignKey('reading_sessions.id'))
    word_id = db.Column(db.Integer, db.ForeignKey('words.id'))
    looked_up_word = db.Column(db.String(100), nullable=False)  # In case word not in dictionary
    context_sentence = db.Column(db.Text)
    article_position = db.Column(db.Integer)  # Position in article where lookup occurred
    lookup_count = db.Column(db.Integer, default=1)
    created_at = db.Column(db.DateTime, default=datetime.utcnow)
    updated_at = db.Column(db.DateTime, default=datetime.utcnow, onupdate=datetime.utcnow)
    
    # Relationships
    user = db.relationship('User', backref='word_lookups')
    reading_session = db.relationship('ReadingSession', backref='word_lookups')
    word = db.relationship('Word', backref='lookups')
    
    def to_dict(self):
        return {
            'id': self.id,
            'user_id': self.user_id,
            'reading_session_id': self.reading_session_id,
            'word_id': self.word_id,
            'looked_up_word': self.looked_up_word,
            'context_sentence': self.context_sentence,
            'article_position': self.article_position,
            'lookup_count': self.lookup_count,
            'word_info': self.word.to_dict() if self.word else None,
            'created_at': self.created_at.isoformat() if self.created_at else None
        }