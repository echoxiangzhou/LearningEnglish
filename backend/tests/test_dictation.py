"""
Tests for Dictation Practice Module

Comprehensive test suite for dictation practice functionality including
word blanking, hints, audio playback, and session management.
"""

import pytest
import json
from unittest.mock import Mock, patch, MagicMock
from datetime import datetime, timedelta
from flask import Flask

# Import services and models
from app.services.dictation_service import (
    DictationService, DictationWord, HintContent, HintType
)
from app.services.audio_playback_service import (
    AudioPlaybackService, AudioStreamService
)
from app.services.dictation_feedback_service import (
    DictationFeedbackService, WordPerformance, SessionFeedback
)
from app.models.dictation_practice import (
    DictationSession, DictationWordAttempt, DictationProgress,
    DictationSettings, DictationDifficulty
)
from app.models.generated_sentence import GeneratedSentence, ApprovalStatus, DifficultyLevel


class TestDictationService:
    """Test cases for DictationService"""
    
    @pytest.fixture
    def service(self):
        """Create service instance"""
        return DictationService()
    
    @pytest.fixture
    def mock_sentence(self):
        """Create mock sentence"""
        sentence = Mock(spec=GeneratedSentence)
        sentence.id = 1
        sentence.text = "The quick brown fox jumps over the lazy dog."
        sentence.target_word = "fox"
        sentence.difficulty = DifficultyLevel.ELEMENTARY
        return sentence
    
    @pytest.fixture
    def mock_db_session(self):
        """Mock database session"""
        with patch('app.services.dictation_service.db.session') as mock_session:
            yield mock_session
    
    def test_create_dictation_session(self, service, mock_sentence, mock_db_session):
        """Test creating a new dictation session"""
        with patch('app.services.dictation_service.GeneratedSentence') as mock_model:
            mock_model.query.get.return_value = mock_sentence
            
            with patch('app.services.dictation_service.DictationSettings') as mock_settings:
                mock_settings.query.filter_by.return_value.first.return_value = None
                
                # Test session creation
                session = service.create_dictation_session(
                    user_id=1,
                    sentence_id=1,
                    difficulty=DictationDifficulty.ELEMENTARY,
                    blank_percentage=0.3
                )
                
                # Verify session properties
                assert mock_db_session.add.called
                assert mock_db_session.commit.called
    
    def test_parse_sentence(self, service):
        """Test sentence parsing"""
        sentence = "Hello, world! How are you?"
        words = service._parse_sentence(sentence)
        
        assert words == ["Hello", ",", "world", "!", "How", "are", "you", "?"]
    
    def test_select_words_to_blank(self, service):
        """Test intelligent word blanking selection"""
        words = ["The", "quick", "brown", "fox", "jumps", "over", "the", "lazy", "dog"]
        target_word = "fox"
        
        # Test with target word present
        blanked_positions = service._select_words_to_blank(
            words, 3, target_word, DictationDifficulty.ELEMENTARY
        )
        
        assert len(blanked_positions) == 3
        assert 3 in blanked_positions  # "fox" should be blanked
    
    def test_calculate_blank_score(self, service):
        """Test word blanking score calculation"""
        words = ["The", "cat", "sleeps"]
        
        # Test scoring for different words
        score_the = service._calculate_blank_score("The", 0, words, DictationDifficulty.BEGINNER)
        score_cat = service._calculate_blank_score("cat", 1, words, DictationDifficulty.BEGINNER)
        score_sleeps = service._calculate_blank_score("sleeps", 2, words, DictationDifficulty.BEGINNER)
        
        # Common words should have different scores based on difficulty
        assert isinstance(score_the, float)
        assert isinstance(score_cat, float)
        assert isinstance(score_sleeps, float)
    
    def test_submit_word(self, service, mock_db_session):
        """Test word submission"""
        # Mock session and word attempt
        mock_session = Mock(spec=DictationSession)
        mock_session.id = 1
        mock_session.is_completed = False
        mock_session.correct_words = 0
        mock_session.incorrect_words = 0
        mock_session.blanked_words = 1
        
        mock_attempt = Mock(spec=DictationWordAttempt)
        mock_attempt.is_blanked = True
        mock_attempt.original_word = "cat"
        mock_attempt.record_attempt = Mock(return_value=True)
        mock_attempt.attempt_count = 1
        
        with patch('app.services.dictation_service.DictationSession') as mock_session_model:
            mock_session_model.query.get.return_value = mock_session
            
            with patch('app.services.dictation_service.DictationWordAttempt') as mock_attempt_model:
                mock_attempt_model.query.filter_by.return_value.first.return_value = mock_attempt
                
                result = service.submit_word(1, 0, "cat")
                
                assert result['success'] is True
                assert result['is_correct'] is True
                assert mock_attempt.record_attempt.called_with("cat")
    
    def test_get_hint(self, service, mock_db_session):
        """Test hint generation"""
        # Mock session and word attempt
        mock_session = Mock(spec=DictationSession)
        mock_session.is_completed = False
        mock_session.hints_used = 0
        
        mock_attempt = Mock(spec=DictationWordAttempt)
        mock_attempt.is_blanked = True
        mock_attempt.original_word = "elephant"
        mock_attempt.hints_used = []
        mock_attempt.use_hint = Mock()
        
        with patch('app.services.dictation_service.DictationSession') as mock_session_model:
            mock_session_model.query.get.return_value = mock_session
            
            with patch('app.services.dictation_service.DictationWordAttempt') as mock_attempt_model:
                mock_attempt_model.query.filter_by.return_value.first.return_value = mock_attempt
                
                # Test first letter hint
                result = service.get_hint(1, 0, HintType.FIRST_LETTER)
                
                assert result['success'] is True
                assert result['hint_type'] == HintType.FIRST_LETTER.value
                assert result['content'] == "E"
                assert result['cost'] == 5
    
    def test_generate_hint_types(self, service):
        """Test different hint type generation"""
        word = "hello"
        
        # First letter hint
        hint = service._generate_hint(word, HintType.FIRST_LETTER)
        assert hint.content == "H"
        assert hint.cost == 5
        
        # Phonetic hint
        hint = service._generate_hint(word, HintType.PHONETIC)
        assert "/" in hint.content  # Should have phonetic markers
        assert hint.cost == 10
        
        # Full word hint
        hint = service._generate_hint(word, HintType.FULL_WORD)
        assert hint.content == "hello"
        assert hint.cost == 20
    
    def test_get_practice_sentences(self, service):
        """Test getting practice sentences"""
        mock_sentences = [Mock(spec=GeneratedSentence) for _ in range(5)]
        
        with patch('app.services.dictation_service.DictationProgress') as mock_progress:
            mock_progress.query.filter_by.return_value.first.return_value = None
            
            with patch('app.services.dictation_service.GeneratedSentence') as mock_sentence_model:
                mock_query = Mock()
                mock_query.filter_by.return_value = mock_query
                mock_query.filter.return_value = mock_query
                mock_query.order_by.return_value = mock_query
                mock_query.limit.return_value = mock_query
                mock_query.all.return_value = mock_sentences
                mock_sentence_model.query = mock_query
                
                sentences = service.get_practice_sentences(1, count=5)
                
                assert len(sentences) == 5


class TestAudioPlaybackService:
    """Test cases for AudioPlaybackService"""
    
    @pytest.fixture
    def service(self):
        """Create service instance"""
        with patch('app.services.audio_playback_service.current_app'):
            return AudioPlaybackService()
    
    @pytest.fixture
    def mock_sentence(self):
        """Create mock sentence"""
        sentence = Mock(spec=GeneratedSentence)
        sentence.id = 1
        sentence.text = "Test sentence for audio."
        return sentence
    
    def test_normalize_speed(self, service):
        """Test speed normalization"""
        assert service._normalize_speed(0.3) == 0.5
        assert service._normalize_speed(0.6) == 0.5
        assert service._normalize_speed(1.0) == 1.0
        assert service._normalize_speed(1.3) == 1.25
        assert service._normalize_speed(2.0) == 1.5
    
    def test_cache_key_generation(self, service):
        """Test cache key generation"""
        key = service._get_cache_key(1, "Test sentence", 1.0)
        assert "dictation_1_" in key
        assert "_1.0x" in key
    
    def test_calculate_speech_rate(self, service):
        """Test speech rate calculation"""
        assert service._calculate_speech_rate(0.5) == 0.75
        assert service._calculate_speech_rate(1.0) == 1.0
        assert service._calculate_speech_rate(1.5) == 1.25
    
    @patch('app.services.audio_playback_service.GeneratedSentence')
    def test_get_audio_url(self, mock_sentence_model, service, mock_sentence):
        """Test audio URL generation"""
        mock_sentence_model.query.get.return_value = mock_sentence
        
        with patch.object(service, '_get_cached_audio', return_value=None):
            with patch.object(service, '_generate_audio', return_value={'audio_data': b'test', 'duration': 5}):
                with patch.object(service, '_cache_audio'):
                    result = service.get_audio_url(1, 1.0)
                    
                    assert result['success'] is True
                    assert '/api/dictation/audio/1?speed=1.0' in result['audio_url']
                    assert result['cached'] is False


class TestDictationFeedbackService:
    """Test cases for DictationFeedbackService"""
    
    @pytest.fixture
    def service(self):
        """Create service instance"""
        return DictationFeedbackService()
    
    @pytest.fixture
    def mock_session(self):
        """Create mock completed session"""
        session = Mock(spec=DictationSession)
        session.id = 1
        session.is_completed = True
        session.accuracy_score = 85.0
        session.speed_score = 75.0
        session.hints_used = 2
        session.blanked_words = 10
        session.user_id = 1
        session.difficulty = DictationDifficulty.ELEMENTARY
        return session
    
    def test_generate_session_feedback(self, service, mock_session):
        """Test session feedback generation"""
        mock_attempts = [
            Mock(attempt_count=1, hint_count=0, is_correct=True, original_word="cat"),
            Mock(attempt_count=2, hint_count=1, is_correct=True, original_word="dog"),
            Mock(attempt_count=3, hint_count=2, is_correct=False, original_word="elephant")
        ]
        
        with patch('app.services.dictation_feedback_service.DictationSession') as mock_model:
            mock_model.query.get.return_value = mock_session
            
            with patch('app.services.dictation_feedback_service.DictationWordAttempt') as mock_attempt_model:
                mock_attempt_model.query.filter_by.return_value.all.return_value = mock_attempts
                
                feedback = service.generate_session_feedback(1)
                
                assert isinstance(feedback, SessionFeedback)
                assert len(feedback.strengths) > 0
                assert len(feedback.suggestions) >= 0
    
    def test_analyze_error_type(self, service):
        """Test error type analysis"""
        # Capitalization error
        assert service._analyze_error_type("Hello", "hello") == "capitalization"
        
        # Minor spelling error
        assert service._analyze_error_type("cat", "cta") == "minor_spelling"
        
        # Empty input
        assert service._analyze_error_type("test", "") == "empty"
        
        # Major error
        assert service._analyze_error_type("elephant", "xyz") == "major_error"
    
    def test_calculate_edit_distance(self, service):
        """Test edit distance calculation"""
        assert service._calculate_edit_distance("cat", "cat") == 0
        assert service._calculate_edit_distance("cat", "bat") == 1
        assert service._calculate_edit_distance("hello", "hallo") == 1
        assert service._calculate_edit_distance("test", "testing") == 3
    
    def test_word_performance_analytics(self, service):
        """Test word performance analytics generation"""
        with patch('app.services.dictation_feedback_service.db.session.query') as mock_query:
            # Mock query results
            mock_query.return_value.join.return_value.filter.return_value.group_by.return_value.all.return_value = [
                ("cat", 10, 8, 10, 1.2, 0.1),
                ("dog", 5, 2, 4, 2.0, 0.5),
                ("elephant", 3, 0, 1, 3.5, 1.5)
            ]
            
            performances = service.get_word_performance_analytics(1, 30)
            
            assert len(performances) == 3
            assert all(isinstance(p, WordPerformance) for p in performances)
            assert performances[0].word == "elephant"  # Should be sorted by difficulty


class TestDictationAPI:
    """Test cases for dictation API endpoints"""
    
    @pytest.fixture
    def client(self):
        """Create test client"""
        from app import create_app, db
        
        app = create_app()
        app.config['TESTING'] = True
        app.config['SQLALCHEMY_DATABASE_URI'] = 'sqlite:///:memory:'
        
        with app.test_client() as client:
            with app.app_context():
                db.create_all()
                yield client
    
    @pytest.fixture
    def auth_headers(self):
        """Create authentication headers"""
        return {'Authorization': 'Bearer test-token'}
    
    @patch('app.routes.dictation.dictation_service')
    def test_create_session_endpoint(self, mock_service, client, auth_headers):
        """Test session creation endpoint"""
        mock_session = Mock()
        mock_session.id = 1
        mock_session.playback_speed = 1.0
        mock_session.sentence_id = 1
        mock_session.session_data = {'sentence_text': 'Test sentence'}
        
        mock_service.create_dictation_session.return_value = mock_session
        mock_service.get_session_state.return_value = {'session_id': 1}
        
        with patch('app.routes.dictation.audio_service') as mock_audio:
            mock_audio.get_audio_url.return_value = {'success': True, 'duration': 5}
            
            with patch('flask_jwt_extended.jwt_required', lambda: lambda f: f):
                with patch('flask_jwt_extended.get_jwt_identity', return_value=1):
                    response = client.post('/api/dictation/session',
                                         json={
                                             'sentence_id': 1,
                                             'difficulty': 'elementary',
                                             'blank_percentage': 0.3
                                         })
        
        assert response.status_code == 200
        data = json.loads(response.data)
        assert data['success'] is True
        assert 'session' in data
        assert 'audio' in data
    
    @patch('app.routes.dictation.dictation_service')
    def test_submit_word_endpoint(self, mock_service, client, auth_headers):
        """Test word submission endpoint"""
        mock_service.submit_word.return_value = {
            'success': True,
            'is_correct': True,
            'attempt_count': 1
        }
        
        with patch('app.models.dictation_practice.DictationSession') as mock_session:
            mock_session.query.get.return_value = Mock(user_id=1)
            
            with patch('flask_jwt_extended.jwt_required', lambda: lambda f: f):
                with patch('flask_jwt_extended.get_jwt_identity', return_value=1):
                    response = client.post('/api/dictation/submit-word',
                                         json={
                                             'session_id': 1,
                                             'position': 0,
                                             'user_input': 'cat'
                                         })
        
        assert response.status_code == 200
        data = json.loads(response.data)
        assert data['success'] is True
        assert data['is_correct'] is True
    
    @patch('app.routes.dictation.dictation_service')
    def test_get_hint_endpoint(self, mock_service, client, auth_headers):
        """Test hint request endpoint"""
        mock_service.get_hint.return_value = {
            'success': True,
            'hint_type': 'first_letter',
            'content': 'C',
            'cost': 5
        }
        
        with patch('app.models.dictation_practice.DictationSession') as mock_session:
            mock_session.query.get.return_value = Mock(user_id=1)
            
            with patch('flask_jwt_extended.jwt_required', lambda: lambda f: f):
                with patch('flask_jwt_extended.get_jwt_identity', return_value=1):
                    response = client.post('/api/dictation/hint',
                                         json={
                                             'session_id': 1,
                                             'position': 0,
                                             'hint_type': 'first_letter'
                                         })
        
        assert response.status_code == 200
        data = json.loads(response.data)
        assert data['success'] is True
        assert data['content'] == 'C'
    
    def test_health_check_endpoint(self, client):
        """Test health check endpoint"""
        with patch('app.models.dictation_practice.DictationSession') as mock_model:
            mock_model.query.count.return_value = 10
            
            response = client.get('/api/dictation/health')
            
            assert response.status_code == 200
            data = json.loads(response.data)
            assert data['success'] is True
            assert data['status'] == 'healthy'


# Integration tests
class TestDictationIntegration:
    """Integration tests for complete dictation workflow"""
    
    @pytest.fixture
    def full_system(self):
        """Create complete system with all services"""
        with patch('app.services.audio_playback_service.current_app'):
            dictation_service = DictationService()
            audio_service = AudioPlaybackService()
            feedback_service = DictationFeedbackService()
            
            return dictation_service, audio_service, feedback_service
    
    def test_complete_dictation_workflow(self, full_system):
        """Test complete dictation workflow from creation to completion"""
        dictation_service, audio_service, feedback_service = full_system
        
        # Mock database models and queries
        with patch('app.services.dictation_service.GeneratedSentence') as mock_sentence_model:
            with patch('app.services.dictation_service.DictationSettings') as mock_settings_model:
                with patch('app.services.dictation_service.db'):
                    # Setup mocks
                    mock_sentence = Mock()
                    mock_sentence.id = 1
                    mock_sentence.text = "The cat sleeps."
                    mock_sentence.target_word = "cat"
                    mock_sentence.difficulty = DifficultyLevel.ELEMENTARY
                    
                    mock_sentence_model.query.get.return_value = mock_sentence
                    mock_settings_model.query.filter_by.return_value.first.return_value = None
                    
                    # 1. Create session
                    session = Mock()
                    session.id = 1
                    session.user_id = 1
                    session.is_completed = False
                    
                    # 2. Test word blanking
                    words = dictation_service._parse_sentence(mock_sentence.text)
                    assert len(words) == 4  # ["The", "cat", "sleeps", "."]
                    
                    # 3. Test hint generation
                    hint = dictation_service._generate_hint("cat", HintType.FIRST_LETTER)
                    assert hint.content == "C"
                    
                    # 4. Test feedback generation
                    mock_session = Mock()
                    mock_session.accuracy_score = 90
                    mock_session.speed_score = 80
                    mock_session.hints_used = 1
                    mock_session.blanked_words = 2
                    
                    with patch('app.services.dictation_feedback_service.DictationSession') as mock_session_model:
                        mock_session_model.query.get.return_value = mock_session
                        
                        with patch('app.services.dictation_feedback_service.DictationWordAttempt') as mock_attempt_model:
                            mock_attempt_model.query.filter_by.return_value.all.return_value = []
                            
                            feedback = feedback_service.generate_session_feedback(1)
                            assert isinstance(feedback, SessionFeedback)
                            assert len(feedback.strengths) > 0