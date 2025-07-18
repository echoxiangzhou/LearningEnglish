"""
Sound Configuration API Routes

API endpoints for managing sound effects configuration.
"""

from flask import Blueprint, request, jsonify
from flask_jwt_extended import jwt_required, get_jwt_identity
import logging
import json
import os
from pathlib import Path

from .. import db
from ..models.sound_config import SoundConfig
from ..models.user import User

sound_config_bp = Blueprint('sound_config', __name__)
logger = logging.getLogger(__name__)


@sound_config_bp.route('/config', methods=['GET'])
@jwt_required()
def get_sound_config():
    """Get current sound configuration"""
    try:
        current_user_id = get_jwt_identity()
        if not current_user_id:
            return jsonify({
                'success': False,
                'error': 'Authentication required'
            }), 401
            
        config = SoundConfig.get_default_config()
        return jsonify({
            'success': True,
            'config': config.to_dict()
        })
    except Exception as e:
        logger.error(f"Error getting sound config: {str(e)}")
        return jsonify({
            'success': False,
            'error': 'Failed to get sound configuration'
        }), 500


@sound_config_bp.route('/config', methods=['POST'])
@jwt_required()
def update_sound_config():
    """Update sound configuration (admin only)"""
    try:
        current_user_id = get_jwt_identity()
        user = User.query.get(current_user_id)
        
        if not user or user.role != 'admin':
            return jsonify({
                'success': False,
                'error': 'Admin access required'
            }), 403
        
        data = request.get_json()
        if not data:
            return jsonify({
                'success': False,
                'error': 'No data provided'
            }), 400
        
        config = SoundConfig.get_default_config()
        
        # Update configuration
        config.update_from_dict(data)
        db.session.commit()
        
        return jsonify({
            'success': True,
            'config': config.to_dict(),
            'message': 'Sound configuration updated successfully'
        })
        
    except Exception as e:
        logger.error(f"Error updating sound config: {str(e)}")
        db.session.rollback()
        return jsonify({
            'success': False,
            'error': 'Failed to update sound configuration'
        }), 500


@sound_config_bp.route('/config/reset', methods=['POST'])
@jwt_required()
def reset_sound_config():
    """Reset sound configuration to defaults (admin only)"""
    try:
        current_user_id = get_jwt_identity()
        user = User.query.get(current_user_id)
        
        if not user or user.role != 'admin':
            return jsonify({
                'success': False,
                'error': 'Admin access required'
            }), 403
        
        # Delete current config and create new default
        SoundConfig.query.delete()
        db.session.commit()
        
        config = SoundConfig.get_default_config()
        
        return jsonify({
            'success': True,
            'config': config.to_dict(),
            'message': 'Sound configuration reset to defaults'
        })
        
    except Exception as e:
        logger.error(f"Error resetting sound config: {str(e)}")
        db.session.rollback()
        return jsonify({
            'success': False,
            'error': 'Failed to reset sound configuration'
        }), 500


@sound_config_bp.route('/test-sound', methods=['POST'])
@jwt_required()
def test_sound():
    """Test sound configuration (admin only)"""
    try:
        current_user_id = get_jwt_identity()
        user = User.query.get(current_user_id)
        
        if not user or user.role != 'admin':
            return jsonify({
                'success': False,
                'error': 'Admin access required'
            }), 403
        
        data = request.get_json()
        sound_type = data.get('sound_type')
        
        if not sound_type:
            return jsonify({
                'success': False,
                'error': 'Sound type is required'
            }), 400
        
        config = SoundConfig.get_default_config()
        
        # Return sound configuration for testing
        sound_config = {
            'keyboard': {
                'enabled': config.keyboard_sound_enabled,
                'volume': config.keyboard_sound_volume,
                'file': config.keyboard_sound_file
            },
            'success': {
                'enabled': config.success_sound_enabled,
                'volume': config.success_sound_volume,
                'file': config.success_sound_file
            },
            'error': {
                'enabled': config.error_sound_enabled,
                'volume': config.error_sound_volume,
                'file': config.error_sound_file
            },
            'completion': {
                'enabled': config.completion_sound_enabled,
                'volume': config.completion_sound_volume,
                'file': config.completion_sound_file
            }
        }
        
        return jsonify({
            'success': True,
            'sound_config': sound_config.get(sound_type, {}),
            'master_volume': config.master_volume,
            'sounds_enabled': config.sounds_enabled
        })
        
    except Exception as e:
        logger.error(f"Error testing sound: {str(e)}")
        return jsonify({
            'success': False,
            'error': 'Failed to test sound'
        }), 500


@sound_config_bp.route('/effects', methods=['GET'])
@jwt_required()
def get_sound_effects():
    """Get list of available sound effects"""
    try:
        current_user_id = get_jwt_identity()
        if not current_user_id:
            return jsonify({
                'success': False,
                'error': 'Authentication required'
            }), 401
            
        # Path to sound effects manifest
        manifest_path = Path(__file__).parent.parent.parent.parent / 'frontend' / 'public' / 'sounds' / 'sound_effects_manifest.json'
        
        if not manifest_path.exists():
            return jsonify({
                'success': False,
                'error': 'Sound effects manifest not found'
            }), 404
        
        with open(manifest_path, 'r') as f:
            sound_effects = json.load(f)
        
        return jsonify({
            'success': True,
            'sound_effects': sound_effects
        })
        
    except Exception as e:
        logger.error(f"Error getting sound effects: {str(e)}")
        return jsonify({
            'success': False,
            'error': 'Failed to get sound effects'
        }), 500


@sound_config_bp.route('/effects/<sound_type>', methods=['GET'])
@jwt_required()
def get_sound_effects_by_type(sound_type):
    """Get sound effects for a specific type"""
    try:
        # Path to sound effects manifest
        manifest_path = Path(__file__).parent.parent.parent.parent / 'frontend' / 'public' / 'sounds' / 'sound_effects_manifest.json'
        
        if not manifest_path.exists():
            return jsonify({
                'success': False,
                'error': 'Sound effects manifest not found'
            }), 404
        
        with open(manifest_path, 'r') as f:
            sound_effects = json.load(f)
        
        if sound_type not in sound_effects:
            return jsonify({
                'success': False,
                'error': f'Sound type "{sound_type}" not found'
            }), 404
        
        return jsonify({
            'success': True,
            'sound_effects': sound_effects[sound_type]
        })
        
    except Exception as e:
        logger.error(f"Error getting sound effects for type {sound_type}: {str(e)}")
        return jsonify({
            'success': False,
            'error': 'Failed to get sound effects'
        }), 500