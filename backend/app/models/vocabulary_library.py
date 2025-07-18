from app import db
from datetime import datetime
from enum import Enum

class LibraryType(Enum):
    """Types of vocabulary libraries"""
    GRADE_BASED = 'grade_based'
    THEMATIC = 'thematic'
    TEXTBOOK = 'textbook'
    CUSTOM = 'custom'

class GradeLevel(Enum):
    """Grade levels for vocabulary libraries"""
    ELEMENTARY_ALL = 'elementary_all'
    GRADE_1 = 'grade_1'
    GRADE_2 = 'grade_2'
    GRADE_3 = 'grade_3'
    GRADE_4 = 'grade_4'
    GRADE_5 = 'grade_5'
    GRADE_6 = 'grade_6'
    MIDDLE_SCHOOL_ALL = 'middle_school_all'
    GRADE_7 = 'grade_7'
    GRADE_8 = 'grade_8'
    GRADE_9 = 'grade_9'

# Association table for many-to-many relationship between libraries and words
library_words = db.Table('library_words',
    db.Column('library_id', db.Integer, db.ForeignKey('vocabulary_libraries.id'), primary_key=True),
    db.Column('word_id', db.Integer, db.ForeignKey('words.id'), primary_key=True),
    db.Column('added_at', db.DateTime, default=datetime.utcnow),
    db.Column('is_core_word', db.Boolean, default=True)  # Whether word is core to this library
)

class VocabularyLibrary(db.Model):
    """Vocabulary libraries for organizing words by grade level and theme"""
    __tablename__ = 'vocabulary_libraries'
    
    id = db.Column(db.Integer, primary_key=True)
    library_id = db.Column(db.String(100), unique=True, nullable=False)  # e.g., 'grade_4', 'animals_nature'
    name = db.Column(db.String(200), nullable=False)
    description = db.Column(db.Text)
    
    # Library classification
    library_type = db.Column(db.String(20), nullable=False)  # Use string instead of enum
    grade_level = db.Column(db.Integer)  # Numeric grade level (1-9)
    
    # Library metadata
    total_words = db.Column(db.Integer, default=0)
    core_words = db.Column(db.Integer, default=0)  # Number of core words
    difficulty_min = db.Column(db.Integer, default=1)  # Minimum difficulty level
    difficulty_max = db.Column(db.Integer, default=5)  # Maximum difficulty level
    
    # Categories and tags (JSON string for flexibility)
    categories = db.Column(db.Text)  # JSON array of category names
    tags = db.Column(db.Text)  # JSON array of tags
    
    # Status and visibility
    is_active = db.Column(db.Boolean, default=True)
    is_public = db.Column(db.Boolean, default=True)
    is_system_library = db.Column(db.Boolean, default=True)  # System vs custom library
    
    # Version control
    version = db.Column(db.String(20), default='1.0')
    last_updated_by = db.Column(db.Integer, db.ForeignKey('users.id'))
    
    # Timestamps
    created_at = db.Column(db.DateTime, default=datetime.utcnow)
    updated_at = db.Column(db.DateTime, default=datetime.utcnow, onupdate=datetime.utcnow)
    
    # Relationships
    words = db.relationship('Word', secondary='library_words', backref='libraries')
    creator = db.relationship('User', backref='created_libraries')
    
    def get_categories(self):
        """Parse categories from JSON string"""
        if self.categories:
            try:
                import json
                return json.loads(self.categories)
            except json.JSONDecodeError:
                return []
        return []
    
    def set_categories(self, categories_list):
        """Set categories as JSON string"""
        import json
        self.categories = json.dumps(categories_list) if categories_list else None
    
    def get_tags(self):
        """Parse tags from JSON string"""
        if self.tags:
            try:
                import json
                return json.loads(self.tags)
            except json.JSONDecodeError:
                return []
        return []
    
    def set_tags(self, tags_list):
        """Set tags as JSON string"""
        import json
        self.tags = json.dumps(tags_list) if tags_list else None
    
    def update_word_count(self):
        """Update the word count based on associated words"""
        from sqlalchemy import func
        # Count total words from the association table
        self.total_words = db.session.query(func.count(library_words.c.word_id)).filter(
            library_words.c.library_id == self.id
        ).scalar() or 0
        
        # Count core words from the association table
        from sqlalchemy import text
        result = db.session.execute(
            text("SELECT COUNT(*) FROM library_words WHERE library_id = :lib_id AND is_core_word = true"),
            {"lib_id": self.id}
        ).scalar()
        self.core_words = result or 0
    
    def add_word(self, word, is_core=True):
        """Add a word to this library"""
        if word not in self.words:
            self.words.append(word)
            # Note: The is_core_word field in the association table would need to be set separately
            # in a more complex implementation
        self.update_word_count()
    
    def remove_word(self, word):
        """Remove a word from this library"""
        if word in self.words:
            self.words.remove(word)
        self.update_word_count()
    
    def get_words_by_difficulty(self, min_difficulty=1, max_difficulty=5):
        """Get words filtered by difficulty range"""
        return [word for word in self.words 
                if min_difficulty <= word.difficulty <= max_difficulty]
    
    def get_words_by_grade_level(self, grade_level):
        """Get words filtered by grade level"""
        return [word for word in self.words if word.grade_level == grade_level]
    
    def to_dict(self, include_words=False):
        return {
            'id': self.id,
            'library_id': self.library_id,
            'name': self.name,
            'description': self.description,
            'library_type': self.library_type,  # Use string value directly
            'grade_level': self.grade_level,
            'total_words': self.total_words,
            'core_words': self.core_words,
            'difficulty_min': self.difficulty_min,
            'difficulty_max': self.difficulty_max,
            'categories': self.get_categories(),
            'tags': self.get_tags(),
            'is_active': self.is_active,
            'is_public': self.is_public,
            'is_system_library': self.is_system_library,
            'version': self.version,
            'created_at': self.created_at.isoformat(),
            'updated_at': self.updated_at.isoformat(),
            'words': [word.to_dict() for word in self.words] if include_words and self.words else []
        }
    
    def to_frontend_dict(self):
        """Convert to format expected by frontend"""
        # Calculate real-time word count using the association table
        from sqlalchemy import func
        word_count = db.session.query(func.count(library_words.c.word_id)).filter(
            library_words.c.library_id == self.id
        ).scalar() or 0
        
        return {
            'id': self.library_id,  # Frontend expects string ID
            'name': self.name,
            'description': self.description,
            'grade_level': self.grade_level,
            'word_count': word_count,
            'categories': self.get_categories()
        }

class LibraryAssignment(db.Model):
    """Manages which libraries are assigned to which users/classes"""
    __tablename__ = 'library_assignments'
    
    id = db.Column(db.Integer, primary_key=True)
    library_id = db.Column(db.Integer, db.ForeignKey('vocabulary_libraries.id'), nullable=False)
    user_id = db.Column(db.Integer, db.ForeignKey('users.id'))
    class_id = db.Column(db.Integer)  # Future implementation for class-based assignments
    
    # Assignment settings
    is_required = db.Column(db.Boolean, default=False)
    start_date = db.Column(db.Date)
    end_date = db.Column(db.Date)
    
    # Progress tracking
    words_completed = db.Column(db.Integer, default=0)
    last_accessed = db.Column(db.DateTime)
    
    # Timestamps
    assigned_at = db.Column(db.DateTime, default=datetime.utcnow)
    assigned_by = db.Column(db.Integer, db.ForeignKey('users.id'))
    
    # Relationships
    library = db.relationship('VocabularyLibrary', backref='assignments')
    user = db.relationship('User', foreign_keys=[user_id], backref='library_assignments')
    assigner = db.relationship('User', foreign_keys=[assigned_by])
    
    # Unique constraint
    __table_args__ = (db.UniqueConstraint('library_id', 'user_id', name='unique_library_user'),)
    
    def calculate_completion_percentage(self):
        """Calculate completion percentage for this assignment"""
        if self.library and self.library.total_words > 0:
            return (self.words_completed / self.library.total_words) * 100
        return 0
    
    def to_dict(self):
        return {
            'id': self.id,
            'library_id': self.library_id,
            'user_id': self.user_id,
            'is_required': self.is_required,
            'start_date': self.start_date.isoformat() if self.start_date else None,
            'end_date': self.end_date.isoformat() if self.end_date else None,
            'words_completed': self.words_completed,
            'completion_percentage': self.calculate_completion_percentage(),
            'last_accessed': self.last_accessed.isoformat() if self.last_accessed else None,
            'assigned_at': self.assigned_at.isoformat(),
            'library': self.library.to_dict() if self.library else None
        }