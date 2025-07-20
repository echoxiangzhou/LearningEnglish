from flask import Blueprint, request, jsonify, current_app
from flask_jwt_extended import jwt_required, get_jwt_identity
from sqlalchemy import and_, or_, func
from sqlalchemy.orm import joinedload
from app import db
from app.models.word import Word
from app.models.vocabulary_library import VocabularyLibrary, LibraryAssignment, library_words
from app.models.user import User
from app.services.tts_service import TTSService
from datetime import datetime, timedelta
import json
import csv
import io
import requests
from werkzeug.utils import secure_filename
import PyPDF2
import re

# Create Blueprint
vocabulary_bp = Blueprint('vocabulary_management', __name__, url_prefix='/api/vocabulary-management')

def require_admin_or_teacher(current_user):
    """Check if user has admin or teacher role"""
    if not current_user:
        return jsonify({'error': 'Authentication required'}), 401
    if current_user.role not in ['admin', 'teacher']:
        return jsonify({'error': 'Admin or teacher access required'}), 403
    return None

@vocabulary_bp.route('/libraries', methods=['GET'])
@jwt_required()
def get_vocabulary_libraries():
    """Get all vocabulary libraries"""
    try:
        current_user_id = get_jwt_identity()
        current_user = User.query.get(current_user_id)
        
        if not current_user:
            return jsonify({'error': 'User not found'}), 404
        
        # Admin/teacher can see all libraries, students see assigned ones
        if current_user.role in ['admin', 'teacher']:
            libraries = VocabularyLibrary.query.filter_by(is_active=True).all()
        else:
            # For students, get libraries assigned to them
            assigned_library_ids = db.session.query(LibraryAssignment.library_id).filter_by(
                user_id=current_user.id
            ).subquery()
            libraries = VocabularyLibrary.query.filter(
                and_(
                    VocabularyLibrary.id.in_(assigned_library_ids),
                    VocabularyLibrary.is_active == True
                )
            ).all()
        
        # Convert to frontend format
        libraries_data = [lib.to_frontend_dict() for lib in libraries]
        
        return jsonify({
            'success': True,
            'libraries': libraries_data
        })
    
    except Exception as e:
        current_app.logger.error(f"Error fetching vocabulary libraries: {str(e)}")
        return jsonify({'error': 'Failed to fetch libraries'}), 500

@vocabulary_bp.route('/libraries/<library_id>/words', methods=['GET'])
@jwt_required()
def get_library_words(library_id):
    """Get words from a specific library"""
    try:
        current_user_id = get_jwt_identity()
        current_user = User.query.get(current_user_id)
        
        if not current_user:
            return jsonify({'error': 'User not found'}), 404
        
        # Find library by library_id (string)
        library = VocabularyLibrary.query.filter_by(library_id=library_id, is_active=True).first()
        if not library:
            return jsonify({'error': 'Library not found'}), 404
        
        # Check access permissions
        if current_user.role not in ['admin', 'teacher']:
            # Check if student has access to this library
            assignment = LibraryAssignment.query.filter_by(
                library_id=library.id,
                user_id=current_user.id
            ).first()
            if not assignment:
                return jsonify({'error': 'Access denied to this library'}), 403
        
        # Get query parameters
        page = request.args.get('page', 1, type=int)
        per_page = min(request.args.get('per_page', 50, type=int), 100)
        search = request.args.get('search', '').strip()
        difficulty = request.args.get('difficulty', type=int)
        grade_level = request.args.get('grade_level', type=int)
        part_of_speech = request.args.get('part_of_speech')
        
        # Build query with active words only using the association table
        query = db.session.query(Word).join(
            library_words, Word.id == library_words.c.word_id
        ).filter(
            library_words.c.library_id == library.id,
            Word.is_active == True
        )
        
        # Apply filters
        if search:
            query = query.filter(or_(
                Word.word.ilike(f'%{search}%'),
                Word.chinese_meaning.ilike(f'%{search}%'),
                Word.definition.ilike(f'%{search}%')
            ))
        
        if difficulty:
            query = query.filter(Word.difficulty == difficulty)
        
        if grade_level:
            query = query.filter(Word.grade_level == grade_level)
        
        if part_of_speech:
            query = query.filter(Word.part_of_speech == part_of_speech)
        
        # Order by word alphabetically
        query = query.order_by(Word.word)
        
        # Paginate
        pagination = query.paginate(
            page=page, 
            per_page=per_page, 
            error_out=False
        )
        
        words_data = [word.to_dict() for word in pagination.items]
        
        return jsonify({
            'success': True,
            'words': words_data,
            'pagination': {
                'page': page,
                'per_page': per_page,
                'total': pagination.total,
                'pages': pagination.pages,
                'has_next': pagination.has_next,
                'has_prev': pagination.has_prev
            },
            'library': library.to_dict()
        })
    
    except Exception as e:
        current_app.logger.error(f"Error fetching library words: {str(e)}")
        return jsonify({'error': 'Failed to fetch words'}), 500

@vocabulary_bp.route('/words', methods=['POST'])
@jwt_required()
def create_word():
    """Create a new word"""
    current_user_id = get_jwt_identity()
    current_user = User.query.get(current_user_id)
    
    # Check permissions
    auth_error = require_admin_or_teacher(current_user)
    if auth_error:
        return auth_error
    
    try:
        data = request.get_json()
        if not data:
            return jsonify({'error': 'No data provided'}), 400
        
        # Validate required fields
        required_fields = ['word', 'chinese_meaning']
        for field in required_fields:
            if not data.get(field):
                return jsonify({'error': f'{field} is required'}), 400
        
        # Check if word already exists
        existing_word = Word.query.filter_by(word=data['word'].lower().strip()).first()
        if existing_word:
            return jsonify({'error': 'Word already exists'}), 409
        
        # Create new word
        word = Word(
            word=data['word'].lower().strip(),
            phonetic=data.get('phonetic', '').strip(),
            pronunciation=data.get('pronunciation', '').strip(),
            definition=data.get('definition', '').strip(),
            chinese_meaning=data['chinese_meaning'].strip(),
            grade_level=data.get('grade_level', 1),
            difficulty=data.get('difficulty', 1),
            difficulty_level=data.get('difficulty_level', 'easy'),
            audio_url=data.get('audio_url', '').strip(),
            image_url=data.get('image_url', '').strip(),
            example_sentence=data.get('example_sentence', '').strip(),
            example_chinese=data.get('example_chinese', '').strip(),
            usage_notes=data.get('usage_notes', '').strip(),
            source=data.get('source', 'manual'),
            is_core_vocabulary=data.get('is_core_vocabulary', False),
            created_by=current_user.id
        )
        
        # Set part of speech if provided
        if data.get('part_of_speech'):
            word.part_of_speech = data['part_of_speech']
        
        # Handle JSON fields
        if data.get('synonyms'):
            word.set_synonyms(data['synonyms'])
        if data.get('antonyms'):
            word.set_antonyms(data['antonyms'])
        if data.get('related_words'):
            word.set_related_words(data['related_words'])
        if data.get('irregular_forms'):
            word.set_irregular_forms(data['irregular_forms'])
        
        db.session.add(word)
        db.session.commit()
        
        return jsonify({
            'success': True,
            'message': 'Word created successfully',
            'word': word.to_dict(include_extended=True)
        }), 201
    
    except Exception as e:
        db.session.rollback()
        current_app.logger.error(f"Error creating word: {str(e)}")
        return jsonify({'error': 'Failed to create word'}), 500

@vocabulary_bp.route('/words/<int:word_id>', methods=['PUT'])
@jwt_required()
def update_word(word_id):
    """Update an existing word"""
    current_user_id = get_jwt_identity()
    current_user = User.query.get(current_user_id)
    
    # Check permissions
    auth_error = require_admin_or_teacher(current_user)
    if auth_error:
        return auth_error
    
    try:
        word = Word.query.get_or_404(word_id)
        data = request.get_json()
        if not data:
            return jsonify({'error': 'No data provided'}), 400
        
        # Update fields
        if 'word' in data:
            # Check for duplicates (excluding current word)
            existing = Word.query.filter(
                and_(Word.word == data['word'].lower().strip(), Word.id != word_id)
            ).first()
            if existing:
                return jsonify({'error': 'Word already exists'}), 409
            word.word = data['word'].lower().strip()
        
        # Update other fields
        updateable_fields = [
            'phonetic', 'pronunciation', 'definition', 'chinese_meaning',
            'grade_level', 'difficulty', 'audio_url', 'image_url',
            'example_sentence', 'example_chinese', 'usage_notes',
            'source', 'is_core_vocabulary'
        ]
        
        for field in updateable_fields:
            if field in data:
                setattr(word, field, data[field])
        
        # Handle string fields that were previously enums
        if 'difficulty_level' in data:
            word.difficulty_level = data['difficulty_level']
        
        if 'part_of_speech' in data:
            word.part_of_speech = data['part_of_speech']
        
        # Handle JSON fields
        if 'synonyms' in data:
            word.set_synonyms(data['synonyms'])
        if 'antonyms' in data:
            word.set_antonyms(data['antonyms'])
        if 'related_words' in data:
            word.set_related_words(data['related_words'])
        if 'irregular_forms' in data:
            word.set_irregular_forms(data['irregular_forms'])
        
        word.updated_at = datetime.utcnow()
        db.session.commit()
        
        return jsonify({
            'success': True,
            'message': 'Word updated successfully',
            'word': word.to_dict(include_extended=True)
        })
    
    except Exception as e:
        db.session.rollback()
        current_app.logger.error(f"Error updating word: {str(e)}")
        return jsonify({'error': 'Failed to update word'}), 500

@vocabulary_bp.route('/words/<int:word_id>', methods=['DELETE'])
@jwt_required()
def delete_word(word_id):
    """Delete a word"""
    current_user_id = get_jwt_identity()
    current_user = User.query.get(current_user_id)
    
    # Check permissions
    auth_error = require_admin_or_teacher(current_user)
    if auth_error:
        return auth_error
    
    try:
        word = Word.query.get_or_404(word_id)
        
        # Soft delete by setting is_active to False
        word.is_active = False
        word.updated_at = datetime.utcnow()
        db.session.commit()
        
        return jsonify({
            'success': True,
            'message': 'Word deleted successfully'
        })
    
    except Exception as e:
        db.session.rollback()
        current_app.logger.error(f"Error deleting word: {str(e)}")
        return jsonify({'error': 'Failed to delete word'}), 500

@vocabulary_bp.route('/libraries', methods=['POST'])
@jwt_required()
def create_library():
    """Create a new vocabulary library"""
    current_user_id = get_jwt_identity()
    current_user = User.query.get(current_user_id)
    
    # Check permissions
    auth_error = require_admin_or_teacher(current_user)
    if auth_error:
        return auth_error
    
    try:
        data = request.get_json()
        if not data:
            return jsonify({'error': 'No data provided'}), 400
        
        # Validate required fields
        required_fields = ['library_id', 'name', 'library_type']
        for field in required_fields:
            if not data.get(field):
                return jsonify({'error': f'{field} is required'}), 400
        
        # Check if library_id already exists
        existing = VocabularyLibrary.query.filter_by(library_id=data['library_id']).first()
        if existing:
            return jsonify({'error': 'Library ID already exists'}), 409
        
        # Create new library
        library = VocabularyLibrary(
            library_id=data['library_id'],
            name=data['name'],
            description=data.get('description', ''),
            library_type=data['library_type'],  # Use string directly
            grade_level=data.get('grade_level'),
            is_public=data.get('is_public', True),
            is_system_library=data.get('is_system_library', False),
            last_updated_by=current_user.id
        )
        
        # Set categories and tags
        if data.get('categories'):
            library.set_categories(data['categories'])
        if data.get('tags'):
            library.set_tags(data['tags'])
        
        db.session.add(library)
        db.session.commit()
        
        return jsonify({
            'success': True,
            'message': 'Library created successfully',
            'library': library.to_dict()
        }), 201
    
    except Exception as e:
        db.session.rollback()
        current_app.logger.error(f"Error creating library: {str(e)}")
        return jsonify({'error': 'Failed to create library'}), 500

@vocabulary_bp.route('/libraries/<library_id>/words/<int:word_id>', methods=['POST'])
@jwt_required()
def add_word_to_library(library_id, word_id):
    """Add a word to a library"""
    current_user_id = get_jwt_identity()
    current_user = User.query.get(current_user_id)
    
    # Check permissions
    auth_error = require_admin_or_teacher(current_user)
    if auth_error:
        return auth_error
    
    try:
        library = VocabularyLibrary.query.filter_by(library_id=library_id).first_or_404()
        word = Word.query.get_or_404(word_id)
        
        # Check if word is already in library
        if word in library.words:
            return jsonify({'error': 'Word is already in this library'}), 409
        
        # Add word to library
        library.add_word(word)
        db.session.commit()
        
        return jsonify({
            'success': True,
            'message': 'Word added to library successfully'
        })
    
    except Exception as e:
        db.session.rollback()
        current_app.logger.error(f"Error adding word to library: {str(e)}")
        return jsonify({'error': 'Failed to add word to library'}), 500

@vocabulary_bp.route('/libraries/<library_id>/words/<int:word_id>', methods=['DELETE'])
@jwt_required()
def remove_word_from_library(library_id, word_id):
    """Remove a word from a library"""
    current_user_id = get_jwt_identity()
    current_user = User.query.get(current_user_id)
    
    # Check permissions
    auth_error = require_admin_or_teacher(current_user)
    if auth_error:
        return auth_error
    
    try:
        library = VocabularyLibrary.query.filter_by(library_id=library_id).first_or_404()
        word = Word.query.get_or_404(word_id)
        
        # Check if word is in library
        if word not in library.words:
            return jsonify({'error': 'Word is not in this library'}), 404
        
        # Remove word from library
        library.remove_word(word)
        db.session.commit()
        
        return jsonify({
            'success': True,
            'message': 'Word removed from library successfully'
        })
    
    except Exception as e:
        db.session.rollback()
        current_app.logger.error(f"Error removing word from library: {str(e)}")
        return jsonify({'error': 'Failed to remove word from library'}), 500

@vocabulary_bp.route('/libraries/<library_id>/assign', methods=['POST'])
@jwt_required()
def assign_library_to_user(library_id):
    """Assign a library to a user"""
    current_user_id = get_jwt_identity()
    current_user = User.query.get(current_user_id)
    
    # Check permissions
    auth_error = require_admin_or_teacher(current_user)
    if auth_error:
        return auth_error
    
    try:
        data = request.get_json()
        current_app.logger.info(f"assign_library_to_user: library_id={library_id}, data={data}")
        
        if not data or not data.get('user_id'):
            current_app.logger.error("assign_library_to_user: user_id is required")
            return jsonify({'error': 'user_id is required'}), 400
        
        library = VocabularyLibrary.query.filter_by(library_id=library_id).first()
        if not library:
            current_app.logger.error(f"assign_library_to_user: Library not found with library_id={library_id}")
            return jsonify({'error': 'Library not found'}), 404
        
        user = User.query.get(data['user_id'])
        if not user:
            current_app.logger.error(f"assign_library_to_user: User not found with id={data['user_id']}")
            return jsonify({'error': 'User not found'}), 404
        
        # Check if assignment already exists
        existing = LibraryAssignment.query.filter_by(
            library_id=library.id,
            user_id=user.id
        ).first()
        
        if existing:
            current_app.logger.warning(f"assign_library_to_user: Assignment already exists for library_id={library.id}, user_id={user.id}")
            return jsonify({'error': 'Library is already assigned to this user'}), 409
        
        # Create assignment
        assignment = LibraryAssignment(
            library_id=library.id,
            user_id=user.id,
            is_required=data.get('is_required', False),
            assigned_by=current_user.id
        )
        
        # Set dates if provided
        if data.get('start_date'):
            try:
                assignment.start_date = datetime.fromisoformat(data['start_date']).date()
            except ValueError as e:
                current_app.logger.error(f"assign_library_to_user: Invalid start_date format: {data['start_date']}, error: {e}")
                return jsonify({'error': 'Invalid start_date format. Use YYYY-MM-DD'}), 400
                
        if data.get('end_date'):
            try:
                assignment.end_date = datetime.fromisoformat(data['end_date']).date()
            except ValueError as e:
                current_app.logger.error(f"assign_library_to_user: Invalid end_date format: {data['end_date']}, error: {e}")
                return jsonify({'error': 'Invalid end_date format. Use YYYY-MM-DD'}), 400
        
        current_app.logger.info(f"assign_library_to_user: Creating assignment - library_id={library.id}, user_id={user.id}, is_required={assignment.is_required}")
        
        db.session.add(assignment)
        db.session.commit()
        
        current_app.logger.info(f"assign_library_to_user: Assignment created successfully with id={assignment.id}")
        
        return jsonify({
            'success': True,
            'message': 'Library assigned successfully',
            'assignment': assignment.to_dict()
        }), 201
    
    except Exception as e:
        db.session.rollback()
        current_app.logger.error(f"Error assigning library: {str(e)}")
        return jsonify({'error': 'Failed to assign library'}), 500

@vocabulary_bp.route('/statistics', methods=['GET'])
@jwt_required()
def get_vocabulary_statistics():
    """Get vocabulary statistics"""
    try:
        current_user_id = get_jwt_identity()
        current_user = User.query.get(current_user_id)
        
        if not current_user:
            return jsonify({'error': 'User not found'}), 404
        
        # Base statistics available to all users
        total_words = Word.query.filter_by(is_active=True).count()
        total_libraries = VocabularyLibrary.query.filter_by(is_active=True).count()
        
        stats = {
            'total_words': total_words,
            'total_libraries': total_libraries
        }
        
        # Additional stats for admin/teacher
        if current_user.role in ['admin', 'teacher']:
            stats.update({
                'words_by_grade': dict(
                    db.session.query(Word.grade_level, func.count(Word.id))
                    .filter(Word.is_active == True)
                    .group_by(Word.grade_level)
                    .all()
                ),
                'words_by_difficulty': dict(
                    db.session.query(Word.difficulty, func.count(Word.id))
                    .filter(Word.is_active == True)
                    .group_by(Word.difficulty)
                    .all()
                ),
                'libraries_by_type': dict(
                    db.session.query(VocabularyLibrary.library_type, func.count(VocabularyLibrary.id))
                    .filter(VocabularyLibrary.is_active == True)
                    .group_by(VocabularyLibrary.library_type)
                    .all()
                )
            })
        
        # User-specific stats
        if current_user.role == 'student':
            assigned_libraries = LibraryAssignment.query.filter_by(user_id=current_user.id).count()
            stats['assigned_libraries'] = assigned_libraries
        
        return jsonify({
            'success': True,
            'statistics': stats
        })
    
    except Exception as e:
        current_app.logger.error(f"Error fetching statistics: {str(e)}")
        return jsonify({'error': 'Failed to fetch statistics'}), 500

@vocabulary_bp.route('/import', methods=['POST'])
@jwt_required()
def import_vocabulary():
    """Import vocabulary from file with automatic translation"""
    try:
        current_user_id = get_jwt_identity()
        user = User.query.get(current_user_id)
        
        # Check permissions
        if not user or user.role not in ['admin', 'teacher']:
            return jsonify({'error': 'Admin or teacher access required'}), 403
        
        # Get form data
        library_name = request.form.get('library_name')
        api_key = request.form.get('api_key')
        
        if not library_name or not api_key:
            return jsonify({'error': 'Library name and API key are required'}), 400
        
        # Get uploaded file
        if 'file' not in request.files:
            return jsonify({'error': 'No file uploaded'}), 400
        
        file = request.files['file']
        if file.filename == '':
            return jsonify({'error': 'No file selected'}), 400
        
        # Process file based on type
        filename = secure_filename(file.filename)
        file_ext = filename.rsplit('.', 1)[1].lower() if '.' in filename else ''
        
        words_to_import = []
        
        if file_ext == 'csv':
            # Process CSV file
            stream = io.StringIO(file.stream.read().decode("UTF8"), newline=None)
            csv_reader = csv.reader(stream)
            for row in csv_reader:
                # Assume each row contains comma-separated words
                words_to_import.extend([word.strip() for word in row if word.strip()])
        
        elif file_ext in ['md', 'txt']:
            # Process Markdown or text file
            content = file.stream.read().decode('utf-8')
            # Split by commas, newlines, or spaces
            words = re.split(r'[,\n\s]+', content)
            words_to_import = [word.strip() for word in words if word.strip()]
        
        elif file_ext == 'pdf':
            # Process PDF file
            pdf_reader = PyPDF2.PdfReader(file.stream)
            text = ''
            for page in pdf_reader.pages:
                text += page.extract_text()
            # Split by commas, newlines, or spaces
            words = re.split(r'[,\n\s]+', text)
            words_to_import = [word.strip() for word in words if word.strip()]
        
        else:
            return jsonify({'error': 'Unsupported file type'}), 400
        
        # Remove duplicates and filter valid words
        words_to_import = list(set([w for w in words_to_import if w and len(w) > 1]))
        
        if not words_to_import:
            return jsonify({'error': 'No valid words found in file'}), 400
        
        # Create or get library
        library = VocabularyLibrary.query.filter_by(name=library_name).first()
        if not library:
            library = VocabularyLibrary(
                id=library_name.lower().replace(' ', '_'),
                name=library_name,
                description=library_name,
                library_type='custom',
                grade_level=1,  # Default, can be updated later
                is_active=True,
                categories=['imported'],
                created_by=user.username
            )
            db.session.add(library)
            db.session.flush()
        
        # Translate words using OpenRouter API
        imported_count = 0
        failed_words = []
        
        for word in words_to_import:
            try:
                # Check if word already exists
                existing_word = Word.query.filter_by(word=word.lower()).first()
                
                if not existing_word:
                    # Translate using OpenRouter API
                    chinese_meaning = translate_word_openrouter(word, api_key)
                    
                    if chinese_meaning:
                        # Create new word
                        new_word = Word(
                            word=word.lower(),
                            chinese_meaning=chinese_meaning,
                            grade_level=1,  # Default
                            difficulty='medium',  # Default
                            category='imported',
                            is_active=True
                        )
                        db.session.add(new_word)
                        db.session.flush()
                        existing_word = new_word
                    else:
                        failed_words.append(word)
                        continue
                
                # Add word to library if not already there
                if existing_word:
                    # Check if word is already in library
                    existing_link = db.session.query(library_words).filter_by(
                        library_id=library.id,
                        word_id=existing_word.id
                    ).first()
                    
                    if not existing_link:
                        # Add word to library
                        db.session.execute(
                            library_words.insert().values(
                                library_id=library.id,
                                word_id=existing_word.id
                            )
                        )
                        imported_count += 1
                
            except Exception as e:
                current_app.logger.error(f"Error importing word '{word}': {str(e)}")
                failed_words.append(word)
        
        # Update library word count
        library.word_count = db.session.query(func.count(library_words.c.word_id)).filter(
            library_words.c.library_id == library.id
        ).scalar() or 0
        
        db.session.commit()
        
        response_data = {
            'success': True,
            'imported_count': imported_count,
            'total_words': len(words_to_import),
            'library_id': library.id,
            'library_name': library.name
        }
        
        if failed_words:
            response_data['failed_words'] = failed_words[:10]  # Limit to first 10
            response_data['failed_count'] = len(failed_words)
        
        return jsonify(response_data)
        
    except Exception as e:
        current_app.logger.error(f"Import error: {str(e)}")
        db.session.rollback()
        return jsonify({'error': f'Import failed: {str(e)}'}), 500

def is_chinese_meaning_empty_or_placeholder(chinese_meaning):
    """检查中文意思是否为空或占位符，需要翻译"""
    if not chinese_meaning:
        return True
    
    # 去除空白字符
    chinese_meaning = chinese_meaning.strip()
    
    # 检查是否为空
    if not chinese_meaning:
        return True
    
    # 检查是否为占位符文本
    placeholder_texts = ['待翻译', 'pending translation', '翻译中', 'to be translated', '未翻译']
    return chinese_meaning in placeholder_texts or any(placeholder in chinese_meaning for placeholder in placeholder_texts)

def get_untranslated_filter_conditions():
    """获取筛选未翻译单词的SQL条件"""
    return or_(
        Word.chinese_meaning.is_(None),
        Word.chinese_meaning == '',
        Word.chinese_meaning == ' ',
        func.trim(Word.chinese_meaning) == '',
        Word.chinese_meaning == '待翻译',
        Word.chinese_meaning == 'pending translation',
        Word.chinese_meaning == '翻译中',
        Word.chinese_meaning.like('%待翻译%'),
        Word.chinese_meaning == 'to be translated',
        Word.chinese_meaning == '未翻译'
    )

def translate_word_openrouter(word, api_key, model="google/gemini-2.0-flash-001"):
    """Translate word or phrase using OpenRouter API with specified model"""
    try:
        url = "https://openrouter.ai/api/v1/chat/completions"
        
        headers = {
            "Authorization": f"Bearer {api_key}",
            "Content-Type": "application/json",
            "HTTP-Referer": "http://localhost:3000",
            "X-Title": "Smart English Learning"
        }
        
        # Determine if it's a word or phrase
        is_phrase = len(word.split()) > 1
        content_type = "phrase" if is_phrase else "word"
        
        payload = {
            "model": model,
            "messages": [
                {
                    "role": "system",
                    "content": f"You are a translator. Translate the given English {content_type} to Chinese (Simplified). Return ONLY the Chinese translation, no explanation or additional text. For phrases, provide a natural Chinese translation that captures the meaning."
                },
                {
                    "role": "user",
                    "content": f"Translate this {content_type} to Chinese: {word}"
                }
            ],
            "temperature": 0.3,
            "max_tokens": 100 if is_phrase else 50
        }
        
        response = requests.post(url, headers=headers, json=payload, timeout=10)
        
        if response.status_code == 200:
            data = response.json()
            translation = data['choices'][0]['message']['content'].strip()
            return translation
        else:
            current_app.logger.error(f"OpenRouter API error: {response.status_code} - {response.text}")
            return None
            
    except Exception as e:
        current_app.logger.error(f"Translation error for '{word}': {str(e)}")
        return None

@vocabulary_bp.route('/import-with-audio', methods=['POST'])
@jwt_required()
def import_vocabulary_with_audio():
    """Import vocabulary with Kokoro TTS audio generation and preview"""
    try:
        current_user_id = get_jwt_identity()
        user = User.query.get(current_user_id)
        
        # Check permissions
        if not user or user.role not in ['admin', 'teacher']:
            return jsonify({'error': 'Admin or teacher access required'}), 403
        
        # Get form data
        library_name = request.form.get('library_name')
        api_key = request.form.get('api_key')
        translation_model = request.form.get('translation_model', 'google/gemini-2.0-flash-001')
        voice = request.form.get('voice', 'af_bella')
        generate_audio = request.form.get('generate_audio', 'true').lower() == 'true'
        append_mode = request.form.get('append_mode', 'false').lower() == 'true'
        
        if not library_name or not api_key:
            return jsonify({'error': 'Library name and API key are required'}), 400
        
        # Get uploaded file
        if 'file' not in request.files:
            return jsonify({'error': 'No file uploaded'}), 400
        
        file = request.files['file']
        if file.filename == '':
            return jsonify({'error': 'No file selected'}), 400
        
        # Process file to extract words
        words_to_import = _extract_words_from_file(file)
        
        if not words_to_import:
            return jsonify({'error': 'No valid words found in file'}), 400
        
        # Initialize TTS service
        tts_service = TTSService() if generate_audio else None
        
        # Process words with translation and TTS
        processed_words = []
        failed_words = []
        
        for i, word in enumerate(words_to_import):
            try:
                # Check if word already exists
                existing_word = Word.query.filter_by(word=word.lower()).first()
                
                word_data = {
                    'word': word.lower(),
                    'original_word': word,
                    'exists': existing_word is not None
                }
                
                if existing_word:
                    # Use existing data
                    word_data.update({
                        'chinese_meaning': existing_word.chinese_meaning,
                        'phonetic': existing_word.phonetic or '',
                        'definition': existing_word.definition or '',
                        'audio_url': existing_word.audio_url or ''
                    })
                else:
                    # Translate word
                    chinese_meaning = translate_word_openrouter(word, api_key, translation_model)
                    if not chinese_meaning:
                        failed_words.append({'word': word, 'error': 'Translation failed'})
                        continue
                    
                    word_data.update({
                        'chinese_meaning': chinese_meaning,
                        'phonetic': '',
                        'definition': '',
                        'audio_url': ''
                    })
                
                # Generate audio if requested and not already available
                if generate_audio and tts_service and not word_data['audio_url']:
                    audio_path, error = tts_service.generate_audio(
                        word_data['original_word'], 
                        provider='kokoro', 
                        voice=voice,
                        category=library_name.lower().replace(' ', '_')
                    )
                    if audio_path:
                        # Convert absolute path to relative URL for frontend access
                        import os
                        backend_root = os.path.dirname(os.path.dirname(os.path.dirname(os.path.abspath(__file__))))
                        relative_path = os.path.relpath(audio_path, backend_root)
                        audio_url = '/' + relative_path.replace('\\', '/')
                        word_data['audio_url'] = audio_url
                        word_data['audio_generated'] = True
                    else:
                        current_app.logger.warning(f"Failed to generate audio for '{word}': {error}")
                        word_data['audio_generated'] = False
                
                processed_words.append(word_data)
                
                # Return progress update every 10 words
                if (i + 1) % 10 == 0:
                    current_app.logger.info(f"Processed {i + 1}/{len(words_to_import)} words")
                
            except Exception as e:
                current_app.logger.error(f"Error processing word '{word}': {str(e)}")
                failed_words.append({'word': word, 'error': str(e)})
        
        # Return preview data without saving to database yet
        return jsonify({
            'success': True,
            'preview_mode': True,
            'processed_words': processed_words,
            'failed_words': failed_words,
            'total_words': len(words_to_import),
            'successful_words': len(processed_words),
            'failed_count': len(failed_words),
            'library_name': library_name,
            'voice_used': voice if generate_audio else None
        })
        
    except Exception as e:
        current_app.logger.error(f"Import with audio error: {str(e)}")
        return jsonify({'error': f'Import failed: {str(e)}'}), 500

@vocabulary_bp.route('/confirm-import', methods=['POST'])
@jwt_required()
def confirm_vocabulary_import():
    """Confirm and save the imported vocabulary to database"""
    try:
        current_user_id = get_jwt_identity()
        user = User.query.get(current_user_id)
        
        # Check permissions
        if not user or user.role not in ['admin', 'teacher']:
            return jsonify({'error': 'Admin or teacher access required'}), 403
        
        data = request.get_json()
        if not data:
            return jsonify({'error': 'No data provided'}), 400
        
        library_name = data.get('library_name')
        processed_words = data.get('processed_words', [])
        append_mode = data.get('append_mode', False)
        
        if not library_name or not processed_words:
            return jsonify({'error': 'Library name and words are required'}), 400
        
        # Create or get library
        library = None
        if append_mode:
            # For append mode, find existing library by library_id or name
            library = VocabularyLibrary.query.filter(
                or_(
                    VocabularyLibrary.library_id == library_name,
                    VocabularyLibrary.name == library_name
                )
            ).first()
            if not library:
                return jsonify({'error': f'Library "{library_name}" not found for append mode'}), 404
        else:
            # For new library mode, create or update existing
            library = VocabularyLibrary.query.filter_by(name=library_name).first()
            if not library:
                library = VocabularyLibrary(
                    library_id=library_name.lower().replace(' ', '_'),
                    name=library_name,
                    description=library_name,
                    library_type='custom',
                    grade_level=1,
                    is_active=True,
                    last_updated_by=user.id
                )
                library.set_categories(['imported'])
                db.session.add(library)
                db.session.flush()
        
        # Save words to database
        imported_count = 0
        
        for word_data in processed_words:
            try:
                word_text = word_data['word']
                
                # Check if word already exists
                existing_word = Word.query.filter_by(word=word_text).first()
                
                if not existing_word:
                    # Create new word
                    new_word = Word(
                        word=word_text,
                        chinese_meaning=word_data['chinese_meaning'],
                        phonetic=word_data.get('phonetic', ''),
                        definition=word_data.get('definition', ''),
                        audio_url=word_data.get('audio_url', ''),
                        grade_level=1,
                        difficulty=1,
                        difficulty_level='easy',
                        source='imported_with_audio',
                        is_active=True,
                        created_by=user.id
                    )
                    db.session.add(new_word)
                    db.session.flush()
                    existing_word = new_word
                else:
                    # Update existing word with new audio if generated
                    if word_data.get('audio_url') and not existing_word.audio_url:
                        existing_word.audio_url = word_data['audio_url']
                
                # Add word to library if not already there
                if existing_word:
                    existing_link = db.session.query(library_words).filter_by(
                        library_id=library.id,
                        word_id=existing_word.id
                    ).first()
                    
                    if not existing_link:
                        db.session.execute(
                            library_words.insert().values(
                                library_id=library.id,
                                word_id=existing_word.id
                            )
                        )
                        imported_count += 1
                
            except Exception as e:
                current_app.logger.error(f"Error saving word '{word_data.get('word', 'unknown')}': {str(e)}")
        
        # Update library word count
        library.word_count = db.session.query(func.count(library_words.c.word_id)).filter(
            library_words.c.library_id == library.id
        ).scalar() or 0
        
        db.session.commit()
        
        return jsonify({
            'success': True,
            'imported_count': imported_count,
            'total_words': len(processed_words),
            'library_id': library.library_id,
            'library_name': library.name
        })
        
    except Exception as e:
        current_app.logger.error(f"Confirm import error: {str(e)}")
        db.session.rollback()
        return jsonify({'error': f'Import confirmation failed: {str(e)}'}), 500

def _extract_words_from_file(file):
    """Extract words and phrases from uploaded file"""
    filename = secure_filename(file.filename)
    file_ext = filename.rsplit('.', 1)[1].lower() if '.' in filename else ''
    
    words_to_import = []
    
    if file_ext == 'csv':
        stream = io.StringIO(file.stream.read().decode("UTF8"), newline=None)
        csv_reader = csv.reader(stream)
        for row in csv_reader:
            # Split each cell by comma to support phrases within CSV cells
            for cell in row:
                if cell.strip():
                    # Split by comma but preserve spaces within phrases
                    phrases = [phrase.strip() for phrase in cell.split(',') if phrase.strip()]
                    words_to_import.extend(phrases)
    
    elif file_ext in ['md', 'txt']:
        content = file.stream.read().decode('utf-8')
        # Split by commas and newlines, but preserve spaces within phrases
        # Use regex to split by comma or newline, but not spaces within phrases
        phrases = re.split(r'[,\n]+', content)
        words_to_import = [phrase.strip() for phrase in phrases if phrase.strip()]
    
    elif file_ext == 'pdf':
        pdf_reader = PyPDF2.PdfReader(file.stream)
        text = ''
        for page in pdf_reader.pages:
            text += page.extract_text()
        # Split by commas and newlines, preserve spaces within phrases
        phrases = re.split(r'[,\n]+', text)
        words_to_import = [phrase.strip() for phrase in phrases if phrase.strip()]
    
    # Remove duplicates and filter valid words/phrases
    # Allow letters, spaces, hyphens, apostrophes for phrases
    valid_words = []
    for word in words_to_import:
        if word and len(word.strip()) > 0:
            # Allow words/phrases with letters, spaces, hyphens, apostrophes
            if re.match(r"^[a-zA-Z\s\-']+$", word.strip()) and len(word.strip()) > 1:
                valid_words.append(word.strip())
    
    # Remove duplicates while preserving order
    seen = set()
    unique_words = []
    for word in valid_words:
        word_lower = word.lower()
        if word_lower not in seen:
            seen.add(word_lower)
            unique_words.append(word)
    
    return unique_words

@vocabulary_bp.route('/libraries/<library_id>/retranslate', methods=['POST'])
@jwt_required()
def retranslate_library_words(library_id):
    """重新翻译词库中未翻译或需要更新的单词"""
    try:
        current_user_id = get_jwt_identity()
        user = User.query.get(current_user_id)
        
        # Check permissions
        if not user or user.role not in ['admin', 'teacher']:
            return jsonify({'error': 'Admin or teacher access required'}), 403
        
        # Get request data
        data = request.get_json()
        if not data:
            return jsonify({'error': 'No data provided'}), 400
        
        api_key = data.get('api_key')
        translation_model = data.get('translation_model', 'google/gemini-2.0-flash-001')
        force_retranslate = data.get('force_retranslate', False)  # 是否强制重新翻译已有翻译的单词
        
        if not api_key:
            return jsonify({'error': 'API key is required'}), 400
        
        # Find library
        library = VocabularyLibrary.query.filter_by(library_id=library_id, is_active=True).first()
        if not library:
            return jsonify({'error': 'Library not found'}), 404
        
        # Get words that need translation using the association table
        if force_retranslate:
            # 重新翻译所有单词
            words_query = db.session.query(Word).join(
                library_words, Word.id == library_words.c.word_id
            ).filter(
                library_words.c.library_id == library.id,
                Word.is_active == True
            )
        else:
            # 只翻译没有中文意思或中文意思为空的单词
            words_query = db.session.query(Word).join(
                library_words, Word.id == library_words.c.word_id
            ).filter(
                library_words.c.library_id == library.id,
                Word.is_active == True,
                or_(
                    Word.chinese_meaning.is_(None),
                    Word.chinese_meaning == '',
                    Word.chinese_meaning == ' ',
                    func.trim(Word.chinese_meaning) == ''
                )
            )
        
        words_to_translate = words_query.all()
        
        if not words_to_translate:
            return jsonify({
                'success': True,
                'message': 'No words need translation',
                'translated_count': 0,
                'total_words': 0,
                'library_name': library.name
            })
        
        # Translate words
        translated_count = 0
        failed_words = []
        
        for word in words_to_translate:
            try:
                # 翻译单词
                chinese_meaning = translate_word_openrouter(word.word, api_key, translation_model)
                
                if chinese_meaning:
                    word.chinese_meaning = chinese_meaning
                    word.updated_at = datetime.utcnow()
                    translated_count += 1
                else:
                    failed_words.append(word.word)
                
            except Exception as e:
                current_app.logger.error(f"翻译单词 '{word.word}' 时出错: {str(e)}")
                failed_words.append(word.word)
        
        # 提交数据库更改
        db.session.commit()
        
        response_data = {
            'success': True,
            'message': f'Successfully translated {translated_count} words',
            'translated_count': translated_count,
            'total_words': len(words_to_translate),
            'library_id': library.library_id,
            'library_name': library.name
        }
        
        if failed_words:
            response_data['failed_words'] = failed_words[:10]  # 限制显示前10个失败的单词
            response_data['failed_count'] = len(failed_words)
        
        return jsonify(response_data)
        
    except Exception as e:
        current_app.logger.error(f"重新翻译错误: {str(e)}")
        db.session.rollback()
        return jsonify({'error': f'Retranslation failed: {str(e)}'}), 500

@vocabulary_bp.route('/libraries/<library_id>/untranslated-count', methods=['GET'])
@jwt_required()
def get_untranslated_words_count(library_id):
    """获取词库中未翻译单词的数量"""
    try:
        current_user_id = get_jwt_identity()
        user = User.query.get(current_user_id)
        
        if not user:
            return jsonify({'error': 'User not found'}), 404
        
        # Find library
        library = VocabularyLibrary.query.filter_by(library_id=library_id, is_active=True).first()
        if not library:
            return jsonify({'error': 'Library not found'}), 404
        
        # Check access permissions for students
        if user.role not in ['admin', 'teacher']:
            assignment = LibraryAssignment.query.filter_by(
                library_id=library.id,
                user_id=user.id
            ).first()
            if not assignment:
                return jsonify({'error': 'Access denied to this library'}), 403
        
        # Count untranslated words using the association table
        untranslated_count = db.session.query(Word).join(
            library_words, Word.id == library_words.c.word_id
        ).filter(
            library_words.c.library_id == library.id,
            Word.is_active == True,
            get_untranslated_filter_conditions()
        ).count()
        
        # Total words in library using the association table
        total_count = db.session.query(Word).join(
            library_words, Word.id == library_words.c.word_id
        ).filter(
            library_words.c.library_id == library.id,
            Word.is_active == True
        ).count()
        
        return jsonify({
            'success': True,
            'library_id': library.library_id,
            'library_name': library.name,
            'untranslated_count': untranslated_count,
            'total_count': total_count,
            'translated_count': total_count - untranslated_count
        })
        
    except Exception as e:
        current_app.logger.error(f"获取未翻译单词数量错误: {str(e)}")
        return jsonify({'error': f'Failed to get untranslated count: {str(e)}'}), 500

@vocabulary_bp.route('/libraries/<library_id>/update-info', methods=['PUT'])
@jwt_required()
def update_library_info(library_id):
    """更新词库基本信息，可选择批量更新单词年级和生成音标"""
    try:
        current_user_id = get_jwt_identity()
        user = User.query.get(current_user_id)
        
        # Check permissions
        if not user or user.role not in ['admin', 'teacher']:
            return jsonify({'error': 'Admin or teacher access required'}), 403
        
        # Get request data
        data = request.get_json()
        if not data:
            return jsonify({'error': 'No data provided'}), 400
        
        # Find library
        library = VocabularyLibrary.query.filter_by(library_id=library_id, is_active=True).first()
        if not library:
            return jsonify({'error': 'Library not found'}), 404
        
        # Update basic library information
        updated_words = 0
        phonetics_generated = 0
        
        if 'name' in data:
            library.name = data['name']
        
        if 'description' in data:
            library.description = data['description']
        
        old_grade_level = library.grade_level
        if 'grade_level' in data:
            library.grade_level = data['grade_level']
        
        library.updated_at = datetime.utcnow()
        
        # Update words grade level if requested
        if data.get('update_words_grade', False) and 'grade_level' in data:
            words_in_library = db.session.query(Word).join(
                library_words, Word.id == library_words.c.word_id
            ).filter(
                library_words.c.library_id == library.id,
                Word.is_active == True
            ).all()
            
            for word in words_in_library:
                word.grade_level = data['grade_level']
                word.updated_at = datetime.utcnow()
                updated_words += 1
        
        # Generate phonetics if requested
        if data.get('generate_phonetics', False) and data.get('api_key'):
            api_key = data['api_key']
            
            # Get words without phonetics
            words_without_phonetics = db.session.query(Word).join(
                library_words, Word.id == library_words.c.word_id
            ).filter(
                library_words.c.library_id == library.id,
                Word.is_active == True,
                or_(
                    Word.phonetic.is_(None),
                    Word.phonetic == '',
                    func.trim(Word.phonetic) == ''
                )
            ).all()
            
            for word in words_without_phonetics:
                try:
                    # Generate phonetic using API (you can implement this function)
                    phonetic = generate_phonetic_openrouter(word.word, api_key)
                    if phonetic:
                        word.phonetic = phonetic
                        word.updated_at = datetime.utcnow()
                        phonetics_generated += 1
                except Exception as e:
                    current_app.logger.warning(f"Failed to generate phonetic for '{word.word}': {str(e)}")
                    continue
        
        # Commit all changes
        db.session.commit()
        
        return jsonify({
            'success': True,
            'message': f'Library information updated successfully',
            'updated_words': updated_words,
            'phonetics_generated': phonetics_generated,
            'library_id': library.library_id,
            'library_name': library.name
        })
        
    except Exception as e:
        current_app.logger.error(f"更新词库信息错误: {str(e)}")
        db.session.rollback()
        return jsonify({'error': f'Failed to update library information: {str(e)}'}), 500

def generate_phonetic_openrouter(word, api_key, model="google/gemini-2.0-flash-001"):
    """Generate phonetic notation using OpenRouter API with multiple model fallback"""
    
    # Model priority list (best to fallback)
    models_to_try = [
        "openai/gpt-4o-2024-11-20",  # Most accurate
        "google/gemini-2.0-flash-001",  # Good balance
        "anthropic/claude-3.5-sonnet-20241022",  # Alternative
        model  # User specified model as final fallback
    ]
    
    for current_model in models_to_try:
        try:
            url = "https://openrouter.ai/api/v1/chat/completions"
            
            headers = {
                "Authorization": f"Bearer {api_key}",
                "Content-Type": "application/json",
                "HTTP-Referer": "http://localhost:3000",
                "X-Title": "Smart English Learning"
            }
            
            # Enhanced system prompt for better accuracy
            system_prompt = """You are an expert in English phonetics and the International Phonetic Alphabet (IPA). 

Generate the precise IPA transcription for the given English word using General American pronunciation. 

Rules:
1. Return ONLY the IPA transcription without forward slashes
2. Use standard IPA symbols (ˈ for primary stress, ˌ for secondary stress)
3. For common words, use the most standard pronunciation
4. No explanations, alternatives, or additional text

Examples:
- apple → ˈæpəl
- computer → kəmˈpjutər  
- beautiful → ˈbjutəfəl
- pronunciation → prəˌnʌnsiˈeɪʃən"""

            payload = {
                "model": current_model,
                "messages": [
                    {
                        "role": "system",
                        "content": system_prompt
                    },
                    {
                        "role": "user",
                        "content": f"Generate IPA transcription for: {word}"
                    }
                ],
                "temperature": 0.1,
                "max_tokens": 100
            }
            
            response = requests.post(url, headers=headers, json=payload, timeout=15)
            
            if response.status_code == 200:
                data = response.json()
                phonetic = data['choices'][0]['message']['content'].strip()
                
                # Clean up the phonetic notation
                phonetic = phonetic.replace('/', '').strip()
                phonetic = phonetic.replace('[', '').replace(']', '')
                
                # Validate that it looks like IPA (contains IPA characters)
                ipa_chars = ['ə', 'ɪ', 'ɛ', 'æ', 'ʌ', 'ɔ', 'ʊ', 'i', 'u', 'ɑ', 'ɒ', 'ɜ', 'ɝ', 'ɚ', 'ˈ', 'ˌ']
                if any(char in phonetic for char in ipa_chars) and len(phonetic) > 0:
                    # Add forward slashes for display
                    if phonetic and not phonetic.startswith('/'):
                        phonetic = f'/{phonetic}/'
                    current_app.logger.info(f"Generated phonetic for '{word}' using {current_model}: {phonetic}")
                    return phonetic
                else:
                    current_app.logger.warning(f"Invalid IPA from {current_model} for '{word}': {phonetic}")
                    continue
                    
            elif response.status_code == 401:
                current_app.logger.error(f"API key invalid for model {current_model}")
                return None  # Don't try other models if API key is invalid
            else:
                current_app.logger.warning(f"Model {current_model} failed for '{word}': {response.status_code}")
                continue  # Try next model
                
        except Exception as e:
            current_app.logger.warning(f"Error with model {current_model} for '{word}': {str(e)}")
            continue  # Try next model
    
    current_app.logger.error(f"All models failed to generate phonetic for '{word}'")
    return None

# =============================================================================
# Library Assignment Management API Endpoints
# =============================================================================

@vocabulary_bp.route('/assignments', methods=['GET'])
@jwt_required()
def get_all_assignments():
    """Get all library assignments with filtering options"""
    try:
        current_user_id = get_jwt_identity()
        current_user = User.query.get(current_user_id)
        
        # Check permissions
        auth_error = require_admin_or_teacher(current_user)
        if auth_error:
            return auth_error
        
        # Get query parameters
        page = request.args.get('page', 1, type=int)
        per_page = min(request.args.get('per_page', 50, type=int), 100)
        user_id = request.args.get('user_id', type=int)
        library_id = request.args.get('library_id')
        is_required = request.args.get('is_required', type=bool)
        
        # Build query
        query = db.session.query(LibraryAssignment)\
            .join(User, LibraryAssignment.user_id == User.id)\
            .join(VocabularyLibrary, LibraryAssignment.library_id == VocabularyLibrary.id)\
            .filter(VocabularyLibrary.is_active == True)
        
        # Apply filters
        if user_id:
            query = query.filter(LibraryAssignment.user_id == user_id)
        if library_id:
            library = VocabularyLibrary.query.filter_by(library_id=library_id).first()
            if library:
                query = query.filter(LibraryAssignment.library_id == library.id)
        if is_required is not None:
            query = query.filter(LibraryAssignment.is_required == is_required)
        
        # Pagination
        assignments = query.paginate(
            page=page, per_page=per_page, error_out=False
        )
        
        # Build response with detailed information
        assignments_data = []
        for assignment in assignments.items:
            assignment_dict = assignment.to_dict()
            
            # Add user information
            user = User.query.get(assignment.user_id)
            assignment_dict['user'] = {
                'id': user.id,
                'username': user.username,
                'email': user.email,
                'role': user.role
            }
            
            # Add library information
            library = VocabularyLibrary.query.get(assignment.library_id)
            assignment_dict['library'] = {
                'id': library.id,
                'library_id': library.library_id,
                'name': library.name,
                'description': library.description,
                'word_count': library.word_count,
                'grade_level': library.grade_level
            }
            
            # Add assigner information
            if assignment.assigned_by:
                assigner = User.query.get(assignment.assigned_by)
                assignment_dict['assigned_by_user'] = {
                    'id': assigner.id,
                    'username': assigner.username
                } if assigner else None
            
            assignments_data.append(assignment_dict)
        
        return jsonify({
            'success': True,
            'assignments': assignments_data,
            'pagination': {
                'page': assignments.page,
                'pages': assignments.pages,
                'per_page': assignments.per_page,
                'total': assignments.total,
                'has_next': assignments.has_next,
                'has_prev': assignments.has_prev
            }
        })
    
    except Exception as e:
        current_app.logger.error(f"Error fetching assignments: {str(e)}")
        return jsonify({'error': 'Failed to fetch assignments'}), 500

@vocabulary_bp.route('/users/<int:user_id>/assignments', methods=['GET'])
@jwt_required()
def get_user_assignments(user_id):
    """Get all library assignments for a specific user"""
    try:
        current_user_id = get_jwt_identity()
        current_user = User.query.get(current_user_id)
        
        # Check permissions - admin/teacher can see all, students can only see their own
        if current_user.role not in ['admin', 'teacher'] and current_user.id != user_id:
            return jsonify({'error': 'Permission denied'}), 403
        
        user = User.query.get_or_404(user_id)
        
        # Get user's assignments
        assignments = db.session.query(LibraryAssignment)\
            .join(VocabularyLibrary, LibraryAssignment.library_id == VocabularyLibrary.id)\
            .filter(
                LibraryAssignment.user_id == user_id,
                VocabularyLibrary.is_active == True
            ).all()
        
        assignments_data = []
        for assignment in assignments:
            assignment_dict = assignment.to_dict()
            
            # Add library information
            library = VocabularyLibrary.query.get(assignment.library_id)
            assignment_dict['library'] = library.to_frontend_dict()
            
            assignments_data.append(assignment_dict)
        
        return jsonify({
            'success': True,
            'user': {
                'id': user.id,
                'username': user.username,
                'email': user.email,
                'role': user.role
            },
            'assignments': assignments_data,
            'total_assignments': len(assignments_data)
        })
    
    except Exception as e:
        current_app.logger.error(f"Error fetching user assignments: {str(e)}")
        return jsonify({'error': 'Failed to fetch user assignments'}), 500

@vocabulary_bp.route('/assignments/<int:assignment_id>', methods=['PUT'])
@jwt_required()
def update_assignment(assignment_id):
    """Update an existing library assignment"""
    try:
        current_user_id = get_jwt_identity()
        current_user = User.query.get(current_user_id)
        
        # Check permissions
        auth_error = require_admin_or_teacher(current_user)
        if auth_error:
            return auth_error
        
        assignment = LibraryAssignment.query.get_or_404(assignment_id)
        data = request.get_json()
        
        if not data:
            return jsonify({'error': 'No data provided'}), 400
        
        # Update assignment fields
        if 'is_required' in data:
            assignment.is_required = data['is_required']
        
        if 'start_date' in data:
            if data['start_date']:
                assignment.start_date = datetime.fromisoformat(data['start_date']).date()
            else:
                assignment.start_date = None
        
        if 'end_date' in data:
            if data['end_date']:
                assignment.end_date = datetime.fromisoformat(data['end_date']).date()
            else:
                assignment.end_date = None
        
        assignment.updated_at = datetime.utcnow()
        
        db.session.commit()
        
        return jsonify({
            'success': True,
            'message': 'Assignment updated successfully',
            'assignment': assignment.to_dict()
        })
    
    except Exception as e:
        db.session.rollback()
        current_app.logger.error(f"Error updating assignment: {str(e)}")
        return jsonify({'error': 'Failed to update assignment'}), 500

@vocabulary_bp.route('/assignments/<int:assignment_id>', methods=['DELETE'])
@jwt_required()
def remove_assignment(assignment_id):
    """Remove a library assignment"""
    try:
        current_user_id = get_jwt_identity()
        current_user = User.query.get(current_user_id)
        
        # Check permissions
        auth_error = require_admin_or_teacher(current_user)
        if auth_error:
            return auth_error
        
        assignment = LibraryAssignment.query.get_or_404(assignment_id)
        
        # Get assignment info before deletion for response
        user = User.query.get(assignment.user_id)
        library = VocabularyLibrary.query.get(assignment.library_id)
        
        db.session.delete(assignment)
        db.session.commit()
        
        return jsonify({
            'success': True,
            'message': f'Assignment removed: {library.name} from {user.username}'
        })
    
    except Exception as e:
        db.session.rollback()
        current_app.logger.error(f"Error removing assignment: {str(e)}")
        return jsonify({'error': 'Failed to remove assignment'}), 500

@vocabulary_bp.route('/assignments/bulk', methods=['POST'])
@jwt_required()
def bulk_assign_libraries():
    """Bulk assign libraries to multiple users"""
    try:
        current_user_id = get_jwt_identity()
        current_user = User.query.get(current_user_id)
        
        # Check permissions
        auth_error = require_admin_or_teacher(current_user)
        if auth_error:
            return auth_error
        
        data = request.get_json()
        if not data:
            return jsonify({'error': 'No data provided'}), 400
        
        user_ids = data.get('user_ids', [])
        library_ids = data.get('library_ids', [])  # library_id strings
        is_required = data.get('is_required', False)
        start_date = data.get('start_date')
        end_date = data.get('end_date')
        
        if not user_ids or not library_ids:
            return jsonify({'error': 'user_ids and library_ids are required'}), 400
        
        # Validate users
        users = User.query.filter(User.id.in_(user_ids)).all()
        if len(users) != len(user_ids):
            return jsonify({'error': 'Some users not found'}), 404
        
        # Validate libraries
        libraries = VocabularyLibrary.query.filter(
            VocabularyLibrary.library_id.in_(library_ids),
            VocabularyLibrary.is_active == True
        ).all()
        if len(libraries) != len(library_ids):
            return jsonify({'error': 'Some libraries not found'}), 404
        
        # Parse dates
        start_date_obj = None
        end_date_obj = None
        
        if start_date:
            start_date_obj = datetime.fromisoformat(start_date).date()
        if end_date:
            end_date_obj = datetime.fromisoformat(end_date).date()
        
        # Create assignments
        created_count = 0
        skipped_count = 0
        assignments_created = []
        
        for user in users:
            for library in libraries:
                # Check if assignment already exists
                existing = LibraryAssignment.query.filter_by(
                    library_id=library.id,
                    user_id=user.id
                ).first()
                
                if existing:
                    skipped_count += 1
                    continue
                
                # Create new assignment
                assignment = LibraryAssignment(
                    library_id=library.id,
                    user_id=user.id,
                    is_required=is_required,
                    start_date=start_date_obj,
                    end_date=end_date_obj,
                    assigned_by=current_user.id
                )
                
                db.session.add(assignment)
                assignments_created.append({
                    'user_id': user.id,
                    'username': user.username,
                    'library_id': library.library_id,
                    'library_name': library.name
                })
                created_count += 1
        
        db.session.commit()
        
        return jsonify({
            'success': True,
            'message': f'Bulk assignment completed: {created_count} assignments created, {skipped_count} skipped',
            'created_count': created_count,
            'skipped_count': skipped_count,
            'assignments': assignments_created
        }), 201
    
    except Exception as e:
        db.session.rollback()
        current_app.logger.error(f"Error in bulk assignment: {str(e)}")
        return jsonify({'error': 'Failed to create bulk assignments'}), 500

@vocabulary_bp.route('/libraries/<library_id>/assigned-users', methods=['GET'])
@jwt_required()
def get_library_assigned_users(library_id):
    """Get all users assigned to a specific library"""
    try:
        current_user_id = get_jwt_identity()
        current_user = User.query.get(current_user_id)
        
        # Check permissions
        auth_error = require_admin_or_teacher(current_user)
        if auth_error:
            return auth_error
        
        # Find library
        library = VocabularyLibrary.query.filter_by(
            library_id=library_id, 
            is_active=True
        ).first()
        
        if not library:
            return jsonify({'error': 'Library not found'}), 404
        
        # Get assigned users
        assignments = db.session.query(LibraryAssignment, User)\
            .join(User, LibraryAssignment.user_id == User.id)\
            .filter(LibraryAssignment.library_id == library.id)\
            .all()
        
        users_data = []
        for assignment, user in assignments:
            user_data = {
                'user_id': user.id,
                'username': user.username,
                'email': user.email,
                'role': user.role,
                'assignment': assignment.to_dict()
            }
            users_data.append(user_data)
        
        return jsonify({
            'success': True,
            'library': {
                'id': library.id,
                'library_id': library.library_id,
                'name': library.name,
                'description': library.description,
                'word_count': library.word_count
            },
            'assigned_users': users_data,
            'total_assigned': len(users_data)
        })
    
    except Exception as e:
        current_app.logger.error(f"Error fetching library assigned users: {str(e)}")
        return jsonify({'error': 'Failed to fetch assigned users'}), 500

@vocabulary_bp.route('/assignment-summary', methods=['GET'])
@jwt_required()
def get_assignment_summary():
    """Get assignment statistics and summary"""
    try:
        current_user_id = get_jwt_identity()
        current_user = User.query.get(current_user_id)
        
        # Check permissions
        auth_error = require_admin_or_teacher(current_user)
        if auth_error:
            return auth_error
        
        # Get assignment statistics
        total_assignments = LibraryAssignment.query.count()
        required_assignments = LibraryAssignment.query.filter_by(is_required=True).count()
        
        # Users with assignments
        users_with_assignments = db.session.query(
            func.count(func.distinct(LibraryAssignment.user_id))
        ).scalar()
        
        # Libraries with assignments
        libraries_with_assignments = db.session.query(
            func.count(func.distinct(LibraryAssignment.library_id))
        ).scalar()
        
        # Recent assignments (last 7 days)
        week_ago = datetime.utcnow() - timedelta(days=7)
        recent_assignments = LibraryAssignment.query.filter(
            LibraryAssignment.assigned_at >= week_ago
        ).count()
        
        # Top assigned libraries
        top_libraries = db.session.query(
            VocabularyLibrary.name,
            VocabularyLibrary.library_id,
            func.count(LibraryAssignment.id).label('assignment_count')
        ).join(
            LibraryAssignment, VocabularyLibrary.id == LibraryAssignment.library_id
        ).group_by(
            VocabularyLibrary.id
        ).order_by(
            func.count(LibraryAssignment.id).desc()
        ).limit(5).all()
        
        top_libraries_data = [
            {
                'name': name,
                'library_id': library_id,
                'assignment_count': count
            }
            for name, library_id, count in top_libraries
        ]
        
        return jsonify({
            'success': True,
            'summary': {
                'total_assignments': total_assignments,
                'required_assignments': required_assignments,
                'optional_assignments': total_assignments - required_assignments,
                'users_with_assignments': users_with_assignments,
                'libraries_with_assignments': libraries_with_assignments,
                'recent_assignments': recent_assignments,
                'top_assigned_libraries': top_libraries_data
            }
        })
    
    except Exception as e:
        current_app.logger.error(f"Error fetching assignment summary: {str(e)}")
        return jsonify({'error': 'Failed to fetch assignment summary'}), 500