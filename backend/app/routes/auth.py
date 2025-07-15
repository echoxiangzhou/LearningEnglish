from flask import Blueprint, request, jsonify, current_app
from flask_jwt_extended import (
    create_access_token, create_refresh_token, jwt_required, 
    get_jwt_identity, get_jwt
)
from flask_mail import Message
from werkzeug.security import generate_password_hash, check_password_hash
from app import db
from app.models import User, SystemLog, AuditLog
import re
import secrets
import string
from datetime import datetime, timedelta

bp = Blueprint('auth', __name__)

# JWT blacklist for logout
blacklisted_tokens = set()

def is_valid_email(email):
    """Validate email format"""
    pattern = r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$'
    return re.match(pattern, email) is not None

def is_valid_password(password):
    """Validate password strength"""
    if len(password) < 8:
        return False, "Password must be at least 8 characters long"
    if not re.search(r'[A-Z]', password):
        return False, "Password must contain at least one uppercase letter"
    if not re.search(r'[a-z]', password):
        return False, "Password must contain at least one lowercase letter"
    if not re.search(r'\d', password):
        return False, "Password must contain at least one number"
    return True, "Password is valid"

def generate_verification_token():
    """Generate a secure verification token"""
    alphabet = string.ascii_letters + string.digits
    return ''.join(secrets.choice(alphabet) for i in range(32))

@bp.route('/register', methods=['POST'])
def register():
    """User registration endpoint"""
    try:
        data = request.get_json()
        
        # Validate required fields
        required_fields = ['username', 'email', 'password']
        for field in required_fields:
            if not data.get(field):
                return jsonify({'error': f'{field.capitalize()} is required'}), 400
        
        username = data.get('username').strip()
        email = data.get('email').strip().lower()
        password = data.get('password')
        role = data.get('role', 'student')
        
        # Validate input
        if len(username) < 3 or len(username) > 80:
            return jsonify({'error': 'Username must be between 3 and 80 characters'}), 400
        
        if not is_valid_email(email):
            return jsonify({'error': 'Invalid email format'}), 400
        
        is_valid, password_message = is_valid_password(password)
        if not is_valid:
            return jsonify({'error': password_message}), 400
        
        # Validate role
        valid_roles = ['student', 'teacher', 'admin']
        if role not in valid_roles:
            return jsonify({'error': 'Invalid role'}), 400
        
        # Check if user already exists
        if User.query.filter_by(username=username).first():
            return jsonify({'error': 'Username already exists'}), 409
        
        if User.query.filter_by(email=email).first():
            return jsonify({'error': 'Email already registered'}), 409
        
        # Create new user
        user = User(
            username=username,
            email=email,
            role=role,
            is_active=True,
            is_email_verified=False
        )
        user.set_password(password)
        
        db.session.add(user)
        db.session.commit()
        
        # Log registration
        SystemLog.log('INFO', 'auth', f'New user registered: {username}', 
                     details={'user_id': user.id, 'email': email, 'role': role},
                     request=request)
        
        # Create audit log
        AuditLog.log_action(
            user_id=user.id,
            action='CREATE',
            resource_type='user',
            resource_id=user.id,
            description=f'User {username} registered',
            request=request
        )
        
        # TODO: Send email verification
        # For now, auto-verify in development
        if current_app.config.get('FLASK_ENV') == 'development':
            user.is_email_verified = True
            db.session.commit()
        
        # Generate access token
        access_token = create_access_token(identity=user.id)
        refresh_token = create_refresh_token(identity=user.id)
        
        return jsonify({
            'message': 'User registered successfully',
            'user': user.to_dict(),
            'access_token': access_token,
            'refresh_token': refresh_token
        }), 201
        
    except Exception as e:
        db.session.rollback()
        SystemLog.log('ERROR', 'auth', f'Registration error: {str(e)}', request=request)
        return jsonify({'error': 'Internal server error'}), 500

@bp.route('/login', methods=['POST'])
def login():
    """User login endpoint"""
    try:
        data = request.get_json()
        
        # Validate required fields
        if not data.get('email') or not data.get('password'):
            return jsonify({'error': 'Email and password are required'}), 400
        
        email = data.get('email').strip().lower()
        password = data.get('password')
        
        # Find user
        user = User.query.filter_by(email=email).first()
        
        if not user or not user.check_password(password):
            SystemLog.log('WARNING', 'auth', f'Failed login attempt for: {email}', 
                         request=request)
            return jsonify({'error': 'Invalid email or password'}), 401
        
        if not user.is_active:
            return jsonify({'error': 'Account is deactivated'}), 401
        
        # Generate tokens
        access_token = create_access_token(identity=user.id)
        refresh_token = create_refresh_token(identity=user.id)
        
        # Log successful login
        SystemLog.log('INFO', 'auth', f'User logged in: {user.username}', 
                     details={'user_id': user.id}, request=request)
        
        return jsonify({
            'message': 'Login successful',
            'user': user.to_dict(),
            'access_token': access_token,
            'refresh_token': refresh_token
        }), 200
        
    except Exception as e:
        SystemLog.log('ERROR', 'auth', f'Login error: {str(e)}', request=request)
        return jsonify({'error': 'Internal server error'}), 500

@bp.route('/logout', methods=['POST'])
@jwt_required()
def logout():
    """User logout endpoint"""
    try:
        current_user_id = get_jwt_identity()
        jti = get_jwt()['jti']  # JWT ID
        
        # Add token to blacklist
        blacklisted_tokens.add(jti)
        
        # Log logout
        SystemLog.log('INFO', 'auth', f'User logged out', 
                     details={'user_id': current_user_id}, request=request)
        
        return jsonify({'message': 'Successfully logged out'}), 200
        
    except Exception as e:
        SystemLog.log('ERROR', 'auth', f'Logout error: {str(e)}', request=request)
        return jsonify({'error': 'Internal server error'}), 500

@bp.route('/refresh', methods=['POST'])
@jwt_required(refresh=True)
def refresh():
    """Refresh access token"""
    try:
        current_user_id = get_jwt_identity()
        user = User.query.get(current_user_id)
        
        if not user or not user.is_active:
            return jsonify({'error': 'User not found or inactive'}), 401
        
        # Generate new access token
        access_token = create_access_token(identity=current_user_id)
        
        return jsonify({
            'access_token': access_token,
            'user': user.to_dict()
        }), 200
        
    except Exception as e:
        SystemLog.log('ERROR', 'auth', f'Token refresh error: {str(e)}', request=request)
        return jsonify({'error': 'Internal server error'}), 500

@bp.route('/profile', methods=['GET'])
@jwt_required()
def get_profile():
    """Get current user profile"""
    try:
        current_user_id = get_jwt_identity()
        user = User.query.get(current_user_id)
        
        if not user:
            return jsonify({'error': 'User not found'}), 404
        
        return jsonify({'user': user.to_dict()}), 200
        
    except Exception as e:
        SystemLog.log('ERROR', 'auth', f'Profile fetch error: {str(e)}', request=request)
        return jsonify({'error': 'Internal server error'}), 500

@bp.route('/profile', methods=['PUT'])
@jwt_required()
def update_profile():
    """Update user profile"""
    try:
        current_user_id = get_jwt_identity()
        user = User.query.get(current_user_id)
        
        if not user:
            return jsonify({'error': 'User not found'}), 404
        
        data = request.get_json()
        old_values = user.to_dict()
        
        # Update allowed fields
        if 'username' in data:
            new_username = data['username'].strip()
            if len(new_username) < 3 or len(new_username) > 80:
                return jsonify({'error': 'Username must be between 3 and 80 characters'}), 400
            
            # Check if username is taken by another user
            existing_user = User.query.filter_by(username=new_username).first()
            if existing_user and existing_user.id != user.id:
                return jsonify({'error': 'Username already exists'}), 409
            
            user.username = new_username
        
        if 'email' in data:
            new_email = data['email'].strip().lower()
            if not is_valid_email(new_email):
                return jsonify({'error': 'Invalid email format'}), 400
            
            # Check if email is taken by another user
            existing_user = User.query.filter_by(email=new_email).first()
            if existing_user and existing_user.id != user.id:
                return jsonify({'error': 'Email already registered'}), 409
            
            user.email = new_email
            user.is_email_verified = False  # Need to re-verify new email
        
        user.updated_at = datetime.utcnow()
        db.session.commit()
        
        # Create audit log
        AuditLog.log_action(
            user_id=current_user_id,
            action='UPDATE',
            resource_type='user',
            resource_id=user.id,
            old_values=old_values,
            new_values=user.to_dict(),
            description='Profile updated',
            request=request
        )
        
        SystemLog.log('INFO', 'auth', f'Profile updated for user: {user.username}', 
                     details={'user_id': user.id}, request=request)
        
        return jsonify({
            'message': 'Profile updated successfully',
            'user': user.to_dict()
        }), 200
        
    except Exception as e:
        db.session.rollback()
        SystemLog.log('ERROR', 'auth', f'Profile update error: {str(e)}', request=request)
        return jsonify({'error': 'Internal server error'}), 500

@bp.route('/change-password', methods=['POST'])
@jwt_required()
def change_password():
    """Change user password"""
    try:
        current_user_id = get_jwt_identity()
        user = User.query.get(current_user_id)
        
        if not user:
            return jsonify({'error': 'User not found'}), 404
        
        data = request.get_json()
        
        if not data.get('current_password') or not data.get('new_password'):
            return jsonify({'error': 'Current password and new password are required'}), 400
        
        current_password = data.get('current_password')
        new_password = data.get('new_password')
        
        # Verify current password
        if not user.check_password(current_password):
            return jsonify({'error': 'Current password is incorrect'}), 401
        
        # Validate new password
        is_valid, password_message = is_valid_password(new_password)
        if not is_valid:
            return jsonify({'error': password_message}), 400
        
        # Update password
        user.set_password(new_password)
        user.updated_at = datetime.utcnow()
        db.session.commit()
        
        # Create audit log
        AuditLog.log_action(
            user_id=current_user_id,
            action='UPDATE',
            resource_type='user',
            resource_id=user.id,
            description='Password changed',
            request=request
        )
        
        SystemLog.log('INFO', 'auth', f'Password changed for user: {user.username}', 
                     details={'user_id': user.id}, request=request)
        
        return jsonify({'message': 'Password changed successfully'}), 200
        
    except Exception as e:
        db.session.rollback()
        SystemLog.log('ERROR', 'auth', f'Password change error: {str(e)}', request=request)
        return jsonify({'error': 'Internal server error'}), 500

@bp.route('/forgot-password', methods=['POST'])
def forgot_password():
    """Request password reset"""
    try:
        data = request.get_json()
        
        if not data.get('email'):
            return jsonify({'error': 'Email is required'}), 400
        
        email = data.get('email').strip().lower()
        user = User.query.filter_by(email=email).first()
        
        # Always return success to prevent email enumeration
        if user and user.is_active:
            # TODO: Generate reset token and send email
            # For now, just log the request
            SystemLog.log('INFO', 'auth', f'Password reset requested for: {email}', 
                         details={'user_id': user.id}, request=request)
        
        return jsonify({
            'message': 'If an account with that email exists, a password reset link has been sent'
        }), 200
        
    except Exception as e:
        SystemLog.log('ERROR', 'auth', f'Forgot password error: {str(e)}', request=request)
        return jsonify({'error': 'Internal server error'}), 500

# Function to check if token is blacklisted (to be used in __init__.py)
def is_token_blacklisted(jwt_payload):
    return jwt_payload['jti'] in blacklisted_tokens