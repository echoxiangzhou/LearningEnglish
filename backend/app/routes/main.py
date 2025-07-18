from flask import Blueprint, jsonify, send_from_directory, current_app, abort
import os

bp = Blueprint('main', __name__)

@bp.route('/health', methods=['GET'])
def health_check():
    return jsonify({'status': 'healthy', 'message': 'Smart English Learning API is running'}), 200

@bp.route('/', methods=['GET'])
def index():
    return jsonify({'message': 'Welcome to Smart English Learning API'}), 200

@bp.route('/static/<path:filename>')
def serve_static_file(filename):
    """Serve static files like audio cache"""
    try:
        # Get the absolute path to the backend directory
        backend_root = os.path.dirname(os.path.dirname(os.path.dirname(os.path.abspath(__file__))))
        static_dir = os.path.join(backend_root, 'static')
        
        # Security check: ensure the file is within the static directory
        safe_path = os.path.normpath(os.path.join(static_dir, filename))
        if not safe_path.startswith(static_dir):
            abort(403)
        
        # Check if file exists
        if not os.path.exists(safe_path):
            abort(404)
        
        # Serve the file
        return send_from_directory(static_dir, filename)
        
    except Exception as e:
        current_app.logger.error(f"Error serving static file {filename}: {str(e)}")
        abort(404)