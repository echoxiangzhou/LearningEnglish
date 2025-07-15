from flask import Blueprint, request, jsonify, send_file
from flask_jwt_extended import jwt_required, get_jwt_identity
from werkzeug.utils import secure_filename
from app import db
from app.models import (
    User, Word, Sentence, Article, ComprehensionQuestion,
    ContentImport, GeneratedContent, ContentTemplate,
    SystemLog, AuditLog
)
from app.services.ocr_service import ocr_service
from app.services.progress_service import progress_service
import os
import uuid
import threading
import time
from datetime import datetime

bp = Blueprint('content', __name__, url_prefix='/api/content')

ALLOWED_EXTENSIONS = {'pdf', 'txt', 'csv', 'xlsx', 'docx'}
MAX_FILE_SIZE = 10 * 1024 * 1024  # 10MB

def allowed_file(filename):
    return '.' in filename and \
           filename.rsplit('.', 1)[1].lower() in ALLOWED_EXTENSIONS

def require_admin():
    """Decorator to require admin role"""
    current_user_id = get_jwt_identity()
    user = User.query.get(current_user_id)
    if not user or user.role != 'admin':
        return jsonify({'error': 'Admin access required'}), 403
    return None

# Word Management Routes
@bp.route('/words', methods=['GET'])
@jwt_required()
def get_words():
    """Get paginated list of words"""
    try:
        page = request.args.get('page', 1, type=int)
        per_page = min(request.args.get('per_page', 20, type=int), 100)
        grade_level = request.args.get('grade_level', type=int)
        difficulty = request.args.get('difficulty', type=int)
        search = request.args.get('search', '').strip()
        
        query = Word.query
        
        # Apply filters
        if grade_level:
            query = query.filter(Word.grade_level == grade_level)
        if difficulty:
            query = query.filter(Word.difficulty == difficulty)
        if search:
            query = query.filter(Word.word.ilike(f'%{search}%'))
        
        # Paginate
        words = query.order_by(Word.frequency.desc(), Word.word).paginate(
            page=page, per_page=per_page, error_out=False
        )
        
        return jsonify({
            'words': [word.to_dict() for word in words.items],
            'pagination': {
                'page': page,
                'pages': words.pages,
                'per_page': per_page,
                'total': words.total,
                'has_next': words.has_next,
                'has_prev': words.has_prev
            }
        }), 200
        
    except Exception as e:
        SystemLog.log('ERROR', 'content', f'Error fetching words: {str(e)}', request=request)
        return jsonify({'error': 'Internal server error'}), 500

@bp.route('/words', methods=['POST'])
@jwt_required()
def create_word():
    """Create a new word"""
    try:
        admin_check = require_admin()
        if admin_check:
            return admin_check
        
        data = request.get_json()
        
        # Validate required fields
        if not data.get('word'):
            return jsonify({'error': 'Word is required'}), 400
        
        word_text = data.get('word').strip().lower()
        
        # Check if word already exists
        if Word.query.filter_by(word=word_text).first():
            return jsonify({'error': 'Word already exists'}), 409
        
        # Create new word
        word = Word(
            word=word_text,
            phonetic=data.get('phonetic', ''),
            definition=data.get('definition', ''),
            part_of_speech=data.get('part_of_speech', ''),
            grade_level=data.get('grade_level', 1),
            frequency=data.get('frequency', 0),
            difficulty=data.get('difficulty', 1)
        )
        
        db.session.add(word)
        db.session.commit()
        
        # Log action
        current_user_id = get_jwt_identity()
        AuditLog.log_action(
            user_id=current_user_id,
            action='CREATE',
            resource_type='word',
            resource_id=word.id,
            description=f'Created word: {word_text}',
            request=request
        )
        
        return jsonify({
            'message': 'Word created successfully',
            'word': word.to_dict()
        }), 201
        
    except Exception as e:
        db.session.rollback()
        SystemLog.log('ERROR', 'content', f'Error creating word: {str(e)}', request=request)
        return jsonify({'error': 'Internal server error'}), 500

@bp.route('/words/<int:word_id>', methods=['PUT'])
@jwt_required()
def update_word(word_id):
    """Update an existing word"""
    try:
        admin_check = require_admin()
        if admin_check:
            return admin_check
        
        word = Word.query.get_or_404(word_id)
        data = request.get_json()
        old_values = word.to_dict()
        
        # Update fields
        if 'phonetic' in data:
            word.phonetic = data['phonetic']
        if 'definition' in data:
            word.definition = data['definition']
        if 'part_of_speech' in data:
            word.part_of_speech = data['part_of_speech']
        if 'grade_level' in data:
            word.grade_level = data['grade_level']
        if 'frequency' in data:
            word.frequency = data['frequency']
        if 'difficulty' in data:
            word.difficulty = data['difficulty']
        
        word.updated_at = datetime.utcnow()
        db.session.commit()
        
        # Log action
        current_user_id = get_jwt_identity()
        AuditLog.log_action(
            user_id=current_user_id,
            action='UPDATE',
            resource_type='word',
            resource_id=word.id,
            old_values=old_values,
            new_values=word.to_dict(),
            description=f'Updated word: {word.word}',
            request=request
        )
        
        return jsonify({
            'message': 'Word updated successfully',
            'word': word.to_dict()
        }), 200
        
    except Exception as e:
        db.session.rollback()
        SystemLog.log('ERROR', 'content', f'Error updating word: {str(e)}', request=request)
        return jsonify({'error': 'Internal server error'}), 500

@bp.route('/words/<int:word_id>', methods=['DELETE'])
@jwt_required()
def delete_word(word_id):
    """Delete a word"""
    try:
        admin_check = require_admin()
        if admin_check:
            return admin_check
        
        word = Word.query.get_or_404(word_id)
        word_text = word.word
        
        db.session.delete(word)
        db.session.commit()
        
        # Log action
        current_user_id = get_jwt_identity()
        AuditLog.log_action(
            user_id=current_user_id,
            action='DELETE',
            resource_type='word',
            resource_id=word_id,
            description=f'Deleted word: {word_text}',
            request=request
        )
        
        return jsonify({'message': 'Word deleted successfully'}), 200
        
    except Exception as e:
        db.session.rollback()
        SystemLog.log('ERROR', 'content', f'Error deleting word: {str(e)}', request=request)
        return jsonify({'error': 'Internal server error'}), 500

# Sentence Management Routes
@bp.route('/sentences', methods=['GET'])
@jwt_required()
def get_sentences():
    """Get paginated list of sentences"""
    try:
        page = request.args.get('page', 1, type=int)
        per_page = min(request.args.get('per_page', 20, type=int), 100)
        difficulty = request.args.get('difficulty', type=int)
        grade_level = request.args.get('grade_level', type=int)
        topic = request.args.get('topic', '').strip()
        source = request.args.get('source', '').strip()
        
        query = Sentence.query
        
        # Apply filters
        if difficulty:
            query = query.filter(Sentence.difficulty == difficulty)
        if grade_level:
            query = query.filter(Sentence.grade_level == grade_level)
        if topic:
            query = query.filter(Sentence.topic.ilike(f'%{topic}%'))
        if source:
            query = query.filter(Sentence.source == source)
        
        # Paginate
        sentences = query.order_by(Sentence.created_at.desc()).paginate(
            page=page, per_page=per_page, error_out=False
        )
        
        return jsonify({
            'sentences': [sentence.to_dict() for sentence in sentences.items],
            'pagination': {
                'page': page,
                'pages': sentences.pages,
                'per_page': per_page,
                'total': sentences.total,
                'has_next': sentences.has_next,
                'has_prev': sentences.has_prev
            }
        }), 200
        
    except Exception as e:
        SystemLog.log('ERROR', 'content', f'Error fetching sentences: {str(e)}', request=request)
        return jsonify({'error': 'Internal server error'}), 500

@bp.route('/sentences', methods=['POST'])
@jwt_required()
def create_sentence():
    """Create a new sentence"""
    try:
        admin_check = require_admin()
        if admin_check:
            return admin_check
        
        data = request.get_json()
        
        # Validate required fields
        if not data.get('text'):
            return jsonify({'error': 'Sentence text is required'}), 400
        
        # Create new sentence
        sentence = Sentence(
            text=data.get('text').strip(),
            difficulty=data.get('difficulty', 1),
            grade_level=data.get('grade_level', 1),
            topic=data.get('topic', ''),
            source=data.get('source', 'manual')
        )
        
        db.session.add(sentence)
        db.session.flush()  # Get the ID
        
        # Associate words if provided
        word_ids = data.get('word_ids', [])
        if word_ids:
            words = Word.query.filter(Word.id.in_(word_ids)).all()
            sentence.words.extend(words)
        
        db.session.commit()
        
        # Log action
        current_user_id = get_jwt_identity()
        AuditLog.log_action(
            user_id=current_user_id,
            action='CREATE',
            resource_type='sentence',
            resource_id=sentence.id,
            description=f'Created sentence: {sentence.text[:50]}...',
            request=request
        )
        
        return jsonify({
            'message': 'Sentence created successfully',
            'sentence': sentence.to_dict()
        }), 201
        
    except Exception as e:
        db.session.rollback()
        SystemLog.log('ERROR', 'content', f'Error creating sentence: {str(e)}', request=request)
        return jsonify({'error': 'Internal server error'}), 500

# Article Management Routes
@bp.route('/articles', methods=['GET'])
@jwt_required()
def get_articles():
    """Get paginated list of articles"""
    try:
        page = request.args.get('page', 1, type=int)
        per_page = min(request.args.get('per_page', 20, type=int), 100)
        published_only = request.args.get('published', 'false').lower() == 'true'
        topic = request.args.get('topic', '').strip()
        grade_level = request.args.get('grade_level', type=int)
        
        query = Article.query
        
        # Apply filters
        if published_only:
            query = query.filter(Article.is_published == True)
        if topic:
            query = query.filter(Article.topic.ilike(f'%{topic}%'))
        if grade_level:
            query = query.filter(Article.grade_level == grade_level)
        
        # Paginate
        articles = query.order_by(Article.created_at.desc()).paginate(
            page=page, per_page=per_page, error_out=False
        )
        
        # Don't include full content in list view
        return jsonify({
            'articles': [article.to_dict(include_content=False) for article in articles.items],
            'pagination': {
                'page': page,
                'pages': articles.pages,
                'per_page': per_page,
                'total': articles.total,
                'has_next': articles.has_next,
                'has_prev': articles.has_prev
            }
        }), 200
        
    except Exception as e:
        SystemLog.log('ERROR', 'content', f'Error fetching articles: {str(e)}', request=request)
        return jsonify({'error': 'Internal server error'}), 500

@bp.route('/articles/<int:article_id>', methods=['GET'])
@jwt_required()
def get_article(article_id):
    """Get full article with content"""
    try:
        article = Article.query.get_or_404(article_id)
        
        # Check if user can access unpublished content
        current_user_id = get_jwt_identity()
        user = User.query.get(current_user_id)
        
        if not article.is_published and user.role not in ['admin', 'teacher']:
            return jsonify({'error': 'Article not found'}), 404
        
        return jsonify({'article': article.to_dict(include_content=True)}), 200
        
    except Exception as e:
        SystemLog.log('ERROR', 'content', f'Error fetching article: {str(e)}', request=request)
        return jsonify({'error': 'Internal server error'}), 500

# File Upload Routes
@bp.route('/upload', methods=['POST'])
@jwt_required()
def upload_file():
    """Upload a file for processing"""
    try:
        admin_check = require_admin()
        if admin_check:
            return admin_check
        
        if 'file' not in request.files:
            return jsonify({'error': 'No file provided'}), 400
        
        file = request.files['file']
        if file.filename == '':
            return jsonify({'error': 'No file selected'}), 400
        
        if not allowed_file(file.filename):
            return jsonify({'error': f'File type not allowed. Allowed types: {", ".join(ALLOWED_EXTENSIONS)}'}), 400
        
        # Check file size
        file.seek(0, 2)  # Seek to end
        file_size = file.tell()
        file.seek(0)  # Reset to beginning
        
        if file_size > MAX_FILE_SIZE:
            return jsonify({'error': f'File too large. Maximum size: {MAX_FILE_SIZE // (1024*1024)}MB'}), 400
        
        # Generate unique filename
        filename = secure_filename(file.filename)
        unique_filename = f"{uuid.uuid4().hex}_{filename}"
        
        # Create upload directory if it doesn't exist
        upload_dir = 'uploads'
        os.makedirs(upload_dir, exist_ok=True)
        
        # Save file
        file_path = os.path.join(upload_dir, unique_filename)
        file.save(file_path)
        
        # Create import record
        current_user_id = get_jwt_identity()
        content_import = ContentImport(
            user_id=current_user_id,
            filename=unique_filename,
            original_filename=filename,
            file_path=file_path,
            file_size=file_size,
            file_type=filename.rsplit('.', 1)[1].lower(),
            status='uploaded'
        )
        
        db.session.add(content_import)
        db.session.commit()
        
        # Log action
        AuditLog.log_action(
            user_id=current_user_id,
            action='CREATE',
            resource_type='import',
            resource_id=content_import.id,
            description=f'Uploaded file: {filename}',
            request=request
        )
        
        return jsonify({
            'message': 'File uploaded successfully',
            'import': content_import.to_dict()
        }), 201
        
    except Exception as e:
        db.session.rollback()
        SystemLog.log('ERROR', 'content', f'Error uploading file: {str(e)}', request=request)
        return jsonify({'error': 'Internal server error'}), 500

@bp.route('/imports', methods=['GET'])
@jwt_required()
def get_imports():
    """Get list of content imports"""
    try:
        admin_check = require_admin()
        if admin_check:
            return admin_check
        
        page = request.args.get('page', 1, type=int)
        per_page = min(request.args.get('per_page', 20, type=int), 100)
        status = request.args.get('status', '').strip()
        
        query = ContentImport.query
        
        if status:
            query = query.filter(ContentImport.status == status)
        
        imports = query.order_by(ContentImport.created_at.desc()).paginate(
            page=page, per_page=per_page, error_out=False
        )
        
        return jsonify({
            'imports': [imp.to_dict() for imp in imports.items],
            'pagination': {
                'page': page,
                'pages': imports.pages,
                'per_page': per_page,
                'total': imports.total,
                'has_next': imports.has_next,
                'has_prev': imports.has_prev
            }
        }), 200
        
    except Exception as e:
        SystemLog.log('ERROR', 'content', f'Error fetching imports: {str(e)}', request=request)
        return jsonify({'error': 'Internal server error'}), 500

@bp.route('/imports/<int:import_id>/process', methods=['POST'])
@jwt_required()
def process_import(import_id):
    """Start processing an uploaded file"""
    try:
        admin_check = require_admin()
        if admin_check:
            return admin_check
        
        content_import = ContentImport.query.get_or_404(import_id)
        
        if content_import.status != 'uploaded':
            return jsonify({'error': 'Import already processed or in progress'}), 400
        
        # Update status
        content_import.status = 'processing'
        content_import.processing_progress = 0
        db.session.commit()
        
        # Start background processing
        processing_thread = threading.Thread(
            target=_process_file_background,
            args=(import_id,)
        )
        processing_thread.daemon = True
        processing_thread.start()
        
        return jsonify({
            'message': 'Processing started',
            'import': content_import.to_dict()
        }), 200
        
    except Exception as e:
        db.session.rollback()
        SystemLog.log('ERROR', 'content', f'Error processing import: {str(e)}', request=request)
        return jsonify({'error': 'Internal server error'}), 500

def _process_file_background(import_id: int):
    """Background function to process uploaded files"""
    from app import create_app
    
    # Create new app context for background thread
    app = create_app()
    with app.app_context():
        try:
            content_import = ContentImport.query.get(import_id)
            if not content_import:
                return
            
            # Update progress
            content_import.update_progress(10, 'processing')
            db.session.commit()
            progress_service.emit_import_progress(import_id, 10, 'processing', 'Starting validation...')
            
            # Validate file
            validation_result = ocr_service.validate_file(content_import.file_path)
            if not validation_result['valid']:
                error_msg = '; '.join(validation_result['errors'])
                content_import.mark_failed(f"File validation failed: {error_msg}")
                db.session.commit()
                progress_service.emit_import_progress(import_id, 0, 'failed', error=error_msg)
                return
            
            content_import.update_progress(25)
            db.session.commit()
            progress_service.emit_import_progress(import_id, 25, 'processing', 'File validated, starting extraction...')
            
            # Process based on file type
            if content_import.file_type == 'pdf':
                result = _process_pdf_file(content_import)
            elif content_import.file_type in ['csv', 'xlsx']:
                result = _process_spreadsheet_file(content_import)
            elif content_import.file_type == 'txt':
                result = _process_text_file(content_import)
            else:
                error_msg = f"Unsupported file type: {content_import.file_type}"
                content_import.mark_failed(error_msg)
                db.session.commit()
                progress_service.emit_import_progress(import_id, 0, 'failed', error=error_msg)
                return
            
            if result['success']:
                content_import.extracted_text = result.get('text', '')
                content_import.processed_data = result.get('structured_data', {})
                content_import.content_type = result.get('content_type', 'unknown')
                content_import.update_progress(90, 'reviewing')
                db.session.commit()
                progress_service.emit_import_progress(import_id, 90, 'reviewing', 'Content extracted, analyzing quality...')
                
                # Auto-approve if high quality score
                if result.get('quality_score', 0) >= 85:
                    _auto_publish_content(content_import, result)
                    content_import.mark_completed(result.get('items_created', 0))
                    progress_service.emit_import_completed(import_id, True, result.get('items_created', 0))
                else:
                    content_import.status = 'reviewing'
                    progress_service.emit_import_progress(import_id, 100, 'reviewing', 'Ready for manual review')
                
                db.session.commit()
            else:
                error_msg = result.get('error', 'Processing failed')
                content_import.mark_failed(error_msg)
                db.session.commit()
                progress_service.emit_import_progress(import_id, 0, 'failed', error=error_msg)
                
        except Exception as e:
            try:
                content_import = ContentImport.query.get(import_id)
                if content_import:
                    content_import.mark_failed(f"Processing error: {str(e)}")
                    db.session.commit()
            except:
                pass
            SystemLog.log('ERROR', 'import', f'Background processing failed: {str(e)}')

def _process_pdf_file(content_import: ContentImport) -> dict:
    """Process PDF file using OCR"""
    try:
        # Extract text using OCR service
        progress_service.emit_import_progress(content_import.id, 40, 'processing', 'Extracting text from PDF...')
        result = ocr_service.extract_text_from_pdf(content_import.file_path)
        
        content_import.update_progress(60)
        db.session.commit()
        progress_service.emit_import_progress(content_import.id, 60, 'processing', 'Text extracted, analyzing content...')
        
        if not result['success']:
            return {'success': False, 'error': result.get('error', 'OCR extraction failed')}
        
        content_import.update_progress(80)
        db.session.commit()
        progress_service.emit_import_progress(content_import.id, 80, 'processing', 'Processing extracted content...')
        
        return result
        
    except Exception as e:
        return {'success': False, 'error': str(e)}

def _process_text_file(content_import: ContentImport) -> dict:
    """Process plain text file"""
    try:
        with open(content_import.file_path, 'r', encoding='utf-8') as file:
            text = file.read()
        
        # Use OCR service to analyze content type and structure
        mock_result = {
            'success': True,
            'text': text,
            'pages': [{'page_number': 1, 'text': text}],
            'method_used': 'text_file',
            'content_type': 'unknown',
            'quality_score': 95.0
        }
        
        # Analyze content using OCR service methods
        analyzed_result = ocr_service._analyze_content(mock_result)
        return analyzed_result
        
    except Exception as e:
        return {'success': False, 'error': str(e)}

def _process_spreadsheet_file(content_import: ContentImport) -> dict:
    """Process CSV/Excel file"""
    try:
        import pandas as pd
        
        # Read spreadsheet
        if content_import.file_type == 'csv':
            df = pd.read_csv(content_import.file_path)
        else:
            df = pd.read_excel(content_import.file_path)
        
        # Convert to text format for analysis
        text_lines = []
        for _, row in df.iterrows():
            line = ' - '.join(str(val) for val in row.values if pd.notna(val))
            text_lines.append(line)
        
        text = '\n'.join(text_lines)
        
        # Structure data for vocabulary import
        structured_data = []
        for _, row in df.iterrows():
            if len(row) >= 2:
                structured_data.append({
                    'word': str(row.iloc[0]).strip().lower(),
                    'definition': str(row.iloc[1]).strip() if pd.notna(row.iloc[1]) else '',
                    'additional_info': {col: str(row[col]) for col in df.columns[2:] if pd.notna(row[col])}
                })
        
        return {
            'success': True,
            'text': text,
            'structured_data': structured_data,
            'content_type': 'vocabulary',
            'quality_score': 90.0,
            'method_used': 'spreadsheet'
        }
        
    except Exception as e:
        return {'success': False, 'error': str(e)}

def _auto_publish_content(content_import: ContentImport, processing_result: dict):
    """Automatically publish high-quality content"""
    try:
        content_type = processing_result.get('content_type')
        structured_data = processing_result.get('structured_data', [])
        items_created = 0
        
        if content_type == 'vocabulary' and isinstance(structured_data, list):
            items_created = _create_vocabulary_items(structured_data)
        elif content_type == 'sentences' and isinstance(structured_data, list):
            items_created = _create_sentence_items(structured_data)
        elif content_type == 'article' and isinstance(structured_data, dict):
            items_created = _create_article_item(structured_data)
        
        processing_result['items_created'] = items_created
        return items_created
        
    except Exception as e:
        SystemLog.log('ERROR', 'import', f'Auto-publish failed: {str(e)}')
        return 0

def _create_vocabulary_items(vocabulary_data: list) -> int:
    """Create Word records from vocabulary data"""
    created_count = 0
    
    for item in vocabulary_data:
        try:
            word_text = item.get('word', '').strip().lower()
            if not word_text or Word.query.filter_by(word=word_text).first():
                continue
            
            word = Word(
                word=word_text,
                definition=item.get('definition', ''),
                part_of_speech=item.get('additional_info', {}).get('part_of_speech', ''),
                grade_level=int(item.get('additional_info', {}).get('grade_level', 1)),
                difficulty=int(item.get('additional_info', {}).get('difficulty', 1)),
                frequency=int(item.get('additional_info', {}).get('frequency', 0))
            )
            
            db.session.add(word)
            created_count += 1
            
        except Exception as e:
            SystemLog.log('WARNING', 'import', f'Failed to create word: {str(e)}')
            continue
    
    db.session.commit()
    return created_count

def _create_sentence_items(sentence_data: list) -> int:
    """Create Sentence records from sentence data"""
    created_count = 0
    
    for item in sentence_data:
        try:
            sentence_text = item.get('text', '').strip()
            if not sentence_text:
                continue
            
            sentence = Sentence(
                text=sentence_text,
                difficulty=item.get('difficulty_estimate', 1),
                grade_level=item.get('grade_level', 1),
                source='import'
            )
            
            db.session.add(sentence)
            created_count += 1
            
        except Exception as e:
            SystemLog.log('WARNING', 'import', f'Failed to create sentence: {str(e)}')
            continue
    
    db.session.commit()
    return created_count

def _create_article_item(article_data: dict) -> int:
    """Create Article record from article data"""
    try:
        title = article_data.get('title', 'Imported Article')
        content = '\n\n'.join(article_data.get('paragraphs', []))
        
        article = Article(
            title=title,
            content=content,
            difficulty=article_data.get('difficulty_estimate', 1),
            grade_level=article_data.get('grade_level', 1),
            estimated_reading_time=article_data.get('estimated_reading_time', 5),
            is_published=True,
            source='import'
        )
        
        db.session.add(article)
        db.session.commit()
        return 1
        
    except Exception as e:
        SystemLog.log('WARNING', 'import', f'Failed to create article: {str(e)}')
        return 0

@bp.route('/imports/<int:import_id>', methods=['GET'])
@jwt_required()
def get_import_details(import_id):
    """Get detailed information about a content import"""
    try:
        admin_check = require_admin()
        if admin_check:
            return admin_check
        
        content_import = ContentImport.query.get_or_404(import_id)
        
        return jsonify({
            'import': content_import.to_dict(include_data=True)
        }), 200
        
    except Exception as e:
        SystemLog.log('ERROR', 'content', f'Error fetching import details: {str(e)}', request=request)
        return jsonify({'error': 'Internal server error'}), 500

@bp.route('/imports/<int:import_id>/approve', methods=['POST'])
@jwt_required()
def approve_import(import_id):
    """Approve and publish content from an import"""
    try:
        admin_check = require_admin()
        if admin_check:
            return admin_check
        
        content_import = ContentImport.query.get_or_404(import_id)
        
        if content_import.status != 'reviewing':
            return jsonify({'error': 'Import not in review status'}), 400
        
        # Get approval data
        data = request.get_json() or {}
        notes = data.get('notes', '')
        
        # Process the content
        if content_import.processed_data:
            mock_result = {
                'content_type': content_import.content_type,
                'structured_data': content_import.processed_data
            }
            items_created = _auto_publish_content(content_import, mock_result)
        else:
            items_created = 0
        
        # Update import record
        current_user_id = get_jwt_identity()
        content_import.is_approved = True
        content_import.approved_by = current_user_id
        content_import.approved_at = datetime.utcnow()
        content_import.review_notes = notes
        content_import.mark_completed(items_created)
        
        db.session.commit()
        
        # Log action
        AuditLog.log_action(
            user_id=current_user_id,
            action='APPROVE',
            resource_type='import',
            resource_id=import_id,
            description=f'Approved import: {content_import.original_filename}',
            request=request
        )
        
        return jsonify({
            'message': 'Import approved and content published',
            'items_created': items_created,
            'import': content_import.to_dict()
        }), 200
        
    except Exception as e:
        db.session.rollback()
        SystemLog.log('ERROR', 'content', f'Error approving import: {str(e)}', request=request)
        return jsonify({'error': 'Internal server error'}), 500

@bp.route('/imports/<int:import_id>/reject', methods=['POST'])
@jwt_required()
def reject_import(import_id):
    """Reject an import with notes"""
    try:
        admin_check = require_admin()
        if admin_check:
            return admin_check
        
        content_import = ContentImport.query.get_or_404(import_id)
        
        if content_import.status not in ['reviewing', 'completed']:
            return jsonify({'error': 'Import cannot be rejected in current status'}), 400
        
        data = request.get_json()
        if not data or not data.get('notes'):
            return jsonify({'error': 'Rejection notes are required'}), 400
        
        # Update import record
        current_user_id = get_jwt_identity()
        content_import.status = 'failed'
        content_import.is_approved = False
        content_import.approved_by = current_user_id
        content_import.approved_at = datetime.utcnow()
        content_import.review_notes = data['notes']
        content_import.error_message = f"Rejected: {data['notes']}"
        
        db.session.commit()
        
        # Log action
        AuditLog.log_action(
            user_id=current_user_id,
            action='REJECT',
            resource_type='import',
            resource_id=import_id,
            description=f'Rejected import: {content_import.original_filename}',
            request=request
        )
        
        return jsonify({
            'message': 'Import rejected',
            'import': content_import.to_dict()
        }), 200
        
    except Exception as e:
        db.session.rollback()
        SystemLog.log('ERROR', 'content', f'Error rejecting import: {str(e)}', request=request)
        return jsonify({'error': 'Internal server error'}), 500