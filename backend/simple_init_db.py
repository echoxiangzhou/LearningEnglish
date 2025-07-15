#!/usr/bin/env python3
"""
Simplified database initialization script
"""
import os
import sys
from sqlalchemy import text, create_engine
from sqlalchemy.orm import sessionmaker

# Add current directory to Python path
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))

def create_simple_app():
    """Create a minimal Flask app for database initialization"""
    from flask import Flask
    from flask_sqlalchemy import SQLAlchemy
    from dotenv import load_dotenv
    
    load_dotenv()
    
    app = Flask(__name__)
    app.config['SQLALCHEMY_DATABASE_URI'] = os.environ.get('DATABASE_URL') or \
        'postgresql://postgres:qnlm8765@localhost:5432/learning_english'
    app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False
    
    db = SQLAlchemy()
    db.init_app(app)
    
    return app, db

def init_database():
    """Initialize database with minimal imports"""
    app, db = create_simple_app()
    
    with app.app_context():
        try:
            print("Testing database connection...")
            
            # Test database connection
            result = db.session.execute(text("SELECT version()"))
            version = result.fetchone()[0]
            print(f"✅ Connected to: {version}")
            
            # Import models after app context is set up
            print("Importing models...")
            from app.models.user import User
            from app.models.word import Word
            from app.models.vocabulary import (
                VocabularyCategory, UserVocabulary, VocabularyTestResult, 
                VocabularySession, VocabularyAchievement, word_categories
            )
            
            print("Creating database tables...")
            db.create_all()
            print("✅ Database tables created successfully!")
            
            # Add sample data
            print("Adding sample vocabulary categories...")
            add_sample_categories(db, VocabularyCategory)
            
            print("Adding sample words...")
            add_sample_words(db, Word, VocabularyCategory)
            
            print("✅ Database initialization completed successfully!")
            
        except Exception as e:
            print(f"❌ Error initializing database: {e}")
            import traceback
            traceback.print_exc()
            db.session.rollback()
            raise
        finally:
            db.session.close()

def add_sample_categories(db, VocabularyCategory):
    """Add sample vocabulary categories"""
    categories = [
        {'name': 'Animals', 'description': 'Words related to animals and pets', 'grade_level': 1},
        {'name': 'Food & Drinks', 'description': 'Words related to food, meals, and beverages', 'grade_level': 1},
        {'name': 'Colors', 'description': 'Basic color words', 'grade_level': 1},
        {'name': 'School', 'description': 'Words related to school and education', 'grade_level': 2},
        {'name': 'Family', 'description': 'Words related to family members and relationships', 'grade_level': 1},
        {'name': 'Transportation', 'description': 'Words related to vehicles and transportation', 'grade_level': 2},
        {'name': 'Weather', 'description': 'Words related to weather and climate', 'grade_level': 3},
        {'name': 'Science', 'description': 'Basic science and nature words', 'grade_level': 4}
    ]
    
    for cat_data in categories:
        existing = VocabularyCategory.query.filter_by(name=cat_data['name']).first()
        if not existing:
            category = VocabularyCategory(**cat_data)
            db.session.add(category)
    
    db.session.commit()

def add_sample_words(db, Word, VocabularyCategory):
    """Add sample words to the database"""
    sample_words = [
        # Animals
        {'word': 'cat', 'phonetic': '/kæt/', 'definition': 'A small domesticated carnivorous mammal', 'part_of_speech': 'noun', 'grade_level': 1, 'difficulty': 1, 'frequency': 95, 'category': 'Animals'},
        {'word': 'dog', 'phonetic': '/dɔːɡ/', 'definition': 'A domesticated carnivorous mammal that is typically kept as a pet', 'part_of_speech': 'noun', 'grade_level': 1, 'difficulty': 1, 'frequency': 98, 'category': 'Animals'},
        {'word': 'bird', 'phonetic': '/bɜːrd/', 'definition': 'A warm-blooded egg-laying vertebrate animal with feathers and wings', 'part_of_speech': 'noun', 'grade_level': 1, 'difficulty': 1, 'frequency': 90, 'category': 'Animals'},
        
        # Food & Drinks
        {'word': 'apple', 'phonetic': '/ˈæpəl/', 'definition': 'A round fruit with red or green skin and crisp flesh', 'part_of_speech': 'noun', 'grade_level': 1, 'difficulty': 1, 'frequency': 92, 'category': 'Food & Drinks'},
        {'word': 'water', 'phonetic': '/ˈwɔːtər/', 'definition': 'A colorless, transparent, odorless liquid that forms the seas, lakes, rivers, and rain', 'part_of_speech': 'noun', 'grade_level': 1, 'difficulty': 1, 'frequency': 100, 'category': 'Food & Drinks'},
        {'word': 'bread', 'phonetic': '/bred/', 'definition': 'Food made of flour, water, and yeast baked into a loaf', 'part_of_speech': 'noun', 'grade_level': 1, 'difficulty': 1, 'frequency': 88, 'category': 'Food & Drinks'},
        
        # Colors
        {'word': 'red', 'phonetic': '/red/', 'definition': 'The color of blood, fire, or rubies', 'part_of_speech': 'adjective', 'grade_level': 1, 'difficulty': 1, 'frequency': 95, 'category': 'Colors'},
        {'word': 'blue', 'phonetic': '/bluː/', 'definition': 'The color of the sky or sea on a sunny day', 'part_of_speech': 'adjective', 'grade_level': 1, 'difficulty': 1, 'frequency': 93, 'category': 'Colors'},
        
        # School
        {'word': 'teacher', 'phonetic': '/ˈtiːtʃər/', 'definition': 'A person who teaches, especially in a school', 'part_of_speech': 'noun', 'grade_level': 2, 'difficulty': 2, 'frequency': 85, 'category': 'School'},
        {'word': 'book', 'phonetic': '/bʊk/', 'definition': 'A written or printed work consisting of pages bound together', 'part_of_speech': 'noun', 'grade_level': 1, 'difficulty': 1, 'frequency': 90, 'category': 'School'},
        
        # More words without categories
        {'word': 'beautiful', 'phonetic': '/ˈbjuːtɪfəl/', 'definition': 'Pleasing to look at; attractive', 'part_of_speech': 'adjective', 'grade_level': 3, 'difficulty': 2, 'frequency': 80, 'category': None},
        {'word': 'computer', 'phonetic': '/kəmˈpjuːtər/', 'definition': 'An electronic device for processing data', 'part_of_speech': 'noun', 'grade_level': 5, 'difficulty': 3, 'frequency': 75, 'category': 'Science'},
    ]
    
    # Get category mappings
    categories = {cat.name: cat for cat in VocabularyCategory.query.all()}
    
    for word_data in sample_words:
        category_name = word_data.pop('category', None)
        
        # Check if word already exists
        existing = Word.query.filter_by(word=word_data['word']).first()
        if not existing:
            word = Word(**word_data)
            db.session.add(word)
            db.session.flush()  # Flush to get the ID
            
            # Add category relationship if specified
            if category_name and category_name in categories:
                word.categories.append(categories[category_name])
    
    db.session.commit()

if __name__ == '__main__':
    init_database()