from app import db
from datetime import datetime
from enum import Enum

class DifficultyLevel(Enum):
    """Word difficulty levels"""
    EASY = 'easy'
    MEDIUM = 'medium'  
    HARD = 'hard'

class PartOfSpeech(Enum):
    """Parts of speech"""
    NOUN = 'noun'
    VERB = 'verb'
    ADJECTIVE = 'adjective'
    ADVERB = 'adverb'
    PRONOUN = 'pronoun'
    PREPOSITION = 'preposition'
    CONJUNCTION = 'conjunction'
    INTERJECTION = 'interjection'
    DETERMINER = 'determiner'

class Word(db.Model):
    __tablename__ = 'words'
    
    id = db.Column(db.Integer, primary_key=True)
    word = db.Column(db.String(100), unique=True, nullable=False, index=True)
    
    # Pronunciation and meaning
    phonetic = db.Column(db.String(100))  # IPA notation
    pronunciation = db.Column(db.String(100))  # Alternative pronunciation guide
    definition = db.Column(db.Text)  # English definition
    chinese_meaning = db.Column(db.String(500))  # Chinese translation
    
    # Grammar information
    part_of_speech = db.Column(db.String(50))  # Use string instead of enum to avoid issues
    irregular_forms = db.Column(db.Text)  # JSON string for irregular verb forms, plural nouns, etc.
    
    # Educational metadata
    grade_level = db.Column(db.Integer, index=True)  # 1-9 for grade levels
    frequency = db.Column(db.Integer, default=0)  # Word frequency ranking
    difficulty = db.Column(db.Integer, default=1)  # 1-5 numeric scale
    difficulty_level = db.Column(db.String(20), default='easy')  # Use string instead of enum
    
    # Audio and visual aids
    audio_url = db.Column(db.String(500))  # URL to audio pronunciation
    image_url = db.Column(db.String(500))  # URL to illustrative image
    
    # Example usage
    example_sentence = db.Column(db.Text)  # Example sentence using the word
    example_chinese = db.Column(db.Text)  # Chinese translation of example
    
    # Additional context
    etymology = db.Column(db.Text)  # Word origin and history
    synonyms = db.Column(db.Text)  # JSON array of synonyms
    antonyms = db.Column(db.Text)  # JSON array of antonyms
    related_words = db.Column(db.Text)  # JSON array of related words
    
    # Usage context
    usage_notes = db.Column(db.Text)  # Special usage notes
    common_mistakes = db.Column(db.Text)  # Common learner mistakes
    
    # System metadata
    source = db.Column(db.String(100))  # Source of the word (textbook, curriculum, etc.)
    is_active = db.Column(db.Boolean, default=True)
    is_core_vocabulary = db.Column(db.Boolean, default=False)  # Essential vocabulary
    created_at = db.Column(db.DateTime, default=datetime.utcnow)
    updated_at = db.Column(db.DateTime, default=datetime.utcnow, onupdate=datetime.utcnow)
    created_by = db.Column(db.Integer, db.ForeignKey('users.id'))
    
    # Relationships
    sentences = db.relationship('Sentence', secondary='sentence_words', back_populates='words')
    # categories relationship removed - vocabulary categories no longer exist
    creator = db.relationship('User', backref='created_words')
    
    def get_synonyms(self):
        """Parse synonyms from JSON string"""
        if self.synonyms:
            try:
                import json
                return json.loads(self.synonyms)
            except json.JSONDecodeError:
                return []
        return []
    
    def set_synonyms(self, synonyms_list):
        """Set synonyms as JSON string"""
        import json
        self.synonyms = json.dumps(synonyms_list) if synonyms_list else None
    
    def get_antonyms(self):
        """Parse antonyms from JSON string"""
        if self.antonyms:
            try:
                import json
                return json.loads(self.antonyms)
            except json.JSONDecodeError:
                return []
        return []
    
    def set_antonyms(self, antonyms_list):
        """Set antonyms as JSON string"""
        import json
        self.antonyms = json.dumps(antonyms_list) if antonyms_list else None
    
    def get_related_words(self):
        """Parse related words from JSON string"""
        if self.related_words:
            try:
                import json
                return json.loads(self.related_words)
            except json.JSONDecodeError:
                return []
        return []
    
    def set_related_words(self, related_list):
        """Set related words as JSON string"""
        import json
        self.related_words = json.dumps(related_list) if related_list else None
    
    def get_irregular_forms(self):
        """Parse irregular forms from JSON string"""
        if self.irregular_forms:
            try:
                import json
                return json.loads(self.irregular_forms)
            except json.JSONDecodeError:
                return {}
        return {}
    
    def set_irregular_forms(self, forms_dict):
        """Set irregular forms as JSON string"""
        import json
        self.irregular_forms = json.dumps(forms_dict) if forms_dict else None
    
    def get_difficulty_text(self):
        """Get human-readable difficulty level"""
        difficulty_map = {
            1: '很简单',
            2: '简单', 
            3: '中等',
            4: '困难',
            5: '很困难'
        }
        return difficulty_map.get(self.difficulty, '未知')
    
    def to_dict(self, include_extended=False):
        base_dict = {
            'id': self.id,
            'word': self.word,
            'phonetic': self.phonetic,
            'pronunciation': self.pronunciation,
            'definition': self.definition,
            'chinese_meaning': self.chinese_meaning,
            'part_of_speech': self.part_of_speech,
            'grade_level': self.grade_level,
            'frequency': self.frequency,
            'difficulty': self.difficulty,
            'difficulty_level': self.difficulty_level,
            'difficulty_text': self.get_difficulty_text(),
            'audio_url': self.audio_url,
            'image_url': self.image_url,
            'example_sentence': self.example_sentence,
            'example_chinese': self.example_chinese,
            'is_core_vocabulary': self.is_core_vocabulary,
            'created_at': self.created_at.isoformat(),
            'updated_at': self.updated_at.isoformat()
        }
        
        if include_extended:
            base_dict.update({
                'etymology': self.etymology,
                'synonyms': self.get_synonyms(),
                'antonyms': self.get_antonyms(),
                'related_words': self.get_related_words(),
                'irregular_forms': self.get_irregular_forms(),
                'usage_notes': self.usage_notes,
                'common_mistakes': self.common_mistakes,
                'source': self.source
                # categories removed - vocabulary categories no longer exist
            })
        
        return base_dict