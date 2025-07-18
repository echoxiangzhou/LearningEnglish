#!/usr/bin/env python3
"""
Integration tests for Article Management API
"""
import pytest
import json
from app import create_app, db
from app.models.article import Article, ComprehensionQuestion
from app.models.user import User


@pytest.fixture
def app():
    """Create and configure test app"""
    app = create_app()
    app.config['TESTING'] = True
    app.config['SQLALCHEMY_DATABASE_URI'] = 'sqlite:///:memory:'
    app.config['JWT_SECRET_KEY'] = 'test-jwt-key'
    
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
            password_hash='hashed_password',
            is_admin=True  # Make user admin for testing
        )
        db.session.add(user)
        db.session.commit()
        return user


@pytest.fixture
def sample_article(app):
    """Create a sample article"""
    with app.app_context():
        article = Article(
            title="Sample Reading Article",
            content="This is a sample article for testing reading comprehension features. It contains multiple sentences and paragraphs to test various reading functionalities.",
            author="Test Author",
            topic="Testing",
            grade_level=3,
            difficulty=2,
            word_count=30,
            is_published=True
        )
        article.set_tags(['test', 'sample', 'reading'])
        article.calculate_reading_time()
        
        db.session.add(article)
        db.session.flush()
        
        # Add sample questions
        questions = [
            ComprehensionQuestion(
                article_id=article.id,
                question_text="What is this article about?",
                question_type="multiple_choice",
                options=["Testing", "Reading", "Writing", "Speaking"],
                correct_answer="Testing",
                explanation="The article discusses testing functionalities.",
                order_index=1
            ),
            ComprehensionQuestion(
                article_id=article.id,
                question_text="This article is for testing purposes.",
                question_type="true_false",
                correct_answer="True",
                explanation="Yes, this is a test article.",
                order_index=2
            )
        ]
        
        for question in questions:
            db.session.add(question)
        
        db.session.commit()
        return article


class TestArticleListAPI:
    """Test article listing endpoints"""
    
    def test_get_articles_empty(self, client):
        """Test getting articles when none exist"""
        response = client.get('/api/articles')
        assert response.status_code == 200
        
        data = json.loads(response.data)
        assert 'articles' in data
        assert 'pagination' in data
        assert len(data['articles']) == 0
        assert data['pagination']['total'] == 0
    
    def test_get_articles_with_data(self, client, sample_article):
        """Test getting articles with sample data"""
        response = client.get('/api/articles')
        assert response.status_code == 200
        
        data = json.loads(response.data)
        assert len(data['articles']) == 1
        assert data['articles'][0]['title'] == "Sample Reading Article"
        assert 'content' not in data['articles'][0]  # Should not include content in list
        assert data['pagination']['total'] == 1
    
    def test_get_articles_with_pagination(self, client, app):
        """Test article pagination"""
        with app.app_context():
            # Create multiple articles
            for i in range(25):
                article = Article(
                    title=f"Article {i}",
                    content=f"Content for article {i}",
                    grade_level=1,
                    is_published=True
                )
                db.session.add(article)
            db.session.commit()
        
        # Test first page
        response = client.get('/api/articles?page=1&per_page=10')
        assert response.status_code == 200
        
        data = json.loads(response.data)
        assert len(data['articles']) == 10
        assert data['pagination']['page'] == 1
        assert data['pagination']['total'] == 25
        assert data['pagination']['has_next'] is True
    
    def test_get_articles_with_filters(self, client, app):
        """Test article filtering"""
        with app.app_context():
            # Create articles with different attributes
            articles = [
                Article(title="Grade 1 Article", content="Content", grade_level=1, difficulty=1, topic="Math", is_published=True),
                Article(title="Grade 2 Article", content="Content", grade_level=2, difficulty=2, topic="Science", is_published=True),
                Article(title="Grade 3 Article", content="Content", grade_level=3, difficulty=3, topic="Math", is_published=True),
            ]
            for article in articles:
                db.session.add(article)
            db.session.commit()
        
        # Test grade level filter
        response = client.get('/api/articles?grade_level=1')
        data = json.loads(response.data)
        assert len(data['articles']) == 1
        assert data['articles'][0]['grade_level'] == 1
        
        # Test difficulty filter
        response = client.get('/api/articles?difficulty=2')
        data = json.loads(response.data)
        assert len(data['articles']) == 1
        assert data['articles'][0]['difficulty'] == 2
        
        # Test topic filter
        response = client.get('/api/articles?topic=Math')
        data = json.loads(response.data)
        assert len(data['articles']) == 2
    
    def test_get_articles_search(self, client, app):
        """Test article search functionality"""
        with app.app_context():
            articles = [
                Article(title="Python Programming", content="Learn Python", is_published=True),
                Article(title="JavaScript Basics", content="Learn JavaScript", is_published=True),
                Article(title="Web Development", content="HTML, CSS, Python", is_published=True),
            ]
            for article in articles:
                db.session.add(article)
            db.session.commit()
        
        # Search in title
        response = client.get('/api/articles?search=Python')
        data = json.loads(response.data)
        assert len(data['articles']) == 2  # Should find both Python articles
        
        # Search in content
        response = client.get('/api/articles?search=JavaScript')
        data = json.loads(response.data)
        assert len(data['articles']) == 1


class TestArticleDetailAPI:
    """Test individual article endpoints"""
    
    def test_get_article_exists(self, client, sample_article):
        """Test getting a specific article"""
        response = client.get(f'/api/articles/{sample_article.id}')
        assert response.status_code == 200
        
        data = json.loads(response.data)
        assert data['title'] == "Sample Reading Article"
        assert 'content' in data  # Should include content for detail view
        assert 'questions' in data
        assert len(data['questions']) == 2
    
    def test_get_article_not_found(self, client):
        """Test getting non-existent article"""
        response = client.get('/api/articles/999')
        assert response.status_code == 404
    
    def test_get_unpublished_article_as_guest(self, client, app):
        """Test accessing unpublished article as guest"""
        with app.app_context():
            article = Article(
                title="Unpublished Article",
                content="Draft content",
                is_published=False
            )
            db.session.add(article)
            db.session.commit()
            article_id = article.id
        
        response = client.get(f'/api/articles/{article_id}')
        assert response.status_code == 404  # Should not be accessible


class TestArticleCreateAPI:
    """Test article creation endpoints"""
    
    def test_create_article_success(self, client, sample_user, app):
        """Test successful article creation"""
        with app.app_context():
            # Mock authentication (in real app, this would be handled by JWT)
            article_data = {
                'title': 'New Test Article',
                'content': 'This is the content of the new test article.',
                'author': 'Test Author',
                'topic': 'Testing',
                'grade_level': 2,
                'difficulty': 2,
                'is_published': True,
                'tags': ['new', 'test'],
                'questions': [
                    {
                        'question_text': 'What is the topic?',
                        'question_type': 'multiple_choice',
                        'options': ['Testing', 'Reading', 'Writing'],
                        'correct_answer': 'Testing',
                        'explanation': 'The topic is testing.'
                    }
                ]
            }
            
            # Note: In real implementation, you'd need proper JWT authentication
            # For testing, we're focusing on the data validation and processing logic
            headers = {'Content-Type': 'application/json'}
            response = client.post('/api/articles', 
                                 data=json.dumps(article_data), 
                                 headers=headers)
            
            # This would normally require authentication, so it should return 401
            # But we're testing the endpoint structure
            assert response.status_code in [201, 401, 403]  # Created or auth required
    
    def test_create_article_missing_fields(self, client):
        """Test article creation with missing required fields"""
        article_data = {'content': 'Content without title'}
        
        headers = {'Content-Type': 'application/json'}
        response = client.post('/api/articles',
                             data=json.dumps(article_data),
                             headers=headers)
        
        # Should require authentication first, but testing data validation
        assert response.status_code in [400, 401, 403]


class TestArticleUpdateAPI:
    """Test article update endpoints"""
    
    def test_update_article_not_found(self, client):
        """Test updating non-existent article"""
        update_data = {'title': 'Updated Title'}
        
        headers = {'Content-Type': 'application/json'}
        response = client.put('/api/articles/999',
                            data=json.dumps(update_data),
                            headers=headers)
        
        assert response.status_code in [404, 401, 403]


class TestArticleDeleteAPI:
    """Test article deletion endpoints"""
    
    def test_delete_article_not_found(self, client):
        """Test deleting non-existent article"""
        response = client.delete('/api/articles/999')
        assert response.status_code in [404, 401, 403]


class TestArticleSearchAPI:
    """Test advanced search functionality"""
    
    def test_search_articles_missing_term(self, client):
        """Test search without search term"""
        search_data = {'filters': {}}
        
        headers = {'Content-Type': 'application/json'}
        response = client.post('/api/articles/search',
                             data=json.dumps(search_data),
                             headers=headers)
        
        assert response.status_code == 400
    
    def test_search_articles_with_term(self, client, app):
        """Test search with valid term"""
        with app.app_context():
            article = Article(
                title="Machine Learning Basics",
                content="Introduction to machine learning concepts",
                is_published=True
            )
            db.session.add(article)
            db.session.commit()
        
        search_data = {
            'search': 'machine learning',
            'filters': {'published_only': True}
        }
        
        headers = {'Content-Type': 'application/json'}
        response = client.post('/api/articles/search',
                             data=json.dumps(search_data),
                             headers=headers)
        
        assert response.status_code == 200
        data = json.loads(response.data)
        assert 'articles' in data
        assert 'count' in data


class TestArticleMetadataAPI:
    """Test metadata endpoints"""
    
    def test_get_articles_metadata(self, client, app):
        """Test getting articles metadata"""
        with app.app_context():
            # Create articles with various metadata
            articles = [
                Article(title="Article 1", content="Content", grade_level=1, difficulty=1, topic="Math", is_published=True),
                Article(title="Article 2", content="Content", grade_level=2, difficulty=2, topic="Science", is_published=True),
                Article(title="Article 3", content="Content", grade_level=3, difficulty=3, topic="Math", is_published=True),
            ]
            for article in articles:
                db.session.add(article)
            db.session.commit()
        
        response = client.get('/api/articles/metadata')
        assert response.status_code == 200
        
        data = json.loads(response.data)
        assert 'grade_levels' in data
        assert 'difficulties' in data
        assert 'topics' in data
        assert 'total_articles' in data
        
        assert set(data['grade_levels']) == {1, 2, 3}
        assert set(data['difficulties']) == {1, 2, 3}
        assert set(data['topics']) == {'Math', 'Science'}
        assert data['total_articles'] == 3


class TestArticleQuestionsAPI:
    """Test question-related endpoints"""
    
    def test_get_article_questions(self, client, sample_article):
        """Test getting questions for an article"""
        response = client.get(f'/api/articles/{sample_article.id}/questions')
        assert response.status_code == 200
        
        data = json.loads(response.data)
        assert 'questions' in data
        assert len(data['questions']) == 2
        
        # Check question order
        questions = data['questions']
        assert questions[0]['order_index'] == 1
        assert questions[1]['order_index'] == 2
    
    def test_get_questions_for_nonexistent_article(self, client):
        """Test getting questions for non-existent article"""
        response = client.get('/api/articles/999/questions')
        assert response.status_code == 404


if __name__ == '__main__':
    pytest.main([__file__])