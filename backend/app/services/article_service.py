#!/usr/bin/env python3
"""
Article Service Layer
Handles business logic for article management and reading comprehension
"""
import re
from typing import List, Dict, Any, Optional, Tuple
from datetime import datetime, timedelta
from sqlalchemy import func, and_, or_
from sqlalchemy.exc import SQLAlchemyError

from app import db
from app.models.article import Article, ComprehensionQuestion, ReadingSession, QuestionAttempt, WordLookup
from app.models.user import User
from app.models.word import Word


class ArticleService:
    """Service class for article management operations"""
    
    @staticmethod
    def calculate_article_difficulty(content: str, word_count: int = None) -> Dict[str, Any]:
        """
        Calculate article difficulty based on various metrics
        Returns difficulty score and metrics breakdown
        """
        if not content:
            return {'difficulty': 1, 'metrics': {}}
        
        # Calculate basic metrics
        if word_count is None:
            word_count = len(content.split())
        
        sentence_count = len(re.split(r'[.!?]+', content.strip()))
        if sentence_count == 0:
            sentence_count = 1
        
        avg_words_per_sentence = word_count / sentence_count
        
        # Calculate vocabulary complexity (simplified)
        words = content.lower().split()
        unique_words = len(set(words))
        vocabulary_diversity = unique_words / word_count if word_count > 0 else 0
        
        # Count complex words (words with more than 6 characters)
        complex_words = [w for w in words if len(w) > 6]
        complex_word_ratio = len(complex_words) / word_count if word_count > 0 else 0
        
        # Simple readability score (Flesch-inspired)
        # Lower score = higher difficulty
        readability_score = 100 - (1.015 * avg_words_per_sentence) - (84.6 * complex_word_ratio)
        
        # Convert to 1-5 difficulty scale
        if readability_score >= 80:
            difficulty = 1  # Very Easy
        elif readability_score >= 60:
            difficulty = 2  # Easy
        elif readability_score >= 40:
            difficulty = 3  # Medium
        elif readability_score >= 20:
            difficulty = 4  # Hard
        else:
            difficulty = 5  # Very Hard
        
        metrics = {
            'word_count': word_count,
            'sentence_count': sentence_count,
            'avg_words_per_sentence': round(avg_words_per_sentence, 2),
            'vocabulary_diversity': round(vocabulary_diversity, 3),
            'complex_word_ratio': round(complex_word_ratio, 3),
            'readability_score': round(readability_score, 2)
        }
        
        return {
            'difficulty': difficulty,
            'metrics': metrics
        }
    
    @staticmethod
    def estimate_reading_time(word_count: int, grade_level: int = None) -> int:
        """
        Estimate reading time based on word count and grade level
        Returns time in minutes
        """
        if not word_count:
            return 1
        
        # Adjust WPM based on grade level
        if grade_level:
            if grade_level <= 2:
                wpm = 100  # Elementary
            elif grade_level <= 5:
                wpm = 150  # Intermediate
            elif grade_level <= 8:
                wpm = 200  # Middle school
            else:
                wpm = 250  # High school+
        else:
            wpm = 200  # Default
        
        reading_time = max(1, round(word_count / wpm))
        return reading_time
    
    @staticmethod
    def extract_article_metadata(content: str) -> Dict[str, Any]:
        """
        Extract metadata from article content
        """
        if not content:
            return {}
        
        # Calculate word count
        word_count = len(content.split())
        
        # Extract sentences
        sentences = re.split(r'[.!?]+', content.strip())
        sentences = [s.strip() for s in sentences if s.strip()]
        sentence_count = len(sentences)
        
        # Calculate difficulty
        difficulty_data = ArticleService.calculate_article_difficulty(content, word_count)
        
        # Suggest grade level based on difficulty and metrics
        avg_words_per_sentence = difficulty_data['metrics'].get('avg_words_per_sentence', 10)
        complex_word_ratio = difficulty_data['metrics'].get('complex_word_ratio', 0)
        
        if avg_words_per_sentence < 8 and complex_word_ratio < 0.1:
            suggested_grade_level = 1
        elif avg_words_per_sentence < 12 and complex_word_ratio < 0.15:
            suggested_grade_level = 2
        elif avg_words_per_sentence < 15 and complex_word_ratio < 0.2:
            suggested_grade_level = 3
        elif avg_words_per_sentence < 18 and complex_word_ratio < 0.25:
            suggested_grade_level = 4
        elif avg_words_per_sentence < 20 and complex_word_ratio < 0.3:
            suggested_grade_level = 5
        else:
            suggested_grade_level = 6
        
        return {
            'word_count': word_count,
            'sentence_count': sentence_count,
            'difficulty': difficulty_data['difficulty'],
            'suggested_grade_level': suggested_grade_level,
            'estimated_reading_time': ArticleService.estimate_reading_time(word_count, suggested_grade_level),
            'metrics': difficulty_data['metrics']
        }
    
    @staticmethod
    def get_article_recommendations(user_id: int, limit: int = 5) -> List[Article]:
        """
        Get personalized article recommendations for a user
        """
        try:
            # Get user's reading history
            reading_sessions = ReadingSession.query.filter_by(user_id=user_id).all()
            
            if not reading_sessions:
                # New user - recommend beginner articles
                return Article.query.filter(
                    Article.is_published == True,
                    Article.grade_level <= 3,
                    Article.difficulty <= 2
                ).order_by(Article.created_at.desc()).limit(limit).all()
            
            # Calculate user's average performance
            avg_completion = db.session.query(func.avg(ReadingSession.completion_percentage)).filter_by(
                user_id=user_id
            ).scalar() or 0
            
            avg_comprehension = db.session.query(func.avg(ReadingSession.comprehension_score)).filter_by(
                user_id=user_id
            ).scalar() or 0
            
            # Get user's preferred topics
            topic_preferences = db.session.query(
                Article.topic,
                func.count(ReadingSession.id).label('count')
            ).join(ReadingSession).filter(
                ReadingSession.user_id == user_id,
                Article.topic.isnot(None)
            ).group_by(Article.topic).order_by(func.count(ReadingSession.id).desc()).limit(3).all()
            
            # Determine appropriate difficulty range
            if avg_comprehension >= 80 and avg_completion >= 90:
                # User is doing well, suggest slightly harder content
                min_difficulty = 2
                max_difficulty = 5
            elif avg_comprehension >= 60 and avg_completion >= 70:
                # User is doing okay, maintain current level
                min_difficulty = 1
                max_difficulty = 3
            else:
                # User is struggling, suggest easier content
                min_difficulty = 1
                max_difficulty = 2
            
            # Build recommendation query
            query = Article.query.filter(
                Article.is_published == True,
                Article.difficulty.between(min_difficulty, max_difficulty)
            )
            
            # Exclude already read articles
            read_article_ids = [rs.article_id for rs in reading_sessions]
            if read_article_ids:
                query = query.filter(~Article.id.in_(read_article_ids))
            
            # Prefer user's favorite topics
            if topic_preferences:
                preferred_topics = [tp.topic for tp in topic_preferences]
                query = query.filter(Article.topic.in_(preferred_topics))
            
            recommendations = query.order_by(Article.created_at.desc()).limit(limit).all()
            
            # If not enough recommendations, fill with general articles
            if len(recommendations) < limit:
                additional = Article.query.filter(
                    Article.is_published == True,
                    ~Article.id.in_([r.id for r in recommendations] + read_article_ids)
                ).order_by(Article.created_at.desc()).limit(limit - len(recommendations)).all()
                recommendations.extend(additional)
            
            return recommendations
            
        except Exception as e:
            # Fallback to general recommendations
            return Article.query.filter(
                Article.is_published == True
            ).order_by(Article.created_at.desc()).limit(limit).all()
    
    @staticmethod
    def track_word_lookup(user_id: int, reading_session_id: int, word: str, 
                         context_sentence: str, article_position: int) -> WordLookup:
        """
        Track when a user looks up a word during reading
        """
        try:
            # Check if this word lookup already exists for this session
            existing_lookup = WordLookup.query.filter_by(
                user_id=user_id,
                reading_session_id=reading_session_id,
                looked_up_word=word.lower()
            ).first()
            
            if existing_lookup:
                # Increment lookup count
                existing_lookup.lookup_count += 1
                existing_lookup.updated_at = datetime.utcnow()
                db.session.commit()
                return existing_lookup
            
            # Try to find the word in the dictionary
            word_obj = Word.query.filter_by(word=word.lower()).first()
            
            # Create new lookup record
            lookup = WordLookup(
                user_id=user_id,
                reading_session_id=reading_session_id,
                word_id=word_obj.id if word_obj else None,
                looked_up_word=word.lower(),
                context_sentence=context_sentence,
                article_position=article_position,
                lookup_count=1
            )
            
            db.session.add(lookup)
            db.session.commit()
            
            return lookup
            
        except SQLAlchemyError as e:
            db.session.rollback()
            raise e
    
    @staticmethod
    def get_user_difficult_words(user_id: int, limit: int = 20) -> List[Dict[str, Any]]:
        """
        Get words that the user has looked up frequently (indicating difficulty)
        """
        try:
            # Get words with high lookup counts
            difficult_words = db.session.query(
                WordLookup.looked_up_word,
                func.sum(WordLookup.lookup_count).label('total_lookups'),
                func.count(WordLookup.id).label('lookup_sessions')
            ).filter_by(user_id=user_id).group_by(
                WordLookup.looked_up_word
            ).having(
                func.sum(WordLookup.lookup_count) >= 2
            ).order_by(
                func.sum(WordLookup.lookup_count).desc()
            ).limit(limit).all()
            
            result = []
            for word_data in difficult_words:
                word_info = {
                    'word': word_data.looked_up_word,
                    'total_lookups': word_data.total_lookups,
                    'lookup_sessions': word_data.lookup_sessions
                }
                
                # Get word definition if available
                word_obj = Word.query.filter_by(word=word_data.looked_up_word).first()
                if word_obj:
                    word_info['definition'] = word_obj.definition
                    word_info['phonetic'] = word_obj.phonetic
                    word_info['part_of_speech'] = word_obj.part_of_speech
                
                result.append(word_info)
            
            return result
            
        except Exception as e:
            return []
    
    @staticmethod
    def calculate_reading_speed(user_id: int, article_id: int, reading_duration: int, 
                              word_count: int) -> float:
        """
        Calculate reading speed in words per minute
        """
        if reading_duration <= 0 or word_count <= 0:
            return 0.0
        
        # Convert seconds to minutes
        reading_minutes = reading_duration / 60
        wpm = word_count / reading_minutes
        
        return round(wpm, 2)
    
    @staticmethod
    def get_user_reading_statistics(user_id: int, days: int = 30) -> Dict[str, Any]:
        """
        Get comprehensive reading statistics for a user
        """
        try:
            # Get reading sessions from the last N days
            cutoff_date = datetime.utcnow() - timedelta(days=days)
            sessions = ReadingSession.query.filter(
                ReadingSession.user_id == user_id,
                ReadingSession.created_at >= cutoff_date,
                ReadingSession.status == 'completed'
            ).all()
            
            if not sessions:
                return {
                    'total_sessions': 0,
                    'total_articles_read': 0,
                    'total_reading_time': 0,
                    'average_comprehension_score': 0,
                    'average_completion_percentage': 0,
                    'reading_streak': 0,
                    'words_read': 0,
                    'average_reading_speed': 0
                }
            
            # Calculate statistics
            total_sessions = len(sessions)
            total_articles_read = len(set(session.article_id for session in sessions))
            total_reading_time = sum(session.reading_duration or 0 for session in sessions)
            
            comprehension_scores = [s.comprehension_score for s in sessions if s.comprehension_score is not None]
            completion_percentages = [s.completion_percentage for s in sessions if s.completion_percentage is not None]
            
            avg_comprehension = sum(comprehension_scores) / len(comprehension_scores) if comprehension_scores else 0
            avg_completion = sum(completion_percentages) / len(completion_percentages) if completion_percentages else 0
            
            # Calculate total words read
            article_ids = [session.article_id for session in sessions]
            total_words = db.session.query(func.sum(Article.word_count)).filter(
                Article.id.in_(article_ids)
            ).scalar() or 0
            
            # Calculate average reading speed
            speeds = []
            for session in sessions:
                if session.reading_duration and session.reading_duration > 0:
                    article = Article.query.get(session.article_id)
                    if article and article.word_count:
                        speed = ArticleService.calculate_reading_speed(
                            user_id, session.article_id, session.reading_duration, article.word_count
                        )
                        speeds.append(speed)
            
            avg_reading_speed = sum(speeds) / len(speeds) if speeds else 0
            
            # Calculate reading streak (consecutive days with reading)
            reading_streak = ArticleService._calculate_reading_streak(user_id)
            
            return {
                'total_sessions': total_sessions,
                'total_articles_read': total_articles_read,
                'total_reading_time': total_reading_time,
                'average_comprehension_score': round(avg_comprehension, 2),
                'average_completion_percentage': round(avg_completion, 2),
                'reading_streak': reading_streak,
                'words_read': total_words,
                'average_reading_speed': round(avg_reading_speed, 2)
            }
            
        except Exception as e:
            return {
                'total_sessions': 0,
                'total_articles_read': 0,
                'total_reading_time': 0,
                'average_comprehension_score': 0,
                'average_completion_percentage': 0,
                'reading_streak': 0,
                'words_read': 0,
                'average_reading_speed': 0
            }
    
    @staticmethod
    def _calculate_reading_streak(user_id: int) -> int:
        """
        Calculate consecutive days with reading activity
        """
        try:
            # Get dates with reading activity, ordered by date descending
            reading_dates = db.session.query(
                func.date(ReadingSession.created_at).label('reading_date')
            ).filter(
                ReadingSession.user_id == user_id,
                ReadingSession.status == 'completed'
            ).distinct().order_by(
                func.date(ReadingSession.created_at).desc()
            ).all()
            
            if not reading_dates:
                return 0
            
            # Check if user read today or yesterday
            today = datetime.utcnow().date()
            yesterday = today - timedelta(days=1)
            
            reading_dates = [rd.reading_date for rd in reading_dates]
            
            # If no reading today or yesterday, streak is broken
            if reading_dates[0] not in [today, yesterday]:
                return 0
            
            # Count consecutive days
            streak = 0
            current_date = reading_dates[0]
            
            for reading_date in reading_dates:
                if reading_date == current_date:
                    streak += 1
                    current_date = current_date - timedelta(days=1)
                else:
                    break
            
            return streak
            
        except Exception as e:
            return 0