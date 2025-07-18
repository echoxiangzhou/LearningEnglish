from flask import Flask
from flask_sqlalchemy import SQLAlchemy
from flask_cors import CORS
from flask_migrate import Migrate
from flask_jwt_extended import JWTManager
from flask_socketio import SocketIO
import os
from dotenv import load_dotenv

load_dotenv()

db = SQLAlchemy()
migrate = Migrate()
jwt = JWTManager()
socketio = SocketIO()

def create_app():
    app = Flask(__name__)
    
    # Configuration
    app.config['SECRET_KEY'] = os.environ.get('SECRET_KEY') or 'dev-secret-key'
    app.config['SQLALCHEMY_DATABASE_URI'] = os.environ.get('DATABASE_URL') or \
        'postgresql://postgres:password@localhost/learning_english'
    app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False
    app.config['JWT_SECRET_KEY'] = os.environ.get('JWT_SECRET_KEY') or 'jwt-secret-key'
    app.config['JWT_ACCESS_TOKEN_EXPIRES'] = 3600  # 1 hour
    
    # Initialize extensions
    db.init_app(app)
    migrate.init_app(app, db)
    jwt.init_app(app)
    CORS(app, origins="*")
    socketio.init_app(app, cors_allowed_origins="*", async_mode='threading')
    
    # Register blueprints (routes)
    from app.routes.auth import bp as auth_bp, is_token_blacklisted
    from app.routes.main import bp as main_bp
    from app.routes.tts import bp as tts_bp
    from app.routes.content import bp as content_bp
    from app.routes.learning import bp as learning_bp
    from app.routes.sentence_generation import sentence_generation_bp
    from app.routes.sentence_admin import sentence_admin_bp
    from app.routes.dictation import dictation_bp
    from app.routes.analytics import analytics_bp
    from app.routes.unified_analytics import unified_analytics_bp
    from app.routes.articles import articles_bp
    from app.routes.dictionary import dictionary_bp
    from app.routes.user_management import bp as user_management_bp
    from app.routes.sound_config import sound_config_bp
    from app.routes.admin_statistics import admin_stats_bp
    from app.routes.onboarding import bp as onboarding_bp
    from app.routes.error_tracking import error_tracking_bp
    
    app.register_blueprint(auth_bp, url_prefix='/api/auth')
    app.register_blueprint(main_bp, url_prefix='/api')
    app.register_blueprint(tts_bp)
    app.register_blueprint(content_bp)
    app.register_blueprint(learning_bp)
    app.register_blueprint(sentence_generation_bp)
    app.register_blueprint(sentence_admin_bp)
    app.register_blueprint(dictation_bp)
    app.register_blueprint(analytics_bp, url_prefix='/api/analytics')
    app.register_blueprint(unified_analytics_bp, url_prefix='/api/unified-analytics')
    app.register_blueprint(articles_bp)
    app.register_blueprint(dictionary_bp, url_prefix='/api/dictionary')
    app.register_blueprint(user_management_bp)
    app.register_blueprint(sound_config_bp, url_prefix='/api/sound')
    app.register_blueprint(admin_stats_bp)
    app.register_blueprint(onboarding_bp, url_prefix='/api/onboarding')
    app.register_blueprint(error_tracking_bp)
    
    # JWT token blacklist check
    @jwt.token_in_blocklist_loader
    def check_if_token_revoked(jwt_header, jwt_payload):
        return is_token_blacklisted(jwt_payload)
    
    # Import SocketIO handlers to register them
    from app.services import progress_service
    
    return app