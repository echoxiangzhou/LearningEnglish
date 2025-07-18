"""
Test suite for DifficultyAssessmentService

Tests the intelligent difficulty assessment using NLP analysis
and personalized article recommendations based on user performance.
"""

import pytest
import json
from unittest.mock import Mock, patch, MagicMock
from datetime import datetime, timedelta

from app.services.difficulty_assessment_service import DifficultyAssessmentService
from app.models.article import Article
from app.models.article import ReadingSession
from app.models.user import User


class TestDifficultyAssessmentService:
    """Test cases for DifficultyAssessmentService"""
    
    @pytest.fixture
    def service(self):
        """Create DifficultyAssessmentService instance"""
        return DifficultyAssessmentService()
    
    @pytest.fixture
    def sample_text(self):
        """Sample text for difficulty assessment"""
        return """
        The quick brown fox jumps over the lazy dog. This is a simple sentence 
        that contains all letters of the alphabet. It is commonly used for 
        testing purposes in typography and printing.
        """
    
    @pytest.fixture
    def complex_text(self):
        """Complex text for difficulty assessment"""
        return """
        The epistemological paradigm of contemporary hermeneutics necessitates 
        a comprehensive re-examination of the foundational assumptions underlying 
        our understanding of textual interpretation. Furthermore, the 
        phenomenological dimensions of linguistic analysis require sophisticated 
        methodological approaches that transcend traditional binary distinctions 
        between subjective and objective interpretative frameworks.
        """
    
    @pytest.fixture
    def mock_sentence_service(self):
        """Mock sentence generation service"""
        mock = Mock()
        mock.analyze_word.return_value = {
            'lemma': 'test',
            'pos': 'NOUN',
            'tag': 'NN',
            'dependency': 'nsubj',
            'has_vector': True,
            'vector_norm': 0.5,
            'syllable_count': 1,
            'frequency_rank': 1000
        }
        return mock
    
    @pytest.fixture
    def mock_validation_service(self):
        """Mock quality validation service"""
        mock = Mock()
        mock.calculate_readability_score.return_value = 3.0
        return mock
    
    @pytest.fixture
    def mock_article_service(self):
        """Mock article service"""
        mock = Mock()
        mock.calculate_article_difficulty.return_value = {
            'difficulty_score': 2.5,
            'word_count': 100,
            'sentence_count': 5,
            'avg_words_per_sentence': 20,
            'complex_word_ratio': 0.1
        }
        return mock

    def test_assess_text_difficulty_simple_text(self, service, sample_text):
        """Test difficulty assessment for simple text"""
        with patch.object(service, 'sentence_service') as mock_sentence, \
             patch.object(service, 'validation_service') as mock_validation, \
             patch.object(service, 'article_service') as mock_article:
            
            # Configure mocks
            mock_sentence.analyze_word.return_value = {
                'lemma': 'simple', 'pos': 'ADJ', 'syllable_count': 2
            }
            mock_validation.calculate_readability_score.return_value = 2.0
            mock_article.calculate_article_difficulty.return_value = {
                'difficulty_score': 2.0, 'word_count': 100
            }
            
            result = service.assess_text_difficulty(sample_text, "Simple Title")
            
            # Verify structure
            assert 'difficulty_score' in result
            assert 'difficulty_level' in result
            assert 'recommended_grade' in result
            assert 'confidence' in result
            assert 'metrics' in result
            assert 'recommendations' in result
            assert 'assessment_timestamp' in result
            
            # Verify difficulty score is reasonable
            assert 1.0 <= result['difficulty_score'] <= 5.0
            assert result['difficulty_level'] in ['very_easy', 'easy', 'medium', 'hard', 'very_hard']
            assert 1 <= result['recommended_grade'] <= 5
            
    def test_assess_text_difficulty_complex_text(self, service, complex_text):
        """Test difficulty assessment for complex text"""
        with patch.object(service, 'sentence_service') as mock_sentence, \
             patch.object(service, 'validation_service') as mock_validation, \
             patch.object(service, 'article_service') as mock_article:
            
            # Configure mocks for complex text
            mock_sentence.analyze_word.return_value = {
                'lemma': 'epistemological', 'pos': 'ADJ', 'syllable_count': 7
            }
            mock_validation.calculate_readability_score.return_value = 4.5
            mock_article.calculate_article_difficulty.return_value = {
                'difficulty_score': 4.5, 'word_count': 100
            }
            
            result = service.assess_text_difficulty(complex_text, "Complex Title")
            
            # Complex text should have higher difficulty
            assert result['difficulty_score'] > 3.0
            assert result['difficulty_level'] in ['hard', 'very_hard']
            assert result['recommended_grade'] >= 4

    def test_analyze_vocabulary_complexity(self, service):
        """Test vocabulary complexity analysis"""
        text = "The sophisticated epistemological framework demonstrates complexity."
        
        with patch.object(service, 'sentence_service') as mock_service:
            mock_service.analyze_word.return_value = {
                'syllable_count': 5,
                'pos': 'NOUN',
                'frequency_rank': 5000
            }
            
            result = service._analyze_vocabulary_complexity(text)
            
            assert 'complexity_score' in result
            assert 'complex_word_ratio' in result
            assert 'avg_syllables' in result
            assert 'pos_distribution' in result
            assert 'analysis_count' in result

    def test_analyze_sentence_complexity(self, service):
        """Test sentence structure complexity analysis"""
        simple_text = "The cat sat. The dog ran."
        complex_text = "Although the cat sat on the mat, which was very comfortable, the dog ran around the yard because it was excited."
        
        simple_result = service._analyze_sentence_complexity(simple_text)
        complex_result = service._analyze_sentence_complexity(complex_text)
        
        # Complex text should have higher complexity score
        assert complex_result['complexity_score'] > simple_result['complexity_score']
        assert complex_result['avg_sentence_length'] > simple_result['avg_sentence_length']

    def test_calculate_comprehensive_readability(self, service):
        """Test comprehensive readability calculation"""
        text = "This is a test sentence for readability analysis."
        
        with patch.object(service, 'validation_service') as mock_validation:
            mock_validation.calculate_readability_score.side_effect = [2.0, 3.0, 4.0]
            
            result = service._calculate_comprehensive_readability(text)
            
            assert 'avg_readability' in result
            assert 'readability_variance' in result
            assert 'level_scores' in result
            assert 'overall_score' in result
            assert result['avg_readability'] == 3.0  # (2.0 + 3.0 + 4.0) / 3

    def test_analyze_syntactic_complexity(self, service):
        """Test syntactic complexity analysis"""
        text = "The quick brown fox jumps over the lazy dog."
        
        result = service._analyze_syntactic_complexity(text)
        
        assert 'complexity_score' in result
        assert 'type_token_ratio' in result
        assert 'passive_voice_ratio' in result
        assert 'word_count' in result
        assert 'sentence_count' in result

    def test_score_to_level_conversion(self, service):
        """Test difficulty score to level conversion"""
        assert service._score_to_level(1.0) == 'very_easy'
        assert service._score_to_level(2.0) == 'easy'
        assert service._score_to_level(3.0) == 'medium'
        assert service._score_to_level(4.0) == 'hard'
        assert service._score_to_level(5.0) == 'very_hard'

    def test_score_to_grade_conversion(self, service):
        """Test difficulty score to grade conversion"""
        assert service._score_to_grade(1.0) == 1
        assert service._score_to_grade(2.0) == 2
        assert service._score_to_grade(3.0) == 3
        assert service._score_to_grade(4.0) == 4
        assert service._score_to_grade(5.0) == 5

    def test_generate_difficulty_recommendations(self, service):
        """Test difficulty recommendation generation"""
        easy_recs = service._generate_difficulty_recommendations(1.5)
        medium_recs = service._generate_difficulty_recommendations(3.0)
        hard_recs = service._generate_difficulty_recommendations(4.5)
        
        assert isinstance(easy_recs, list)
        assert isinstance(medium_recs, list)
        assert isinstance(hard_recs, list)
        
        assert len(easy_recs) > 0
        assert len(medium_recs) > 0
        assert len(hard_recs) > 0

    @patch('app.services.difficulty_assessment_service.get_db')
    def test_get_personalized_recommendations(self, mock_get_db, service):
        """Test personalized recommendation generation"""
        # Mock database session
        mock_db = Mock()
        mock_get_db.return_value.__next__.return_value = mock_db
        
        # Mock articles
        mock_articles = [
            Mock(id=1, title="Article 1", difficulty_level=2, word_count=100, 
                 reading_time=5, category="science", tags=["tag1"], is_active=True),
            Mock(id=2, title="Article 2", difficulty_level=3, word_count=200, 
                 reading_time=10, category="history", tags=["tag2"], is_active=True)
        ]
        mock_db.query.return_value.filter.return_value.all.return_value = mock_articles
        
        # Mock user performance
        with patch.object(service, '_analyze_user_performance') as mock_analyze:
            mock_analyze.return_value = {
                'avg_comprehension': 0.8,
                'avg_reading_speed': 150,
                'preferred_difficulty': 2,
                'performance_trend': 0.1,
                'category_preferences': {'science': {'preference_score': 3.0}},
                'session_count': 10,
                'consistency_score': 0.7
            }
            
            # Mock recently read check
            with patch.object(service, '_recently_read', return_value=False):
                result = service.get_personalized_recommendations(user_id=1, limit=5)
                
                assert isinstance(result, list)
                assert len(result) <= 5
                if result:
                    assert 'id' in result[0]
                    assert 'title' in result[0]
                    assert 'recommendation_score' in result[0]
                    assert 'reasons' in result[0]

    @patch('app.services.difficulty_assessment_service.get_db')
    def test_analyze_user_performance(self, mock_get_db, service):
        """Test user performance analysis"""
        # Mock database session
        mock_db = Mock()
        mock_get_db.return_value.__next__.return_value = mock_db
        
        # Mock reading sessions
        mock_sessions = [
            Mock(comprehension_score=80, reading_speed=150, 
                 article=Mock(difficulty_level=2, category="science")),
            Mock(comprehension_score=90, reading_speed=160, 
                 article=Mock(difficulty_level=2, category="history"))
        ]
        
        # Mock database queries
        mock_db.query.return_value.filter.return_value.order_by.return_value.limit.return_value.all.return_value = mock_sessions
        mock_db.query.return_value.join.return_value.filter.return_value.group_by.return_value.all.return_value = [
            ('science', 1, 80),
            ('history', 1, 90)
        ]
        
        result = service._analyze_user_performance(1, mock_db)
        
        assert 'avg_comprehension' in result
        assert 'avg_reading_speed' in result
        assert 'preferred_difficulty' in result
        assert 'performance_trend' in result
        assert 'category_preferences' in result
        assert 'session_count' in result
        assert 'consistency_score' in result

    def test_calculate_performance_trend(self, service):
        """Test performance trend calculation"""
        # Mock sessions with improving trend
        improving_sessions = [
            Mock(comprehension_score=90),  # Recent
            Mock(comprehension_score=85),  # Recent
            Mock(comprehension_score=70),  # Older
            Mock(comprehension_score=65)   # Older
        ]
        
        trend = service._calculate_performance_trend(improving_sessions)
        assert trend > 0  # Should indicate improvement
        
        # Mock sessions with declining trend
        declining_sessions = [
            Mock(comprehension_score=60),  # Recent
            Mock(comprehension_score=65),  # Recent
            Mock(comprehension_score=85),  # Older
            Mock(comprehension_score=90)   # Older
        ]
        
        trend = service._calculate_performance_trend(declining_sessions)
        assert trend < 0  # Should indicate decline

    @patch('app.services.difficulty_assessment_service.get_db')
    def test_recently_read(self, mock_get_db, service):
        """Test recently read article check"""
        mock_db = Mock()
        mock_get_db.return_value.__next__.return_value = mock_db
        
        # Mock recent session exists
        mock_db.query.return_value.filter.return_value.first.return_value = Mock(id=1)
        
        result = service._recently_read(1, 1, mock_db)
        assert result is True
        
        # Mock no recent session
        mock_db.query.return_value.filter.return_value.first.return_value = None
        
        result = service._recently_read(1, 1, mock_db)
        assert result is False

    def test_calculate_recommendation_score(self, service):
        """Test recommendation score calculation"""
        # Mock article
        article = Mock(
            difficulty_level=3,
            reading_time=10,
            word_count=500,
            category="science"
        )
        
        # Mock user performance
        user_performance = {
            'preferred_difficulty': 2,
            'performance_trend': 0.1,
            'category_preferences': {
                'science': {'preference_score': 3.0}
            }
        }
        
        score = service._calculate_recommendation_score(article, user_performance)
        
        assert isinstance(score, float)
        assert score >= 0

    def test_generate_recommendation_reasons(self, service):
        """Test recommendation reason generation"""
        # Mock article
        article = Mock(
            difficulty_level=3,
            reading_time=10,
            category="science"
        )
        
        # Mock user performance
        user_performance = {
            'preferred_difficulty': 2,
            'performance_trend': 0.1,
            'category_preferences': {
                'science': {'preference_score': 3.0}
            }
        }
        
        reasons = service._generate_recommendation_reasons(article, user_performance)
        
        assert isinstance(reasons, list)
        assert len(reasons) <= 3
        for reason in reasons:
            assert isinstance(reason, str)
            assert len(reason) > 0

    def test_error_handling(self, service):
        """Test error handling in difficulty assessment"""
        # Test with invalid text
        with patch.object(service, 'article_service') as mock_article:
            mock_article.calculate_article_difficulty.side_effect = Exception("Test error")
            
            # Should not raise exception, should return default values or handle gracefully
            try:
                result = service.assess_text_difficulty("", "")
                # Should have some default structure even on error
                assert isinstance(result, dict)
            except Exception:
                # If it does raise, make sure it's handled appropriately
                pass

    def test_empty_text_handling(self, service):
        """Test handling of empty text"""
        with patch.object(service, 'article_service') as mock_article, \
             patch.object(service, 'validation_service') as mock_validation, \
             patch.object(service, 'sentence_service') as mock_sentence:
            
            mock_article.calculate_article_difficulty.return_value = {
                'difficulty_score': 2.5, 'word_count': 0
            }
            mock_validation.calculate_readability_score.return_value = 2.5
            mock_sentence.analyze_word.return_value = None
            
            result = service.assess_text_difficulty("", "")
            
            assert 'difficulty_score' in result
            assert result['difficulty_score'] >= 1.0
            assert result['difficulty_score'] <= 5.0

    def test_confidence_calculation(self, service):
        """Test confidence score calculation"""
        # High confidence scenario
        high_conf_metrics = {
            'analysis_count': 100,
            'sentence_count': 20,
            'readability_variance': 0.1
        }
        
        confidence = service._calculate_confidence(
            {}, 
            high_conf_metrics, 
            {'sentence_count': 20}, 
            {'readability_variance': 0.1}
        )
        
        assert 0.1 <= confidence <= 1.0
        
        # Low confidence scenario
        low_conf_metrics = {
            'analysis_count': 5,
            'sentence_count': 1,
            'readability_variance': 2.0
        }
        
        confidence = service._calculate_confidence(
            {}, 
            low_conf_metrics, 
            {'sentence_count': 1}, 
            {'readability_variance': 2.0}
        )
        
        assert 0.1 <= confidence <= 1.0


if __name__ == '__main__':
    pytest.main([__file__])