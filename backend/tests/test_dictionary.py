import pytest
import json
from unittest.mock import patch, MagicMock
from app import create_app, db
from app.models.user import User
from app.models.word import Word
from app.models.article import WordLookup, ReadingSession, Article
from app.services.dictionary_service import DictionaryService
from flask_jwt_extended import create_access_token


@pytest.fixture
def app():
    """Create application for testing."""
    app = create_app()
    app.config['TESTING'] = True
    app.config['SQLALCHEMY_DATABASE_URI'] = 'sqlite:///:memory:'
    app.config['JWT_SECRET_KEY'] = 'test-secret'
    
    with app.app_context():
        db.create_all()
        yield app
        db.drop_all()


@pytest.fixture
def client(app):
    """Create test client."""
    return app.test_client()


@pytest.fixture
def auth_headers(app):
    """Create authentication headers for testing."""
    with app.app_context():
        # Create test user
        user = User(
            username='testuser',
            email='test@example.com',
            password_hash='hashed_password'
        )
        db.session.add(user)
        db.session.commit()
        
        # Create access token
        access_token = create_access_token(identity=user.id)
        return {'Authorization': f'Bearer {access_token}'}


@pytest.fixture
def sample_word(app):
    """Create a sample word in the database."""
    with app.app_context():
        word = Word(
            word='example',
            phonetic='/ɪɡˈzæmpəl/',
            definition='A thing characteristic of its kind or illustrating a general rule.',
            part_of_speech='noun',
            grade_level=5,
            difficulty=3,
            frequency=100
        )
        db.session.add(word)
        db.session.commit()
        return word


class TestDictionaryService:
    """Test dictionary service functions."""
    
    def test_get_word_definition_from_database(self, app, sample_word):
        """Test getting word definition from local database."""
        with app.app_context():
            result = DictionaryService.get_word_definition('example')
            
            assert result['word'] == 'example'
            assert result['phonetic'] == '/ɪɡˈzæmpəl/'
            assert result['definition'] == 'A thing characteristic of its kind or illustrating a general rule.'
            assert result['part_of_speech'] == 'noun'
            assert result['source'] == 'local'
    
    def test_get_word_definition_not_found(self, app):
        """Test getting definition for word not in database or external API."""
        with app.app_context():
            with patch('app.services.dictionary_service.requests.get') as mock_get:
                # Mock external API failure
                mock_get.return_value.status_code = 404
                
                result = DictionaryService.get_word_definition('nonexistentword')
                
                assert result['word'] == 'nonexistentword'
                assert result['definition'] == 'Definition not found'
                assert result['source'] == 'not_found'
    
    @patch('app.services.dictionary_service.requests.get')
    def test_fetch_external_definition_success(self, mock_get, app):
        """Test fetching definition from external API."""
        with app.app_context():
            # Mock successful API response
            mock_response = MagicMock()
            mock_response.status_code = 200
            mock_response.json.return_value = [{
                'phonetics': [{'text': '/test/'}],
                'meanings': [{
                    'partOfSpeech': 'noun',
                    'definitions': [{
                        'definition': 'A test definition',
                        'example': 'This is a test example'
                    }]
                }]
            }]
            mock_get.return_value = mock_response
            
            result = DictionaryService._fetch_external_definition('test')
            
            assert result['word'] == 'test'
            assert result['phonetic'] == '/test/'
            assert result['definition'] == 'A test definition'
            assert result['part_of_speech'] == 'noun'
            assert result['example'] == 'This is a test example'
            assert result['source'] == 'external'
    
    def test_get_user_lookup_history(self, app, auth_headers):
        """Test getting user lookup history."""
        with app.app_context():
            user = User.query.first()
            
            # Create some lookup records
            lookups = [
                WordLookup(
                    user_id=user.id,
                    looked_up_word='word1',
                    context_sentence='This is word1 in context.',
                    lookup_count=1
                ),
                WordLookup(
                    user_id=user.id,
                    looked_up_word='word2',
                    context_sentence='This is word2 in context.',
                    lookup_count=2
                )
            ]
            
            for lookup in lookups:
                db.session.add(lookup)
            db.session.commit()
            
            history = DictionaryService.get_user_lookup_history(user.id)
            
            assert len(history) == 2
            assert history[0]['word'] == 'word2'  # Most recent first
            assert history[0]['lookup_count'] == 2
            assert history[1]['word'] == 'word1'
    
    def test_get_popular_words(self, app):
        """Test getting popular words across all users."""
        with app.app_context():
            # Create users
            users = []
            for i in range(3):
                user = User(
                    username=f'user{i}',
                    email=f'user{i}@example.com',
                    password_hash='hashed_password'
                )
                db.session.add(user)
                users.append(user)
            
            db.session.commit()
            
            # Create lookup records
            lookups = [
                WordLookup(user_id=users[0].id, looked_up_word='popular', lookup_count=5),
                WordLookup(user_id=users[1].id, looked_up_word='popular', lookup_count=3),
                WordLookup(user_id=users[2].id, looked_up_word='common', lookup_count=2),
            ]
            
            for lookup in lookups:
                db.session.add(lookup)
            db.session.commit()
            
            popular_words = DictionaryService.get_popular_words(limit=10)
            
            assert len(popular_words) == 2
            assert popular_words[0]['word'] == 'popular'
            assert popular_words[0]['total_lookups'] == 8
            assert popular_words[0]['unique_users'] == 2


class TestDictionaryAPI:
    """Test dictionary API endpoints."""
    
    def test_get_word_definition_endpoint(self, client, auth_headers, sample_word):
        """Test GET /api/dictionary/definition/<word> endpoint."""
        response = client.get(
            '/api/dictionary/definition/example',
            headers=auth_headers
        )
        
        assert response.status_code == 200
        data = json.loads(response.data)
        assert data['success'] is True
        assert data['data']['word'] == 'example'
        assert data['data']['definition'] == 'A thing characteristic of its kind or illustrating a general rule.'
    
    def test_get_word_definition_unauthorized(self, client):
        """Test unauthorized access to definition endpoint."""
        response = client.get('/api/dictionary/definition/example')
        
        assert response.status_code == 401
    
    def test_lookup_word_endpoint(self, client, auth_headers, sample_word):
        """Test POST /api/dictionary/lookup endpoint."""
        lookup_data = {
            'word': 'example',
            'context_sentence': 'This is an example sentence.',
            'article_position': 150
        }
        
        response = client.post(
            '/api/dictionary/lookup',
            headers=auth_headers,
            json=lookup_data
        )
        
        assert response.status_code == 200
        data = json.loads(response.data)
        assert data['success'] is True
        assert data['data']['definition']['word'] == 'example'
        assert data['data']['lookup_saved'] is True
    
    def test_lookup_word_missing_word(self, client, auth_headers):
        """Test lookup endpoint with missing word."""
        response = client.post(
            '/api/dictionary/lookup',
            headers=auth_headers,
            json={}
        )
        
        assert response.status_code == 400
        data = json.loads(response.data)
        assert data['success'] is False
        assert 'Word is required' in data['error']
    
    def test_get_lookup_history_endpoint(self, client, auth_headers):
        """Test GET /api/dictionary/history endpoint."""
        response = client.get(
            '/api/dictionary/history',
            headers=auth_headers
        )
        
        assert response.status_code == 200
        data = json.loads(response.data)
        assert data['success'] is True
        assert 'history' in data['data']
        assert 'count' in data['data']
    
    def test_get_popular_words_endpoint(self, client):
        """Test GET /api/dictionary/popular endpoint."""
        response = client.get('/api/dictionary/popular')
        
        assert response.status_code == 200
        data = json.loads(response.data)
        assert data['success'] is True
        assert 'popular_words' in data['data']
        assert 'count' in data['data']
    
    def test_get_vocabulary_stats_endpoint(self, client, auth_headers):
        """Test GET /api/dictionary/stats endpoint."""
        response = client.get(
            '/api/dictionary/stats',
            headers=auth_headers
        )
        
        assert response.status_code == 200
        data = json.loads(response.data)
        assert data['success'] is True
        assert 'total_lookups' in data['data']
        assert 'unique_words' in data['data']
    
    def test_get_word_phonetic_endpoint(self, client, auth_headers, sample_word):
        """Test GET /api/dictionary/phonetic/<word> endpoint."""
        response = client.get(
            '/api/dictionary/phonetic/example',
            headers=auth_headers
        )
        
        assert response.status_code == 200
        data = json.loads(response.data)
        assert data['success'] is True
        assert data['data']['word'] == 'example'
        assert data['data']['phonetic'] == '/ɪɡˈzæmpəl/'
        assert data['data']['found'] is True
    
    def test_batch_lookup_endpoint(self, client, auth_headers, sample_word):
        """Test POST /api/dictionary/batch-lookup endpoint."""
        batch_data = {
            'words': ['example', 'test'],
            'context_data': {
                'article_position': 100
            }
        }
        
        response = client.post(
            '/api/dictionary/batch-lookup',
            headers=auth_headers,
            json=batch_data
        )
        
        assert response.status_code == 200
        data = json.loads(response.data)
        assert data['success'] is True
        assert len(data['data']['results']) == 2
        assert data['data']['results'][0]['word'] == 'example'
    
    def test_batch_lookup_too_many_words(self, client, auth_headers):
        """Test batch lookup with too many words."""
        batch_data = {
            'words': ['word' + str(i) for i in range(15)]  # More than 10 words
        }
        
        response = client.post(
            '/api/dictionary/batch-lookup',
            headers=auth_headers,
            json=batch_data
        )
        
        assert response.status_code == 400
        data = json.loads(response.data)
        assert data['success'] is False
        assert 'Maximum 10 words per batch' in data['error']


class TestDictionaryIntegration:
    """Test dictionary integration with other components."""
    
    def test_reading_session_integration(self, app, auth_headers):
        """Test dictionary integration with reading sessions."""
        with app.app_context():
            user = User.query.first()
            
            # Create article and reading session
            article = Article(
                title='Test Article',
                content='This is a test article with example words.',
                word_count=9,
                estimated_reading_time=1,
                difficulty=3,
                grade_level=5
            )
            db.session.add(article)
            db.session.commit()
            
            session = ReadingSession(
                user_id=user.id,
                article_id=article.id,
                status='active'
            )
            db.session.add(session)
            db.session.commit()
            
            # Test lookup with reading session context
            success = DictionaryService.save_word_lookup(
                user_id=user.id,
                word='example',
                context_sentence='This is a test article with example words.',
                article_position=30,
                reading_session_id=session.id
            )
            
            assert success is True
            
            # Verify lookup was saved with session context
            lookup = WordLookup.query.filter_by(
                user_id=user.id,
                reading_session_id=session.id,
                looked_up_word='example'
            ).first()
            
            assert lookup is not None
            assert lookup.context_sentence == 'This is a test article with example words.'
            assert lookup.article_position == 30
            assert lookup.lookup_count == 1