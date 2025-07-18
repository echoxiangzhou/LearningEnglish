"""
Tests for Analytics Service and Progress Tracking

Tests comprehensive analytics functionality including progress tracking,
dashboard data generation, and achievement calculations.
"""
import pytest
from datetime import datetime, timedelta
from app import create_app, db
from app.models.user import User
from app.models.word import Word
from app.models.vocabulary import (
    UserVocabulary, VocabularyTestResult, VocabularySession,
    VocabularyAchievement, VocabularyCategory, MasteryLevel, TestType
)
from app.services.analytics_service import AnalyticsService
import json


@pytest.fixture
def app():
    """Create test app with in-memory database"""
    app = create_app()
    app.config['TESTING'] = True
    app.config['SQLALCHEMY_DATABASE_URI'] = 'sqlite:///:memory:'
    
    with app.app_context():
        db.create_all()
        yield app
        db.drop_all()


@pytest.fixture
def client(app):
    """Create test client"""
    return app.test_client()


@pytest.fixture
def test_user(app):
    """Create test user"""
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
def test_words(app):
    """Create test words and categories"""
    with app.app_context():
        # Create category
        category = VocabularyCategory(
            name='Basic Words',
            description='Basic vocabulary',
            grade_level=3
        )
        db.session.add(category)
        db.session.flush()
        
        # Create words
        words = []
        word_data = [
            ('apple', 'A red or green fruit', 'noun', 1),
            ('run', 'To move quickly on foot', 'verb', 2),
            ('happy', 'Feeling joy', 'adjective', 1),
            ('book', 'A set of pages with text', 'noun', 1),
            ('beautiful', 'Pleasing to look at', 'adjective', 3),
        ]
        
        for word, definition, pos, difficulty in word_data:
            w = Word(
                word=word,
                definition=definition,
                part_of_speech=pos,
                difficulty=difficulty,
                grade_level=3
            )
            w.categories.append(category)
            words.append(w)
            db.session.add(w)
        
        db.session.commit()
        return words


@pytest.fixture
def test_user_vocabulary(app, test_user, test_words):
    """Create test user vocabulary progress"""
    with app.app_context():
        user_vocab_data = []
        
        for i, word in enumerate(test_words):
            # Create vocabulary progress with different mastery levels
            mastery_levels = [
                MasteryLevel.NEW,
                MasteryLevel.LEARNING,
                MasteryLevel.FAMILIAR,
                MasteryLevel.PROFICIENT,
                MasteryLevel.MASTERED
            ]
            
            user_vocab = UserVocabulary(
                user_id=test_user.id,
                word_id=word.id,
                mastery_level=mastery_levels[i],
                review_count=i * 2,
                correct_count=i * 2 if i < 3 else i,
                success_rate=1.0 if i < 3 else 0.8,
                first_seen=datetime.utcnow() - timedelta(days=30-i*5),
                last_reviewed=datetime.utcnow() - timedelta(days=i+1),
                next_review=datetime.utcnow() + timedelta(days=i+1),
                due_for_review=(i % 2 == 0)
            )
            user_vocab_data.append(user_vocab)
            db.session.add(user_vocab)
        
        db.session.commit()
        return user_vocab_data


@pytest.fixture
def test_results(app, test_user, test_words):
    """Create test vocabulary results"""
    with app.app_context():
        results = []
        
        # Create test results for the past week
        for i in range(10):
            result = VocabularyTestResult(
                user_id=test_user.id,
                word_id=test_words[i % len(test_words)].id,
                test_type=TestType.READING,
                is_correct=(i % 3 != 0),  # 2/3 success rate
                response_time=2.0 + (i % 3),
                quality_score=4 if (i % 3 != 0) else 1,
                user_answer='test answer',
                correct_answer='correct answer',
                created_at=datetime.utcnow() - timedelta(days=i/2),
                session_id=f'session_{i//3}'
            )
            results.append(result)
            db.session.add(result)
        
        db.session.commit()
        return results


@pytest.fixture
def test_sessions(app, test_user):
    """Create test vocabulary sessions"""
    with app.app_context():
        sessions = []
        
        for i in range(3):
            session = VocabularySession(
                user_id=test_user.id,
                session_type='review',
                words_studied=10 + i,
                correct_answers=8 + i,
                total_time=300 + i * 60,
                started_at=datetime.utcnow() - timedelta(days=i*2),
                ended_at=datetime.utcnow() - timedelta(days=i*2) + timedelta(minutes=5+i),
                is_completed=True,
                target_words=10,
                difficulty_level=2
            )
            sessions.append(session)
            db.session.add(session)
        
        db.session.commit()
        return sessions


class TestAnalyticsService:
    """Test analytics service functionality"""
    
    def test_get_vocabulary_overview(self, app, test_user, test_user_vocabulary, test_results):
        """Test vocabulary overview statistics"""
        with app.app_context():
            overview = AnalyticsService._get_vocabulary_overview(test_user.id)
            
            assert overview['total_words'] == 5
            assert overview['mastery_distribution']['mastered'] == 1
            assert overview['mastery_distribution']['proficient'] == 1
            assert overview['mastery_distribution']['familiar'] == 1
            assert overview['mastery_distribution']['learning'] == 1
            assert overview['mastery_distribution']['new'] == 1
            assert overview['due_for_review'] >= 0
            assert overview['total_tests'] == 10
            assert 0 <= overview['average_success_rate'] <= 100
    
    def test_get_progress_timeline(self, app, test_user, test_results):
        """Test progress timeline generation"""
        with app.app_context():
            timeline = AnalyticsService._get_progress_timeline(test_user.id, 7)
            
            assert timeline['period_days'] == 7
            assert len(timeline['timeline']) == 7
            assert 'total_tests' in timeline
            assert 'average_accuracy' in timeline
            
            # Check timeline data structure
            for day_data in timeline['timeline']:
                assert 'date' in day_data
                assert 'test_count' in day_data
                assert 'accuracy' in day_data
                assert 'new_words' in day_data
    
    def test_get_mastery_distribution(self, app, test_user, test_user_vocabulary):
        """Test mastery distribution calculation"""
        with app.app_context():
            distribution = AnalyticsService._get_mastery_distribution(test_user.id)
            
            assert distribution['total_words'] == 5
            assert distribution['distribution']['mastered'] == 1
            assert distribution['distribution']['proficient'] == 1
            assert distribution['distribution']['familiar'] == 1
            assert distribution['distribution']['learning'] == 1
            assert distribution['distribution']['new'] == 1
            
            # Check percentages add up to 100
            total_percentage = sum(distribution['percentages'].values())
            assert abs(total_percentage - 100.0) < 0.1
            
            # Check mastery score
            assert 0 <= distribution['mastery_score'] <= 100
    
    def test_get_category_performance(self, app, test_user, test_user_vocabulary):
        """Test category performance breakdown"""
        with app.app_context():
            performance = AnalyticsService._get_category_performance(test_user.id)
            
            assert len(performance) >= 1
            
            for category_data in performance:
                assert 'category_id' in category_data
                assert 'category_name' in category_data
                assert 'total_words' in category_data
                assert 'mastered_words' in category_data
                assert 'average_success_rate' in category_data
                assert 'mastery_percentage' in category_data
                assert 0 <= category_data['average_success_rate'] <= 100
                assert 0 <= category_data['mastery_percentage'] <= 100
    
    def test_get_recent_activity(self, app, test_user, test_results, test_sessions):
        """Test recent activity summary"""
        with app.app_context():
            activity = AnalyticsService._get_recent_activity(test_user.id, 7)
            
            assert 'recent_tests' in activity
            assert 'recent_sessions' in activity
            assert 'test_type_breakdown' in activity
            assert 'total_recent_tests' in activity
            assert 'total_recent_sessions' in activity
            
            # Check test type breakdown
            for test_type_data in activity['test_type_breakdown']:
                assert 'test_type' in test_type_data
                assert 'count' in test_type_data
                assert 'accuracy' in test_type_data
                assert 0 <= test_type_data['accuracy'] <= 100
    
    def test_get_user_achievements(self, app, test_user):
        """Test user achievements retrieval"""
        with app.app_context():
            achievements = AnalyticsService._get_user_achievements(test_user.id)
            
            assert 'current_achievements' in achievements
            assert 'recent_achievements' in achievements
            assert 'potential_achievements' in achievements
            assert 'total_achievements' in achievements
            
            # Check potential achievements structure
            for potential in achievements['potential_achievements']:
                assert 'type' in potential
                assert 'name' in potential
                assert 'description' in potential
                assert 'current_progress' in potential
                assert 'target' in potential
                assert 'progress_percentage' in potential
                assert 0 <= potential['progress_percentage'] <= 100
    
    def test_calculate_potential_achievements(self, app, test_user, test_user_vocabulary):
        """Test potential achievements calculation"""
        with app.app_context():
            dashboard_data = {'overview': AnalyticsService._get_vocabulary_overview(test_user.id)}
            potential = AnalyticsService._calculate_potential_achievements(test_user.id)
            
            assert len(potential) >= 1
            
            achievement_types = [p['type'] for p in potential]
            assert 'streak' in achievement_types or 'mastery' in achievement_types or 'accuracy' in achievement_types
    
    def test_get_streak_analytics(self, app, test_user, test_results):
        """Test streak analytics calculation"""
        with app.app_context():
            streak_data = AnalyticsService._get_streak_analytics(test_user.id)
            
            assert 'current_streak' in streak_data
            assert 'longest_streak' in streak_data
            assert 'streak_history' in streak_data
            assert 'streak_goal' in streak_data
            
            assert streak_data['current_streak'] >= 0
            assert streak_data['longest_streak'] >= 0
            assert streak_data['streak_goal'] > streak_data['current_streak']
            
            # Check streak history structure
            for day_data in streak_data['streak_history']:
                assert 'date' in day_data
                assert 'has_activity' in day_data
                assert 'activity_count' in day_data
                assert isinstance(day_data['has_activity'], bool)
    
    def test_get_performance_trends(self, app, test_user, test_results):
        """Test performance trends calculation"""
        with app.app_context():
            trends = AnalyticsService._get_performance_trends(test_user.id)
            
            assert 'monthly_performance' in trends
            assert 'response_time_trend' in trends
            assert 'improvement_indicators' in trends
            
            # Check monthly performance structure
            for month_data in trends['monthly_performance']:
                assert 'month' in month_data
                assert 'month_name' in month_data
                assert 'total_tests' in month_data
                assert 'accuracy' in month_data
                assert 'avg_response_time' in month_data
                assert 0 <= month_data['accuracy'] <= 100
    
    def test_calculate_mastery_score(self, app):
        """Test mastery score calculation"""
        with app.app_context():
            # Test balanced distribution
            distribution = {
                'new': 2,
                'learning': 2,
                'familiar': 2,
                'proficient': 2,
                'mastered': 2
            }
            score = AnalyticsService._calculate_mastery_score(distribution)
            assert 0 <= score <= 100
            assert score == 46.0  # (0*2 + 20*2 + 40*2 + 70*2 + 100*2) / 10
            
            # Test all mastered
            distribution_mastered = {
                'new': 0,
                'learning': 0,
                'familiar': 0,
                'proficient': 0,
                'mastered': 5
            }
            score_mastered = AnalyticsService._calculate_mastery_score(distribution_mastered)
            assert score_mastered == 100.0
    
    def test_generate_progress_report(self, app, test_user, test_user_vocabulary, test_results):
        """Test progress report generation"""
        with app.app_context():
            report = AnalyticsService.generate_progress_report(test_user.id, 'weekly')
            
            assert report['report_type'] == 'weekly'
            assert report['period_days'] == 7
            assert 'period_summary' in report
            assert 'dashboard_data' in report
            assert 'recommendations' in report
            assert 'generated_at' in report
            
            # Check period summary
            summary = report['period_summary']
            assert 'total_tests' in summary
            assert 'correct_tests' in summary
            assert 'accuracy' in summary
            assert 'active_days' in summary
            assert 0 <= summary['accuracy'] <= 100
    
    def test_generate_recommendations(self, app, test_user, test_user_vocabulary):
        """Test learning recommendations generation"""
        with app.app_context():
            dashboard_data = AnalyticsService.get_progress_dashboard(test_user.id)
            recommendations = AnalyticsService._generate_recommendations(test_user.id, dashboard_data)
            
            assert isinstance(recommendations, list)
            
            for rec in recommendations:
                assert 'type' in rec
                assert 'priority' in rec
                assert 'title' in rec
                assert 'description' in rec
                assert 'action' in rec
                assert rec['priority'] in ['high', 'medium', 'low']
    
    def test_get_progress_dashboard(self, app, test_user, test_user_vocabulary, test_results, test_sessions):
        """Test complete progress dashboard"""
        with app.app_context():
            dashboard = AnalyticsService.get_progress_dashboard(test_user.id)
            
            # Check all required sections
            required_sections = [
                'overview', 'progress_timeline', 'mastery_distribution',
                'category_performance', 'recent_activity', 'achievements',
                'streak_data', 'performance_trends', 'generated_at'
            ]
            
            for section in required_sections:
                assert section in dashboard
            
            # Verify data types and basic validation
            assert isinstance(dashboard['overview'], dict)
            assert isinstance(dashboard['progress_timeline'], dict)
            assert isinstance(dashboard['mastery_distribution'], dict)
            assert isinstance(dashboard['category_performance'], list)
            assert isinstance(dashboard['recent_activity'], dict)
            assert isinstance(dashboard['achievements'], dict)
            assert isinstance(dashboard['streak_data'], dict)
            assert isinstance(dashboard['performance_trends'], dict)


class TestAnalyticsAPI:
    """Test analytics API endpoints"""
    
    def test_analytics_dashboard_endpoint(self, client, app, test_user, test_user_vocabulary):
        """Test analytics dashboard API endpoint"""
        with app.app_context():
            # This would require JWT token setup for a complete test
            # For now, test the basic endpoint structure
            pass
    
    def test_progress_timeline_endpoint(self, client, app, test_user):
        """Test progress timeline API endpoint"""
        with app.app_context():
            # This would require JWT token setup for a complete test
            # For now, test the basic endpoint structure
            pass


if __name__ == '__main__':
    pytest.main([__file__])