"""
Test suite for Recommendation API endpoints

Tests the API endpoints for difficulty assessment and personalized recommendations
in the reading comprehension module.
"""

import pytest
import json
from unittest.mock import Mock, patch
from datetime import datetime

from app import create_app
from app.models.article import Article
from app.models.user import User


class TestRecommendationAPI:
    """Test cases for Recommendation API endpoints"""
    
    @pytest.fixture
    def app(self):
        """Create test Flask application"""
        app = create_app('testing')
        return app
    
    @pytest.fixture
    def client(self, app):
        """Create test client"""
        return app.test_client()
    
    @pytest.fixture
    def auth_headers(self):
        """Mock authentication headers"""
        return {
            'Authorization': 'Bearer test-jwt-token',
            'Content-Type': 'application/json'
        }
    
    @pytest.fixture
    def mock_user(self):
        """Mock user for authentication"""
        user = Mock()
        user.id = 1
        user.username = 'testuser'
        user.is_admin = True
        return user
    
    @pytest.fixture
    def mock_article(self):
        """Mock article for testing"""
        article = Mock()
        article.id = 1
        article.title = "Test Article"
        article.content = "This is a test article content for difficulty assessment."
        article.difficulty_level = 2
        article.word_count = 100
        article.reading_time = 5
        article.category = "science"
        article.tags = ["test", "science"]
        article.is_published = True
        return article
    
    @pytest.fixture
    def sample_assessment(self):
        """Sample difficulty assessment result"""
        return {
            'difficulty_score': 2.5,
            'difficulty_level': 'medium',
            'recommended_grade': 3,
            'confidence': 0.85,
            'metrics': {
                'vocabulary': {'complexity_score': 2.3},
                'sentence_structure': {'complexity_score': 2.7},
                'readability': {'overall_score': 2.5}
            },
            'recommendations': ['Good for intermediate readers'],
            'assessment_timestamp': '2024-01-01T12:00:00'
        }
    
    @pytest.fixture
    def sample_recommendations(self):
        """Sample recommendations data"""
        return {
            'challenge': [
                {
                    'id': 1,
                    'title': 'Challenge Article',
                    'difficulty_level': 3,
                    'recommendation_score': 85,
                    'reason': 'Good challenge for improvement'
                }
            ],
            'comfort': [
                {
                    'id': 2,
                    'title': 'Comfort Article',
                    'difficulty_level': 2,
                    'recommendation_score': 80,
                    'reason': 'Perfect for your level'
                }
            ],
            'user_profile': {
                'reading_level': 2,
                'avg_comprehension': 75.0
            },
            'recommendation_stats': {
                'total_articles': 100,
                'articles_read': 15
            }
        }

    @patch('app.routes.articles.get_jwt_identity')
    @patch('app.routes.articles.User')
    @patch('app.routes.articles.Article')
    def test_assess_article_difficulty(self, mock_article_model, mock_user_model, mock_jwt, 
                                     client, auth_headers, mock_user, mock_article, sample_assessment):
        """Test POST /api/articles/<id>/difficulty-assessment"""
        # Setup mocks
        mock_jwt.return_value = 1
        mock_user_model.query.get.return_value = mock_user
        mock_article_model.query.get_or_404.return_value = mock_article
        
        with patch('app.routes.articles.DifficultyAssessmentService') as mock_service:
            mock_service.return_value.assess_text_difficulty.return_value = sample_assessment
            
            # Test assessment without updating article
            response = client.post(
                '/api/articles/1/difficulty-assessment',
                headers=auth_headers,
                data=json.dumps({'update_article': False})
            )
            
            assert response.status_code == 200
            data = json.loads(response.data)
            
            assert 'assessment' in data
            assert 'article_id' in data
            assert 'updated' in data
            assert data['article_id'] == 1
            assert data['updated'] is False
            
            # Verify assessment structure
            assessment = data['assessment']
            assert 'difficulty_score' in assessment
            assert 'difficulty_level' in assessment
            assert 'recommended_grade' in assessment

    @patch('app.routes.articles.get_jwt_identity')
    @patch('app.routes.articles.User')
    @patch('app.routes.articles.Article')
    @patch('app.routes.articles.db')
    def test_assess_article_difficulty_with_update(self, mock_db, mock_article_model, 
                                                 mock_user_model, mock_jwt, client, 
                                                 auth_headers, mock_user, mock_article, sample_assessment):
        """Test difficulty assessment with article update"""
        # Setup mocks
        mock_jwt.return_value = 1
        mock_user_model.query.get.return_value = mock_user
        mock_article_model.query.get_or_404.return_value = mock_article
        
        with patch('app.routes.articles.DifficultyAssessmentService') as mock_service:
            mock_service.return_value.assess_text_difficulty.return_value = sample_assessment
            
            response = client.post(
                '/api/articles/1/difficulty-assessment',
                headers=auth_headers,
                data=json.dumps({'update_article': True})
            )
            
            assert response.status_code == 200
            data = json.loads(response.data)
            assert data['updated'] is True
            
            # Verify article was updated
            assert mock_article.difficulty_level == sample_assessment['recommended_grade']
            mock_db.session.commit.assert_called_once()

    @patch('app.routes.articles.get_jwt_identity')
    @patch('app.routes.articles.User')
    def test_assess_text_difficulty(self, mock_user_model, mock_jwt, client, 
                                  auth_headers, mock_user, sample_assessment):
        """Test POST /api/articles/difficulty-assessment"""
        # Setup mocks
        mock_jwt.return_value = 1
        mock_user_model.query.get.return_value = mock_user
        
        with patch('app.routes.articles.DifficultyAssessmentService') as mock_service:
            mock_service.return_value.assess_text_difficulty.return_value = sample_assessment
            
            test_data = {
                'text': 'This is a sample text for difficulty assessment.',
                'title': 'Sample Title'
            }
            
            response = client.post(
                '/api/articles/difficulty-assessment',
                headers=auth_headers,
                data=json.dumps(test_data)
            )
            
            assert response.status_code == 200
            data = json.loads(response.data)
            
            assert 'assessment' in data
            assert 'text_length' in data
            assert 'word_count' in data
            assert data['text_length'] == len(test_data['text'])
            assert data['word_count'] == len(test_data['text'].split())

    def test_assess_text_difficulty_missing_text(self, client, auth_headers):
        """Test difficulty assessment with missing text"""
        with patch('app.routes.articles.get_jwt_identity', return_value=1), \
             patch('app.routes.articles.User') as mock_user_model:
            
            mock_user = Mock()
            mock_user.is_admin = True
            mock_user_model.query.get.return_value = mock_user
            
            response = client.post(
                '/api/articles/difficulty-assessment',
                headers=auth_headers,
                data=json.dumps({})
            )
            
            assert response.status_code == 400
            data = json.loads(response.data)
            assert 'error' in data
            assert 'Text content is required' in data['error']

    @patch('app.routes.articles.get_jwt_identity')
    def test_get_personalized_recommendations(self, mock_jwt, client, auth_headers, sample_recommendations):
        """Test GET /api/reading/recommendations"""
        mock_jwt.return_value = 1
        
        with patch('app.routes.articles.RecommendationService') as mock_service:
            mock_service.return_value.get_comprehensive_recommendations.return_value = sample_recommendations
            
            response = client.get('/api/reading/recommendations', headers=auth_headers)
            
            assert response.status_code == 200
            data = json.loads(response.data)
            
            assert 'recommendations' in data
            assert 'user_id' in data
            assert 'generated_at' in data
            assert data['user_id'] == 1
            
            # Verify recommendation structure
            recommendations = data['recommendations']
            assert 'challenge' in recommendations
            assert 'comfort' in recommendations
            assert 'user_profile' in recommendations

    @patch('app.routes.articles.get_jwt_identity')
    def test_get_personalized_recommendations_with_limit(self, mock_jwt, client, auth_headers, sample_recommendations):
        """Test recommendations with custom limit"""
        mock_jwt.return_value = 1
        
        with patch('app.routes.articles.RecommendationService') as mock_service:
            mock_service.return_value.get_comprehensive_recommendations.return_value = sample_recommendations
            
            response = client.get('/api/reading/recommendations?limit=10', headers=auth_headers)
            
            assert response.status_code == 200
            
            # Verify service was called with correct limit
            mock_service.return_value.get_comprehensive_recommendations.assert_called_with(
                user_id=1, limit=10
            )

    @patch('app.routes.articles.get_jwt_identity')
    def test_get_simple_recommendations(self, mock_jwt, client, auth_headers):
        """Test GET /api/reading/recommendations/simple"""
        mock_jwt.return_value = 1
        
        simple_recs = [
            {
                'id': 1,
                'title': 'Simple Article',
                'difficulty_level': 2,
                'recommendation_score': 85,
                'reasons': ['Good for your level']
            }
        ]
        
        with patch('app.routes.articles.DifficultyAssessmentService') as mock_service:
            mock_service.return_value.get_personalized_recommendations.return_value = simple_recs
            
            response = client.get('/api/reading/recommendations/simple', headers=auth_headers)
            
            assert response.status_code == 200
            data = json.loads(response.data)
            
            assert 'recommendations' in data
            assert 'count' in data
            assert 'user_id' in data
            assert data['count'] == len(simple_recs)

    @patch('app.routes.articles.get_jwt_identity')
    @patch('app.routes.articles.Article')
    @patch('app.routes.articles.User')
    def test_get_similar_articles(self, mock_user_model, mock_article_model, 
                                mock_jwt, client, auth_headers, mock_article):
        """Test GET /api/articles/<id>/similar"""
        mock_jwt.return_value = 1
        mock_article_model.query.get_or_404.return_value = mock_article
        
        similar_articles = [
            {
                'id': 2,
                'title': 'Similar Article',
                'difficulty_level': 2,
                'recommendation_score': 75
            }
        ]
        
        with patch('app.routes.articles.RecommendationService') as mock_service:
            mock_service.return_value.get_similar_articles.return_value = similar_articles
            
            response = client.get('/api/articles/1/similar', headers=auth_headers)
            
            assert response.status_code == 200
            data = json.loads(response.data)
            
            assert 'similar_articles' in data
            assert 'reference_article_id' in data
            assert 'count' in data
            assert data['reference_article_id'] == 1
            assert data['count'] == len(similar_articles)

    @patch('app.routes.articles.get_jwt_identity')
    def test_get_user_performance_analysis(self, mock_jwt, client, auth_headers):
        """Test GET /api/reading/user-performance"""
        mock_jwt.return_value = 1
        
        user_performance = {
            'avg_comprehension': 75.0,
            'avg_reading_speed': 150.0,
            'preferred_difficulty': 2,
            'performance_trend': 0.1
        }
        
        with patch('app.routes.articles.DifficultyAssessmentService') as mock_service, \
             patch('app.routes.articles.get_db') as mock_get_db:
            
            mock_db = Mock()
            mock_get_db.return_value.__next__.return_value = mock_db
            mock_service.return_value._analyze_user_performance.return_value = user_performance
            
            response = client.get('/api/reading/user-performance', headers=auth_headers)
            
            assert response.status_code == 200
            data = json.loads(response.data)
            
            assert 'user_performance' in data
            assert 'user_id' in data
            assert 'analysis_date' in data
            assert data['user_id'] == 1

    @patch('app.routes.articles.get_jwt_identity')
    @patch('app.routes.articles.User')
    @patch('app.routes.articles.Article')
    @patch('app.routes.articles.db')
    def test_batch_assess_article_difficulty(self, mock_db, mock_article_model, 
                                           mock_user_model, mock_jwt, client, 
                                           auth_headers, mock_user, sample_assessment):
        """Test POST /api/articles/batch-difficulty-assessment"""
        # Setup mocks
        mock_jwt.return_value = 1
        mock_user_model.query.get.return_value = mock_user
        
        # Mock articles
        mock_articles = [Mock(id=1, content="Test 1", title="Title 1"),
                        Mock(id=2, content="Test 2", title="Title 2")]
        mock_article_model.query.get.side_effect = lambda x: mock_articles[x-1] if x <= 2 else None
        
        with patch('app.routes.articles.DifficultyAssessmentService') as mock_service:
            mock_service.return_value.assess_text_difficulty.return_value = sample_assessment
            
            test_data = {
                'article_ids': [1, 2],
                'update_articles': True
            }
            
            response = client.post(
                '/api/articles/batch-difficulty-assessment',
                headers=auth_headers,
                data=json.dumps(test_data)
            )
            
            assert response.status_code == 200
            data = json.loads(response.data)
            
            assert 'results' in data
            assert 'total_processed' in data
            assert 'successful' in data
            assert 'updated' in data
            assert data['total_processed'] == 2
            assert data['successful'] == 2
            assert data['updated'] == 2

    def test_batch_assess_too_many_articles(self, client, auth_headers):
        """Test batch assessment with too many articles"""
        with patch('app.routes.articles.get_jwt_identity', return_value=1), \
             patch('app.routes.articles.User') as mock_user_model:
            
            mock_user = Mock()
            mock_user.is_admin = True
            mock_user_model.query.get.return_value = mock_user
            
            test_data = {
                'article_ids': list(range(1, 52))  # 51 articles (exceeds limit of 50)
            }
            
            response = client.post(
                '/api/articles/batch-difficulty-assessment',
                headers=auth_headers,
                data=json.dumps(test_data)
            )
            
            assert response.status_code == 400
            data = json.loads(response.data)
            assert 'Maximum 50 articles per batch' in data['error']

    def test_unauthorized_access(self, client):
        """Test unauthorized access to protected endpoints"""
        # Test without authorization header
        response = client.post('/api/articles/difficulty-assessment')
        assert response.status_code == 401
        
        response = client.get('/api/reading/recommendations')
        assert response.status_code == 401

    @patch('app.routes.articles.get_jwt_identity')
    @patch('app.routes.articles.User')
    def test_non_admin_access_to_admin_endpoints(self, mock_user_model, mock_jwt, client, auth_headers):
        """Test non-admin access to admin-only endpoints"""
        mock_jwt.return_value = 1
        
        # Mock non-admin user
        mock_user = Mock()
        mock_user.is_admin = False
        mock_user_model.query.get.return_value = mock_user
        
        response = client.post(
            '/api/articles/difficulty-assessment',
            headers=auth_headers,
            data=json.dumps({'text': 'test'})
        )
        
        assert response.status_code == 403

    def test_invalid_json_data(self, client, auth_headers):
        """Test invalid JSON data handling"""
        with patch('app.routes.articles.get_jwt_identity', return_value=1), \
             patch('app.routes.articles.User') as mock_user_model:
            
            mock_user = Mock()
            mock_user.is_admin = True
            mock_user_model.query.get.return_value = mock_user
            
            response = client.post(
                '/api/articles/difficulty-assessment',
                headers={'Authorization': 'Bearer test-jwt-token'},
                data='invalid json'
            )
            
            assert response.status_code == 400

    @patch('app.routes.articles.get_jwt_identity')
    def test_service_error_handling(self, mock_jwt, client, auth_headers):
        """Test error handling when services raise exceptions"""
        mock_jwt.return_value = 1
        
        with patch('app.routes.articles.RecommendationService') as mock_service:
            mock_service.return_value.get_comprehensive_recommendations.side_effect = Exception("Service error")
            
            response = client.get('/api/reading/recommendations', headers=auth_headers)
            
            assert response.status_code == 500
            data = json.loads(response.data)
            assert 'error' in data

    @patch('app.routes.articles.get_jwt_identity')
    @patch('app.routes.articles.Article')
    def test_article_not_found(self, mock_article_model, mock_jwt, client, auth_headers):
        """Test handling of non-existent articles"""
        mock_jwt.return_value = 1
        mock_article_model.query.get_or_404.side_effect = Exception("Not found")
        
        response = client.get('/api/articles/999/similar', headers=auth_headers)
        
        assert response.status_code == 500

    def test_recommendations_limit_validation(self, client, auth_headers):
        """Test recommendation limit validation"""
        with patch('app.routes.articles.get_jwt_identity', return_value=1), \
             patch('app.routes.articles.RecommendationService') as mock_service:
            
            mock_service.return_value.get_comprehensive_recommendations.return_value = {}
            
            # Test maximum limit enforcement
            response = client.get('/api/reading/recommendations?limit=100', headers=auth_headers)
            
            assert response.status_code == 200
            
            # Verify limit was capped at 50
            mock_service.return_value.get_comprehensive_recommendations.assert_called_with(
                user_id=1, limit=50
            )

    @patch('app.routes.articles.get_jwt_identity')
    @patch('app.routes.articles.User')
    @patch('app.routes.articles.Article')
    def test_unpublished_article_access(self, mock_article_model, mock_user_model, 
                                       mock_jwt, client, auth_headers):
        """Test access to unpublished articles"""
        mock_jwt.return_value = 1
        
        # Mock unpublished article
        mock_article = Mock()
        mock_article.is_published = False
        mock_article_model.query.get_or_404.return_value = mock_article
        
        # Test with non-admin user
        mock_user = Mock()
        mock_user.is_admin = False
        mock_user_model.query.get.return_value = mock_user
        
        response = client.get('/api/articles/1/similar', headers=auth_headers)
        
        assert response.status_code == 404

    @patch('app.routes.articles.get_jwt_identity')
    def test_empty_recommendations(self, mock_jwt, client, auth_headers):
        """Test handling of empty recommendation results"""
        mock_jwt.return_value = 1
        
        with patch('app.routes.articles.DifficultyAssessmentService') as mock_service:
            mock_service.return_value.get_personalized_recommendations.return_value = []
            
            response = client.get('/api/reading/recommendations/simple', headers=auth_headers)
            
            assert response.status_code == 200
            data = json.loads(response.data)
            
            assert data['count'] == 0
            assert data['recommendations'] == []


if __name__ == '__main__':
    pytest.main([__file__])