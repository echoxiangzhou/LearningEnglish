from app import db
from datetime import datetime

# Association table for many-to-many relationship between sentences and words
sentence_words = db.Table('sentence_words',
    db.Column('sentence_id', db.Integer, db.ForeignKey('sentences.id'), primary_key=True),
    db.Column('word_id', db.Integer, db.ForeignKey('words.id'), primary_key=True)
)

class Sentence(db.Model):
    __tablename__ = 'sentences'
    
    id = db.Column(db.Integer, primary_key=True)
    text = db.Column(db.Text, nullable=False)
    difficulty = db.Column(db.Integer, default=1)  # 1-5 scale
    grade_level = db.Column(db.Integer)
    topic = db.Column(db.String(100))
    source = db.Column(db.String(200))  # e.g., 'generated', 'pdf_import', 'manual'
    audio_url = db.Column(db.String(500))
    created_at = db.Column(db.DateTime, default=datetime.utcnow)
    updated_at = db.Column(db.DateTime, default=datetime.utcnow, onupdate=datetime.utcnow)
    
    # Relationships
    words = db.relationship('Word', secondary=sentence_words, back_populates='sentences')
    
    def to_dict(self):
        return {
            'id': self.id,
            'text': self.text,
            'difficulty': self.difficulty,
            'grade_level': self.grade_level,
            'topic': self.topic,
            'source': self.source,
            'audio_url': self.audio_url,
            'words': [word.word for word in self.words]
        }