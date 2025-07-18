#!/usr/bin/env python3
"""
Database initialization script for Learning English application
"""
import os
import sys
from sqlalchemy import text

# Add current directory to Python path
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))

from app import create_app, db
from app.models import *  # Import all models

def init_database():
    """Initialize database with tables and sample data"""
    app = create_app()
    
    with app.app_context():
        try:
            print("Creating database tables...")
            db.create_all()
            print("✅ Database tables created successfully!")
            
            # Check if we can connect to the database
            result = db.session.execute(text("SELECT version()"))
            version = result.fetchone()[0]
            print(f"✅ Connected to: {version}")
            
            # Add some sample words (vocabulary categories removed)
            print("Adding sample words...")
            add_sample_words()
            
            print("✅ Database initialization completed successfully!")
            
        except Exception as e:
            print(f"❌ Error initializing database: {e}")
            db.session.rollback()
            raise
        finally:
            db.session.close()

def add_sample_words():
    """Add sample words to the database"""
    from app.models.word import Word
    
    sample_words = [
        # Basic words for practice
        {'word': 'cat', 'phonetic': '/kæt/', 'definition': 'A small domesticated carnivorous mammal', 'part_of_speech': 'noun', 'difficulty_level': 1},
        {'word': 'dog', 'phonetic': '/dɔːɡ/', 'definition': 'A domesticated carnivorous mammal that is typically kept as a pet', 'part_of_speech': 'noun', 'difficulty_level': 1},
        {'word': 'bird', 'phonetic': '/bɜːrd/', 'definition': 'A warm-blooded egg-laying vertebrate animal with feathers and wings', 'part_of_speech': 'noun', 'difficulty_level': 1},
        {'word': 'fish', 'phonetic': '/fɪʃ/', 'definition': 'A limbless cold-blooded vertebrate animal that lives in water', 'part_of_speech': 'noun', 'difficulty_level': 1},
        {'word': 'apple', 'phonetic': '/ˈæpəl/', 'definition': 'A round fruit with red or green skin and crisp flesh', 'part_of_speech': 'noun', 'difficulty_level': 1},
        {'word': 'water', 'phonetic': '/ˈwɔːtər/', 'definition': 'A colorless, transparent, odorless liquid that forms the seas, lakes, rivers, and rain', 'part_of_speech': 'noun', 'difficulty_level': 1},
        {'word': 'bread', 'phonetic': '/bred/', 'definition': 'Food made of flour, water, and yeast baked into a loaf', 'part_of_speech': 'noun', 'difficulty_level': 1},
        {'word': 'red', 'phonetic': '/red/', 'definition': 'The color of blood, fire, or rubies', 'part_of_speech': 'adjective', 'difficulty_level': 1},
        {'word': 'blue', 'phonetic': '/bluː/', 'definition': 'The color of the sky or sea on a sunny day', 'part_of_speech': 'adjective', 'difficulty_level': 1},
        {'word': 'green', 'phonetic': '/ɡriːn/', 'definition': 'The color of grass and emeralds', 'part_of_speech': 'adjective', 'difficulty_level': 1},
        {'word': 'teacher', 'phonetic': '/ˈtiːtʃər/', 'definition': 'A person who teaches, especially in a school', 'part_of_speech': 'noun', 'difficulty_level': 2},
        {'word': 'book', 'phonetic': '/bʊk/', 'definition': 'A written or printed work consisting of pages bound together', 'part_of_speech': 'noun', 'difficulty_level': 1},
        {'word': 'student', 'phonetic': '/ˈstuːdənt/', 'definition': 'A person who is studying at a school or college', 'part_of_speech': 'noun', 'difficulty_level': 2},
        {'word': 'mother', 'phonetic': '/ˈmʌðər/', 'definition': 'A female parent', 'part_of_speech': 'noun', 'difficulty_level': 1},
        {'word': 'father', 'phonetic': '/ˈfɑːðər/', 'definition': 'A male parent', 'part_of_speech': 'noun', 'difficulty_level': 1},
        {'word': 'sister', 'phonetic': '/ˈsɪstər/', 'definition': 'A female sibling', 'part_of_speech': 'noun', 'difficulty_level': 1},
        {'word': 'beautiful', 'phonetic': '/ˈbjuːtɪfəl/', 'definition': 'Pleasing to look at; attractive', 'part_of_speech': 'adjective', 'difficulty_level': 2},
        {'word': 'computer', 'phonetic': '/kəmˈpjuːtər/', 'definition': 'An electronic device for processing data', 'part_of_speech': 'noun', 'difficulty_level': 3},
        {'word': 'understand', 'phonetic': '/ˌʌndərˈstænd/', 'definition': 'To perceive the meaning of something', 'part_of_speech': 'verb', 'difficulty_level': 3},
    ]
    
    for word_data in sample_words:
        # Check if word already exists
        existing = Word.query.filter_by(word=word_data['word']).first()
        if not existing:
            word = Word(**word_data)
            db.session.add(word)
    
    db.session.commit()

if __name__ == '__main__':
    init_database()