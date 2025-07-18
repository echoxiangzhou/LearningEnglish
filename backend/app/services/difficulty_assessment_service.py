"""
Difficulty Assessment Service for Reading Comprehension Module

This service provides intelligent difficulty assessment using NLP analysis
and creates personalized article recommendations based on user performance.
"""

import logging
from typing import Dict, List, Optional, Tuple
from datetime import datetime, timedelta
# from sqlalchemy.orm import Session
# from sqlalchemy import func, desc, and_, or_

from app.models.article import Article, ReadingSession
from app.models.user import User
from app import db
from app.services.sentence_generation_service import SentenceGenerationService
from app.services.quality_validation_service import QualityValidationService
from app.services.article_service import ArticleService

logger = logging.getLogger(__name__)


class DifficultyAssessmentService:
    """Service for assessing text difficulty and providing personalized recommendations."""
    
    def __init__(self):
        self.sentence_service = SentenceGenerationService()
        self.validation_service = QualityValidationService()
        self.article_service = ArticleService()
        
        # Difficulty thresholds
        self.DIFFICULTY_THRESHOLDS = {
            'very_easy': 1.0,
            'easy': 2.0,
            'medium': 3.0,
            'hard': 4.0,
            'very_hard': 5.0
        }
        
        # Grade level mappings
        self.GRADE_LEVEL_MAP = {
            1: 'very_easy',
            2: 'easy',
            3: 'medium',
            4: 'hard',
            5: 'very_hard',
            6: 'very_hard'
        }
    
    def assess_text_difficulty(self, text: str, title: str = None) -> Dict:
        """
        Comprehensive difficulty assessment using multiple NLP metrics.
        
        Args:
            text: The text content to analyze
            title: Optional title for additional context
            
        Returns:
            Dictionary containing comprehensive difficulty metrics
        """
        try:
            # Basic article analysis using existing service
            article_analysis = self.article_service.calculate_article_difficulty(text)
            
            # Enhanced vocabulary complexity analysis
            vocabulary_metrics = self._analyze_vocabulary_complexity(text)
            
            # Sentence structure complexity
            sentence_metrics = self._analyze_sentence_complexity(text)
            
            # Readability assessment using multiple algorithms
            readability_metrics = self._calculate_comprehensive_readability(text)
            
            # Syntactic complexity analysis
            syntactic_metrics = self._analyze_syntactic_complexity(text)
            
            # Final difficulty score calculation
            final_score = self._calculate_weighted_difficulty_score(
                article_analysis,
                vocabulary_metrics,
                sentence_metrics,
                readability_metrics,
                syntactic_metrics
            )
            
            return {
                'difficulty_score': final_score,
                'difficulty_level': self._score_to_level(final_score),
                'recommended_grade': self._score_to_grade(final_score),
                'confidence': self._calculate_confidence(
                    article_analysis,
                    vocabulary_metrics,
                    sentence_metrics,
                    readability_metrics
                ),
                'metrics': {
                    'article_analysis': article_analysis,
                    'vocabulary': vocabulary_metrics,
                    'sentence_structure': sentence_metrics,
                    'readability': readability_metrics,
                    'syntactic': syntactic_metrics
                },
                'recommendations': self._generate_difficulty_recommendations(final_score),
                'assessment_timestamp': datetime.utcnow().isoformat()
            }
            
        except Exception as e:
            logger.error(f"Error assessing text difficulty: {str(e)}")
            raise
    
    def _analyze_vocabulary_complexity(self, text: str) -> Dict:
        """Analyze vocabulary complexity using spaCy word analysis."""
        try:
            # Split text into words for analysis
            words = text.split()
            analyzed_words = []
            
            # Sample analysis for performance (max 200 words)
            sample_words = words[:200] if len(words) > 200 else words
            
            for word in sample_words:
                # Clean word (remove punctuation)
                clean_word = word.strip('.,!?;:"()[]{}').lower()
                if clean_word and len(clean_word) > 2:
                    word_analysis = self.sentence_service.analyze_word(clean_word)
                    if word_analysis:
                        analyzed_words.append(word_analysis)
            
            if not analyzed_words:
                return {'complexity_score': 2.5, 'analysis_count': 0}
            
            # Calculate vocabulary metrics
            complex_words = len([w for w in analyzed_words if w.get('syllable_count', 0) > 3])
            avg_syllables = sum(w.get('syllable_count', 0) for w in analyzed_words) / len(analyzed_words)
            
            # POS distribution analysis
            pos_counts = {}
            for word in analyzed_words:
                pos = word.get('pos', 'UNKNOWN')
                pos_counts[pos] = pos_counts.get(pos, 0) + 1
            
            # Calculate complexity score based on multiple factors
            complexity_score = self._calculate_vocabulary_complexity_score(
                complex_words / len(analyzed_words),
                avg_syllables,
                pos_counts,
                len(analyzed_words)
            )
            
            return {
                'complexity_score': complexity_score,
                'complex_word_ratio': complex_words / len(analyzed_words),
                'avg_syllables': avg_syllables,
                'pos_distribution': pos_counts,
                'analysis_count': len(analyzed_words),
                'sample_size': len(sample_words)
            }
            
        except Exception as e:
            logger.error(f"Error analyzing vocabulary complexity: {str(e)}")
            return {'complexity_score': 2.5, 'analysis_count': 0}
    
    def _analyze_sentence_complexity(self, text: str) -> Dict:
        """Analyze sentence structure complexity."""
        try:
            sentences = text.split('.')
            sentences = [s.strip() for s in sentences if s.strip()]
            
            if not sentences:
                return {'complexity_score': 2.5, 'sentence_count': 0}
            
            # Calculate sentence length metrics
            sentence_lengths = [len(s.split()) for s in sentences]
            avg_sentence_length = sum(sentence_lengths) / len(sentence_lengths)
            max_sentence_length = max(sentence_lengths)
            
            # Count complex sentence indicators
            complex_indicators = 0
            for sentence in sentences:
                # Count subordinating conjunctions and relative pronouns
                complex_words = ['because', 'although', 'since', 'while', 'whereas', 
                               'which', 'that', 'who', 'whom', 'whose', 'when', 'where']
                for word in complex_words:
                    if word in sentence.lower():
                        complex_indicators += 1
            
            # Calculate complexity score
            complexity_score = min(5.0, (
                (avg_sentence_length / 10) +  # Longer sentences = more complex
                (complex_indicators / len(sentences)) +  # More complex structures
                (max_sentence_length / 30)  # Very long sentences increase complexity
            ))
            
            return {
                'complexity_score': complexity_score,
                'avg_sentence_length': avg_sentence_length,
                'max_sentence_length': max_sentence_length,
                'sentence_count': len(sentences),
                'complex_structure_ratio': complex_indicators / len(sentences)
            }
            
        except Exception as e:
            logger.error(f"Error analyzing sentence complexity: {str(e)}")
            return {'complexity_score': 2.5, 'sentence_count': 0}
    
    def _calculate_comprehensive_readability(self, text: str) -> Dict:
        """Calculate readability using multiple algorithms."""
        try:
            # Use existing readability from quality validation service
            readability_scores = {}
            
            # Test with different difficulty levels to get range
            for level in ['elementary', 'intermediate', 'advanced']:
                score = self.validation_service.calculate_readability_score(text, level)
                readability_scores[level] = score
            
            # Calculate average and variance
            scores = list(readability_scores.values())
            avg_readability = sum(scores) / len(scores)
            readability_variance = sum((score - avg_readability) ** 2 for score in scores) / len(scores)
            
            return {
                'avg_readability': avg_readability,
                'readability_variance': readability_variance,
                'level_scores': readability_scores,
                'overall_score': avg_readability
            }
            
        except Exception as e:
            logger.error(f"Error calculating readability: {str(e)}")
            return {'avg_readability': 2.5, 'overall_score': 2.5}
    
    def _analyze_syntactic_complexity(self, text: str) -> Dict:
        """Analyze syntactic complexity using linguistic features."""
        try:
            # Basic syntactic analysis
            word_count = len(text.split())
            sentence_count = len([s for s in text.split('.') if s.strip()])
            
            # Calculate type-token ratio (vocabulary diversity)
            words = text.lower().split()
            unique_words = set(words)
            type_token_ratio = len(unique_words) / len(words) if words else 0
            
            # Count passive voice indicators
            passive_indicators = ['was', 'were', 'been', 'being', 'is', 'are']
            passive_count = sum(1 for word in words if word in passive_indicators)
            passive_ratio = passive_count / len(words) if words else 0
            
            # Calculate syntactic complexity score
            complexity_score = min(5.0, (
                (word_count / 200) +  # Longer texts can be more complex
                (type_token_ratio * 2) +  # Higher diversity = more complex
                (passive_ratio * 3)  # More passive constructions = more complex
            ))
            
            return {
                'complexity_score': complexity_score,
                'type_token_ratio': type_token_ratio,
                'passive_voice_ratio': passive_ratio,
                'syntactic_diversity': type_token_ratio,
                'word_count': word_count,
                'sentence_count': sentence_count
            }
            
        except Exception as e:
            logger.error(f"Error analyzing syntactic complexity: {str(e)}")
            return {'complexity_score': 2.5}
    
    def _calculate_vocabulary_complexity_score(self, complex_ratio: float, 
                                             avg_syllables: float, 
                                             pos_counts: Dict, 
                                             word_count: int) -> float:
        """Calculate vocabulary complexity score from various metrics."""
        try:
            # Base score from complex word ratio
            base_score = complex_ratio * 3
            
            # Syllable complexity
            syllable_score = min(2.0, (avg_syllables - 1) / 2)
            
            # POS diversity (more diverse = more complex)
            pos_diversity = len(pos_counts) / 10  # Normalize to 0-1 range
            
            # Combine scores with weights
            final_score = (base_score * 0.4) + (syllable_score * 0.4) + (pos_diversity * 0.2)
            
            return min(5.0, max(1.0, final_score))
            
        except Exception as e:
            logger.error(f"Error calculating vocabulary complexity score: {str(e)}")
            return 2.5
    
    def _calculate_weighted_difficulty_score(self, article_analysis: Dict,
                                           vocabulary_metrics: Dict,
                                           sentence_metrics: Dict,
                                           readability_metrics: Dict,
                                           syntactic_metrics: Dict) -> float:
        """Calculate final weighted difficulty score."""
        try:
            # Extract individual scores
            article_score = article_analysis.get('difficulty_score', 2.5)
            vocab_score = vocabulary_metrics.get('complexity_score', 2.5)
            sentence_score = sentence_metrics.get('complexity_score', 2.5)
            readability_score = readability_metrics.get('overall_score', 2.5)
            syntactic_score = syntactic_metrics.get('complexity_score', 2.5)
            
            # Weighted combination
            weights = {
                'article': 0.3,
                'vocabulary': 0.25,
                'sentence': 0.2,
                'readability': 0.15,
                'syntactic': 0.1
            }
            
            final_score = (
                (article_score * weights['article']) +
                (vocab_score * weights['vocabulary']) +
                (sentence_score * weights['sentence']) +
                (readability_score * weights['readability']) +
                (syntactic_score * weights['syntactic'])
            )
            
            return min(5.0, max(1.0, final_score))
            
        except Exception as e:
            logger.error(f"Error calculating weighted difficulty score: {str(e)}")
            return 2.5
    
    def _calculate_confidence(self, article_analysis: Dict,
                            vocabulary_metrics: Dict,
                            sentence_metrics: Dict,
                            readability_metrics: Dict) -> float:
        """Calculate confidence score for the difficulty assessment."""
        try:
            # Base confidence on amount of data analyzed
            vocab_confidence = min(1.0, vocabulary_metrics.get('analysis_count', 0) / 100)
            sentence_confidence = min(1.0, sentence_metrics.get('sentence_count', 0) / 20)
            
            # Readability variance affects confidence
            readability_variance = readability_metrics.get('readability_variance', 1.0)
            variance_confidence = max(0.1, 1.0 - (readability_variance / 2))
            
            # Overall confidence
            confidence = (vocab_confidence + sentence_confidence + variance_confidence) / 3
            
            return min(1.0, max(0.1, confidence))
            
        except Exception as e:
            logger.error(f"Error calculating confidence: {str(e)}")
            return 0.5
    
    def _score_to_level(self, score: float) -> str:
        """Convert difficulty score to level name."""
        if score <= 1.5:
            return 'very_easy'
        elif score <= 2.5:
            return 'easy'
        elif score <= 3.5:
            return 'medium'
        elif score <= 4.5:
            return 'hard'
        else:
            return 'very_hard'
    
    def _score_to_grade(self, score: float) -> int:
        """Convert difficulty score to recommended grade level."""
        if score <= 1.5:
            return 1
        elif score <= 2.5:
            return 2
        elif score <= 3.5:
            return 3
        elif score <= 4.5:
            return 4
        else:
            return 5
    
    def _generate_difficulty_recommendations(self, score: float) -> List[str]:
        """Generate recommendations based on difficulty score."""
        recommendations = []
        
        if score <= 2.0:
            recommendations.extend([
                "This text is suitable for beginners",
                "Good for building basic reading confidence",
                "Ideal for vocabulary development"
            ])
        elif score <= 3.0:
            recommendations.extend([
                "Appropriate for intermediate readers",
                "Good for expanding vocabulary",
                "Suitable for developing reading comprehension skills"
            ])
        elif score <= 4.0:
            recommendations.extend([
                "Challenging for intermediate readers",
                "Good for advanced vocabulary building",
                "Helps develop complex reading skills"
            ])
        else:
            recommendations.extend([
                "Advanced reading material",
                "Suitable for experienced readers",
                "Excellent for academic preparation"
            ])
        
        return recommendations
    
    def get_personalized_recommendations(self, user_id: int, limit: int = 10) -> List[Dict]:
        """
        Get personalized article recommendations based on user performance.
        
        Args:
            user_id: User ID for personalization
            limit: Number of recommendations to return
            
        Returns:
            List of recommended articles with scores
        """
        try:
            session = db.session
            
            # Get user's reading history and performance
            user_performance = self._analyze_user_performance(user_id, session)
            
            # Get available articles
            articles = session.query(Article).filter(Article.is_active == True).all()
            
            # Score articles based on user performance
            scored_articles = []
            for article in articles:
                # Skip articles already read recently
                if self._recently_read(user_id, article.id, session):
                    continue
                
                score = self._calculate_recommendation_score(article, user_performance)
                scored_articles.append({
                    'article': article,
                    'score': score,
                    'reasons': self._generate_recommendation_reasons(article, user_performance)
                })
            
            # Sort by score and return top recommendations
            scored_articles.sort(key=lambda x: x['score'], reverse=True)
            
            recommendations = []
            for item in scored_articles[:limit]:
                article = item['article']
                recommendations.append({
                    'id': article.id,
                    'title': article.title,
                    'difficulty_level': article.difficulty_level,
                    'word_count': article.word_count,
                    'reading_time': article.reading_time,
                    'category': article.category,
                    'recommendation_score': item['score'],
                    'reasons': item['reasons'],
                    'tags': article.tags
                })
            
            return recommendations
            
        except Exception as e:
            logger.error(f"Error getting personalized recommendations: {str(e)}")
            return []
    
    def _analyze_user_performance(self, user_id: int, db) -> Dict:
        """Analyze user's reading performance and preferences."""
        try:
            # Get recent reading sessions
            recent_sessions = db.query(ReadingSession).filter(
                ReadingSession.user_id == user_id,
                ReadingSession.start_time >= datetime.utcnow() - timedelta(days=30)
            ).order_by(desc(ReadingSession.start_time)).limit(20).all()
            
            if not recent_sessions:
                return self._get_default_user_performance()
            
            # Calculate performance metrics
            avg_comprehension = sum(s.comprehension_score or 0 for s in recent_sessions) / len(recent_sessions)
            avg_reading_speed = sum(s.reading_speed or 0 for s in recent_sessions) / len(recent_sessions)
            
            # Analyze difficulty preferences
            difficulty_history = {}
            for session in recent_sessions:
                if session.article:
                    difficulty = session.article.difficulty_level
                    difficulty_history[difficulty] = difficulty_history.get(difficulty, 0) + 1
            
            # Find preferred difficulty
            preferred_difficulty = max(difficulty_history.keys(), 
                                     key=difficulty_history.get) if difficulty_history else 3
            
            # Calculate trend (improving/declining)
            performance_trend = self._calculate_performance_trend(recent_sessions)
            
            # Category preferences
            category_preferences = self._analyze_category_preferences(user_id, db)
            
            return {
                'avg_comprehension': avg_comprehension,
                'avg_reading_speed': avg_reading_speed,
                'preferred_difficulty': preferred_difficulty,
                'performance_trend': performance_trend,
                'category_preferences': category_preferences,
                'session_count': len(recent_sessions),
                'consistency_score': self._calculate_consistency_score(recent_sessions)
            }
            
        except Exception as e:
            logger.error(f"Error analyzing user performance: {str(e)}")
            return self._get_default_user_performance()
    
    def _get_default_user_performance(self) -> Dict:
        """Get default performance metrics for new users."""
        return {
            'avg_comprehension': 0.7,
            'avg_reading_speed': 150,
            'preferred_difficulty': 2,
            'performance_trend': 0.0,
            'category_preferences': {},
            'session_count': 0,
            'consistency_score': 0.5
        }
    
    def _calculate_performance_trend(self, sessions: List[ReadingSession]) -> float:
        """Calculate if user performance is improving or declining."""
        try:
            if len(sessions) < 2:
                return 0.0
            
            # Split sessions into two halves
            mid_point = len(sessions) // 2
            recent_half = sessions[:mid_point]
            older_half = sessions[mid_point:]
            
            # Calculate average comprehension for each half
            recent_avg = sum(s.comprehension_score or 0 for s in recent_half) / len(recent_half)
            older_avg = sum(s.comprehension_score or 0 for s in older_half) / len(older_half)
            
            # Return trend (-1 to 1)
            return (recent_avg - older_avg) / 100
            
        except Exception as e:
            logger.error(f"Error calculating performance trend: {str(e)}")
            return 0.0
    
    def _analyze_category_preferences(self, user_id: int, db) -> Dict:
        """Analyze user's category preferences based on reading history."""
        try:
            # Get category engagement data
            category_query = db.query(
                Article.category,
                func.count(ReadingSession.id).label('session_count'),
                func.avg(ReadingSession.comprehension_score).label('avg_comprehension')
            ).join(
                ReadingSession, Article.id == ReadingSession.article_id
            ).filter(
                ReadingSession.user_id == user_id,
                ReadingSession.start_time >= datetime.utcnow() - timedelta(days=60)
            ).group_by(Article.category).all()
            
            preferences = {}
            for category, count, avg_comp in category_query:
                preferences[category] = {
                    'engagement_score': count,
                    'performance_score': avg_comp or 0,
                    'preference_score': (count * 0.6) + ((avg_comp or 0) * 0.4)
                }
            
            return preferences
            
        except Exception as e:
            logger.error(f"Error analyzing category preferences: {str(e)}")
            return {}
    
    def _calculate_consistency_score(self, sessions: List[ReadingSession]) -> float:
        """Calculate user's reading consistency score."""
        try:
            if len(sessions) < 2:
                return 0.5
            
            # Calculate standard deviation of comprehension scores
            scores = [s.comprehension_score or 0 for s in sessions]
            mean_score = sum(scores) / len(scores)
            variance = sum((score - mean_score) ** 2 for score in scores) / len(scores)
            std_dev = variance ** 0.5
            
            # Convert to consistency score (lower std_dev = higher consistency)
            consistency = max(0.1, 1.0 - (std_dev / 50))
            
            return min(1.0, consistency)
            
        except Exception as e:
            logger.error(f"Error calculating consistency score: {str(e)}")
            return 0.5
    
    def _recently_read(self, user_id: int, article_id: int, db) -> bool:
        """Check if user has read this article recently."""
        try:
            recent_session = db.query(ReadingSession).filter(
                ReadingSession.user_id == user_id,
                ReadingSession.article_id == article_id,
                ReadingSession.start_time >= datetime.utcnow() - timedelta(days=7)
            ).first()
            
            return recent_session is not None
            
        except Exception as e:
            logger.error(f"Error checking recent reads: {str(e)}")
            return False
    
    def _calculate_recommendation_score(self, article: Article, user_performance: Dict) -> float:
        """Calculate recommendation score for an article based on user performance."""
        try:
            score = 0.0
            
            # Difficulty matching (prefer articles slightly above user's level)
            user_level = user_performance['preferred_difficulty']
            article_level = article.difficulty_level
            
            if article_level == user_level:
                score += 30  # Perfect match
            elif article_level == user_level + 1:
                score += 25  # Slightly challenging
            elif article_level == user_level - 1:
                score += 20  # Slightly easier
            else:
                score += max(0, 15 - abs(article_level - user_level) * 5)
            
            # Performance trend adjustment
            trend = user_performance['performance_trend']
            if trend > 0.1:  # Improving
                if article_level > user_level:
                    score += 10  # Reward with harder content
            elif trend < -0.1:  # Declining
                if article_level < user_level:
                    score += 10  # Suggest easier content
            
            # Category preference boost
            category_prefs = user_performance.get('category_preferences', {})
            if article.category in category_prefs:
                pref_score = category_prefs[article.category]['preference_score']
                score += min(20, pref_score * 2)
            
            # Reading time consideration
            if article.reading_time:
                if 5 <= article.reading_time <= 15:  # Sweet spot
                    score += 5
                elif article.reading_time > 20:  # Long articles
                    score -= 5
            
            # Boost for appropriate word count
            if article.word_count:
                if 200 <= article.word_count <= 800:  # Ideal range
                    score += 5
            
            return max(0, score)
            
        except Exception as e:
            logger.error(f"Error calculating recommendation score: {str(e)}")
            return 0.0
    
    def _generate_recommendation_reasons(self, article: Article, user_performance: Dict) -> List[str]:
        """Generate reasons why this article is recommended."""
        reasons = []
        
        user_level = user_performance['preferred_difficulty']
        article_level = article.difficulty_level
        
        if article_level == user_level:
            reasons.append("Matches your current reading level")
        elif article_level == user_level + 1:
            reasons.append("Slightly challenging to help you improve")
        elif article_level == user_level - 1:
            reasons.append("Good for building confidence")
        
        # Category reasons
        category_prefs = user_performance.get('category_preferences', {})
        if article.category in category_prefs:
            reasons.append(f"You perform well in {article.category} topics")
        
        # Reading time
        if article.reading_time and 5 <= article.reading_time <= 15:
            reasons.append("Perfect length for focused reading")
        
        # Performance trend
        trend = user_performance['performance_trend']
        if trend > 0.1 and article_level > user_level:
            reasons.append("You're improving - time for a challenge!")
        elif trend < -0.1 and article_level < user_level:
            reasons.append("Build confidence with this level")
        
        return reasons[:3]  # Return top 3 reasons