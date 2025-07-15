from app import db
from datetime import datetime

class Word(db.Model):
    __tablename__ = 'words'
    
    id = db.Column(db.Integer, primary_key=True)
    word = db.Column(db.String(100), unique=True, nullable=False)
    phonetic = db.Column(db.String(100))
    definition = db.Column(db.Text)
    part_of_speech = db.Column(db.String(50))
    grade_level = db.Column(db.Integer)
    frequency = db.Column(db.Integer, default=0)
    difficulty = db.Column(db.Integer, default=1)  # 1-5 scale
    created_at = db.Column(db.DateTime, default=datetime.utcnow)
    updated_at = db.Column(db.DateTime, default=datetime.utcnow, onupdate=datetime.utcnow)
    
    # Relationships
    sentences = db.relationship('Sentence', secondary='sentence_words', back_populates='words')
    categories = db.relationship('VocabularyCategory', secondary='word_categories', back_populates='words')
    
    def to_dict(self):
        return {
            'id': self.id,
            'word': self.word,
            'phonetic': self.phonetic,
            'definition': self.definition,
            'part_of_speech': self.part_of_speech,
            'grade_level': self.grade_level,
            'frequency': self.frequency,
            'difficulty': self.difficulty
        }