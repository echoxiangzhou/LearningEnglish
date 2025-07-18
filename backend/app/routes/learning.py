from flask import Blueprint, request, jsonify
from flask_jwt_extended import jwt_required, get_jwt_identity
from app import db
from app.models import (
    User, Word, Sentence, LearningSession, Progress, 
    UserWordProgress, Article, ReadingSession, SystemLog
)
from datetime import datetime, timedelta
import random

bp = Blueprint('learning', __name__, url_prefix='/api/learning')

# Dictation Practice Routes
@bp.route('/dictation/start', methods=['POST'])
@jwt_required()
def start_dictation_session():
    """Start a new dictation practice session"""
    try:
        current_user_id = int(get_jwt_identity())
        data = request.get_json()
        
        # Get session parameters
        difficulty = data.get('difficulty', 1)
        grade_level = data.get('grade_level', 1)
        topic = data.get('topic', '')
        sentence_count = min(data.get('sentence_count', 10), 50)
        
        # Query sentences based on criteria
        query = Sentence.query
        
        if difficulty:
            query = query.filter(Sentence.difficulty == difficulty)
        if grade_level:
            query = query.filter(Sentence.grade_level == grade_level)
        if topic:
            query = query.filter(Sentence.topic.ilike(f'%{topic}%'))
        
        # Get random sentences
        sentences = query.order_by(db.func.random()).limit(sentence_count).all()
        
        if not sentences:
            return jsonify({'error': 'No sentences found matching criteria'}), 404
        
        # Create learning session
        session = LearningSession(
            user_id=current_user_id,
            session_type='dictation',
            status='in_progress',
            total_items=len(sentences),
            session_data={
                'difficulty': difficulty,
                'grade_level': grade_level,
                'topic': topic,
                'sentence_ids': [s.id for s in sentences],
                'current_index': 0
            }
        )
        
        db.session.add(session)
        db.session.commit()
        
        # Return session info with first sentence
        return jsonify({
            'session': session.to_dict(),
            'sentences': [s.to_dict() for s in sentences],
            'current_sentence': sentences[0].to_dict() if sentences else None
        }), 201
        
    except Exception as e:
        db.session.rollback()
        SystemLog.log('ERROR', 'learning', f'Error starting dictation session: {str(e)}', 
                     details={'user_id': current_user_id}, request=request)
        return jsonify({'error': 'Internal server error'}), 500

@bp.route('/dictation/<int:session_id>/submit', methods=['POST'])
@jwt_required()
def submit_dictation_answer():
    """Submit an answer for a dictation exercise"""
    try:
        current_user_id = int(get_jwt_identity())
        session_id = int(request.view_args['session_id'])
        data = request.get_json()
        
        # Get session
        session = LearningSession.query.filter_by(
            id=session_id, user_id=current_user_id, session_type='dictation'
        ).first()
        
        if not session:
            return jsonify({'error': 'Session not found'}), 404
        
        if session.status != 'in_progress':
            return jsonify({'error': 'Session is not active'}), 400
        
        # Get submission data
        sentence_id = data.get('sentence_id')
        user_answer = data.get('answer', '').strip()
        time_taken = data.get('time_taken', 0)
        hints_used = data.get('hints_used', 0)
        
        # Get correct sentence
        sentence = Sentence.query.get(sentence_id)
        if not sentence:
            return jsonify({'error': 'Sentence not found'}), 404
        
        # Check answer (simple text comparison for now)
        correct_answer = sentence.text.strip()
        is_correct = user_answer.lower() == correct_answer.lower()
        
        # Create progress record
        progress = Progress(
            user_id=current_user_id,
            session_id=session_id,
            item_type='sentence',
            item_id=sentence_id,
            is_correct=is_correct,
            user_answer=user_answer,
            correct_answer=correct_answer,
            time_taken_seconds=time_taken,
            hints_used=hints_used,
            difficulty_level=sentence.difficulty
        )
        
        db.session.add(progress)
        
        # Update session stats
        if is_correct:
            session.correct_items += 1
        else:
            session.incorrect_items += 1
        
        session.session_data = session.session_data or {}
        session.session_data['current_index'] = session.session_data.get('current_index', 0) + 1
        
        # Check if session is complete
        if session.session_data['current_index'] >= session.total_items:
            session.complete_session()
        
        db.session.commit()
        
        return jsonify({
            'is_correct': is_correct,
            'correct_answer': correct_answer,
            'session': session.to_dict(),
            'progress': progress.to_dict()
        }), 200
        
    except Exception as e:
        db.session.rollback()
        SystemLog.log('ERROR', 'learning', f'Error submitting dictation answer: {str(e)}', 
                     details={'user_id': current_user_id}, request=request)
        return jsonify({'error': 'Internal server error'}), 500

# Vocabulary Learning Routes
@bp.route('/vocabulary/practice', methods=['POST'])
@jwt_required()
def start_vocabulary_practice():
    """Start vocabulary practice session"""
    try:
        current_user_id = int(get_jwt_identity())
        data = request.get_json()
        
        # Get practice parameters
        practice_type = data.get('type', 'mixed')  # 'mixed', 'new', 'review'
        difficulty = data.get('difficulty')
        grade_level = data.get('grade_level')
        word_count = min(data.get('word_count', 20), 100)
        
        # Build query based on practice type
        if practice_type == 'review':
            # Get words due for review
            query = db.session.query(Word).join(UserWordProgress).filter(
                UserWordProgress.user_id == current_user_id,
                UserWordProgress.next_review <= datetime.utcnow(),
                UserWordProgress.mastery_level < 5
            )
        elif practice_type == 'new':
            # Get words not yet practiced
            practiced_word_ids = db.session.query(UserWordProgress.word_id).filter_by(
                user_id=current_user_id
            ).subquery()
            query = Word.query.filter(~Word.id.in_(practiced_word_ids))
        else:
            # Mixed practice
            query = Word.query
        
        # Apply additional filters
        if difficulty:
            query = query.filter(Word.difficulty == difficulty)
        if grade_level:
            query = query.filter(Word.grade_level == grade_level)
        
        # Get random words
        words = query.order_by(db.func.random()).limit(word_count).all()
        
        if not words:
            return jsonify({'error': 'No words found for practice'}), 404
        
        # Create learning session
        session = LearningSession(
            user_id=current_user_id,
            session_type='vocabulary',
            status='in_progress',
            total_items=len(words),
            session_data={
                'practice_type': practice_type,
                'difficulty': difficulty,
                'grade_level': grade_level,
                'word_ids': [w.id for w in words],
                'current_index': 0
            }
        )
        
        db.session.add(session)
        db.session.commit()
        
        return jsonify({
            'session': session.to_dict(),
            'words': [w.to_dict() for w in words]
        }), 201
        
    except Exception as e:
        db.session.rollback()
        SystemLog.log('ERROR', 'learning', f'Error starting vocabulary practice: {str(e)}', 
                     details={'user_id': current_user_id}, request=request)
        return jsonify({'error': 'Internal server error'}), 500

@bp.route('/vocabulary/<int:session_id>/submit', methods=['POST'])
@jwt_required()
def submit_vocabulary_answer():
    """Submit vocabulary practice answer"""
    try:
        current_user_id = int(get_jwt_identity())
        session_id = int(request.view_args['session_id'])
        data = request.get_json()
        
        # Get session
        session = LearningSession.query.filter_by(
            id=session_id, user_id=current_user_id, session_type='vocabulary'
        ).first()
        
        if not session or session.status != 'in_progress':
            return jsonify({'error': 'Session not found or not active'}), 404
        
        # Get submission data
        word_id = data.get('word_id')
        user_answer = data.get('answer', '').strip()
        question_type = data.get('question_type', 'definition')  # 'definition', 'spelling', 'pronunciation'
        time_taken = data.get('time_taken', 0)
        
        # Get word
        word = Word.query.get(word_id)
        if not word:
            return jsonify({'error': 'Word not found'}), 404
        
        # Check answer based on question type
        is_correct = False
        correct_answer = ''
        
        if question_type == 'definition':
            correct_answer = word.definition
            # Simple keyword matching for definition questions
            is_correct = any(keyword.lower() in user_answer.lower() 
                           for keyword in correct_answer.split() if len(keyword) > 3)
        elif question_type == 'spelling':
            correct_answer = word.word
            is_correct = user_answer.lower() == correct_answer.lower()
        elif question_type == 'pronunciation':
            correct_answer = word.phonetic
            # For pronunciation, we'd need audio comparison (simplified for now)
            is_correct = True  # Assume correct for demo
        
        # Create progress record
        progress = Progress(
            user_id=current_user_id,
            session_id=session_id,
            item_type='word',
            item_id=word_id,
            is_correct=is_correct,
            user_answer=user_answer,
            correct_answer=correct_answer,
            time_taken_seconds=time_taken,
            difficulty_level=word.difficulty
        )
        
        db.session.add(progress)
        
        # Update or create user word progress
        word_progress = UserWordProgress.query.filter_by(
            user_id=current_user_id, word_id=word_id
        ).first()
        
        if not word_progress:
            word_progress = UserWordProgress(
                user_id=current_user_id,
                word_id=word_id
            )
            db.session.add(word_progress)
        
        word_progress.update_progress(is_correct)
        
        # Update session stats
        if is_correct:
            session.correct_items += 1
        else:
            session.incorrect_items += 1
        
        session.session_data['current_index'] = session.session_data.get('current_index', 0) + 1
        
        # Check if session is complete
        if session.session_data['current_index'] >= session.total_items:
            session.complete_session()
        
        db.session.commit()
        
        return jsonify({
            'is_correct': is_correct,
            'correct_answer': correct_answer,
            'word_progress': word_progress.to_dict(),
            'session': session.to_dict()
        }), 200
        
    except Exception as e:
        db.session.rollback()
        SystemLog.log('ERROR', 'learning', f'Error submitting vocabulary answer: {str(e)}', 
                     details={'user_id': current_user_id}, request=request)
        return jsonify({'error': 'Internal server error'}), 500

# Reading Module Routes
@bp.route('/reading/<int:article_id>/start', methods=['POST'])
@jwt_required()
def start_reading_session(article_id):
    """Start a reading session for an article"""
    try:
        current_user_id = int(get_jwt_identity())
        
        # Get article
        article = Article.query.filter_by(id=article_id, is_published=True).first()
        if not article:
            return jsonify({'error': 'Article not found'}), 404
        
        # Check if there's an existing incomplete session
        existing_session = ReadingSession.query.filter_by(
            user_id=current_user_id,
            article_id=article_id,
            status='in_progress'
        ).first()
        
        if existing_session:
            return jsonify({
                'session': existing_session.to_dict(),
                'article': article.to_dict()
            }), 200
        
        # Create new reading session
        session = ReadingSession(
            user_id=current_user_id,
            article_id=article_id,
            status='in_progress'
        )
        
        db.session.add(session)
        db.session.commit()
        
        return jsonify({
            'session': session.to_dict(),
            'article': article.to_dict()
        }), 201
        
    except Exception as e:
        db.session.rollback()
        SystemLog.log('ERROR', 'learning', f'Error starting reading session: {str(e)}', 
                     details={'user_id': current_user_id}, request=request)
        return jsonify({'error': 'Internal server error'}), 500

@bp.route('/reading/<int:session_id>/progress', methods=['POST'])
@jwt_required()
def update_reading_progress(session_id):
    """Update reading progress"""
    try:
        current_user_id = int(get_jwt_identity())
        data = request.get_json()
        
        # Get session
        session = ReadingSession.query.filter_by(
            id=session_id, user_id=current_user_id
        ).first()
        
        if not session:
            return jsonify({'error': 'Session not found'}), 404
        
        # Update progress
        if 'completion_percentage' in data:
            session.completion_percentage = min(100, max(0, data['completion_percentage']))
        
        if 'reading_duration' in data:
            session.reading_duration = data['reading_duration']
        
        if 'notes' in data:
            session.notes = data['notes']
        
        # Mark as completed if 100%
        if session.completion_percentage >= 100:
            session.status = 'completed'
            session.end_time = datetime.utcnow()
            if session.start_time:
                session.total_duration = int((session.end_time - session.start_time).total_seconds())
        
        session.updated_at = datetime.utcnow()
        db.session.commit()
        
        return jsonify({'session': session.to_dict()}), 200
        
    except Exception as e:
        db.session.rollback()
        SystemLog.log('ERROR', 'learning', f'Error updating reading progress: {str(e)}', 
                     details={'user_id': current_user_id}, request=request)
        return jsonify({'error': 'Internal server error'}), 500

# Progress and Analytics Routes
@bp.route('/progress/overview', methods=['GET'])
@jwt_required()
def get_progress_overview():
    """Get user's learning progress overview"""
    try:
        current_user_id = int(get_jwt_identity())
        
        # Get recent sessions
        recent_sessions = LearningSession.query.filter_by(
            user_id=current_user_id
        ).order_by(LearningSession.created_at.desc()).limit(10).all()
        
        # Get word progress stats
        word_stats = db.session.query(
            db.func.count(UserWordProgress.id).label('total_words'),
            db.func.avg(UserWordProgress.mastery_level).label('avg_mastery'),
            db.func.sum(UserWordProgress.correct_attempts).label('total_correct'),
            db.func.sum(UserWordProgress.total_attempts).label('total_attempts')
        ).filter_by(user_id=current_user_id).first()
        
        # Get this week's activity
        week_ago = datetime.utcnow() - timedelta(days=7)
        weekly_sessions = LearningSession.query.filter(
            LearningSession.user_id == current_user_id,
            LearningSession.created_at >= week_ago
        ).all()
        
        # Calculate statistics
        weekly_stats = {
            'sessions': len(weekly_sessions),
            'total_time': sum(s.duration_seconds or 0 for s in weekly_sessions),
            'avg_accuracy': sum(s.accuracy_rate for s in weekly_sessions) / len(weekly_sessions) if weekly_sessions else 0
        }
        
        return jsonify({
            'recent_sessions': [s.to_dict() for s in recent_sessions],
            'word_stats': {
                'total_words': word_stats.total_words or 0,
                'average_mastery': round(word_stats.avg_mastery or 0, 2),
                'accuracy_rate': (word_stats.total_correct / word_stats.total_attempts * 100) if word_stats.total_attempts else 0
            },
            'weekly_stats': weekly_stats
        }), 200
        
    except Exception as e:
        SystemLog.log('ERROR', 'learning', f'Error getting progress overview: {str(e)}', 
                     details={'user_id': current_user_id}, request=request)
        return jsonify({'error': 'Internal server error'}), 500

@bp.route('/sessions', methods=['GET'])
@jwt_required()
def get_learning_sessions():
    """Get user's learning sessions"""
    try:
        current_user_id = int(get_jwt_identity())
        
        page = request.args.get('page', 1, type=int)
        per_page = min(request.args.get('per_page', 20, type=int), 100)
        session_type = request.args.get('type', '').strip()
        
        query = LearningSession.query.filter_by(user_id=current_user_id)
        
        if session_type:
            query = query.filter(LearningSession.session_type == session_type)
        
        sessions = query.order_by(LearningSession.created_at.desc()).paginate(
            page=page, per_page=per_page, error_out=False
        )
        
        return jsonify({
            'sessions': [session.to_dict() for session in sessions.items],
            'pagination': {
                'page': page,
                'pages': sessions.pages,
                'per_page': per_page,
                'total': sessions.total,
                'has_next': sessions.has_next,
                'has_prev': sessions.has_prev
            }
        }), 200
        
    except Exception as e:
        SystemLog.log('ERROR', 'learning', f'Error getting learning sessions: {str(e)}', 
                     details={'user_id': current_user_id}, request=request)
        return jsonify({'error': 'Internal server error'}), 500