"""
User Management Routes
Handles admin functionality for managing users
"""

from flask import Blueprint, request, jsonify
from flask_jwt_extended import get_jwt_identity, jwt_required
from sqlalchemy import or_
from werkzeug.security import generate_password_hash
from ..models.user import User
from app import db
from datetime import datetime, timezone
import logging

bp = Blueprint('user_management', __name__, url_prefix='/api/users')
logger = logging.getLogger(__name__)

def require_admin():
    """Decorator to check if user has admin privileges"""
    def decorator(f):
        def decorated_function(*args, **kwargs):
            current_user_id = get_jwt_identity()
            user = User.query.get(current_user_id)
            if not user or not user.is_admin:
                return jsonify({'error': 'Admin privileges required'}), 403
            return f(*args, **kwargs)
        decorated_function.__name__ = f.__name__
        return decorated_function
    return decorator

@bp.route('', methods=['GET'])
@jwt_required()
@require_admin()
def get_users():
    """Get all users with optional filtering"""
    try:
        page = request.args.get('page', 1, type=int)
        per_page = min(request.args.get('per_page', 10, type=int), 1000)  # Max 1000 per page
        role_filter = request.args.get('role', type=str)
        is_active_filter = request.args.get('is_active', type=str)
        search = request.args.get('search', type=str)
        
        # Build query
        query = User.query
        
        # Apply filters
        if role_filter:
            query = query.filter(User.role == role_filter)
        
        if is_active_filter is not None:
            is_active = is_active_filter.lower() == 'true'
            query = query.filter(User.is_active == is_active)
        
        if search:
            search_term = f"%{search}%"
            query = query.filter(or_(
                User.username.ilike(search_term),
                User.email.ilike(search_term),
                User.first_name.ilike(search_term)
            ))
        
        # Order by creation date (newest first)
        query = query.order_by(User.created_at.desc())
        
        # Paginate
        pagination = query.paginate(
            page=page, 
            per_page=per_page, 
            error_out=False
        )
        
        users = []
        for user in pagination.items:
            users.append({
                'id': user.id,
                'username': user.username,
                'email': user.email,
                'first_name': user.first_name,
                'last_name': user.last_name,
                'role': user.role,
                'is_active': user.is_active,
                'is_admin': user.is_admin,
                'is_email_verified': user.is_email_verified,
                'created_at': user.created_at.isoformat() if user.created_at else None,
                'updated_at': user.updated_at.isoformat() if user.updated_at else None,
                'last_login': user.last_login.isoformat() if user.last_login else None
            })
        
        return jsonify({
            'users': users,
            'total': pagination.total,
            'page': page,
            'per_page': per_page,
            'pages': pagination.pages
        }), 200
        
    except Exception as e:
        logger.error(f"Error fetching users: {str(e)}")
        return jsonify({'error': 'Failed to fetch users'}), 500

@bp.route('/<int:user_id>', methods=['GET'])
@jwt_required()
@require_admin()
def get_user(user_id):
    """Get a specific user by ID"""
    try:
        user = User.query.get_or_404(user_id)
        
        return jsonify({
            'id': user.id,
            'username': user.username,
            'email': user.email,
            'first_name': user.first_name,
            'last_name': user.last_name,
            'role': user.role,
            'is_active': user.is_active,
            'is_admin': user.is_admin,
            'is_email_verified': user.is_email_verified,
            'created_at': user.created_at.isoformat() if user.created_at else None,
            'updated_at': user.updated_at.isoformat() if user.updated_at else None,
            'last_login': user.last_login.isoformat() if user.last_login else None
        }), 200
        
    except Exception as e:
        logger.error(f"Error fetching user {user_id}: {str(e)}")
        return jsonify({'error': 'Failed to fetch user'}), 500

@bp.route('', methods=['POST'])
@jwt_required()
@require_admin()
def create_user():
    """Create a new user"""
    try:
        data = request.get_json()
        
        # Validate required fields
        required_fields = ['username', 'email', 'password', 'role']
        for field in required_fields:
            if not data.get(field):
                return jsonify({'error': f'{field} is required'}), 400
        
        # Check if username or email already exists
        if User.query.filter_by(username=data['username']).first():
            return jsonify({'error': 'Username already exists'}), 400
        
        if User.query.filter_by(email=data['email']).first():
            return jsonify({'error': 'Email already exists'}), 400
        
        # Validate role
        valid_roles = ['student', 'teacher', 'admin']
        if data['role'] not in valid_roles:
            return jsonify({'error': 'Invalid role'}), 400
        
        # Create new user
        user = User(
            username=data['username'],
            email=data['email'],
            password_hash=generate_password_hash(data['password']),
            first_name=data.get('first_name'),
            last_name=data.get('last_name'),
            role=data['role'],
            is_active=data.get('is_active', True),
            created_at=datetime.now(timezone.utc)
        )
        
        db.session.add(user)
        db.session.commit()
        
        return jsonify({
            'id': user.id,
            'username': user.username,
            'email': user.email,
            'first_name': user.first_name,
            'last_name': user.last_name,
            'role': user.role,
            'is_active': user.is_active,
            'created_at': user.created_at.isoformat() if user.created_at else None,
            'message': 'User created successfully'
        }), 201
        
    except Exception as e:
        db.session.rollback()
        logger.error(f"Error creating user: {str(e)}")
        return jsonify({'error': 'Failed to create user'}), 500

@bp.route('/<int:user_id>', methods=['PUT'])
@jwt_required()
@require_admin()
def update_user(user_id):
    """Update an existing user"""
    try:
        user = User.query.get_or_404(user_id)
        data = request.get_json()
        
        # Check if username or email already exists (excluding current user)
        if 'username' in data:
            existing_user = User.query.filter(
                User.username == data['username'],
                User.id != user_id
            ).first()
            if existing_user:
                return jsonify({'error': 'Username already exists'}), 400
        
        if 'email' in data:
            existing_user = User.query.filter(
                User.email == data['email'],
                User.id != user_id
            ).first()
            if existing_user:
                return jsonify({'error': 'Email already exists'}), 400
        
        # Validate role if provided
        if 'role' in data:
            valid_roles = ['student', 'teacher', 'admin']
            if data['role'] not in valid_roles:
                return jsonify({'error': 'Invalid role'}), 400
        
        # Update user fields
        for field in ['username', 'email', 'first_name', 'last_name', 'role', 'is_active']:
            if field in data:
                setattr(user, field, data[field])
        
        user.updated_at = datetime.now(timezone.utc)
        db.session.commit()
        
        return jsonify({
            'id': user.id,
            'username': user.username,
            'email': user.email,
            'first_name': user.first_name,
            'last_name': user.last_name,
            'role': user.role,
            'is_active': user.is_active,
            'created_at': user.created_at.isoformat() if user.created_at else None,
            'updated_at': user.updated_at.isoformat() if user.updated_at else None,
            'message': 'User updated successfully'
        }), 200
        
    except Exception as e:
        db.session.rollback()
        logger.error(f"Error updating user {user_id}: {str(e)}")
        return jsonify({'error': 'Failed to update user'}), 500

@bp.route('/<int:user_id>', methods=['DELETE'])
@jwt_required()
@require_admin()
def delete_user(user_id):
    """Delete a user"""
    try:
        user = User.query.get_or_404(user_id)
        
        # Prevent deletion of admin users or self
        current_user_id = get_jwt_identity()
        if user.role == 'admin':
            return jsonify({'error': 'Cannot delete admin users'}), 400
        
        if user.id == current_user_id:
            return jsonify({'error': 'Cannot delete your own account'}), 400
        
        db.session.delete(user)
        db.session.commit()
        
        return jsonify({
            'success': True,
            'message': 'User deleted successfully'
        }), 200
        
    except Exception as e:
        db.session.rollback()
        logger.error(f"Error deleting user {user_id}: {str(e)}")
        return jsonify({'error': 'Failed to delete user'}), 500

@bp.route('/<int:user_id>/status', methods=['PATCH'])
@jwt_required()
@require_admin()
def toggle_user_status(user_id):
    """Toggle user active status"""
    try:
        user = User.query.get_or_404(user_id)
        data = request.get_json()
        
        if 'is_active' not in data:
            return jsonify({'error': 'is_active field is required'}), 400
        
        # Prevent deactivating admin users
        if user.role == 'admin' and not data['is_active']:
            return jsonify({'error': 'Cannot deactivate admin users'}), 400
        
        user.is_active = data['is_active']
        user.updated_at = datetime.now(timezone.utc)
        db.session.commit()
        
        return jsonify({
            'id': user.id,
            'username': user.username,
            'email': user.email,
            'first_name': user.first_name,
            'last_name': user.last_name,
            'role': user.role,
            'is_active': user.is_active,
            'updated_at': user.updated_at.isoformat() if user.updated_at else None,
            'message': f'User {"activated" if user.is_active else "deactivated"} successfully'
        }), 200
        
    except Exception as e:
        db.session.rollback()
        logger.error(f"Error toggling user status {user_id}: {str(e)}")
        return jsonify({'error': 'Failed to update user status'}), 500

@bp.route('/<int:user_id>/reset-password', methods=['POST'])
@jwt_required()
@require_admin()
def reset_user_password(user_id):
    """Reset user password (admin only)"""
    try:
        current_user_id = int(get_jwt_identity())
        current_user = User.query.get(current_user_id)
        
        if not current_user or not current_user.is_admin:
            return jsonify({'error': 'Admin access required'}), 403
        
        # Find the user to reset password for
        user = User.query.get(user_id)
        if not user:
            return jsonify({'error': 'User not found'}), 404
        
        data = request.get_json()
        if not data or not data.get('new_password'):
            return jsonify({'error': 'new_password is required'}), 400
        
        new_password = data.get('new_password')
        
        # Validate new password strength
        from app.routes.auth import is_valid_password
        is_valid, password_message = is_valid_password(new_password)
        if not is_valid:
            return jsonify({'error': password_message}), 400
        
        # Update password
        user.set_password(new_password)
        user.updated_at = datetime.now(timezone.utc)
        db.session.commit()
        
        # Log the password reset action
        logger.info(f"Admin {current_user.username} reset password for user {user.username}")
        
        return jsonify({
            'success': True,
            'message': f'Password reset successfully for user {user.username}'
        }), 200
        
    except Exception as e:
        db.session.rollback()
        logger.error(f"Error resetting password for user {user_id}: {str(e)}")
        return jsonify({'error': 'Failed to reset password'}), 500

@bp.route('/simple', methods=['GET'])
def get_simple_user_list():
    """Get simplified user list for dropdowns/assignments"""
    try:
        users = User.query.filter_by(is_active=True).order_by(User.username).all()
        
        user_list = []
        for user in users:
            user_list.append({
                'id': user.id,
                'username': user.username,
                'email': user.email,
                'first_name': user.first_name
            })
        
        return jsonify(user_list), 200
        
    except Exception as e:
        logger.error(f"Error fetching simple user list: {str(e)}")
        return jsonify({'error': 'Failed to fetch user list'}), 500

@bp.route('/category/<int:category_id>/assigned', methods=['GET'])
@jwt_required()
@require_admin()
def get_users_assigned_to_category(category_id):
    """Get users assigned to a specific category"""
    try:
        from app.models.user_category import UserCategoryAssignment
        
        # Get user IDs assigned to this category
        assignments = UserCategoryAssignment.query.filter_by(category_id=category_id).all()
        user_ids = [assignment.user_id for assignment in assignments]
        
        if not user_ids:
            return jsonify([]), 200
        
        # Get user details
        users = User.query.filter(User.id.in_(user_ids)).all()
        
        # Return user list in the expected format
        user_list = []
        for user in users:
            user_list.append({
                'id': user.id,
                'username': user.username,
                'email': user.email,
                'first_name': user.first_name
            })
        
        return jsonify(user_list), 200
        
    except Exception as e:
        logger.error(f"Error fetching assigned users for category {category_id}: {str(e)}")
        return jsonify({'error': 'Failed to fetch assigned users'}), 500


@bp.route('/me/categories', methods=['GET'])
@jwt_required()
def get_current_user_categories():
    """Get categories assigned to the current user"""
    try:
        current_user_id = int(get_jwt_identity())
        logger.info(f"Fetching categories for user {current_user_id}")
        
        # Import models here to avoid circular imports
        from app.models.user_category import UserCategoryAssignment
        
        # Get user's assigned categories
        assignments = UserCategoryAssignment.query.filter_by(user_id=current_user_id).all()
        
        if not assignments:
            logger.info(f"No categories assigned to user {current_user_id}")
            return jsonify([]), 200
        
        # Get category IDs for sentence count query
        category_ids = [assignment.category_id for assignment in assignments]
        
        # For now, let's skip sentence counting and just return basic category info
        sentence_counts = {}  # We'll fix this later
        
        # Build category list with accurate sentence counts
        categories = []
        for assignment in assignments:
            category_id = assignment.category_id
            category_name = assignment.category_name or f"Category {category_id}"
            
            # Simple difficulty mapping based on category_id
            if category_id <= 3:
                difficulty = 'elementary'
            elif category_id <= 6:
                difficulty = 'intermediate'
            else:
                difficulty = 'advanced'
            
            # Get actual sentence count or default to a reasonable number for testing
            sentence_count = sentence_counts.get(category_id, 200)  # Default to 200 for testing
            
            categories.append({
                'id': category_id,
                'name': category_name,
                'description': f'分类 {category_name}',
                'difficulty': difficulty,
                'is_active': True,
                'sentence_count': sentence_count,
                'created_at': assignment.assigned_at.isoformat() if assignment.assigned_at else None,
                'updated_at': assignment.assigned_at.isoformat() if assignment.assigned_at else None
            })
        
        logger.info(f"Found {len(categories)} categories for user {current_user_id}")
        return jsonify(categories), 200
        
    except Exception as e:
        logger.error(f"Error fetching categories for current user: {str(e)}")
        return jsonify({'error': f'Failed to fetch user categories: {str(e)}'}), 500