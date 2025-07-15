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
    from app.routes.vocabulary import vocabulary_bp
    
    app.register_blueprint(auth_bp, url_prefix='/api/auth')
    app.register_blueprint(main_bp, url_prefix='/api')
    app.register_blueprint(tts_bp)
    app.register_blueprint(content_bp)
    app.register_blueprint(learning_bp)
    app.register_blueprint(sentence_generation_bp)
    app.register_blueprint(sentence_admin_bp)
    app.register_blueprint(dictation_bp)
    app.register_blueprint(vocabulary_bp)
    
    # JWT token blacklist check
    @jwt.token_in_blocklist_loader
    def check_if_token_revoked(jwt_header, jwt_payload):
        return is_token_blacklisted(jwt_payload)
    
    # Import SocketIO handlers to register them
    from app.services import progress_service
    
    return app