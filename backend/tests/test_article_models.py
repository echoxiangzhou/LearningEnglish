#!/usr/bin/env python3
"""
Unit tests for Article-related models
"""
import pytest
import json
from datetime import datetime, timedelta
from app import create_app, db
from app.models.article import Article, ComprehensionQuestion, ReadingSession, QuestionAttempt, WordLookup
from app.models.user import User
from app.models.word import Word


@pytest.fixture
def app():
    """Create and configure test app"""
    app = create_app()
    app.config['TESTING'] = True
    app.config['SQLALCHEMY_DATABASE_URI'] = 'sqlite:///:memory:'
    
    with app.app_context():
        db.create_all()
        yield app
        db.drop_all()


@pytest.fixture
def client(app):
    """Test client"""
    return app.test_client()


@pytest.fixture
def sample_user(app):
    """Create a sample user"""
    with app.app_context():
        user = User(
            username='test_user',
            email='test@example.com',
            password_hash='hashed_password'
        )
        db.session.add(user)
        db.session.commit()
        return user


@pytest.fixture
def sample_word(app):
    """Create a sample word"""
    with app.app_context():
        word = Word(
            word='comprehension',
            phonetic='/ˌkɒmprɪˈhenʃən/',
            definition='The action or capability of understanding something',
            part_of_speech='noun',
            grade_level=5,
            difficulty=3,
            frequency=75
        )
        db.session.add(word)
        db.session.commit()
        return word


class TestArticleModel:
    """Test Article model"""
    
    def test_article_creation(self, app):
        """Test creating an article"""
        with app.app_context():
            article = Article(
                title="Test Reading Article",
                content="This is a comprehensive test article for reading comprehension practice. It contains multiple sentences and paragraphs to test various reading skills.",
                author="Test Author",
                source="Test Source",
                topic="Education",
                grade_level=4,
                difficulty=3,
                word_count=25,
                is_published=True
            )
            
            db.session.add(article)
            db.session.commit()
            
            assert article.id is not None
            assert article.title == "Test Reading Article"
            assert article.grade_level == 4
            assert article.difficulty == 3
            assert article.is_published is True
    
    def test_article_tags(self, app):
        """Test article tags functionality"""
        with app.app_context():
            article = Article(
                title="Tagged Article",
                content="Article with tags"
            )
            
            # Test setting and getting tags
            tags = ['elementary', 'reading', 'practice']
            article.set_tags(tags)
            
            assert article.get_tags() == tags
            assert isinstance(article.tags, str)  # Should be JSON string
    
    def test_reading_time_calculation(self, app):
        """Test reading time calculation"""
        with app.app_context():
            article = Article(
                title="Time Test Article",
                content="Test content",
                word_count=400
            )
            
            # Test default WPM (200)
            reading_time = article.calculate_reading_time()
            assert reading_time == 2  # 400 words / 200 WPM = 2 minutes
            
            # Test custom WPM
            reading_time = article.calculate_reading_time(100)
            assert reading_time == 4  # 400 words / 100 WPM = 4 minutes
            
            # Test minimum time
            article.word_count = 50
            reading_time = article.calculate_reading_time()
            assert reading_time == 1  # Should be at least 1 minute
    
    def test_article_to_dict(self, app):
        """Test article serialization"""
        with app.app_context():
            article = Article(
                title="Serialization Test",
                content="Test content for serialization",
                author="Test Author",
                grade_level=3,
                difficulty=2,
                word_count=20,
                is_published=True
            )
            article.set_tags(['test', 'serialization'])
            
            # Test with content
            article_dict = article.to_dict(include_content=True)
            assert 'content' in article_dict
            assert article_dict['title'] == "Serialization Test"
            assert article_dict['tags'] == ['test', 'serialization']
            
            # Test without content
            article_dict = article.to_dict(include_content=False)
            assert 'content' not in article_dict


class TestComprehensionQuestionModel:
    """Test ComprehensionQuestion model"""
    
    def test_question_creation(self, app):
        """Test creating comprehension questions"""
        with app.app_context():
            article = Article(title="Test Article", content="Test content")
            db.session.add(article)
            db.session.flush()
            
            # Multiple choice question
            mc_question = ComprehensionQuestion(
                article_id=article.id,
                question_text="What is the main topic?",
                question_type="multiple_choice",
                options=["A", "B", "C", "D"],
                correct_answer="A",
                explanation="A is correct because...",
                difficulty=2,
                order_index=1
            )
            
            # True/False question
            tf_question = ComprehensionQuestion(
                article_id=article.id,
                question_text="The article is about testing?",
                question_type="true_false",
                correct_answer="True",
                explanation="Yes, the article is about testing.",
                difficulty=1,
                order_index=2
            )
            
            # Short answer question
            sa_question = ComprehensionQuestion(
                article_id=article.id,
                question_text="Explain the main concept.",
                question_type="short_answer",
                correct_answer="Testing comprehension",
                explanation="The answer should mention testing.",
                difficulty=3,
                order_index=3
            )
            
            db.session.add_all([mc_question, tf_question, sa_question])
            db.session.commit()
            
            assert mc_question.id is not None
            assert mc_question.question_type == "multiple_choice"
            assert isinstance(mc_question.options, list)
            
            assert tf_question.question_type == "true_false"
            assert sa_question.question_type == "short_answer"
    
    def test_question_to_dict(self, app):
        """Test question serialization"""
        with app.app_context():
            article = Article(title="Test", content="Test")
            db.session.add(article)
            db.session.flush()
            
            question = ComprehensionQuestion(
                article_id=article.id,
                question_text="Test question?",
                question_type="multiple_choice",
                options=["Option 1", "Option 2"],
                correct_answer="Option 1",
                difficulty=2
            )
            
            question_dict = question.to_dict()
            assert question_dict['question_text'] == "Test question?"
            assert question_dict['options'] == ["Option 1", "Option 2"]
            assert question_dict['difficulty'] == 2


class TestReadingSessionModel:
    """Test ReadingSession model"""
    
    def test_session_creation(self, app, sample_user):
        """Test creating reading sessions"""
        with app.app_context():
            article = Article(title="Session Test", content="Test content")
            db.session.add(article)
            db.session.flush()
            
            session = ReadingSession(
                user_id=sample_user.id,
                article_id=article.id,
                reading_duration=300,  # 5 minutes
                total_duration=360,    # 6 minutes
                completion_percentage=90.0,
                comprehension_score=85.5,
                questions_answered=8,
                questions_correct=7,
                status="completed"
            )
            
            db.session.add(session)
            db.session.commit()
            
            assert session.id is not None
            assert session.reading_duration == 300
            assert session.completion_percentage == 90.0
            assert session.comprehension_score == 85.5
            assert session.status == "completed"
    
    def test_bookmark_functionality(self, app, sample_user):
        """Test bookmark add functionality"""
        with app.app_context():
            article = Article(title="Bookmark Test", content="Test content")
            db.session.add(article)
            db.session.flush()
            
            session = ReadingSession(
                user_id=sample_user.id,
                article_id=article.id
            )
            db.session.add(session)
            db.session.flush()
            
            # Test adding bookmarks
            session.add_bookmark(100, "Important Point")
            session.add_bookmark(250, "Key Concept")
            session.add_bookmark(400)  # No title provided
            
            assert len(session.bookmarks) == 3
            assert session.bookmarks[0]['position'] == 100
            assert session.bookmarks[0]['title'] == "Important Point"
            assert session.bookmarks[2]['title'] == "Bookmark 3"
    
    def test_session_to_dict(self, app, sample_user):
        """Test session serialization"""
        with app.app_context():
            article = Article(title="Dict Test", content="Test")
            db.session.add(article)
            db.session.flush()
            
            session = ReadingSession(
                user_id=sample_user.id,
                article_id=article.id,
                reading_duration=180,
                completion_percentage=75.5,
                status="in_progress"
            )
            session.add_bookmark(150, "Midpoint")
            
            session_dict = session.to_dict()
            assert session_dict['reading_duration'] == 180
            assert session_dict['completion_percentage'] == 75.5
            assert session_dict['status'] == "in_progress"
            assert len(session_dict['bookmarks']) == 1


class TestQuestionAttemptModel:
    """Test QuestionAttempt model"""
    
    def test_attempt_creation(self, app, sample_user):
        """Test creating question attempts"""
        with app.app_context():
            article = Article(title="Attempt Test", content="Test")
            db.session.add(article)
            db.session.flush()
            
            question = ComprehensionQuestion(
                article_id=article.id,
                question_text="Test question?",
                correct_answer="Test answer"
            )
            db.session.add(question)
            db.session.flush()
            
            session = ReadingSession(
                user_id=sample_user.id,
                article_id=article.id
            )
            db.session.add(session)
            db.session.flush()
            
            attempt = QuestionAttempt(
                reading_session_id=session.id,
                question_id=question.id,
                user_answer="Test answer",
                is_correct=True,
                time_taken_seconds=45,
                attempt_number=1
            )
            
            db.session.add(attempt)
            db.session.commit()
            
            assert attempt.id is not None
            assert attempt.user_answer == "Test answer"
            assert attempt.is_correct is True
            assert attempt.time_taken_seconds == 45


class TestWordLookupModel:
    """Test WordLookup model"""
    
    def test_lookup_creation(self, app, sample_user, sample_word):
        """Test creating word lookups"""
        with app.app_context():
            session = ReadingSession(
                user_id=sample_user.id,
                article_id=1  # Dummy article ID
            )
            db.session.add(session)
            db.session.flush()
            
            lookup = WordLookup(
                user_id=sample_user.id,
                reading_session_id=session.id,
                word_id=sample_word.id,
                looked_up_word="comprehension",
                context_sentence="Reading comprehension is important.",
                article_position=25,
                lookup_count=1
            )
            
            db.session.add(lookup)
            db.session.commit()
            
            assert lookup.id is not None
            assert lookup.looked_up_word == "comprehension"
            assert lookup.article_position == 25
            assert lookup.lookup_count == 1
    
    def test_lookup_to_dict(self, app, sample_user, sample_word):
        """Test lookup serialization"""
        with app.app_context():
            lookup = WordLookup(
                user_id=sample_user.id,
                word_id=sample_word.id,
                looked_up_word="comprehension",
                context_sentence="Test sentence."
            )
            
            lookup_dict = lookup.to_dict()
            assert lookup_dict['looked_up_word'] == "comprehension"
            assert lookup_dict['context_sentence'] == "Test sentence."


class TestModelRelationships:
    """Test relationships between models"""
    
    def test_article_question_relationship(self, app):
        """Test article-question relationship"""
        with app.app_context():
            article = Article(title="Relationship Test", content="Test")
            db.session.add(article)
            db.session.flush()
            
            question1 = ComprehensionQuestion(
                article_id=article.id,
                question_text="Question 1?",
                correct_answer="Answer 1"
            )
            question2 = ComprehensionQuestion(
                article_id=article.id,
                question_text="Question 2?",
                correct_answer="Answer 2"
            )
            
            db.session.add_all([question1, question2])
            db.session.commit()
            
            # Test relationship
            assert len(article.questions) == 2
            assert question1.article == article
            assert question2.article == article
    
    def test_session_attempt_relationship(self, app, sample_user):
        """Test session-attempt relationship"""
        with app.app_context():
            article = Article(title="Relationship Test", content="Test")
            db.session.add(article)
            db.session.flush()
            
            question = ComprehensionQuestion(
                article_id=article.id,
                question_text="Test?",
                correct_answer="Yes"
            )
            db.session.add(question)
            db.session.flush()
            
            session = ReadingSession(
                user_id=sample_user.id,
                article_id=article.id
            )
            db.session.add(session)
            db.session.flush()
            
            attempt = QuestionAttempt(
                reading_session_id=session.id,
                question_id=question.id,
                user_answer="Yes",
                is_correct=True
            )
            db.session.add(attempt)
            db.session.commit()
            
            # Test relationships
            assert len(session.question_attempts) == 1
            assert attempt.reading_session == session
            assert attempt.question == question


if __name__ == '__main__':
    pytest.main([__file__])