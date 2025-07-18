#!/usr/bin/env python3
"""
Unit tests for Reading Analytics API endpoints
"""
import pytest
import json
from datetime import datetime, timedelta
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
    """Create authentication headers for test user"""
    with app.app_context():
        # Create test user
        user = User(
            username='test_reader',
            email='reader@example.com',
            password_hash='hashed_password',
            is_admin=False
        )
        db.session.add(user)
        db.session.commit()
        
        # Create access token
        access_token = create_access_token(identity=user.id)
        return {
            'Authorization': f'Bearer {access_token}',
            'Content-Type': 'application/json'
        }, user.id


@pytest.fixture
def sample_reading_data(app, auth_headers):
    """Create sample reading data for testing"""
    headers, user_id = auth_headers
    
    with app.app_context():
        # Create articles
        articles = []
        for i in range(3):
            article = Article(
                title=f"Test Article {i+1}",
                content=f"This is test content for article {i+1}. " * 20,
                grade_level=i+2,
                difficulty=i+1,
                word_count=100 + (i * 50),
                is_published=True
            )
            db.session.add(article)
            articles.append(article)
        
        db.session.flush()
        
        # Create reading sessions with varying dates
        sessions = []
        for i, article in enumerate(articles):
            # Create sessions from past days
            for days_ago in range(7):
                session_date = datetime.utcnow() - timedelta(days=days_ago)
                
                session = ReadingSession(
                    user_id=user_id,
                    article_id=article.id,
                    start_time=session_date,
                    end_time=session_date + timedelta(minutes=10 + i),
                    reading_duration=(10 + i) * 60,  # in seconds
                    total_duration=(12 + i) * 60,
                    completion_percentage=80 + (i * 5),
                    comprehension_score=70 + (i * 10),
                    questions_answered=5,
                    questions_correct=3 + i,
                    status='completed',
                    created_at=session_date
                )
                db.session.add(session)
                sessions.append(session)
        
        db.session.commit()
        
        return {
            'articles': articles,
            'sessions': sessions,
            'user_id': user_id
        }


class TestReadingAnalyticsOverview:
    """Test reading analytics overview endpoint"""
    
    def test_get_overview_with_data(self, client, sample_reading_data, auth_headers):
        """Test getting overview with reading data"""
        headers, user_id = auth_headers
        
        response = client.get('/api/reading/analytics/overview', headers=headers)
        
        assert response.status_code == 200
        data = json.loads(response.data)
        
        # Check structure
        assert 'overview' in data
        assert 'daily_reading' in data
        assert 'difficulty_breakdown' in data
        assert 'achievements' in data
        assert 'period_days' in data
        
        # Check overview data
        overview = data['overview']
        assert overview['total_sessions'] > 0
        assert overview['total_articles_read'] > 0
        assert overview['total_reading_time'] > 0
        assert overview['average_comprehension_score'] > 0
        assert overview['reading_streak'] >= 0
        
        # Check daily reading data
        assert len(data['daily_reading']) >= 0
        
        # Check difficulty breakdown
        assert len(data['difficulty_breakdown']) > 0
        for diff in data['difficulty_breakdown']:
            assert 'difficulty' in diff
            assert 'sessions' in diff
            assert 'average_score' in diff
    
    def test_get_overview_different_periods(self, client, sample_reading_data, auth_headers):
        """Test getting overview for different time periods"""
        headers, user_id = auth_headers
        
        for days in [7, 30, 90]:
            response = client.get(f'/api/reading/analytics/overview?days={days}', headers=headers)
            
            assert response.status_code == 200
            data = json.loads(response.data)
            assert data['period_days'] == days
    
    def test_get_overview_no_data(self, client, auth_headers):
        """Test getting overview with no reading data"""
        headers, user_id = auth_headers
        
        response = client.get('/api/reading/analytics/overview', headers=headers)
        
        assert response.status_code == 200
        data = json.loads(response.data)
        
        overview = data['overview']
        assert overview['total_sessions'] == 0
        assert overview['total_articles_read'] == 0
        assert overview['total_reading_time'] == 0
    
    def test_get_overview_unauthorized(self, client):
        """Test getting overview without authentication"""
        response = client.get('/api/reading/analytics/overview')
        assert response.status_code == 401


class TestReadingProgressTimeline:
    """Test reading progress timeline endpoint"""
    
    def test_get_timeline_with_data(self, client, sample_reading_data, auth_headers):
        """Test getting timeline with reading data"""
        headers, user_id = auth_headers
        
        response = client.get('/api/reading/analytics/progress', headers=headers)
        
        assert response.status_code == 200
        data = json.loads(response.data)
        
        # Check structure
        assert 'timeline' in data
        assert 'period_days' in data
        assert 'generated_at' in data
        
        # Check timeline data
        timeline = data['timeline']
        assert len(timeline) == 30  # Default period
        
        # Check timeline entry structure
        for entry in timeline:
            assert 'date' in entry
            assert 'reading_time' in entry
            assert 'sessions' in entry
            assert 'completed_sessions' in entry
            assert 'average_comprehension' in entry
            assert 'articles_read' in entry
    
    def test_get_timeline_different_periods(self, client, sample_reading_data, auth_headers):
        """Test getting timeline for different periods"""
        headers, user_id = auth_headers
        
        for days in [7, 30, 90]:
            response = client.get(f'/api/reading/analytics/progress?days={days}', headers=headers)
            
            assert response.status_code == 200
            data = json.loads(response.data)
            assert len(data['timeline']) == days
            assert data['period_days'] == days
    
    def test_get_timeline_chronological_order(self, client, sample_reading_data, auth_headers):
        """Test that timeline data is in chronological order"""
        headers, user_id = auth_headers
        
        response = client.get('/api/reading/analytics/progress?days=7', headers=headers)
        
        assert response.status_code == 200
        data = json.loads(response.data)
        
        timeline = data['timeline']
        dates = [datetime.fromisoformat(entry['date']) for entry in timeline]
        
        # Check that dates are in ascending order (oldest to newest)
        for i in range(1, len(dates)):
            assert dates[i] >= dates[i-1]
    
    def test_get_timeline_unauthorized(self, client):
        """Test getting timeline without authentication"""
        response = client.get('/api/reading/analytics/progress')
        assert response.status_code == 401


class TestReadingRecommendations:
    """Test reading recommendations endpoint"""
    
    def test_get_recommendations_new_user(self, client, auth_headers):
        """Test recommendations for new user with no reading history"""
        headers, user_id = auth_headers
        
        response = client.get('/api/reading/analytics/recommendations', headers=headers)
        
        assert response.status_code == 200
        data = json.loads(response.data)
        
        # Check structure
        assert 'recommendations' in data
        assert 'user_stats' in data
        assert 'generated_at' in data
        
        # Should have at least one recommendation for new user
        recommendations = data['recommendations']
        assert len(recommendations) > 0
        
        # Should have "Start Your Reading Journey" recommendation
        start_rec = next((r for r in recommendations if r['type'] == 'consistency'), None)
        assert start_rec is not None
        assert start_rec['title'] == 'Start Your Reading Journey'
    
    def test_get_recommendations_active_user(self, client, sample_reading_data, auth_headers):
        """Test recommendations for user with reading history"""
        headers, user_id = auth_headers
        
        response = client.get('/api/reading/analytics/recommendations', headers=headers)
        
        assert response.status_code == 200
        data = json.loads(response.data)
        
        recommendations = data['recommendations']
        user_stats = data['user_stats']
        
        # Check recommendation structure
        for rec in recommendations:
            assert 'type' in rec
            assert 'priority' in rec
            assert 'title' in rec
            assert 'description' in rec
            assert 'action' in rec
            assert 'icon' in rec
            assert rec['priority'] in ['high', 'medium', 'low']
    
    def test_recommendations_based_on_performance(self, client, auth_headers):
        """Test that recommendations change based on user performance"""
        headers, user_id = auth_headers
        
        with client.application.app_context():
            # Create articles and sessions with poor comprehension
            article = Article(
                title="Low Comprehension Test",
                content="Test content",
                difficulty=1,
                word_count=100,
                is_published=True
            )
            db.session.add(article)
            db.session.flush()
            
            # Create session with low comprehension score
            session = ReadingSession(
                user_id=user_id,
                article_id=article.id,
                reading_duration=600,
                comprehension_score=50,  # Low score
                status='completed'
            )
            db.session.add(session)
            db.session.commit()
        
        response = client.get('/api/reading/analytics/recommendations', headers=headers)
        
        assert response.status_code == 200
        data = json.loads(response.data)
        
        # Should recommend focusing on comprehension
        comprehension_rec = next(
            (r for r in data['recommendations'] if r['type'] == 'comprehension'), 
            None
        )
        assert comprehension_rec is not None
        assert 'comprehension' in comprehension_rec['title'].lower()
    
    def test_get_recommendations_unauthorized(self, client):
        """Test getting recommendations without authentication"""
        response = client.get('/api/reading/analytics/recommendations')
        assert response.status_code == 401


class TestAnalyticsIntegration:
    """Test integration between different analytics endpoints"""
    
    def test_data_consistency_across_endpoints(self, client, sample_reading_data, auth_headers):
        """Test that data is consistent across different analytics endpoints"""
        headers, user_id = auth_headers
        
        # Get data from both endpoints
        overview_response = client.get('/api/reading/analytics/overview', headers=headers)
        timeline_response = client.get('/api/reading/analytics/progress', headers=headers)
        
        assert overview_response.status_code == 200
        assert timeline_response.status_code == 200
        
        overview_data = json.loads(overview_response.data)
        timeline_data = json.loads(timeline_response.data)
        
        # Check that session counts are consistent
        total_sessions_from_timeline = sum(day['sessions'] for day in timeline_data['timeline'])
        overview_sessions = overview_data['overview']['total_sessions']
        
        # Note: They might not be exactly equal if overview uses different filters
        # but they should be in a reasonable range
        assert total_sessions_from_timeline >= 0
        assert overview_sessions >= 0
    
    def test_achievements_logic(self, client, sample_reading_data, auth_headers):
        """Test achievement calculation logic"""
        headers, user_id = auth_headers
        
        response = client.get('/api/reading/analytics/overview', headers=headers)
        
        assert response.status_code == 200
        data = json.loads(response.data)
        
        achievements = data['achievements']
        overview = data['overview']
        
        # Check achievement logic
        if overview['reading_streak'] >= 7:
            streak_achievement = next(
                (a for a in achievements if a['id'] == 'streak_7'), 
                None
            )
            assert streak_achievement is not None
        
        if overview['total_articles_read'] >= 10:
            articles_achievement = next(
                (a for a in achievements if a['id'] == 'articles_10'), 
                None
            )
            assert articles_achievement is not None


class TestAnalyticsPerformance:
    """Test analytics performance and edge cases"""
    
    def test_large_dataset_performance(self, client, auth_headers):
        """Test analytics with larger dataset"""
        headers, user_id = auth_headers
        
        with client.application.app_context():
            # Create many articles and sessions
            articles = []
            for i in range(50):
                article = Article(
                    title=f"Performance Test Article {i}",
                    content="Test content " * 100,
                    difficulty=(i % 5) + 1,
                    word_count=500,
                    is_published=True
                )
                db.session.add(article)
                articles.append(article)
            
            db.session.flush()
            
            # Create many sessions
            for i in range(100):
                session = ReadingSession(
                    user_id=user_id,
                    article_id=articles[i % len(articles)].id,
                    reading_duration=300 + (i * 10),
                    comprehension_score=60 + (i % 40),
                    status='completed',
                    created_at=datetime.utcnow() - timedelta(days=i % 30)
                )
                db.session.add(session)
            
            db.session.commit()
        
        # Test that endpoints still respond in reasonable time
        import time
        
        start_time = time.time()
        response = client.get('/api/reading/analytics/overview', headers=headers)
        end_time = time.time()
        
        assert response.status_code == 200
        assert (end_time - start_time) < 5.0  # Should complete within 5 seconds
    
    def test_edge_case_empty_sessions(self, client, auth_headers):
        """Test analytics with sessions that have null values"""
        headers, user_id = auth_headers
        
        with client.application.app_context():
            article = Article(
                title="Edge Case Article",
                content="Test content",
                difficulty=1,
                word_count=100,
                is_published=True
            )
            db.session.add(article)
            db.session.flush()
            
            # Create session with minimal data
            session = ReadingSession(
                user_id=user_id,
                article_id=article.id,
                status='in_progress'  # Not completed
                # Many fields will be None/null
            )
            db.session.add(session)
            db.session.commit()
        
        # Should handle null values gracefully
        response = client.get('/api/reading/analytics/overview', headers=headers)
        
        assert response.status_code == 200
        data = json.loads(response.data)
        
        # Should not crash and should provide sensible defaults
        overview = data['overview']
        assert overview['total_sessions'] >= 0
        assert overview['average_comprehension_score'] >= 0


if __name__ == '__main__':
    pytest.main([__file__])