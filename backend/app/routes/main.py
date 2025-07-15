from flask import Blueprint, jsonify

bp = Blueprint('main', __name__)

@bp.route('/health', methods=['GET'])
def health_check():
    return jsonify({'status': 'healthy', 'message': 'Smart English Learning API is running'}), 200

@bp.route('/', methods=['GET'])
def index():
    return jsonify({'message': 'Welcome to Smart English Learning API'}), 200