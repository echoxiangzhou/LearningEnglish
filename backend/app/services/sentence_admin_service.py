"""
Sentence Administration Service

Provides administrative functionality for managing generated sentences,
patterns, and approval workflows.
"""

from typing import List, Dict, Optional, Tuple
from datetime import datetime, timedelta
from sqlalchemy import and_, or_, func
from sqlalchemy.orm import joinedload
import logging

from .. import db
from ..models.generated_sentence import (
    GeneratedSentence, SentenceGenerationPattern, WordAnalysis,
    DifficultyLevel, SentencePattern, ApprovalStatus
)
from ..models.user import User
from .sentence_generation_service import SentenceGenerationService
from .quality_validation_service import QualityValidationService

logger = logging.getLogger(__name__)


class SentenceAdminService:
    """Service for administrative sentence management"""
    
    def __init__(self):
        self.sentence_service = SentenceGenerationService()
        self.validation_service = QualityValidationService()
    
    def save_generated_sentences(self, sentences_data: List[Dict], 
                               generator_user_id: Optional[int] = None) -> List[GeneratedSentence]:
        """Save generated sentences to database"""
        saved_sentences = []
        
        try:
            for sentence_data in sentences_data:
                # Create GeneratedSentence model
                sentence = GeneratedSentence(
                    text=sentence_data['text'],
                    target_word=sentence_data['target_word'].lower(),
                    pattern=SentencePattern(sentence_data['pattern']),
                    difficulty=DifficultyLevel(sentence_data['difficulty']),
                    confidence=sentence_data.get('confidence', 0.0),
                    grammar_score=sentence_data.get('grammar_score', 0.0),
                    overall_score=sentence_data.get('overall_score', 0.0),
                    readability_score=sentence_data.get('readability_score', 0.0),
                    appropriateness_score=sentence_data.get('appropriateness_score', 0.0),
                    is_validated=sentence_data.get('is_validated', False),
                    validation_issues=sentence_data.get('validation_issues', [])
                )
                
                db.session.add(sentence)
                saved_sentences.append(sentence)
            
            db.session.commit()
            logger.info(f"Saved {len(saved_sentences)} sentences to database")
            
        except Exception as e:
            db.session.rollback()
            logger.error(f"Error saving sentences: {str(e)}")
            raise
        
        return saved_sentences
    
    def get_sentences_for_review(self, limit: int = 50, 
                               difficulty: Optional[DifficultyLevel] = None,
                               target_word: Optional[str] = None) -> List[GeneratedSentence]:
        """Get sentences pending approval"""
        query = GeneratedSentence.query.filter_by(
            approval_status=ApprovalStatus.PENDING
        )
        
        if difficulty:
            query = query.filter_by(difficulty=difficulty)
        
        if target_word:
            query = query.filter_by(target_word=target_word.lower())
        
        return query.order_by(GeneratedSentence.created_at.desc()).limit(limit).all()
    
    def approve_sentence(self, sentence_id: int, approver_user_id: int, 
                        notes: Optional[str] = None) -> bool:
        """Approve a generated sentence"""
        try:
            sentence = GeneratedSentence.query.get(sentence_id)
            if not sentence:
                logger.warning(f"Sentence {sentence_id} not found for approval")
                return False
            
            sentence.approve(approver_user_id, notes)
            db.session.commit()
            
            logger.info(f"Sentence {sentence_id} approved by user {approver_user_id}")
            return True
            
        except Exception as e:
            db.session.rollback()
            logger.error(f"Error approving sentence {sentence_id}: {str(e)}")
            return False
    
    def reject_sentence(self, sentence_id: int, rejector_user_id: int, 
                       notes: Optional[str] = None) -> bool:
        """Reject a generated sentence"""
        try:
            sentence = GeneratedSentence.query.get(sentence_id)
            if not sentence:
                logger.warning(f"Sentence {sentence_id} not found for rejection")
                return False
            
            sentence.reject(rejector_user_id, notes)
            db.session.commit()
            
            logger.info(f"Sentence {sentence_id} rejected by user {rejector_user_id}")
            return True
            
        except Exception as e:
            db.session.rollback()
            logger.error(f"Error rejecting sentence {sentence_id}: {str(e)}")
            return False
    
    def batch_approve_sentences(self, sentence_ids: List[int], 
                              approver_user_id: int) -> Dict[str, int]:
        """Batch approve multiple sentences"""
        approved_count = 0
        failed_count = 0
        
        try:
            sentences = GeneratedSentence.query.filter(
                GeneratedSentence.id.in_(sentence_ids)
            ).all()
            
            for sentence in sentences:
                try:
                    sentence.approve(approver_user_id)
                    approved_count += 1
                except Exception as e:
                    logger.error(f"Failed to approve sentence {sentence.id}: {str(e)}")
                    failed_count += 1
            
            db.session.commit()
            logger.info(f"Batch approved {approved_count} sentences, {failed_count} failed")
            
        except Exception as e:
            db.session.rollback()
            logger.error(f"Error in batch approval: {str(e)}")
            raise
        
        return {"approved": approved_count, "failed": failed_count}
    
    def generate_and_validate_sentences(self, target_words: List[str],
                                      difficulty: DifficultyLevel,
                                      sentences_per_word: int = 3,
                                      auto_approve_threshold: float = 0.8) -> Dict:
        """Generate sentences for words and validate them"""
        try:
            # Generate sentences
            generation_results = self.sentence_service.batch_generate_sentences(
                target_words, difficulty, sentences_per_word
            )
            
            all_sentences = []
            for word_sentences in generation_results.values():
                all_sentences.extend(word_sentences)
            
            if not all_sentences:
                return {"success": False, "error": "No sentences generated"}
            
            # Validate sentences
            validation_results = self.validation_service.batch_validate_sentences(all_sentences)
            
            # Prepare data for saving
            sentences_data = []
            auto_approved = 0
            
            for sentence, validation in zip(all_sentences, validation_results):
                sentence_data = {
                    'text': sentence.text,
                    'target_word': sentence.target_word,
                    'pattern': sentence.pattern.value,
                    'difficulty': sentence.difficulty.value,
                    'confidence': sentence.confidence,
                    'grammar_score': sentence.grammar_score,
                    'overall_score': validation.overall_score,
                    'readability_score': validation.readability_score,
                    'appropriateness_score': validation.appropriateness_score,
                    'is_validated': True,
                    'validation_issues': [
                        {
                            'type': issue.type,
                            'severity': issue.severity.value,
                            'message': issue.message,
                            'position': issue.position,
                            'length': issue.length,
                            'suggestions': issue.suggestions
                        }
                        for issue in validation.issues
                    ]
                }
                
                sentences_data.append(sentence_data)
                
                # Auto-approve high-quality sentences
                if (validation.is_valid and 
                    validation.overall_score >= auto_approve_threshold):
                    auto_approved += 1
            
            # Save sentences
            saved_sentences = self.save_generated_sentences(sentences_data)
            
            # Auto-approve qualifying sentences
            auto_approve_count = 0
            for sentence, validation in zip(saved_sentences, validation_results):
                if (validation.is_valid and 
                    validation.overall_score >= auto_approve_threshold):
                    sentence.approval_status = ApprovalStatus.APPROVED
                    sentence.approval_notes = f"Auto-approved (score: {validation.overall_score:.2f})"
                    auto_approve_count += 1
            
            db.session.commit()
            
            # Get validation summary
            validation_summary = self.validation_service.get_validation_summary(validation_results)
            
            return {
                "success": True,
                "total_generated": len(all_sentences),
                "total_saved": len(saved_sentences),
                "auto_approved": auto_approve_count,
                "pending_review": len(saved_sentences) - auto_approve_count,
                "validation_summary": validation_summary,
                "generation_results": {
                    word: len(sentences) for word, sentences in generation_results.items()
                }
            }
            
        except Exception as e:
            logger.error(f"Error in generate_and_validate_sentences: {str(e)}")
            return {"success": False, "error": str(e)}
    
    def get_sentence_statistics(self) -> Dict:
        """Get comprehensive sentence statistics"""
        try:
            # Basic counts
            total_sentences = GeneratedSentence.query.count()
            pending_count = GeneratedSentence.query.filter_by(
                approval_status=ApprovalStatus.PENDING
            ).count()
            approved_count = GeneratedSentence.query.filter_by(
                approval_status=ApprovalStatus.APPROVED
            ).count()
            rejected_count = GeneratedSentence.query.filter_by(
                approval_status=ApprovalStatus.REJECTED
            ).count()
            
            # By difficulty
            difficulty_stats = {}
            for difficulty in DifficultyLevel:
                count = GeneratedSentence.query.filter_by(difficulty=difficulty).count()
                difficulty_stats[difficulty.value] = count
            
            # By pattern type
            pattern_stats = {}
            for pattern in SentencePattern:
                count = GeneratedSentence.query.filter_by(pattern=pattern).count()
                pattern_stats[pattern.value] = count
            
            # Quality metrics
            validated_sentences = GeneratedSentence.query.filter_by(is_validated=True).all()
            if validated_sentences:
                avg_overall_score = sum(s.overall_score for s in validated_sentences) / len(validated_sentences)
                avg_grammar_score = sum(s.grammar_score for s in validated_sentences) / len(validated_sentences)
                avg_readability_score = sum(s.readability_score for s in validated_sentences) / len(validated_sentences)
            else:
                avg_overall_score = avg_grammar_score = avg_readability_score = 0.0
            
            # Top target words
            word_counts = db.session.query(
                GeneratedSentence.target_word,
                func.count(GeneratedSentence.id).label('count')
            ).group_by(GeneratedSentence.target_word).order_by(
                func.count(GeneratedSentence.id).desc()
            ).limit(10).all()
            
            top_words = [{"word": word, "count": count} for word, count in word_counts]
            
            # Recent activity (last 7 days)
            week_ago = datetime.utcnow() - timedelta(days=7)
            recent_generated = GeneratedSentence.query.filter(
                GeneratedSentence.created_at >= week_ago
            ).count()
            
            return {
                "total_sentences": total_sentences,
                "approval_status": {
                    "pending": pending_count,
                    "approved": approved_count,
                    "rejected": rejected_count
                },
                "by_difficulty": difficulty_stats,
                "by_pattern": pattern_stats,
                "quality_metrics": {
                    "average_overall_score": avg_overall_score,
                    "average_grammar_score": avg_grammar_score,
                    "average_readability_score": avg_readability_score,
                    "validated_count": len(validated_sentences)
                },
                "top_target_words": top_words,
                "recent_activity": {
                    "generated_last_week": recent_generated
                }
            }
            
        except Exception as e:
            logger.error(f"Error getting sentence statistics: {str(e)}")
            return {}
    
    def search_sentences(self, query: str, difficulty: Optional[DifficultyLevel] = None,
                        approval_status: Optional[ApprovalStatus] = None,
                        source_category: Optional[str] = None,
                        limit: int = 50) -> List[GeneratedSentence]:
        """Search sentences by text content or target word"""
        try:
            # Build query
            base_query = GeneratedSentence.query
            
            # Text search (target word or sentence content)
            search_filter = or_(
                GeneratedSentence.target_word.ilike(f'%{query.lower()}%'),
                GeneratedSentence.text.ilike(f'%{query}%')
            )
            base_query = base_query.filter(search_filter)
            
            # Apply filters
            if difficulty:
                base_query = base_query.filter_by(difficulty=difficulty)
            
            if approval_status:
                base_query = base_query.filter_by(approval_status=approval_status)
            
            if source_category:
                base_query = base_query.filter_by(source_category=source_category)
            
            return base_query.order_by(
                GeneratedSentence.created_at.desc()
            ).limit(limit).all()
            
        except Exception as e:
            logger.error(f"Error searching sentences: {str(e)}")
            return []
    
    def manage_sentence_patterns(self) -> Dict:
        """Get pattern management information"""
        try:
            # Get pattern usage statistics
            pattern_usage = db.session.query(
                GeneratedSentence.pattern,
                func.count(GeneratedSentence.id).label('usage_count'),
                func.avg(GeneratedSentence.overall_score).label('avg_score')
            ).group_by(GeneratedSentence.pattern).all()
            
            pattern_stats = []
            for pattern, count, avg_score in pattern_usage:
                pattern_stats.append({
                    "pattern": pattern.value,
                    "usage_count": count,
                    "average_score": float(avg_score) if avg_score else 0.0
                })
            
            # Get stored patterns from database
            stored_patterns = SentenceGenerationPattern.query.filter_by(is_active=True).all()
            
            return {
                "pattern_usage_stats": pattern_stats,
                "stored_patterns_count": len(stored_patterns),
                "stored_patterns": [p.to_dict() for p in stored_patterns[:20]]  # Limit for performance
            }
            
        except Exception as e:
            logger.error(f"Error getting pattern management info: {str(e)}")
            return {}
    
    def export_approved_sentences(self, difficulty: Optional[DifficultyLevel] = None,
                                target_words: Optional[List[str]] = None) -> List[Dict]:
        """Export approved sentences for use in learning modules"""
        try:
            query = GeneratedSentence.query.filter_by(approval_status=ApprovalStatus.APPROVED)
            
            if difficulty:
                query = query.filter_by(difficulty=difficulty)
            
            if target_words:
                query = query.filter(
                    GeneratedSentence.target_word.in_([w.lower() for w in target_words])
                )
            
            sentences = query.order_by(GeneratedSentence.overall_score.desc()).all()
            
            return [
                {
                    'id': sentence.id,
                    'text': sentence.text,
                    'target_word': sentence.target_word,
                    'difficulty': sentence.difficulty.value,
                    'pattern': sentence.pattern.value,
                    'overall_score': sentence.overall_score,
                    'usage_count': sentence.usage_count
                }
                for sentence in sentences
            ]
            
        except Exception as e:
            logger.error(f"Error exporting sentences: {str(e)}")
            return []
    
    def cleanup_rejected_sentences(self, days_old: int = 30) -> int:
        """Remove old rejected sentences to save space"""
        try:
            cutoff_date = datetime.utcnow() - timedelta(days=days_old)
            
            deleted_count = GeneratedSentence.query.filter(
                and_(
                    GeneratedSentence.approval_status == ApprovalStatus.REJECTED,
                    GeneratedSentence.created_at < cutoff_date
                )
            ).delete()
            
            db.session.commit()
            logger.info(f"Cleaned up {deleted_count} old rejected sentences")
            return deleted_count
            
        except Exception as e:
            db.session.rollback()
            logger.error(f"Error cleaning up rejected sentences: {str(e)}")
            return 0