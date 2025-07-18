#!/usr/bin/env python3
"""
Unit tests for Comprehension Question API endpoints
"""
import pytest
import json
from datetime import datetime
from flask_jwt_extended import create_access_token
from app import create_app, db
from app.models.article import Article, ComprehensionQuestion, ReadingSession, QuestionAttempt
from app.models.user import User


@pytest.fixture
def app():
    """Create and configure test app"""
    app = create_app()
    app.config['TESTING'] = True
    app.config['SQLALCHEMY_DATABASE_URI'] = 'sqlite:///:memory:'
    app.config['JWT_SECRET_KEY'] = 'test-secret-key'
    
    with app.app_context():
        db.create_all()
        yield app
        db.drop_all()


@pytest.fixture
def client(app):
    """Test client"""
    return app.test_client()


@pytest.fixture
def auth_headers(app):
    """Create authentication headers"""
    with app.app_context():
        # Create test user
        user = User(
            username='test_user',
            email='test@example.com',
            password_hash='hashed_password',
            is_admin=True
        )
        db.session.add(user)
        db.session.commit()
        
        # Create access token
        access_token = create_access_token(identity=user.id)
        return {
            'Authorization': f'Bearer {access_token}',
            'Content-Type': 'application/json'
        }


@pytest.fixture
def student_headers(app):
    """Create student authentication headers"""
    with app.app_context():
        # Create test student
        student = User(
            username='test_student',
            email='student@example.com',
            password_hash='hashed_password',
            is_admin=False
        )
        db.session.add(student)
        db.session.commit()
        
        # Create access token
        access_token = create_access_token(identity=student.id)
        return {
            'Authorization': f'Bearer {access_token}',
            'Content-Type': 'application/json'
        }, student.id


@pytest.fixture
def sample_article(app):
    """Create a sample article with questions"""
    with app.app_context():
        article = Article(
            title="Test Reading Article",
            content="This is a comprehensive test article for reading comprehension practice. It contains multiple sentences and paragraphs to test various reading skills. The article discusses important concepts and provides examples.",
            author="Test Author",
            topic="Education",
            grade_level=4,
            difficulty=3,
            word_count=45,
            is_published=True
        )
        db.session.add(article)
        db.session.flush()
        
        # Add questions
        questions = [
            ComprehensionQuestion(
                article_id=article.id,
                question_text="What is the main topic of the article?",
                question_type="multiple_choice",
                options=["Education", "Technology", "Sports", "Art"],
                correct_answer="Education",
                explanation="The article focuses on educational concepts.",
                difficulty=2,
                order_index=1
            ),
            ComprehensionQuestion(
                article_id=article.id,
                question_text="Does the article provide examples?",
                question_type="true_false",
                correct_answer="True",
                explanation="Yes, the article mentions providing examples.",
                difficulty=1,
                order_index=2
            ),
            ComprehensionQuestion(
                article_id=article.id,
                question_text="What does the article discuss?",
                question_type="short_answer",
                correct_answer="important concepts",
                explanation="The article discusses important concepts and examples.",
                difficulty=3,
                order_index=3
            )
        ]
        
        db.session.add_all(questions)
        db.session.commit()
        
        return article


class TestQuestionRetrievalAPI:
    """Test question retrieval endpoints"""
    
    def test_get_article_questions(self, client, sample_article):
        """Test getting questions for an article"""
        response = client.get(f'/api/articles/{sample_article.id}/questions')
        
        assert response.status_code == 200
        data = json.loads(response.data)
        
        assert 'questions' in data
        assert len(data['questions']) == 3
        
        # Check question ordering
        questions = data['questions']
        assert questions[0]['order_index'] == 1
        assert questions[1]['order_index'] == 2
        assert questions[2]['order_index'] == 3
        
        # Verify question types
        assert questions[0]['question_type'] == 'multiple_choice'
        assert questions[1]['question_type'] == 'true_false'
        assert questions[2]['question_type'] == 'short_answer'
    
    def test_get_questions_nonexistent_article(self, client):
        """Test getting questions for non-existent article"""
        response = client.get('/api/articles/999/questions')
        assert response.status_code == 404
    
    def test_get_session_questions_no_attempts(self, client, sample_article, student_headers):
        """Test getting session questions with no previous attempts"""
        headers, student_id = student_headers
        
        # Create reading session
        with client.application.app_context():
            session = ReadingSession(
                user_id=student_id,
                article_id=sample_article.id,
                status='in_progress'
            )
            db.session.add(session)
            db.session.commit()
            session_id = session.id
        
        response = client.get(f'/api/reading/sessions/{session_id}/questions', headers=headers)
        
        assert response.status_code == 200
        data = json.loads(response.data)
        
        assert 'questions' in data
        assert 'session' in data
        assert len(data['questions']) == 3
        
        # Questions should not have attempt data
        for question in data['questions']:
            assert 'attempt' not in question
            assert 'correct_answer' not in question
    
    def test_get_session_questions_unauthorized(self, client, sample_article):
        """Test getting session questions without authentication"""
        response = client.get('/api/reading/sessions/1/questions')
        assert response.status_code == 401


class TestQuestionSubmissionAPI:
    """Test question answer submission endpoints"""
    
    def test_submit_multiple_choice_correct(self, client, sample_article, student_headers):
        """Test submitting correct multiple choice answer"""
        headers, student_id = student_headers
        
        # Create reading session and get question
        with client.application.app_context():
            session = ReadingSession(
                user_id=student_id,
                article_id=sample_article.id,
                status='in_progress'
            )
            db.session.add(session)
            db.session.commit()
            session_id = session.id
            
            question = ComprehensionQuestion.query.filter_by(
                article_id=sample_article.id,
                question_type='multiple_choice'
            ).first()
            question_id = question.id
        
        # Submit correct answer
        answer_data = {
            'answer': 'Education',
            'time_taken': 30
        }
        
        response = client.post(
            f'/api/reading/sessions/{session_id}/questions/{question_id}/submit',
            headers=headers,
            data=json.dumps(answer_data)
        )
        
        assert response.status_code == 200
        data = json.loads(response.data)
        
        assert data['is_correct'] is True
        assert 'attempt' in data
        assert 'explanation' in data
        assert data['attempt']['attempt_number'] == 1
        assert data['attempt']['time_taken_seconds'] == 30
    
    def test_submit_multiple_choice_incorrect(self, client, sample_article, student_headers):
        """Test submitting incorrect multiple choice answer"""
        headers, student_id = student_headers
        
        # Create reading session and get question
        with client.application.app_context():
            session = ReadingSession(
                user_id=student_id,
                article_id=sample_article.id,
                status='in_progress'
            )
            db.session.add(session)
            db.session.commit()
            session_id = session.id
            
            question = ComprehensionQuestion.query.filter_by(
                article_id=sample_article.id,
                question_type='multiple_choice'
            ).first()
            question_id = question.id
        
        # Submit incorrect answer
        answer_data = {
            'answer': 'Technology',
            'time_taken': 25
        }
        
        response = client.post(
            f'/api/reading/sessions/{session_id}/questions/{question_id}/submit',
            headers=headers,
            data=json.dumps(answer_data)
        )
        
        assert response.status_code == 200
        data = json.loads(response.data)
        
        assert data['is_correct'] is False
        assert data['attempt']['attempt_number'] == 1
        # Correct answer should not be shown on first incorrect attempt
        assert 'correct_answer' not in data
    
    def test_submit_true_false_answer(self, client, sample_article, student_headers):
        """Test submitting true/false answer"""
        headers, student_id = student_headers
        
        # Create reading session and get question
        with client.application.app_context():
            session = ReadingSession(
                user_id=student_id,
                article_id=sample_article.id,
                status='in_progress'
            )
            db.session.add(session)
            db.session.commit()
            session_id = session.id
            
            question = ComprehensionQuestion.query.filter_by(
                article_id=sample_article.id,
                question_type='true_false'
            ).first()
            question_id = question.id
        
        # Submit answer (various formats should work)
        for answer_format in ['True', 'true', 'T', 'yes', 'Y']:
            answer_data = {
                'answer': answer_format,
                'time_taken': 15
            }
            
            response = client.post(
                f'/api/reading/sessions/{session_id}/questions/{question_id}/submit',
                headers=headers,
                data=json.dumps(answer_data)
            )
            
            assert response.status_code == 200
            data = json.loads(response.data)
            assert data['is_correct'] is True
    
    def test_submit_short_answer(self, client, sample_article, student_headers):
        """Test submitting short answer"""
        headers, student_id = student_headers
        
        # Create reading session and get question
        with client.application.app_context():
            session = ReadingSession(
                user_id=student_id,
                article_id=sample_article.id,
                status='in_progress'
            )
            db.session.add(session)
            db.session.commit()
            session_id = session.id
            
            question = ComprehensionQuestion.query.filter_by(
                article_id=sample_article.id,
                question_type='short_answer'
            ).first()
            question_id = question.id
        
        # Test partial keyword match
        answer_data = {
            'answer': 'The article talks about important concepts and ideas',
            'time_taken': 60
        }
        
        response = client.post(
            f'/api/reading/sessions/{session_id}/questions/{question_id}/submit',
            headers=headers,
            data=json.dumps(answer_data)
        )
        
        assert response.status_code == 200
        data = json.loads(response.data)
        assert data['is_correct'] is True  # Should match "important" and "concepts"
    
    def test_submit_answer_retry(self, client, sample_article, student_headers):
        """Test submitting answer multiple times (retry functionality)"""
        headers, student_id = student_headers
        
        # Create reading session and get question
        with client.application.app_context():
            session = ReadingSession(
                user_id=student_id,
                article_id=sample_article.id,
                status='in_progress'
            )
            db.session.add(session)
            db.session.commit()
            session_id = session.id
            
            question = ComprehensionQuestion.query.filter_by(
                article_id=sample_article.id,
                question_type='multiple_choice'
            ).first()
            question_id = question.id
        
        # First attempt - incorrect
        answer_data = {
            'answer': 'Technology',
            'time_taken': 25
        }
        
        response = client.post(
            f'/api/reading/sessions/{session_id}/questions/{question_id}/submit',
            headers=headers,
            data=json.dumps(answer_data)
        )
        
        assert response.status_code == 200
        data = json.loads(response.data)
        assert data['is_correct'] is False
        assert data['attempt']['attempt_number'] == 1
        
        # Second attempt - still incorrect, should show correct answer
        answer_data = {
            'answer': 'Sports',
            'time_taken': 20
        }
        
        response = client.post(
            f'/api/reading/sessions/{session_id}/questions/{question_id}/submit',
            headers=headers,
            data=json.dumps(answer_data)
        )
        
        assert response.status_code == 200
        data = json.loads(response.data)
        assert data['is_correct'] is False
        assert data['attempt']['attempt_number'] == 2
        assert 'correct_answer' in data  # Should show correct answer after 2nd attempt
        assert data['correct_answer'] == 'Education'
    
    def test_submit_answer_missing_data(self, client, sample_article, student_headers):
        """Test submitting answer with missing data"""
        headers, student_id = student_headers
        
        # Create reading session
        with client.application.app_context():
            session = ReadingSession(
                user_id=student_id,
                article_id=sample_article.id,
                status='in_progress'
            )
            db.session.add(session)
            db.session.commit()
            session_id = session.id
            
            question = ComprehensionQuestion.query.filter_by(
                article_id=sample_article.id,
                question_type='multiple_choice'
            ).first()
            question_id = question.id
        
        # Submit without answer
        response = client.post(
            f'/api/reading/sessions/{session_id}/questions/{question_id}/submit',
            headers=headers,
            data=json.dumps({})
        )
        
        assert response.status_code == 400
        data = json.loads(response.data)
        assert 'error' in data
    
    def test_submit_answer_unauthorized(self, client, sample_article):
        """Test submitting answer without authentication"""
        response = client.post(
            '/api/reading/sessions/1/questions/1/submit',
            data=json.dumps({'answer': 'test'})
        )
        assert response.status_code == 401


class TestQuestionAdministrationAPI:
    """Test question administration endpoints"""
    
    def test_add_question_to_article(self, client, sample_article, auth_headers):
        """Test adding a new question to an article"""
        question_data = {
            'question_text': 'What grade level is this article for?',
            'question_type': 'multiple_choice',
            'options': ['Grade 3', 'Grade 4', 'Grade 5', 'Grade 6'],
            'correct_answer': 'Grade 4',
            'explanation': 'The article is written at a 4th grade level.',
            'difficulty': 2
        }
        
        response = client.post(
            f'/api/articles/{sample_article.id}/questions',
            headers=auth_headers,
            data=json.dumps(question_data)
        )
        
        assert response.status_code == 201
        data = json.loads(response.data)
        
        assert data['message'] == 'Question added successfully'
        assert 'question' in data
        assert data['question']['question_text'] == question_data['question_text']
        assert data['question']['order_index'] == 4  # Should be next after existing 3
    
    def test_add_question_missing_fields(self, client, sample_article, auth_headers):
        """Test adding question with missing required fields"""
        question_data = {
            'question_text': 'Incomplete question?',
            # Missing correct_answer
        }
        
        response = client.post(
            f'/api/articles/{sample_article.id}/questions',
            headers=auth_headers,
            data=json.dumps(question_data)
        )
        
        assert response.status_code == 400
        data = json.loads(response.data)
        assert 'error' in data
    
    def test_add_question_non_admin(self, client, sample_article, student_headers):
        """Test adding question as non-admin user"""
        headers, _ = student_headers
        
        question_data = {
            'question_text': 'Unauthorized question?',
            'correct_answer': 'No'
        }
        
        response = client.post(
            f'/api/articles/{sample_article.id}/questions',
            headers=headers,
            data=json.dumps(question_data)
        )
        
        assert response.status_code == 403


class TestAutomaticGradingLogic:
    """Test the automatic grading algorithms"""
    
    def test_grade_multiple_choice(self, app):
        """Test multiple choice grading"""
        from app.routes.articles import _grade_answer
        
        with app.app_context():
            question = ComprehensionQuestion(
                question_type='multiple_choice',
                correct_answer='A'
            )
            
            # Test exact match (case insensitive)
            assert _grade_answer(question, 'A') is True
            assert _grade_answer(question, 'a') is True
            assert _grade_answer(question, 'B') is False
            assert _grade_answer(question, '') is False
    
    def test_grade_true_false(self, app):
        """Test true/false grading"""
        from app.routes.articles import _grade_answer
        
        with app.app_context():
            question = ComprehensionQuestion(
                question_type='true_false',
                correct_answer='True'
            )
            
            # Test various true formats
            true_formats = ['True', 'true', 'T', 't', 'Yes', 'yes', 'Y', 'y', '1']
            for answer in true_formats:
                assert _grade_answer(question, answer) is True
            
            # Test false formats
            false_formats = ['False', 'false', 'F', 'f', 'No', 'no', 'N', 'n', '0']
            for answer in false_formats:
                assert _grade_answer(question, answer) is False
    
    def test_grade_short_answer(self, app):
        """Test short answer grading"""
        from app.routes.articles import _grade_answer
        
        with app.app_context():
            question = ComprehensionQuestion(
                question_type='short_answer',
                correct_answer='important educational concepts'
            )
            
            # Test keyword matching
            assert _grade_answer(question, 'important concepts') is True
            assert _grade_answer(question, 'educational ideas') is True
            assert _grade_answer(question, 'important educational topics') is True
            
            # Test insufficient keywords
            assert _grade_answer(question, 'concepts') is False  # Only 1 out of 2 keywords
            assert _grade_answer(question, 'unrelated answer') is False
            assert _grade_answer(question, '') is False


class TestReadingSessionStatistics:
    """Test reading session statistics updates"""
    
    def test_session_stats_update(self, client, sample_article, student_headers):
        """Test that session statistics are updated after question attempts"""
        headers, student_id = student_headers
        
        # Create reading session
        with client.application.app_context():
            session = ReadingSession(
                user_id=student_id,
                article_id=sample_article.id,
                status='in_progress'
            )
            db.session.add(session)
            db.session.commit()
            session_id = session.id
            
            questions = ComprehensionQuestion.query.filter_by(
                article_id=sample_article.id
            ).all()
        
        # Submit answers to all questions
        answers = [
            {'answer': 'Education', 'correct': True},     # Multiple choice - correct
            {'answer': 'True', 'correct': True},          # True/false - correct
            {'answer': 'wrong answer', 'correct': False}   # Short answer - incorrect
        ]
        
        for i, (question, answer_data) in enumerate(zip(questions, answers)):
            response = client.post(
                f'/api/reading/sessions/{session_id}/questions/{question.id}/submit',
                headers=headers,
                data=json.dumps({'answer': answer_data['answer'], 'time_taken': 30})
            )
            assert response.status_code == 200
        
        # Check session statistics
        with client.application.app_context():
            updated_session = ReadingSession.query.get(session_id)
            assert updated_session.questions_answered == 3
            assert updated_session.questions_correct == 2
            assert updated_session.comprehension_score == 66.67  # 2/3 * 100, rounded


if __name__ == '__main__':
    pytest.main([__file__])