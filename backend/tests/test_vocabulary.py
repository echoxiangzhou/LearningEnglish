"""
Test module for vocabulary learning functionality
"""
import pytest
import json
from datetime import datetime, timedelta
from app import create_app, db
from app.models.user import User
from app.models.word import Word
from app.models.vocabulary import (
    VocabularyCategory, UserVocabulary, VocabularyTestResult,
    VocabularySession, MasteryLevel, TestType
)
from app.services.vocabulary_service import VocabularyService

@pytest.fixture
def app():
    """Create test app"""
    app = create_app()
    app.config['TESTING'] = True
    app.config['SQLALCHEMY_DATABASE_URI'] = 'sqlite:///:memory:'
    
    with app.app_context():
        db.create_all()
        yield app
        db.session.remove()
        db.drop_all()

@pytest.fixture
def client(app):
    """Create test client"""
    return app.test_client()

@pytest.fixture
def sample_user(app):
    """Create a sample user for testing"""
    with app.app_context():
        user = User(
            username='testuser',
            email='test@example.com',
            password_hash='hashed_password'
        )
        db.session.add(user)
        db.session.commit()
        return user

@pytest.fixture
def sample_words(app):
    """Create sample words for testing"""
    with app.app_context():
        words = [
            Word(
                word='apple',
                phonetic='/ˈæpəl/',
                definition='A round fruit with red or green skin',
                part_of_speech='noun',
                grade_level=1,
                difficulty=1,
                frequency=100
            ),
            Word(
                word='beautiful',
                phonetic='/ˈbjuːtɪfəl/',
                definition='Pleasing to look at; attractive',
                part_of_speech='adjective',
                grade_level=3,
                difficulty=2,
                frequency=80
            ),
            Word(
                word='computer',
                phonetic='/kəmˈpjuːtər/',
                definition='An electronic device for processing data',
                part_of_speech='noun',
                grade_level=5,
                difficulty=3,
                frequency=90
            )
        ]
        
        for word in words:
            db.session.add(word)
        db.session.commit()
        return words

@pytest.fixture
def sample_category(app):
    """Create a sample vocabulary category"""
    with app.app_context():
        category = VocabularyCategory(
            name='Fruits',
            description='Words related to fruits',
            grade_level=1
        )
        db.session.add(category)
        db.session.commit()
        return category

class TestVocabularyModels:
    """Test vocabulary model functionality"""
    
    def test_vocabulary_category_creation(self, app, sample_category):
        """Test creating a vocabulary category"""
        with app.app_context():
            assert sample_category.name == 'Fruits'
            assert sample_category.description == 'Words related to fruits'
            assert sample_category.grade_level == 1
            assert sample_category.is_active == True
    
    def test_user_vocabulary_creation(self, app, sample_user, sample_words):
        """Test creating user vocabulary progress"""
        with app.app_context():
            word = sample_words[0]
            user_vocab = UserVocabulary(
                user_id=sample_user.id,
                word_id=word.id,
                mastery_level=MasteryLevel.NEW
            )
            db.session.add(user_vocab)
            db.session.commit()
            
            assert user_vocab.mastery_level == MasteryLevel.NEW
            assert user_vocab.easiness_factor == 2.5
            assert user_vocab.interval == 1
            assert user_vocab.repetitions == 0
    
    def test_spaced_repetition_algorithm(self, app, sample_user, sample_words):
        """Test SM-2 spaced repetition algorithm"""
        with app.app_context():
            word = sample_words[0]
            user_vocab = UserVocabulary(
                user_id=sample_user.id,
                word_id=word.id
            )
            db.session.add(user_vocab)
            db.session.commit()
            
            # Test good quality response
            user_vocab.calculate_next_review(quality=4)
            assert user_vocab.interval == 1
            assert user_vocab.repetitions == 1
            assert user_vocab.next_review is not None
            
            # Test another good response
            user_vocab.calculate_next_review(quality=4)
            assert user_vocab.interval == 6
            assert user_vocab.repetitions == 2
            
            # Test poor quality response
            user_vocab.calculate_next_review(quality=1)
            assert user_vocab.repetitions == 0
            assert user_vocab.interval == 1
    
    def test_mastery_level_update(self, app, sample_user, sample_words):
        """Test mastery level calculation"""
        with app.app_context():
            word = sample_words[0]
            user_vocab = UserVocabulary(
                user_id=sample_user.id,
                word_id=word.id,
                review_count=10,
                correct_count=9,
                repetitions=5
            )
            user_vocab.success_rate = user_vocab.correct_count / user_vocab.review_count
            user_vocab.update_mastery_level()
            
            assert user_vocab.mastery_level == MasteryLevel.MASTERED
    
    def test_custom_tags(self, app, sample_user, sample_words):
        """Test custom tags functionality"""
        with app.app_context():
            word = sample_words[0]
            user_vocab = UserVocabulary(
                user_id=sample_user.id,
                word_id=word.id
            )
            
            tags = ['important', 'review-later', 'difficult']
            user_vocab.set_custom_tags(tags)
            
            assert user_vocab.get_custom_tags() == tags

class TestVocabularyService:
    """Test vocabulary service functionality"""
    
    def test_add_word_to_vocabulary(self, app, sample_user, sample_words):
        """Test adding word to user vocabulary"""
        with app.app_context():
            word = sample_words[0]
            
            result = VocabularyService.add_word_to_user_vocabulary(
                user_id=sample_user.id,
                word_id=word.id,
                is_favorite=True,
                personal_notes="This is my note",
                custom_tags=['important']
            )
            
            assert result['is_favorite'] == True
            assert result['personal_notes'] == "This is my note"
            assert result['custom_tags'] == ['important']
    
    def test_search_vocabulary(self, app, sample_user, sample_words):
        """Test vocabulary search functionality"""
        with app.app_context():
            results = VocabularyService.search_vocabulary(
                query='apple',
                user_id=sample_user.id,
                limit=10
            )
            
            assert len(results) == 1
            assert results[0]['word'] == 'apple'
    
    def test_record_test_result(self, app, sample_user, sample_words):
        """Test recording test results"""
        with app.app_context():
            word = sample_words[0]
            
            result = VocabularyService.record_test_result(
                user_id=sample_user.id,
                word_id=word.id,
                test_type='reading',
                is_correct=True,
                response_time=2.5,
                user_answer='apple',
                correct_answer='apple'
            )
            
            assert result['is_correct'] == True
            assert result['response_time'] == 2.5
            assert result['test_type'] == 'reading'
            
            # Check that user vocabulary was updated
            user_vocab = UserVocabulary.query.filter_by(
                user_id=sample_user.id,
                word_id=word.id
            ).first()
            
            assert user_vocab is not None
            assert user_vocab.review_count == 1
            assert user_vocab.correct_count == 1
            assert user_vocab.success_rate == 1.0
    
    def test_generate_vocabulary_quiz(self, app, sample_user, sample_words):
        """Test quiz generation"""
        with app.app_context():
            # Add some words to user vocabulary
            for word in sample_words:
                VocabularyService.add_word_to_user_vocabulary(
                    user_id=sample_user.id,
                    word_id=word.id
                )
            
            quiz = VocabularyService.generate_vocabulary_quiz(
                user_id=sample_user.id,
                test_type='reading',
                num_questions=2
            )
            
            assert quiz['test_type'] == 'reading'
            assert len(quiz['questions']) <= 2
            assert quiz['total_questions'] <= 2
            
            # Check question structure
            if quiz['questions']:
                question = quiz['questions'][0]
                assert 'word_id' in question
                assert 'word' in question
                assert 'test_type' in question
                assert 'correct_answer' in question
    
    def test_vocabulary_statistics(self, app, sample_user, sample_words):
        """Test vocabulary statistics calculation"""
        with app.app_context():
            # Add some words with different mastery levels
            word1, word2, word3 = sample_words
            
            # Add words to vocabulary
            VocabularyService.add_word_to_user_vocabulary(sample_user.id, word1.id, is_favorite=True)
            VocabularyService.add_word_to_user_vocabulary(sample_user.id, word2.id)
            VocabularyService.add_word_to_user_vocabulary(sample_user.id, word3.id)
            
            # Record some test results
            VocabularyService.record_test_result(
                sample_user.id, word1.id, 'reading', True, 2.0, 'apple', 'apple'
            )
            
            stats = VocabularyService.get_vocabulary_statistics(sample_user.id)
            
            assert stats['total_words'] == 3
            assert stats['favorites_count'] == 1
            assert 'mastery_distribution' in stats
            assert 'average_success_rate' in stats
    
    def test_due_words_for_review(self, app, sample_user, sample_words):
        """Test getting words due for review"""
        with app.app_context():
            word = sample_words[0]
            
            # Create user vocabulary with past due date
            user_vocab = UserVocabulary(
                user_id=sample_user.id,
                word_id=word.id,
                next_review=datetime.utcnow() - timedelta(days=1),
                due_for_review=True
            )
            db.session.add(user_vocab)
            db.session.commit()
            
            due_words = VocabularyService.get_due_words_for_review(
                user_id=sample_user.id,
                limit=10
            )
            
            assert len(due_words) == 1
            assert due_words[0]['word_id'] == word.id

if __name__ == '__main__':
    pytest.main([__file__])