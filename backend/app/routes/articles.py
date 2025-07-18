#!/usr/bin/env python3
"""
Article Management API Routes
Provides RESTful endpoints for managing reading comprehension articles
"""
from flask import Blueprint, request, jsonify, current_app
from flask_jwt_extended import jwt_required, get_jwt_identity
from sqlalchemy import or_, and_, text
from sqlalchemy.exc import SQLAlchemyError
from datetime import datetime
import json
import re
from functools import wraps

from app import db
from app.models.article import Article, ComprehensionQuestion, ReadingSession, QuestionAttempt, WordLookup
from app.models.user import User
from app.services.difficulty_assessment_service import DifficultyAssessmentService
from app.services.recommendation_service import RecommendationService

# Create blueprint
articles_bp = Blueprint('articles', __name__)


def admin_required(f):
    """Decorator to require admin privileges"""
    @wraps(f)
    def decorated_function(*args, **kwargs):
        user_id = int(get_jwt_identity())
        if not user_id:
            return jsonify({'error': 'Authentication required'}), 401
        
        user = User.query.get(user_id)
        if not user or not getattr(user, 'is_admin', False):
            return jsonify({'error': 'Admin access required'}), 403
        return f(*args, **kwargs)
    return decorated_function


@articles_bp.route('/api/articles', methods=['GET'])
def get_articles():
    """
    Get list of articles with filtering and pagination
    Query parameters:
    - page: Page number (default: 1)
    - per_page: Items per page (default: 20, max: 100)
    - search: Search term for title/content
    - grade_level: Filter by grade level
    - difficulty: Filter by difficulty level
    - topic: Filter by topic
    - published_only: Show only published articles (default: true)
    - sort: Sort field (title, difficulty, grade_level, created_at)
    - order: Sort order (asc, desc)
    """
    try:
        # Get query parameters
        page = request.args.get('page', 1, type=int)
        per_page = min(request.args.get('per_page', 20, type=int), 100)
        search = request.args.get('search', '').strip()
        grade_level = request.args.get('grade_level', type=int)
        difficulty = request.args.get('difficulty', type=int)
        topic = request.args.get('topic', '').strip()
        published_only = request.args.get('published_only', 'true').lower() == 'true'
        sort_field = request.args.get('sort', 'created_at')
        sort_order = request.args.get('order', 'desc').lower()
        
        # Build query
        query = Article.query
        
        # Apply filters
        if published_only:
            query = query.filter(Article.is_published == True)
        
        if search:
            # Full-text search in title and content
            search_filter = or_(
                Article.title.ilike(f'%{search}%'),
                Article.content.ilike(f'%{search}%'),
                Article.author.ilike(f'%{search}%'),
                Article.summary.ilike(f'%{search}%')
            )
            query = query.filter(search_filter)
        
        if grade_level is not None:
            query = query.filter(Article.grade_level == grade_level)
        
        if difficulty is not None:
            query = query.filter(Article.difficulty == difficulty)
        
        if topic:
            query = query.filter(Article.topic.ilike(f'%{topic}%'))
        
        # Apply sorting
        valid_sort_fields = ['title', 'difficulty', 'grade_level', 'created_at', 'word_count', 'estimated_reading_time']
        if sort_field in valid_sort_fields:
            sort_column = getattr(Article, sort_field)
            if sort_order == 'desc':
                query = query.order_by(sort_column.desc())
            else:
                query = query.order_by(sort_column.asc())
        else:
            query = query.order_by(Article.created_at.desc())
        
        # Execute paginated query
        pagination = query.paginate(
            page=page,
            per_page=per_page,
            error_out=False
        )
        
        # Serialize articles (without content for list view)
        articles = [article.to_dict(include_content=False) for article in pagination.items]
        
        return jsonify({
            'articles': articles,
            'pagination': {
                'page': pagination.page,
                'pages': pagination.pages,
                'per_page': pagination.per_page,
                'total': pagination.total,
                'has_next': pagination.has_next,
                'has_prev': pagination.has_prev,
                'next_num': pagination.next_num,
                'prev_num': pagination.prev_num
            }
        })
        
    except Exception as e:
        current_app.logger.error(f"Error fetching articles: {str(e)}")
        return jsonify({'error': 'Failed to fetch articles'}), 500


@articles_bp.route('/api/articles/<int:article_id>', methods=['GET'])
@jwt_required(optional=True)
def get_article(article_id):
    """Get a specific article by ID with full content"""
    try:
        article = Article.query.get_or_404(article_id)
        
        # Check if user can access unpublished articles
        if not article.is_published:
            user_id = int(get_jwt_identity())
            if not user_id:
                return jsonify({'error': 'Article not found'}), 404
            
            user = User.query.get(user_id)
            if not user or not getattr(user, 'is_admin', False):
                return jsonify({'error': 'Article not found'}), 404
        
        # Get article with full content and questions
        article_data = article.to_dict(include_content=True)
        
        # Add questions
        questions = [q.to_dict() for q in article.questions]
        article_data['questions'] = questions
        
        # Add reading statistics if user is authenticated
        user_id = int(get_jwt_identity())
        if user_id:
            # Get user's reading progress for this article
            latest_session = ReadingSession.query.filter_by(
                user_id=user_id,
                article_id=article.id
            ).order_by(ReadingSession.created_at.desc()).first()
            
            if latest_session:
                article_data['user_progress'] = {
                    'completion_percentage': latest_session.completion_percentage,
                    'comprehension_score': latest_session.comprehension_score,
                    'last_read': latest_session.updated_at.isoformat() if latest_session.updated_at else None,
                    'bookmarks': latest_session.bookmarks or []
                }
        
        return jsonify(article_data)
        
    except Exception as e:
        current_app.logger.error(f"Error fetching article {article_id}: {str(e)}")
        return jsonify({'error': 'Failed to fetch article'}), 500


@articles_bp.route('/api/articles', methods=['POST'])
@jwt_required()
@admin_required
def create_article():
    """Create a new article"""
    try:
        data = request.get_json()
        
        # Validate required fields
        required_fields = ['title', 'content']
        for field in required_fields:
            if not data.get(field):
                return jsonify({'error': f'Missing required field: {field}'}), 400
        
        # Calculate word count if not provided
        content = data['content']
        word_count = data.get('word_count')
        if not word_count:
            # Simple word count (split by whitespace)
            word_count = len(content.split())
        
        # Create new article
        current_user = User.query.get(int(get_jwt_identity()))
        default_author = current_user.username if current_user else 'Unknown'
        
        article = Article(
            title=data['title'],
            content=content,
            summary=data.get('summary', ''),
            author=data.get('author', default_author),
            source=data.get('source', ''),
            topic=data.get('topic', ''),
            grade_level=data.get('grade_level', 1),
            difficulty=data.get('difficulty', 1),
            word_count=word_count,
            image_url=data.get('image_url'),
            is_published=data.get('is_published', False)
        )
        
        # Set tags if provided
        if data.get('tags'):
            article.set_tags(data['tags'])
        
        # Calculate reading time
        article.calculate_reading_time()
        
        db.session.add(article)
        db.session.flush()  # Get article ID
        
        # Add questions if provided
        questions_data = data.get('questions', [])
        for i, question_data in enumerate(questions_data):
            question = ComprehensionQuestion(
                article_id=article.id,
                question_text=question_data['question_text'],
                question_type=question_data.get('question_type', 'multiple_choice'),
                options=question_data.get('options'),
                correct_answer=question_data['correct_answer'],
                explanation=question_data.get('explanation', ''),
                difficulty=question_data.get('difficulty', 1),
                order_index=question_data.get('order_index', i + 1)
            )
            db.session.add(question)
        
        db.session.commit()
        
        return jsonify({
            'message': 'Article created successfully',
            'article': article.to_dict(include_content=False)
        }), 201
        
    except SQLAlchemyError as e:
        db.session.rollback()
        current_app.logger.error(f"Database error creating article: {str(e)}")
        return jsonify({'error': 'Database error occurred'}), 500
    except Exception as e:
        db.session.rollback()
        current_app.logger.error(f"Error creating article: {str(e)}")
        return jsonify({'error': 'Failed to create article'}), 500


@articles_bp.route('/api/articles/<int:article_id>', methods=['PUT'])
@jwt_required()
@admin_required
def update_article(article_id):
    """Update an existing article"""
    try:
        article = Article.query.get_or_404(article_id)
        data = request.get_json()
        
        # Update fields if provided
        if 'title' in data:
            article.title = data['title']
        if 'content' in data:
            article.content = data['content']
            # Recalculate word count if content changed
            article.word_count = len(data['content'].split())
            article.calculate_reading_time()
        if 'summary' in data:
            article.summary = data['summary']
        if 'author' in data:
            article.author = data['author']
        if 'source' in data:
            article.source = data['source']
        if 'topic' in data:
            article.topic = data['topic']
        if 'grade_level' in data:
            article.grade_level = data['grade_level']
        if 'difficulty' in data:
            article.difficulty = data['difficulty']
        if 'image_url' in data:
            article.image_url = data['image_url']
        if 'is_published' in data:
            article.is_published = data['is_published']
        if 'tags' in data:
            article.set_tags(data['tags'])
        
        article.updated_at = datetime.utcnow()
        
        # Update questions if provided
        if 'questions' in data:
            # Remove existing questions
            ComprehensionQuestion.query.filter_by(article_id=article.id).delete()
            
            # Add new questions
            for i, question_data in enumerate(data['questions']):
                question = ComprehensionQuestion(
                    article_id=article.id,
                    question_text=question_data['question_text'],
                    question_type=question_data.get('question_type', 'multiple_choice'),
                    options=question_data.get('options'),
                    correct_answer=question_data['correct_answer'],
                    explanation=question_data.get('explanation', ''),
                    difficulty=question_data.get('difficulty', 1),
                    order_index=question_data.get('order_index', i + 1)
                )
                db.session.add(question)
        
        db.session.commit()
        
        return jsonify({
            'message': 'Article updated successfully',
            'article': article.to_dict(include_content=False)
        })
        
    except SQLAlchemyError as e:
        db.session.rollback()
        current_app.logger.error(f"Database error updating article {article_id}: {str(e)}")
        return jsonify({'error': 'Database error occurred'}), 500
    except Exception as e:
        db.session.rollback()
        current_app.logger.error(f"Error updating article {article_id}: {str(e)}")
        return jsonify({'error': 'Failed to update article'}), 500


@articles_bp.route('/api/articles/<int:article_id>', methods=['DELETE'])
@jwt_required()
@admin_required
def delete_article(article_id):
    """Delete an article and all related data"""
    try:
        article = Article.query.get_or_404(article_id)
        
        # Delete related data (cascaded by database constraints)
        db.session.delete(article)
        db.session.commit()
        
        return jsonify({'message': 'Article deleted successfully'})
        
    except SQLAlchemyError as e:
        db.session.rollback()
        current_app.logger.error(f"Database error deleting article {article_id}: {str(e)}")
        return jsonify({'error': 'Database error occurred'}), 500
    except Exception as e:
        db.session.rollback()
        current_app.logger.error(f"Error deleting article {article_id}: {str(e)}")
        return jsonify({'error': 'Failed to delete article'}), 500


@articles_bp.route('/api/articles/search', methods=['POST'])
def search_articles():
    """Advanced article search with full-text capabilities"""
    try:
        data = request.get_json()
        search_term = data.get('search', '').strip()
        filters = data.get('filters', {})
        
        if not search_term:
            return jsonify({'error': 'Search term is required'}), 400
        
        # Build advanced search query
        query = Article.query
        
        # Full-text search using PostgreSQL
        if current_app.config.get('SQLALCHEMY_DATABASE_URI', '').startswith('postgresql'):
            # Use PostgreSQL full-text search
            search_vector = text(
                "to_tsvector('english', title || ' ' || content || ' ' || COALESCE(summary, '')) "
                "@@ plainto_tsquery('english', :search_term)"
            )
            query = query.filter(search_vector).params(search_term=search_term)
        else:
            # Fallback to LIKE search for other databases
            search_filter = or_(
                Article.title.ilike(f'%{search_term}%'),
                Article.content.ilike(f'%{search_term}%'),
                Article.summary.ilike(f'%{search_term}%')
            )
            query = query.filter(search_filter)
        
        # Apply additional filters
        if filters.get('grade_levels'):
            query = query.filter(Article.grade_level.in_(filters['grade_levels']))
        
        if filters.get('difficulties'):
            query = query.filter(Article.difficulty.in_(filters['difficulties']))
        
        if filters.get('topics'):
            topic_filter = or_(*[Article.topic.ilike(f'%{topic}%') for topic in filters['topics']])
            query = query.filter(topic_filter)
        
        if filters.get('published_only', True):
            query = query.filter(Article.is_published == True)
        
        # Execute search
        articles = query.order_by(Article.created_at.desc()).limit(50).all()
        
        return jsonify({
            'articles': [article.to_dict(include_content=False) for article in articles],
            'count': len(articles)
        })
        
    except Exception as e:
        current_app.logger.error(f"Error in article search: {str(e)}")
        return jsonify({'error': 'Search failed'}), 500


@articles_bp.route('/api/articles/metadata', methods=['GET'])
def get_articles_metadata():
    """Get metadata for article filtering and categorization"""
    try:
        # Get available grade levels
        grade_levels = db.session.query(Article.grade_level).distinct().filter(
            Article.grade_level.isnot(None)
        ).order_by(Article.grade_level).all()
        grade_levels = [level[0] for level in grade_levels]
        
        # Get available difficulties
        difficulties = db.session.query(Article.difficulty).distinct().filter(
            Article.difficulty.isnot(None)
        ).order_by(Article.difficulty).all()
        difficulties = [diff[0] for diff in difficulties]
        
        # Get available topics
        topics = db.session.query(Article.topic).distinct().filter(
            Article.topic.isnot(None),
            Article.topic != ''
        ).order_by(Article.topic).all()
        topics = [topic[0] for topic in topics]
        
        # Get article counts by category
        total_articles = Article.query.filter(Article.is_published == True).count()
        
        return jsonify({
            'grade_levels': grade_levels,
            'difficulties': difficulties,
            'topics': topics,
            'total_articles': total_articles
        })
        
    except Exception as e:
        current_app.logger.error(f"Error fetching articles metadata: {str(e)}")
        return jsonify({'error': 'Failed to fetch metadata'}), 500


@articles_bp.route('/api/articles/<int:article_id>/questions', methods=['GET'])
@jwt_required(optional=True)
def get_article_questions(article_id):
    """Get all questions for a specific article"""
    try:
        article = Article.query.get_or_404(article_id)
        
        # Check article access permissions
        if not article.is_published:
            user_id = int(get_jwt_identity())
            if not user_id:
                return jsonify({'error': 'Article not found'}), 404
            
            user = User.query.get(user_id)
            if not user or not getattr(user, 'is_admin', False):
                return jsonify({'error': 'Article not found'}), 404
        
        questions = ComprehensionQuestion.query.filter_by(article_id=article_id).order_by(
            ComprehensionQuestion.order_index
        ).all()
        
        return jsonify({
            'questions': [question.to_dict() for question in questions]
        })
        
    except Exception as e:
        current_app.logger.error(f"Error fetching questions for article {article_id}: {str(e)}")
        return jsonify({'error': 'Failed to fetch questions'}), 500


@articles_bp.route('/api/articles/<int:article_id>/questions', methods=['POST'])
@jwt_required()
@admin_required
def add_article_question(article_id):
    """Add a new question to an article"""
    try:
        article = Article.query.get_or_404(article_id)
        data = request.get_json()
        
        # Validate required fields
        if not data.get('question_text') or not data.get('correct_answer'):
            return jsonify({'error': 'Missing required fields'}), 400
        
        # Get next order index
        max_order = db.session.query(db.func.max(ComprehensionQuestion.order_index)).filter_by(
            article_id=article_id
        ).scalar() or 0
        
        question = ComprehensionQuestion(
            article_id=article_id,
            question_text=data['question_text'],
            question_type=data.get('question_type', 'multiple_choice'),
            options=data.get('options'),
            correct_answer=data['correct_answer'],
            explanation=data.get('explanation', ''),
            difficulty=data.get('difficulty', 1),
            order_index=data.get('order_index', max_order + 1)
        )
        
        db.session.add(question)
        db.session.commit()
        
        return jsonify({
            'message': 'Question added successfully',
            'question': question.to_dict()
        }), 201
        
    except Exception as e:
        db.session.rollback()
        current_app.logger.error(f"Error adding question to article {article_id}: {str(e)}")
        return jsonify({'error': 'Failed to add question'}), 500


@articles_bp.route('/api/reading/sessions/<int:session_id>/questions/<int:question_id>/submit', methods=['POST'])
@jwt_required()
def submit_question_answer(session_id, question_id):
    """Submit an answer to a comprehension question"""
    try:
        user_id = int(get_jwt_identity())
        data = request.get_json()
        
        # Validate input
        if 'answer' not in data:
            return jsonify({'error': 'Answer is required'}), 400
        
        # Get reading session
        session = ReadingSession.query.filter_by(
            id=session_id,
            user_id=user_id
        ).first()
        
        if not session:
            return jsonify({'error': 'Reading session not found'}), 404
        
        # Get question
        question = ComprehensionQuestion.query.filter_by(
            id=question_id,
            article_id=session.article_id
        ).first()
        
        if not question:
            return jsonify({'error': 'Question not found'}), 404
        
        # Check if user already attempted this question in this session
        existing_attempt = QuestionAttempt.query.filter_by(
            reading_session_id=session_id,
            question_id=question_id
        ).first()
        
        user_answer = data['answer'].strip()
        time_taken = data.get('time_taken', 0)
        
        # Grade the answer
        is_correct = _grade_answer(question, user_answer)
        
        if existing_attempt:
            # Update existing attempt (allow retries)
            existing_attempt.user_answer = user_answer
            existing_attempt.is_correct = is_correct
            existing_attempt.time_taken_seconds = time_taken
            existing_attempt.attempt_number += 1
            attempt = existing_attempt
        else:
            # Create new attempt
            attempt = QuestionAttempt(
                reading_session_id=session_id,
                question_id=question_id,
                user_answer=user_answer,
                is_correct=is_correct,
                time_taken_seconds=time_taken,
                attempt_number=1
            )
            db.session.add(attempt)
        
        # Update reading session statistics
        _update_reading_session_stats(session)
        
        db.session.commit()
        
        # Prepare response
        response_data = {
            'is_correct': is_correct,
            'attempt': attempt.to_dict(),
            'explanation': question.explanation if question.explanation else None
        }
        
        # Include correct answer for incorrect attempts (after first try)
        if not is_correct and attempt.attempt_number > 1:
            response_data['correct_answer'] = question.correct_answer
        
        return jsonify(response_data), 200
        
    except Exception as e:
        db.session.rollback()
        current_app.logger.error(f"Error submitting question answer: {str(e)}")
        return jsonify({'error': 'Failed to submit answer'}), 500


@articles_bp.route('/api/reading/sessions/<int:session_id>/questions', methods=['GET'])
@jwt_required()
def get_session_questions(session_id):
    """Get all questions for a reading session with user's attempts"""
    try:
        user_id = int(get_jwt_identity())
        
        # Get reading session
        session = ReadingSession.query.filter_by(
            id=session_id,
            user_id=user_id
        ).first()
        
        if not session:
            return jsonify({'error': 'Reading session not found'}), 404
        
        # Get questions for the article
        questions = ComprehensionQuestion.query.filter_by(
            article_id=session.article_id
        ).order_by(ComprehensionQuestion.order_index).all()
        
        # Get user's attempts for this session
        attempts = QuestionAttempt.query.filter_by(
            reading_session_id=session_id
        ).all()
        
        # Create a map of question_id to attempt
        attempts_map = {attempt.question_id: attempt for attempt in attempts}
        
        # Prepare questions with attempt data
        questions_data = []
        for question in questions:
            question_dict = question.to_dict()
            
            # Remove correct answer from response (only show after incorrect attempt)
            question_dict.pop('correct_answer', None)
            
            # Add attempt data if exists
            if question.id in attempts_map:
                attempt = attempts_map[question.id]
                question_dict['attempt'] = {
                    'user_answer': attempt.user_answer,
                    'is_correct': attempt.is_correct,
                    'attempt_number': attempt.attempt_number,
                    'time_taken_seconds': attempt.time_taken_seconds
                }
                
                # Show correct answer if user got it wrong and has attempted more than once
                if not attempt.is_correct and attempt.attempt_number > 1:
                    question_dict['correct_answer'] = question.correct_answer
            
            questions_data.append(question_dict)
        
        return jsonify({
            'questions': questions_data,
            'session': session.to_dict()
        }), 200
        
    except Exception as e:
        current_app.logger.error(f"Error getting session questions: {str(e)}")
        return jsonify({'error': 'Failed to get questions'}), 500


def _grade_answer(question: ComprehensionQuestion, user_answer: str) -> bool:
    """
    Grade a user's answer to a comprehension question
    """
    if not user_answer:
        return False
    
    user_answer = user_answer.strip().lower()
    correct_answer = question.correct_answer.strip().lower()
    
    if question.question_type == 'multiple_choice':
        # For multiple choice, exact match required
        return user_answer == correct_answer
    
    elif question.question_type == 'true_false':
        # Normalize true/false answers
        true_answers = ['true', 't', 'yes', 'y', '1']
        false_answers = ['false', 'f', 'no', 'n', '0']
        
        user_normalized = 'true' if user_answer in true_answers else 'false' if user_answer in false_answers else user_answer
        correct_normalized = 'true' if correct_answer in true_answers else 'false' if correct_answer in false_answers else correct_answer
        
        return user_normalized == correct_normalized
    
    elif question.question_type == 'short_answer':
        # For short answer, check for key words or phrases
        import re
        
        # Simple keyword matching - check if user answer contains key words from correct answer
        correct_words = re.findall(r'\b\w+\b', correct_answer.lower())
        user_words = re.findall(r'\b\w+\b', user_answer.lower())
        
        # Remove common words
        common_words = {'the', 'a', 'an', 'and', 'or', 'but', 'in', 'on', 'at', 'to', 'for', 'of', 'with', 'by', 'is', 'are', 'was', 'were', 'be', 'been', 'being', 'have', 'has', 'had', 'do', 'does', 'did', 'will', 'would', 'could', 'should', 'may', 'might', 'can', 'must'}
        
        key_words = [word for word in correct_words if word not in common_words and len(word) > 2]
        
        if not key_words:
            # If no key words found, fall back to substring matching
            return correct_answer in user_answer or user_answer in correct_answer
        
        # Check if at least 60% of key words are present
        matches = sum(1 for word in key_words if word in user_words)
        return matches / len(key_words) >= 0.6
    
    # Default: exact match
    return user_answer == correct_answer


def _update_reading_session_stats(session: ReadingSession):
    """
    Update reading session statistics based on question attempts
    """
    # Get all attempts for this session
    attempts = QuestionAttempt.query.filter_by(
        reading_session_id=session.id
    ).all()
    
    if not attempts:
        return
    
    # Calculate comprehension score
    total_questions = len(set(attempt.question_id for attempt in attempts))
    correct_answers = len([attempt for attempt in attempts if attempt.is_correct])
    
    session.questions_answered = total_questions
    session.questions_correct = correct_answers
    session.comprehension_score = (correct_answers / total_questions * 100) if total_questions > 0 else 0
    
    # Update timestamp
    session.updated_at = datetime.utcnow()


@articles_bp.route('/api/reading/analytics/overview', methods=['GET'])
@jwt_required()
def get_reading_analytics_overview():
    """Get comprehensive reading analytics overview for the current user"""
    try:
        user_id = int(get_jwt_identity())
        days = request.args.get('days', 30, type=int)
        
        # Get reading statistics from ArticleService
        from app.services.article_service import ArticleService
        stats = ArticleService.get_user_reading_statistics(user_id, days)
        
        # Get additional metrics
        cutoff_date = datetime.utcnow() - timedelta(days=days)
        
        # Reading frequency by day
        daily_reading = db.session.query(
            func.date(ReadingSession.created_at).label('date'),
            func.count(ReadingSession.id).label('sessions'),
            func.sum(ReadingSession.reading_duration).label('total_time'),
            func.avg(ReadingSession.comprehension_score).label('avg_score')
        ).filter(
            ReadingSession.user_id == user_id,
            ReadingSession.created_at >= cutoff_date,
            ReadingSession.status == 'completed'
        ).group_by(func.date(ReadingSession.created_at)).all()
        
        # Reading by difficulty level
        difficulty_stats = db.session.query(
            Article.difficulty,
            func.count(ReadingSession.id).label('sessions'),
            func.avg(ReadingSession.comprehension_score).label('avg_score'),
            func.avg(ReadingSession.completion_percentage).label('avg_completion')
        ).join(ReadingSession).filter(
            ReadingSession.user_id == user_id,
            ReadingSession.created_at >= cutoff_date,
            ReadingSession.status == 'completed'
        ).group_by(Article.difficulty).all()
        
        # Recent achievements (mock for now)
        achievements = []
        if stats['reading_streak'] >= 7:
            achievements.append({
                'id': 'streak_7',
                'title': 'Reading Streak',
                'description': f"{stats['reading_streak']} days of consistent reading",
                'icon': '🔥',
                'earned_at': datetime.utcnow().isoformat()
            })
        
        if stats['total_articles_read'] >= 10:
            achievements.append({
                'id': 'articles_10',
                'title': 'Bookworm',
                'description': f"Read {stats['total_articles_read']} articles",
                'icon': '📚',
                'earned_at': datetime.utcnow().isoformat()
            })
        
        # Format daily reading data
        daily_data = []
        for day in daily_reading:
            daily_data.append({
                'date': day.date.isoformat(),
                'sessions': day.sessions,
                'total_time': day.total_time or 0,
                'average_score': round(day.avg_score or 0, 2)
            })
        
        # Format difficulty data
        difficulty_data = []
        for diff in difficulty_stats:
            difficulty_data.append({
                'difficulty': diff.difficulty,
                'sessions': diff.sessions,
                'average_score': round(diff.avg_score or 0, 2),
                'average_completion': round(diff.avg_completion or 0, 2)
            })
        
        return jsonify({
            'overview': stats,
            'daily_reading': daily_data,
            'difficulty_breakdown': difficulty_data,
            'achievements': achievements,
            'period_days': days,
            'generated_at': datetime.utcnow().isoformat()
        })
        
    except Exception as e:
        current_app.logger.error(f"Error getting reading analytics: {str(e)}")
        return jsonify({'error': 'Failed to get reading analytics'}), 500


@articles_bp.route('/api/reading/analytics/progress', methods=['GET'])
@jwt_required()
def get_reading_progress_timeline():
    """Get reading progress timeline data"""
    try:
        user_id = int(get_jwt_identity())
        days = request.args.get('days', 30, type=int)
        
        cutoff_date = datetime.utcnow() - timedelta(days=days)
        
        # Generate timeline data for each day
        timeline_data = []
        for i in range(days):
            date = (datetime.utcnow() - timedelta(days=i)).date()
            
            # Get sessions for this day
            day_sessions = ReadingSession.query.filter(
                ReadingSession.user_id == user_id,
                func.date(ReadingSession.created_at) == date
            ).all()
            
            total_time = sum(s.reading_duration or 0 for s in day_sessions)
            total_sessions = len(day_sessions)
            completed_sessions = len([s for s in day_sessions if s.status == 'completed'])
            avg_comprehension = sum(s.comprehension_score or 0 for s in day_sessions if s.comprehension_score) / max(1, len([s for s in day_sessions if s.comprehension_score]))
            
            timeline_data.append({
                'date': date.isoformat(),
                'reading_time': total_time,
                'sessions': total_sessions,
                'completed_sessions': completed_sessions,
                'average_comprehension': round(avg_comprehension, 2) if avg_comprehension else 0,
                'articles_read': len(set(s.article_id for s in day_sessions if s.status == 'completed'))
            })
        
        timeline_data.reverse()  # Show oldest to newest
        
        return jsonify({
            'timeline': timeline_data,
            'period_days': days,
            'generated_at': datetime.utcnow().isoformat()
        })
        
    except Exception as e:
        current_app.logger.error(f"Error getting reading progress timeline: {str(e)}")
        return jsonify({'error': 'Failed to get progress timeline'}), 500


@articles_bp.route('/api/reading/analytics/recommendations', methods=['GET'])
@jwt_required()
def get_reading_recommendations():
    """Get personalized reading recommendations based on user performance"""
    try:
        user_id = int(get_jwt_identity())
        
        # Get user's reading statistics
        from app.services.article_service import ArticleService
        stats = ArticleService.get_user_reading_statistics(user_id, days=30)
        
        recommendations = []
        
        # Analyze performance and generate recommendations
        if stats['reading_streak'] == 0:
            recommendations.append({
                'type': 'consistency',
                'priority': 'high',
                'title': 'Start Your Reading Journey',
                'description': 'Begin with a short article to establish a reading habit.',
                'action': 'Start Reading',
                'icon': '🚀'
            })
        elif stats['reading_streak'] < 7:
            recommendations.append({
                'type': 'consistency',
                'priority': 'medium',
                'title': 'Build Your Reading Streak',
                'description': f"You're on a {stats['reading_streak']}-day streak. Keep it going!",
                'action': 'Read Today',
                'icon': '🔥'
            })
        
        if stats['average_comprehension_score'] < 70:
            recommendations.append({
                'type': 'comprehension',
                'priority': 'high',
                'title': 'Focus on Comprehension',
                'description': 'Try reading at an easier difficulty level to improve understanding.',
                'action': 'Practice Easier Articles',
                'icon': '🎯'
            })
        elif stats['average_comprehension_score'] > 85:
            recommendations.append({
                'type': 'challenge',
                'priority': 'medium',
                'title': 'Ready for a Challenge',
                'description': 'You\'re doing great! Try more difficult articles.',
                'action': 'Read Harder Content',
                'icon': '💪'
            })
        
        if stats['average_reading_speed'] < 150:
            recommendations.append({
                'type': 'speed',
                'priority': 'low',
                'title': 'Improve Reading Speed',
                'description': 'Practice with familiar topics to increase reading speed.',
                'action': 'Speed Practice',
                'icon': '⚡'
            })
        
        return jsonify({
            'recommendations': recommendations,
            'user_stats': stats,
            'generated_at': datetime.utcnow().isoformat()
        })
        
    except Exception as e:
        current_app.logger.error(f"Error getting reading recommendations: {str(e)}")
        return jsonify({'error': 'Failed to get recommendations'}), 500


@articles_bp.route('/api/articles/<int:article_id>/difficulty-assessment', methods=['POST'])
@jwt_required()
@admin_required
def assess_article_difficulty(article_id):
    """Assess difficulty of an existing article using NLP analysis"""
    try:
        article = Article.query.get_or_404(article_id)
        
        # Initialize difficulty assessment service
        difficulty_service = DifficultyAssessmentService()
        
        # Perform comprehensive difficulty assessment
        assessment = difficulty_service.assess_text_difficulty(
            text=article.content,
            title=article.title
        )
        
        # Update article difficulty if provided in request
        data = request.get_json() or {}
        if data.get('update_article', False):
            article.difficulty_level = assessment['recommended_grade']
            article.metadata = json.dumps({
                'difficulty_assessment': assessment,
                'assessment_date': datetime.utcnow().isoformat()
            })
            db.session.commit()
        
        return jsonify({
            'assessment': assessment,
            'article_id': article_id,
            'updated': data.get('update_article', False)
        })
        
    except Exception as e:
        current_app.logger.error(f"Error assessing article difficulty: {str(e)}")
        return jsonify({'error': 'Failed to assess article difficulty'}), 500


@articles_bp.route('/api/articles/difficulty-assessment', methods=['POST'])
@jwt_required()
@admin_required
def assess_text_difficulty():
    """Assess difficulty of arbitrary text using NLP analysis"""
    try:
        data = request.get_json()
        
        if not data or not data.get('text'):
            return jsonify({'error': 'Text content is required'}), 400
        
        text = data['text']
        title = data.get('title', '')
        
        # Initialize difficulty assessment service
        difficulty_service = DifficultyAssessmentService()
        
        # Perform comprehensive difficulty assessment
        assessment = difficulty_service.assess_text_difficulty(
            text=text,
            title=title
        )
        
        return jsonify({
            'assessment': assessment,
            'text_length': len(text),
            'word_count': len(text.split())
        })
        
    except Exception as e:
        current_app.logger.error(f"Error assessing text difficulty: {str(e)}")
        return jsonify({'error': 'Failed to assess text difficulty'}), 500


@articles_bp.route('/api/reading/recommendations', methods=['GET'])
@jwt_required()
def get_personalized_recommendations():
    """Get personalized article recommendations for the current user"""
    try:
        user_id = int(get_jwt_identity())
        limit = request.args.get('limit', 20, type=int)
        limit = min(limit, 50)  # Cap at 50 recommendations
        
        # Initialize recommendation service
        recommendation_service = RecommendationService()
        
        # Get comprehensive recommendations
        recommendations = recommendation_service.get_comprehensive_recommendations(
            user_id=user_id,
            limit=limit
        )
        
        return jsonify({
            'recommendations': recommendations,
            'user_id': user_id,
            'generated_at': datetime.utcnow().isoformat()
        })
        
    except Exception as e:
        current_app.logger.error(f"Error getting personalized recommendations: {str(e)}")
        return jsonify({'error': 'Failed to get recommendations'}), 500


@articles_bp.route('/api/reading/recommendations/simple', methods=['GET'])
@jwt_required()
def get_simple_recommendations():
    """Get simple list of recommended articles for the current user"""
    try:
        user_id = int(get_jwt_identity())
        limit = request.args.get('limit', 10, type=int)
        limit = min(limit, 20)  # Cap at 20 for simple view
        
        # Initialize services
        difficulty_service = DifficultyAssessmentService()
        
        # Get personalized recommendations using difficulty service
        recommendations = difficulty_service.get_personalized_recommendations(
            user_id=user_id,
            limit=limit
        )
        
        return jsonify({
            'recommendations': recommendations,
            'count': len(recommendations),
            'user_id': user_id,
            'generated_at': datetime.utcnow().isoformat()
        })
        
    except Exception as e:
        current_app.logger.error(f"Error getting simple recommendations: {str(e)}")
        return jsonify({'error': 'Failed to get recommendations'}), 500


@articles_bp.route('/api/articles/<int:article_id>/similar', methods=['GET'])
@jwt_required()
def get_similar_articles(article_id):
    """Get articles similar to the specified article"""
    try:
        # Check if article exists
        article = Article.query.get_or_404(article_id)
        
        # Check article access permissions
        if not article.is_published:
            user_id = int(get_jwt_identity())
            if not user_id:
                return jsonify({'error': 'Article not found'}), 404
            
            user = User.query.get(user_id)
            if not user or not getattr(user, 'is_admin', False):
                return jsonify({'error': 'Article not found'}), 404
        
        limit = request.args.get('limit', 5, type=int)
        limit = min(limit, 10)  # Cap at 10 similar articles
        
        # Initialize recommendation service
        recommendation_service = RecommendationService()
        
        # Get similar articles
        similar_articles = recommendation_service.get_similar_articles(
            article_id=article_id,
            limit=limit
        )
        
        return jsonify({
            'similar_articles': similar_articles,
            'reference_article_id': article_id,
            'count': len(similar_articles),
            'generated_at': datetime.utcnow().isoformat()
        })
        
    except Exception as e:
        current_app.logger.error(f"Error getting similar articles: {str(e)}")
        return jsonify({'error': 'Failed to get similar articles'}), 500


@articles_bp.route('/api/reading/user-performance', methods=['GET'])
@jwt_required()
def get_user_performance_analysis():
    """Get detailed user performance analysis for recommendations"""
    try:
        user_id = int(get_jwt_identity())
        
        # Initialize difficulty assessment service
        difficulty_service = DifficultyAssessmentService()
        
        # Get user performance analysis
        from app.database import get_db
        db_session = next(get_db())
        user_performance = difficulty_service._analyze_user_performance(user_id, db_session)
        
        return jsonify({
            'user_performance': user_performance,
            'user_id': user_id,
            'analysis_date': datetime.utcnow().isoformat()
        })
        
    except Exception as e:
        current_app.logger.error(f"Error getting user performance analysis: {str(e)}")
        return jsonify({'error': 'Failed to get user performance analysis'}), 500


@articles_bp.route('/api/articles/batch-difficulty-assessment', methods=['POST'])
@jwt_required()
@admin_required
def batch_assess_article_difficulty():
    """Assess difficulty for multiple articles in batch"""
    try:
        data = request.get_json()
        article_ids = data.get('article_ids', [])
        update_articles = data.get('update_articles', False)
        
        if not article_ids:
            return jsonify({'error': 'Article IDs are required'}), 400
        
        # Limit batch size
        if len(article_ids) > 50:
            return jsonify({'error': 'Maximum 50 articles per batch'}), 400
        
        # Initialize difficulty assessment service
        difficulty_service = DifficultyAssessmentService()
        
        # Process each article
        results = []
        updated_count = 0
        
        for article_id in article_ids:
            try:
                article = Article.query.get(article_id)
                if not article:
                    results.append({
                        'article_id': article_id,
                        'status': 'error',
                        'error': 'Article not found'
                    })
                    continue
                
                # Assess difficulty
                assessment = difficulty_service.assess_text_difficulty(
                    text=article.content,
                    title=article.title
                )
                
                # Update article if requested
                if update_articles:
                    article.difficulty_level = assessment['recommended_grade']
                    article.metadata = json.dumps({
                        'difficulty_assessment': assessment,
                        'assessment_date': datetime.utcnow().isoformat()
                    })
                    updated_count += 1
                
                results.append({
                    'article_id': article_id,
                    'status': 'success',
                    'assessment': assessment
                })
                
            except Exception as e:
                results.append({
                    'article_id': article_id,
                    'status': 'error',
                    'error': str(e)
                })
        
        # Commit updates if requested
        if update_articles and updated_count > 0:
            db.session.commit()
        
        return jsonify({
            'results': results,
            'total_processed': len(article_ids),
            'successful': len([r for r in results if r['status'] == 'success']),
            'updated': updated_count,
            'processed_at': datetime.utcnow().isoformat()
        })
        
    except Exception as e:
        db.session.rollback()
        current_app.logger.error(f"Error in batch difficulty assessment: {str(e)}")
        return jsonify({'error': 'Failed to process batch assessment'}), 500


# Error handlers
@articles_bp.errorhandler(404)
def not_found(error):
    return jsonify({'error': 'Resource not found'}), 404


@articles_bp.errorhandler(400)
def bad_request(error):
    return jsonify({'error': 'Bad request'}), 400


@articles_bp.errorhandler(403)
def forbidden(error):
    return jsonify({'error': 'Access forbidden'}), 403


@articles_bp.errorhandler(500)
def internal_error(error):
    db.session.rollback()
    return jsonify({'error': 'Internal server error'}), 500