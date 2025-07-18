"""
Test suite for RecommendationService

Tests the personalized article recommendation engine based on user performance,
reading history, and intelligent content matching algorithms.
"""

import pytest
from unittest.mock import Mock, patch, MagicMock
from datetime import datetime, timedelta

from app.services.recommendation_service import RecommendationService
from app.models.article import Article
from app.models.article import ReadingSession
from app.models.user import User


class TestRecommendationService:
    """Test cases for RecommendationService"""
    
    @pytest.fixture
    def service(self):
        """Create RecommendationService instance"""
        return RecommendationService()
    
    @pytest.fixture
    def mock_articles(self):
        """Mock article data"""
        return [
            Mock(
                id=1, title="Beginner Science", difficulty_level=1, 
                word_count=100, reading_time=5, category="science", 
                tags=["basic", "intro"], is_active=True,
                created_at=datetime.utcnow()
            ),
            Mock(
                id=2, title="Intermediate History", difficulty_level=2, 
                word_count=200, reading_time=8, category="history", 
                tags=["medieval", "europe"], is_active=True,
                created_at=datetime.utcnow()
            ),
            Mock(
                id=3, title="Advanced Mathematics", difficulty_level=4, 
                word_count=500, reading_time=15, category="math", 
                tags=["calculus", "advanced"], is_active=True,
                created_at=datetime.utcnow()
            ),
            Mock(
                id=4, title="Challenging Literature", difficulty_level=5, 
                word_count=800, reading_time=25, category="literature", 
                tags=["classic", "analysis"], is_active=True,
                created_at=datetime.utcnow()
            )
        ]
    
    @pytest.fixture
    def mock_user_performance(self):
        """Mock user performance data"""
        return {
            'preferred_difficulty': 2,
            'avg_comprehension': 75.0,
            'avg_reading_speed': 150.0,
            'performance_trend': 0.1,
            'consistency_score': 0.8,
            'session_count': 15,
            'category_preferences': {
                'science': {'preference_score': 3.5, 'engagement_score': 5, 'performance_score': 80},
                'history': {'preference_score': 2.8, 'engagement_score': 3, 'performance_score': 70}
            }
        }
    
    @pytest.fixture
    def mock_db_session(self):
        """Mock database session"""
        mock_db = Mock()
        
        # Mock query chain for articles
        mock_query = Mock()
        mock_db.query.return_value = mock_query
        mock_query.filter.return_value = mock_query
        mock_query.order_by.return_value = mock_query
        mock_query.limit.return_value = mock_query
        mock_query.all.return_value = []
        mock_query.first.return_value = None
        
        return mock_db

    @patch('app.services.recommendation_service.get_db')
    def test_get_comprehensive_recommendations(self, mock_get_db, service, mock_articles, mock_user_performance):
        """Test comprehensive recommendation generation"""
        mock_db = Mock()
        mock_get_db.return_value.__next__.return_value = mock_db
        
        with patch.object(service.difficulty_service, '_analyze_user_performance', return_value=mock_user_performance), \
             patch.object(service, '_get_challenge_recommendations', return_value=mock_articles[:1]), \
             patch.object(service, '_get_comfort_recommendations', return_value=mock_articles[1:2]), \
             patch.object(service, '_get_exploration_recommendations', return_value=mock_articles[2:3]), \
             patch.object(service, '_get_trending_recommendations', return_value=mock_articles[3:4]), \
             patch.object(service, '_get_user_profile_summary', return_value=mock_user_performance), \
             patch.object(service, '_get_recommendation_stats', return_value={'total_articles': 100}):
            
            result = service.get_comprehensive_recommendations(user_id=1, limit=20)
            
            assert 'challenge' in result
            assert 'comfort' in result
            assert 'explore' in result
            assert 'trending' in result
            assert 'user_profile' in result
            assert 'recommendation_stats' in result
            
            assert isinstance(result['challenge'], list)
            assert isinstance(result['comfort'], list)
            assert isinstance(result['explore'], list)
            assert isinstance(result['trending'], list)

    def test_get_challenge_recommendations(self, service, mock_articles, mock_user_performance, mock_db_session):
        """Test challenge recommendation generation"""
        # Mock articles at target level (user_level + 1)
        challenge_articles = [a for a in mock_articles if a.difficulty_level == 3]
        mock_db_session.query.return_value.filter.return_value.order_by.return_value.limit.return_value.all.return_value = challenge_articles
        
        with patch.object(service.difficulty_service, '_recently_read', return_value=False):
            result = service._get_challenge_recommendations(1, mock_user_performance, mock_db_session, 5)
            
            assert isinstance(result, list)
            # Should return formatted recommendations
            if result:
                assert 'id' in result[0]
                assert 'title' in result[0]
                assert 'recommendation_type' in result[0]
                assert result[0]['recommendation_type'] == 'challenge'

    def test_get_comfort_recommendations(self, service, mock_articles, mock_user_performance, mock_db_session):
        """Test comfort recommendation generation"""
        # Mock articles at user's current level
        comfort_articles = [a for a in mock_articles if a.difficulty_level == 2]
        mock_db_session.query.return_value.filter.return_value.order_by.return_value.limit.return_value.all.return_value = comfort_articles
        
        with patch.object(service.difficulty_service, '_recently_read', return_value=False):
            result = service._get_comfort_recommendations(1, mock_user_performance, mock_db_session, 5)
            
            assert isinstance(result, list)
            if result:
                assert 'recommendation_type' in result[0]
                assert result[0]['recommendation_type'] == 'comfort'

    def test_get_exploration_recommendations(self, service, mock_articles, mock_user_performance, mock_db_session):
        """Test exploration recommendation generation"""
        # Mock unread categories
        mock_db_session.query.return_value.join.return_value.filter.return_value.distinct.return_value.all.return_value = [('science',), ('history',)]
        
        # Mock articles in new categories
        exploration_articles = [a for a in mock_articles if a.category not in ['science', 'history']]
        mock_db_session.query.return_value.filter.return_value.order_by.return_value.limit.return_value.all.return_value = exploration_articles
        
        with patch.object(service.difficulty_service, '_recently_read', return_value=False):
            result = service._get_exploration_recommendations(1, mock_user_performance, mock_db_session, 5)
            
            assert isinstance(result, list)
            if result:
                assert 'recommendation_type' in result[0]
                assert result[0]['recommendation_type'] == 'explore'

    def test_get_trending_recommendations(self, service, mock_articles, mock_user_performance, mock_db_session):
        """Test trending recommendation generation"""
        # Mock trending query results
        trending_data = [
            Mock(id=1, title="Trending 1", difficulty_level=2, category="science", session_count=5, avg_score=85),
            Mock(id=2, title="Trending 2", difficulty_level=3, category="history", session_count=4, avg_score=80)
        ]
        
        mock_db_session.query.return_value.join.return_value.filter.return_value.group_by.return_value.having.return_value.order_by.return_value.limit.return_value.all.return_value = trending_data
        mock_db_session.query.return_value.filter.return_value.all.return_value = mock_articles[:2]
        
        with patch.object(service.difficulty_service, '_recently_read', return_value=False):
            result = service._get_trending_recommendations(1, mock_user_performance, mock_db_session, 5)
            
            assert isinstance(result, list)
            if result:
                assert 'recommendation_type' in result[0]
                assert result[0]['recommendation_type'] == 'trending'

    def test_calculate_challenge_score(self, service, mock_user_performance):
        """Test challenge score calculation"""
        # Test article at appropriate challenge level
        article = Mock(difficulty_level=3, reading_time=15, word_count=400)
        
        score = service._calculate_challenge_score(article, mock_user_performance)
        
        assert isinstance(score, float)
        assert score >= 0
        
        # Test that improving users get higher scores for challenging content
        improving_performance = mock_user_performance.copy()
        improving_performance['performance_trend'] = 0.2
        improving_performance['consistency_score'] = 0.9
        
        improving_score = service._calculate_challenge_score(article, improving_performance)
        assert improving_score >= score

    def test_calculate_comfort_score(self, service, mock_user_performance):
        """Test comfort score calculation"""
        # Test article at user's comfort level
        article = Mock(difficulty_level=2, reading_time=10, category='science')
        
        score = service._calculate_comfort_score(article, mock_user_performance)
        
        assert isinstance(score, float)
        assert score >= 0
        
        # Article in preferred category should get higher score
        preferred_article = Mock(difficulty_level=2, reading_time=10, category='science')
        non_preferred_article = Mock(difficulty_level=2, reading_time=10, category='unknown')
        
        preferred_score = service._calculate_comfort_score(preferred_article, mock_user_performance)
        non_preferred_score = service._calculate_comfort_score(non_preferred_article, mock_user_performance)
        
        assert preferred_score > non_preferred_score

    def test_calculate_exploration_score(self, service, mock_user_performance):
        """Test exploration score calculation"""
        article = Mock(difficulty_level=2, reading_time=8, category='new_category')
        
        score = service._calculate_exploration_score(article, mock_user_performance)
        
        assert isinstance(score, float)
        assert score >= 0
        
        # Shorter articles should get higher exploration scores
        short_article = Mock(difficulty_level=2, reading_time=5, category='new_category')
        long_article = Mock(difficulty_level=2, reading_time=20, category='new_category')
        
        short_score = service._calculate_exploration_score(short_article, mock_user_performance)
        long_score = service._calculate_exploration_score(long_article, mock_user_performance)
        
        assert short_score > long_score

    def test_calculate_trending_score(self, service, mock_user_performance):
        """Test trending score calculation"""
        # Test article at appropriate difficulty for trending
        article = Mock(difficulty_level=2, reading_time=12)
        
        score = service._calculate_trending_score(article, mock_user_performance)
        
        assert isinstance(score, float)
        assert score >= 0
        
        # Article at user's level should score higher than very difficult ones
        easy_article = Mock(difficulty_level=2, reading_time=12)
        hard_article = Mock(difficulty_level=5, reading_time=12)
        
        easy_score = service._calculate_trending_score(easy_article, mock_user_performance)
        hard_score = service._calculate_trending_score(hard_article, mock_user_performance)
        
        assert easy_score > hard_score

    def test_format_recommendations(self, service, mock_articles):
        """Test recommendation formatting"""
        scored_articles = [
            {'article': mock_articles[0], 'score': 85.0},
            {'article': mock_articles[1], 'score': 75.0}
        ]
        
        result = service._format_recommendations(scored_articles, 'challenge')
        
        assert isinstance(result, list)
        assert len(result) == 2
        
        for item in result:
            assert 'id' in item
            assert 'title' in item
            assert 'difficulty_level' in item
            assert 'word_count' in item
            assert 'reading_time' in item
            assert 'category' in item
            assert 'recommendation_score' in item
            assert 'recommendation_type' in item
            assert 'reason' in item
            assert item['recommendation_type'] == 'challenge'

    def test_get_recommendation_reason(self, service, mock_articles):
        """Test recommendation reason generation"""
        article = mock_articles[0]
        
        challenge_reason = service._get_recommendation_reason('challenge', article)
        comfort_reason = service._get_recommendation_reason('comfort', article)
        explore_reason = service._get_recommendation_reason('explore', article)
        trending_reason = service._get_recommendation_reason('trending', article)
        
        assert isinstance(challenge_reason, str)
        assert isinstance(comfort_reason, str)
        assert isinstance(explore_reason, str)
        assert isinstance(trending_reason, str)
        
        assert len(challenge_reason) > 0
        assert len(comfort_reason) > 0
        assert len(explore_reason) > 0
        assert len(trending_reason) > 0

    def test_get_user_profile_summary(self, service, mock_user_performance):
        """Test user profile summary generation"""
        result = service._get_user_profile_summary(mock_user_performance)
        
        assert 'reading_level' in result
        assert 'avg_comprehension' in result
        assert 'avg_reading_speed' in result
        assert 'performance_trend' in result
        assert 'consistency_score' in result
        assert 'total_sessions' in result
        assert 'top_categories' in result
        
        assert result['reading_level'] == mock_user_performance['preferred_difficulty']
        assert result['avg_comprehension'] == mock_user_performance['avg_comprehension']
        assert isinstance(result['top_categories'], list)

    def test_get_recommendation_stats(self, service, mock_db_session):
        """Test recommendation statistics generation"""
        # Mock database queries
        mock_db_session.query.return_value.filter.return_value.count.return_value = 100
        mock_db_session.query.return_value.filter.return_value.distinct.return_value.count.return_value = 15
        mock_db_session.query.return_value.join.return_value.filter.return_value.distinct.return_value.count.return_value = 5
        
        result = service._get_recommendation_stats(1, mock_db_session)
        
        assert 'total_articles' in result
        assert 'articles_read' in result
        assert 'completion_percentage' in result
        assert 'categories_explored' in result
        assert 'recommendations_generated' in result
        
        assert result['total_articles'] == 100
        assert result['articles_read'] == 15
        assert result['categories_explored'] == 5

    def test_get_similar_articles(self, service, mock_articles, mock_db_session):
        """Test similar articles recommendation"""
        reference_article = mock_articles[0]
        similar_articles = mock_articles[1:3]
        
        # Mock database queries
        mock_db_session.query.return_value.filter.return_value.first.return_value = reference_article
        mock_db_session.query.return_value.filter.return_value.limit.return_value.all.return_value = similar_articles
        
        result = service.get_similar_articles(article_id=1, limit=5)
        
        assert isinstance(result, list)
        if result:
            assert 'id' in result[0]
            assert 'title' in result[0]
            assert 'recommendation_type' in result[0]
            assert result[0]['recommendation_type'] == 'similar'

    def test_calculate_similarity_score(self, service):
        """Test similarity score calculation between articles"""
        ref_article = Mock(
            category='science',
            difficulty_level=2,
            word_count=200,
            reading_time=10
        )
        
        # Identical article (minus ID)
        identical_article = Mock(
            category='science',
            difficulty_level=2,
            word_count=200,
            reading_time=10
        )
        
        # Different article
        different_article = Mock(
            category='history',
            difficulty_level=4,
            word_count=500,
            reading_time=20
        )
        
        identical_score = service._calculate_similarity_score(ref_article, identical_article)
        different_score = service._calculate_similarity_score(ref_article, different_article)
        
        assert identical_score > different_score
        assert identical_score >= 0
        assert different_score >= 0

    def test_get_fallback_recommendations(self, service, mock_db_session, mock_articles):
        """Test fallback recommendations when main algorithm fails"""
        mock_db_session.query.return_value.filter.return_value.order_by.return_value.limit.return_value.all.return_value = mock_articles
        
        with patch('app.services.recommendation_service.get_db') as mock_get_db:
            mock_get_db.return_value.__next__.return_value = mock_db_session
            
            result = service._get_fallback_recommendations(user_id=1)
            
            assert isinstance(result, dict)
            assert 'challenge' in result
            assert 'comfort' in result
            assert 'explore' in result
            assert 'trending' in result
            assert 'user_profile' in result
            assert 'recommendation_stats' in result

    def test_error_handling(self, service):
        """Test error handling in recommendation service"""
        # Test with invalid user ID
        with patch('app.services.recommendation_service.get_db') as mock_get_db:
            mock_get_db.side_effect = Exception("Database error")
            
            # Should not raise exception, should return fallback
            result = service.get_comprehensive_recommendations(user_id=999, limit=10)
            
            # Should return empty or fallback structure
            assert isinstance(result, dict)

    def test_recommendation_weights(self, service):
        """Test recommendation weight configuration"""
        assert hasattr(service, 'WEIGHTS')
        assert isinstance(service.WEIGHTS, dict)
        
        # Check that weights sum to reasonable total
        total_weight = sum(service.WEIGHTS.values())
        assert 0.8 <= total_weight <= 1.2  # Allow some flexibility

    def test_recommendation_types(self, service):
        """Test recommendation type definitions"""
        assert hasattr(service, 'RECOMMENDATION_TYPES')
        assert isinstance(service.RECOMMENDATION_TYPES, dict)
        
        expected_types = ['challenge', 'comfort', 'explore', 'trending']
        for rec_type in expected_types:
            assert rec_type in service.RECOMMENDATION_TYPES
            assert isinstance(service.RECOMMENDATION_TYPES[rec_type], str)

    def test_empty_user_performance(self, service, mock_db_session):
        """Test handling of users with no reading history"""
        empty_performance = {
            'avg_comprehension': 0.0,
            'avg_reading_speed': 0.0,
            'preferred_difficulty': 2,
            'performance_trend': 0.0,
            'category_preferences': {},
            'session_count': 0,
            'consistency_score': 0.0
        }
        
        with patch.object(service.difficulty_service, '_analyze_user_performance', return_value=empty_performance):
            result = service._get_challenge_recommendations(1, empty_performance, mock_db_session, 5)
            
            # Should still return valid structure
            assert isinstance(result, list)

    def test_large_limit_handling(self, service, mock_user_performance, mock_db_session):
        """Test handling of large recommendation limits"""
        large_limit = 1000
        
        with patch.object(service.difficulty_service, '_analyze_user_performance', return_value=mock_user_performance):
            # Should handle large limits gracefully
            result = service._get_challenge_recommendations(1, mock_user_performance, mock_db_session, large_limit)
            
            assert isinstance(result, list)
            # Should not cause performance issues or crashes


if __name__ == '__main__':
    pytest.main([__file__])