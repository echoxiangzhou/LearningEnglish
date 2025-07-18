"""
Recommendation Service for Reading Comprehension Module

This service provides personalized article recommendations based on user performance,
reading history, and intelligent content matching algorithms.
"""

import logging
from typing import Dict, List, Optional, Tuple
from datetime import datetime, timedelta
# from sqlalchemy.orm import Session  
# from sqlalchemy import func, desc, and_, or_, text
from collections import defaultdict
import json

from app.models.article import Article
from app.models.article import ReadingSession
from app.models.user import User
from app import db
from app.services.difficulty_assessment_service import DifficultyAssessmentService

logger = logging.getLogger(__name__)


class RecommendationService:
    """Service for generating personalized reading recommendations."""
    
    def __init__(self):
        self.difficulty_service = DifficultyAssessmentService()
        
        # Recommendation weights
        self.WEIGHTS = {
            'difficulty_match': 0.3,
            'performance_trend': 0.2,
            'category_preference': 0.2,
            'reading_time': 0.1,
            'novelty': 0.1,
            'engagement': 0.1
        }
        
        # Recommendation categories
        self.RECOMMENDATION_TYPES = {
            'challenge': 'Articles to challenge and improve your skills',
            'comfort': 'Articles at your comfortable reading level',
            'review': 'Articles to reinforce your current skills',
            'explore': 'New topics to expand your interests',
            'trending': 'Popular articles among similar readers'
        }
    
    def get_comprehensive_recommendations(self, user_id: int, limit: int = 20) -> Dict:
        """
        Get comprehensive recommendations with multiple categories.
        
        Args:
            user_id: User ID for personalization
            limit: Total number of recommendations
            
        Returns:
            Dictionary with categorized recommendations
        """
        try:
            db = next(get_db())
            
            # Get user performance analysis
            user_performance = self.difficulty_service._analyze_user_performance(user_id, db)
            
            # Generate different types of recommendations
            recommendations = {
                'challenge': self._get_challenge_recommendations(user_id, user_performance, db, limit // 4),
                'comfort': self._get_comfort_recommendations(user_id, user_performance, db, limit // 4),
                'explore': self._get_exploration_recommendations(user_id, user_performance, db, limit // 4),
                'trending': self._get_trending_recommendations(user_id, user_performance, db, limit // 4),
                'user_profile': self._get_user_profile_summary(user_performance),
                'recommendation_stats': self._get_recommendation_stats(user_id, db)
            }
            
            return recommendations
            
        except Exception as e:
            logger.error(f"Error getting comprehensive recommendations: {str(e)}")
            return self._get_fallback_recommendations(user_id)
    
    def _get_challenge_recommendations(self, user_id: int, user_performance: Dict, 
                                     db, limit: int) -> List[Dict]:
        """Get challenging articles to help user improve."""
        try:
            user_level = user_performance['preferred_difficulty']
            target_level = min(5, user_level + 1)
            
            # Get articles slightly above user's level
            articles = db.query(Article).filter(
                Article.difficulty_level == target_level,
                Article.is_active == True
            ).order_by(desc(Article.created_at)).limit(limit * 2).all()
            
            # Filter out recently read articles
            filtered_articles = []
            for article in articles:
                if not self.difficulty_service._recently_read(user_id, article.id, db):
                    filtered_articles.append(article)
            
            # Score and sort
            scored_articles = []
            for article in filtered_articles[:limit]:
                score = self._calculate_challenge_score(article, user_performance)
                scored_articles.append({
                    'article': article,
                    'score': score,
                    'type': 'challenge'
                })
            
            scored_articles.sort(key=lambda x: x['score'], reverse=True)
            
            return self._format_recommendations(scored_articles[:limit], 'challenge')
            
        except Exception as e:
            logger.error(f"Error getting challenge recommendations: {str(e)}")
            return []
    
    def _get_comfort_recommendations(self, user_id: int, user_performance: Dict, 
                                   db, limit: int) -> List[Dict]:
        """Get articles at user's comfort level."""
        try:
            user_level = user_performance['preferred_difficulty']
            
            # Get articles at user's current level
            articles = db.query(Article).filter(
                Article.difficulty_level == user_level,
                Article.is_active == True
            ).order_by(desc(Article.created_at)).limit(limit * 2).all()
            
            # Filter based on category preferences
            category_prefs = user_performance.get('category_preferences', {})
            preferred_categories = [cat for cat, data in category_prefs.items() 
                                  if data['preference_score'] > 2.0]
            
            comfort_articles = []
            for article in articles:
                if not self.difficulty_service._recently_read(user_id, article.id, db):
                    if not preferred_categories or article.category in preferred_categories:
                        comfort_articles.append(article)
            
            # Score and sort
            scored_articles = []
            for article in comfort_articles[:limit]:
                score = self._calculate_comfort_score(article, user_performance)
                scored_articles.append({
                    'article': article,
                    'score': score,
                    'type': 'comfort'
                })
            
            scored_articles.sort(key=lambda x: x['score'], reverse=True)
            
            return self._format_recommendations(scored_articles[:limit], 'comfort')
            
        except Exception as e:
            logger.error(f"Error getting comfort recommendations: {str(e)}")
            return []
    
    def _get_exploration_recommendations(self, user_id: int, user_performance: Dict, 
                                       db, limit: int) -> List[Dict]:
        """Get articles in new categories to explore."""
        try:
            # Get user's read categories
            read_categories = db.query(Article.category).join(
                ReadingSession, Article.id == ReadingSession.article_id
            ).filter(ReadingSession.user_id == user_id).distinct().all()
            
            read_categories = [cat[0] for cat in read_categories]
            
            # Get articles in unread categories
            user_level = user_performance['preferred_difficulty']
            level_range = [max(1, user_level - 1), min(5, user_level + 1)]
            
            articles = db.query(Article).filter(
                Article.difficulty_level.in_(level_range),
                Article.is_active == True
            ).order_by(desc(Article.created_at)).limit(limit * 3).all()
            
            # Filter for new categories
            exploration_articles = []
            for article in articles:
                if (article.category not in read_categories and 
                    not self.difficulty_service._recently_read(user_id, article.id, db)):
                    exploration_articles.append(article)
            
            # Score and sort
            scored_articles = []
            for article in exploration_articles[:limit]:
                score = self._calculate_exploration_score(article, user_performance)
                scored_articles.append({
                    'article': article,
                    'score': score,
                    'type': 'explore'
                })
            
            scored_articles.sort(key=lambda x: x['score'], reverse=True)
            
            return self._format_recommendations(scored_articles[:limit], 'explore')
            
        except Exception as e:
            logger.error(f"Error getting exploration recommendations: {str(e)}")
            return []
    
    def _get_trending_recommendations(self, user_id: int, user_performance: Dict, 
                                    db, limit: int) -> List[Dict]:
        """Get trending articles based on community engagement."""
        try:
            # Get articles with high recent engagement
            trending_query = db.query(
                Article.id,
                Article.title,
                Article.difficulty_level,
                Article.category,
                func.count(ReadingSession.id).label('session_count'),
                func.avg(ReadingSession.comprehension_score).label('avg_score')
            ).join(
                ReadingSession, Article.id == ReadingSession.article_id
            ).filter(
                ReadingSession.start_time >= datetime.utcnow() - timedelta(days=7),
                Article.is_active == True
            ).group_by(
                Article.id, Article.title, Article.difficulty_level, Article.category
            ).having(
                func.count(ReadingSession.id) > 2  # At least 3 sessions
            ).order_by(
                desc(func.count(ReadingSession.id))
            ).limit(limit * 2).all()
            
            # Get full article objects
            trending_ids = [item.id for item in trending_query]
            articles = db.query(Article).filter(Article.id.in_(trending_ids)).all()
            
            # Filter and score
            scored_articles = []
            for article in articles:
                if not self.difficulty_service._recently_read(user_id, article.id, db):
                    score = self._calculate_trending_score(article, user_performance)
                    scored_articles.append({
                        'article': article,
                        'score': score,
                        'type': 'trending'
                    })
            
            scored_articles.sort(key=lambda x: x['score'], reverse=True)
            
            return self._format_recommendations(scored_articles[:limit], 'trending')
            
        except Exception as e:
            logger.error(f"Error getting trending recommendations: {str(e)}")
            return []
    
    def _calculate_challenge_score(self, article: Article, user_performance: Dict) -> float:
        """Calculate score for challenge recommendations."""
        try:
            score = 50  # Base score
            
            # Difficulty appropriateness
            user_level = user_performance['preferred_difficulty']
            if article.difficulty_level == user_level + 1:
                score += 30
            elif article.difficulty_level == user_level + 2:
                score += 15
            
            # Performance trend bonus
            if user_performance['performance_trend'] > 0.1:
                score += 20  # User is improving
            
            # Reading time preference
            if article.reading_time and 10 <= article.reading_time <= 20:
                score += 10
            
            # Consistency bonus
            if user_performance['consistency_score'] > 0.7:
                score += 15  # Consistent readers get harder challenges
            
            return score
            
        except Exception as e:
            logger.error(f"Error calculating challenge score: {str(e)}")
            return 0.0
    
    def _calculate_comfort_score(self, article: Article, user_performance: Dict) -> float:
        """Calculate score for comfort recommendations."""
        try:
            score = 50  # Base score
            
            # Category preference boost
            category_prefs = user_performance.get('category_preferences', {})
            if article.category in category_prefs:
                pref_score = category_prefs[article.category]['preference_score']
                score += min(30, pref_score * 5)
            
            # Reading time preference
            if article.reading_time and 5 <= article.reading_time <= 15:
                score += 15
            
            # Performance stability
            if user_performance['consistency_score'] > 0.6:
                score += 10
            
            return score
            
        except Exception as e:
            logger.error(f"Error calculating comfort score: {str(e)}")
            return 0.0
    
    def _calculate_exploration_score(self, article: Article, user_performance: Dict) -> float:
        """Calculate score for exploration recommendations."""
        try:
            score = 50  # Base score
            
            # Difficulty appropriateness (slightly easier for exploration)
            user_level = user_performance['preferred_difficulty']
            if article.difficulty_level == user_level:
                score += 25
            elif article.difficulty_level == user_level - 1:
                score += 20
            
            # Reading time (shorter for exploration)
            if article.reading_time and 5 <= article.reading_time <= 12:
                score += 20
            
            # Novelty bonus
            score += 15  # Always bonus for new categories
            
            return score
            
        except Exception as e:
            logger.error(f"Error calculating exploration score: {str(e)}")
            return 0.0
    
    def _calculate_trending_score(self, article: Article, user_performance: Dict) -> float:
        """Calculate score for trending recommendations."""
        try:
            score = 50  # Base score
            
            # Difficulty match
            user_level = user_performance['preferred_difficulty']
            difficulty_diff = abs(article.difficulty_level - user_level)
            score += max(0, 25 - (difficulty_diff * 5))
            
            # Community engagement bonus
            score += 20  # Already trending
            
            # Reading time
            if article.reading_time and 8 <= article.reading_time <= 18:
                score += 10
            
            return score
            
        except Exception as e:
            logger.error(f"Error calculating trending score: {str(e)}")
            return 0.0
    
    def _format_recommendations(self, scored_articles: List[Dict], recommendation_type: str) -> List[Dict]:
        """Format recommendations for API response."""
        formatted = []
        
        for item in scored_articles:
            article = item['article']
            formatted.append({
                'id': article.id,
                'title': article.title,
                'difficulty_level': article.difficulty_level,
                'word_count': article.word_count,
                'reading_time': article.reading_time,
                'category': article.category,
                'tags': article.tags,
                'recommendation_score': item['score'],
                'recommendation_type': recommendation_type,
                'reason': self._get_recommendation_reason(recommendation_type, article),
                'created_at': article.created_at.isoformat() if article.created_at else None
            })
        
        return formatted
    
    def _get_recommendation_reason(self, rec_type: str, article: Article) -> str:
        """Get reason for recommendation."""
        reasons = {
            'challenge': f"Challenge yourself with this level {article.difficulty_level} article",
            'comfort': f"Perfect for your current reading level in {article.category}",
            'explore': f"Discover new topics in {article.category}",
            'trending': f"Popular choice among readers - {article.reading_time} min read"
        }
        
        return reasons.get(rec_type, "Recommended based on your reading pattern")
    
    def _get_user_profile_summary(self, user_performance: Dict) -> Dict:
        """Get user profile summary for recommendations."""
        return {
            'reading_level': user_performance['preferred_difficulty'],
            'avg_comprehension': user_performance['avg_comprehension'],
            'avg_reading_speed': user_performance['avg_reading_speed'],
            'performance_trend': user_performance['performance_trend'],
            'consistency_score': user_performance['consistency_score'],
            'total_sessions': user_performance['session_count'],
            'top_categories': list(user_performance.get('category_preferences', {}).keys())[:3]
        }
    
    def _get_recommendation_stats(self, user_id: int, db) -> Dict:
        """Get recommendation statistics."""
        try:
            # Get total articles available
            total_articles = db.query(Article).filter(Article.is_active == True).count()
            
            # Get articles read by user
            read_articles = db.query(ReadingSession).filter(
                ReadingSession.user_id == user_id
            ).distinct(ReadingSession.article_id).count()
            
            # Get categories explored
            categories_explored = db.query(Article.category).join(
                ReadingSession, Article.id == ReadingSession.article_id
            ).filter(ReadingSession.user_id == user_id).distinct().count()
            
            return {
                'total_articles': total_articles,
                'articles_read': read_articles,
                'completion_percentage': (read_articles / total_articles * 100) if total_articles > 0 else 0,
                'categories_explored': categories_explored,
                'recommendations_generated': datetime.utcnow().isoformat()
            }
            
        except Exception as e:
            logger.error(f"Error getting recommendation stats: {str(e)}")
            return {}
    
    def _get_fallback_recommendations(self, user_id: int) -> Dict:
        """Get fallback recommendations if main algorithm fails."""
        try:
            db = next(get_db())
            
            # Get recent articles
            recent_articles = db.query(Article).filter(
                Article.is_active == True
            ).order_by(desc(Article.created_at)).limit(10).all()
            
            fallback_recs = []
            for article in recent_articles:
                fallback_recs.append({
                    'id': article.id,
                    'title': article.title,
                    'difficulty_level': article.difficulty_level,
                    'word_count': article.word_count,
                    'reading_time': article.reading_time,
                    'category': article.category,
                    'tags': article.tags,
                    'recommendation_score': 50,
                    'recommendation_type': 'fallback',
                    'reason': 'Recent article - good for getting started'
                })
            
            return {
                'challenge': fallback_recs[:3],
                'comfort': fallback_recs[3:6],
                'explore': fallback_recs[6:8],
                'trending': fallback_recs[8:10],
                'user_profile': {
                    'reading_level': 2,
                    'avg_comprehension': 0.0,
                    'avg_reading_speed': 0.0,
                    'performance_trend': 0.0,
                    'consistency_score': 0.0,
                    'total_sessions': 0,
                    'top_categories': []
                },
                'recommendation_stats': {
                    'total_articles': len(recent_articles),
                    'articles_read': 0,
                    'completion_percentage': 0,
                    'categories_explored': 0,
                    'recommendations_generated': datetime.utcnow().isoformat()
                }
            }
            
        except Exception as e:
            logger.error(f"Error getting fallback recommendations: {str(e)}")
            return {}
    
    def get_similar_articles(self, article_id: int, limit: int = 5) -> List[Dict]:
        """Get articles similar to the given article."""
        try:
            db = next(get_db())
            
            # Get the reference article
            ref_article = db.query(Article).filter(Article.id == article_id).first()
            if not ref_article:
                return []
            
            # Find similar articles based on multiple factors
            similar_articles = db.query(Article).filter(
                Article.id != article_id,
                Article.is_active == True,
                or_(
                    Article.category == ref_article.category,  # Same category
                    Article.difficulty_level == ref_article.difficulty_level,  # Same difficulty
                    and_(
                        Article.word_count >= ref_article.word_count * 0.8,
                        Article.word_count <= ref_article.word_count * 1.2
                    )  # Similar length
                )
            ).limit(limit * 2).all()
            
            # Score similarity
            scored_articles = []
            for article in similar_articles:
                score = self._calculate_similarity_score(ref_article, article)
                scored_articles.append({
                    'article': article,
                    'score': score
                })
            
            # Sort and format
            scored_articles.sort(key=lambda x: x['score'], reverse=True)
            
            return self._format_recommendations(scored_articles[:limit], 'similar')
            
        except Exception as e:
            logger.error(f"Error getting similar articles: {str(e)}")
            return []
    
    def _calculate_similarity_score(self, ref_article: Article, article: Article) -> float:
        """Calculate similarity score between two articles."""
        try:
            score = 0
            
            # Category match
            if article.category == ref_article.category:
                score += 40
            
            # Difficulty match
            if article.difficulty_level == ref_article.difficulty_level:
                score += 30
            elif abs(article.difficulty_level - ref_article.difficulty_level) == 1:
                score += 20
            
            # Word count similarity
            if ref_article.word_count and article.word_count:
                ratio = min(article.word_count, ref_article.word_count) / max(article.word_count, ref_article.word_count)
                score += ratio * 20
            
            # Reading time similarity
            if ref_article.reading_time and article.reading_time:
                time_diff = abs(article.reading_time - ref_article.reading_time)
                if time_diff <= 2:
                    score += 10
                elif time_diff <= 5:
                    score += 5
            
            return score
            
        except Exception as e:
            logger.error(f"Error calculating similarity score: {str(e)}")
            return 0.0