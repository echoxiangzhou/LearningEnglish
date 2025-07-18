"""
Generated Sentence Model

Database model for storing generated sentences and their metadata.
"""

from datetime import datetime
from sqlalchemy import Column, Integer, String, Text, Float, Boolean, DateTime, Enum as SQLEnum, ForeignKey
from sqlalchemy.orm import relationship
from sqlalchemy.dialects.postgresql import JSON
import enum

from .. import db


class DifficultyLevel(enum.Enum):
    """Sentence difficulty levels"""
    ELEMENTARY = "elementary"
    INTERMEDIATE = "intermediate"
    ADVANCED = "advanced"


class SentencePattern(enum.Enum):
    """Sentence pattern types"""
    SVO = "subject_verb_object"
    SVC = "subject_verb_complement"
    SVOO = "subject_verb_object_object"
    SV = "subject_verb"
    SVA = "subject_verb_adverb"


class ApprovalStatus(enum.Enum):
    """Approval status for sentences"""
    PENDING = "pending"
    APPROVED = "approved"
    REJECTED = "rejected"
    NEEDS_REVIEW = "needs_review"


class GeneratedSentence(db.Model):
    """Model for generated sentences"""
    __tablename__ = 'generated_sentences'
    
    id = Column(Integer, primary_key=True)
    text = Column(Text, nullable=False)
    target_word = Column(String(100), nullable=False, index=True)
    pattern = Column(SQLEnum(SentencePattern), nullable=False)
    difficulty = Column(String(20), nullable=False, index=True)  # Temporarily changed from enum
    
    # Generation metadata
    confidence = Column(Float, default=0.0)
    grammar_score = Column(Float, default=0.0)
    
    # Validation metadata
    overall_score = Column(Float, default=0.0)
    readability_score = Column(Float, default=0.0)
    appropriateness_score = Column(Float, default=0.0)
    is_validated = Column(Boolean, default=False)
    validation_issues = Column(JSON)  # Store validation issues as JSON
    
    # Translation and source
    chinese_translation = Column(Text)
    source_category = Column(String(100), default='AI generated', index=True)
    
    # Approval workflow
    approval_status = Column(SQLEnum(ApprovalStatus), default=ApprovalStatus.PENDING, index=True)
    approved_by = Column(Integer, ForeignKey('users.id'), nullable=True)
    approval_notes = Column(Text)
    
    # Usage tracking
    usage_count = Column(Integer, default=0)
    last_used = Column(DateTime)
    
    # Audio generation
    audio_file_path = Column(String(500))  # Path to pre-generated audio file
    audio_cache_key = Column(String(64), index=True)  # Cache key for quick lookup
    audio_generated_at = Column(DateTime)  # When audio was generated
    
    # Timestamps
    created_at = Column(DateTime, default=datetime.utcnow, nullable=False)
    updated_at = Column(DateTime, default=datetime.utcnow, onupdate=datetime.utcnow, nullable=False)
    
    # Relationships
    approver = relationship("User", backref="approved_sentences")
    
    def __repr__(self):
        return f'<GeneratedSentence {self.id}: "{self.text[:50]}...">'
    
    def to_dict(self):
        """Convert model to dictionary"""
        return {
            'id': self.id,
            'text': self.text,
            'target_word': self.target_word,
            'pattern': self.pattern.value,
            'difficulty': self.difficulty,  # String instead of enum
            'confidence': self.confidence,
            'grammar_score': self.grammar_score,
            'overall_score': self.overall_score,
            'readability_score': self.readability_score,
            'appropriateness_score': self.appropriateness_score,
            'is_validated': self.is_validated,
            'validation_issues': self.validation_issues,
            'chinese_translation': self.chinese_translation,
            'source_category': self.source_category,
            'approval_status': self.approval_status.value,
            'approval_notes': self.approval_notes,
            'approved_by': self.approved_by,
            'approved_at': self.updated_at.isoformat() if self.approval_status == ApprovalStatus.APPROVED else None,
            'rejection_reason': self.approval_notes if self.approval_status == ApprovalStatus.REJECTED else None,
            'usage_count': self.usage_count,
            'last_used': self.last_used.isoformat() if self.last_used else None,
            'audio_file_path': self.audio_file_path,
            'audio_cache_key': self.audio_cache_key,
            'audio_generated_at': self.audio_generated_at.isoformat() if self.audio_generated_at else None,
            'created_at': self.created_at.isoformat(),
            'updated_at': self.updated_at.isoformat()
        }
    
    @classmethod
    def get_by_target_word(cls, target_word, difficulty=None, approved_only=True):
        """Get sentences for a specific target word"""
        query = cls.query.filter_by(target_word=target_word.lower())
        
        if difficulty:
            query = query.filter_by(difficulty=difficulty)
        
        if approved_only:
            query = query.filter_by(approval_status=ApprovalStatus.APPROVED)
        
        return query.all()
    
    @classmethod
    def get_pending_approval(cls, limit=50):
        """Get sentences pending approval"""
        return cls.query.filter_by(
            approval_status=ApprovalStatus.PENDING
        ).order_by(cls.created_at.desc()).limit(limit).all()
    
    @classmethod
    def get_by_difficulty(cls, difficulty, approved_only=True, limit=100):
        """Get sentences by difficulty level"""
        query = cls.query.filter_by(difficulty=difficulty)
        
        if approved_only:
            query = query.filter_by(approval_status=ApprovalStatus.APPROVED)
        
        return query.order_by(cls.usage_count.desc()).limit(limit).all()
    
    def approve(self, approved_by_user_id, notes=None):
        """Approve the sentence"""
        self.approval_status = ApprovalStatus.APPROVED
        self.approved_by = approved_by_user_id
        self.approval_notes = notes
        self.updated_at = datetime.utcnow()
    
    def reject(self, rejected_by_user_id, notes=None):
        """Reject the sentence"""
        self.approval_status = ApprovalStatus.REJECTED
        self.approved_by = rejected_by_user_id
        self.approval_notes = notes
        self.updated_at = datetime.utcnow()
    
    def mark_used(self):
        """Mark sentence as used and increment usage count"""
        self.usage_count += 1
        self.last_used = datetime.utcnow()
        self.updated_at = datetime.utcnow()


class SentenceGenerationPattern(db.Model):
    """Model for sentence generation patterns"""
    __tablename__ = 'sentence_generation_patterns'
    
    id = Column(Integer, primary_key=True)
    pattern_id = Column(String(100), unique=True, nullable=False, index=True)
    pattern_type = Column(SQLEnum(SentencePattern), nullable=False)
    template = Column(Text, nullable=False)
    difficulty = Column(SQLEnum(DifficultyLevel), nullable=False, index=True)
    
    # Pattern configuration
    pos_requirements = Column(JSON, nullable=False)  # Store POS requirements as JSON
    semantic_constraints = Column(JSON)  # Store semantic constraints as JSON
    variations = Column(JSON)  # Store template variations as JSON
    
    # Pattern metadata
    example = Column(Text)
    description = Column(Text)
    weight = Column(Float, default=1.0)
    is_active = Column(Boolean, default=True, index=True)
    
    # Usage tracking
    usage_count = Column(Integer, default=0)
    success_rate = Column(Float, default=0.0)  # Percentage of successful generations
    
    # Timestamps
    created_at = Column(DateTime, default=datetime.utcnow, nullable=False)
    updated_at = Column(DateTime, default=datetime.utcnow, onupdate=datetime.utcnow, nullable=False)
    
    def __repr__(self):
        return f'<SentenceGenerationPattern {self.pattern_id}>'
    
    def to_dict(self):
        """Convert model to dictionary"""
        return {
            'id': self.id,
            'pattern_id': self.pattern_id,
            'pattern_type': self.pattern_type.value,
            'template': self.template,
            'difficulty': self.difficulty.value,
            'pos_requirements': self.pos_requirements,
            'semantic_constraints': self.semantic_constraints,
            'variations': self.variations,
            'example': self.example,
            'description': self.description,
            'weight': self.weight,
            'is_active': self.is_active,
            'usage_count': self.usage_count,
            'success_rate': self.success_rate,
            'created_at': self.created_at.isoformat(),
            'updated_at': self.updated_at.isoformat()
        }
    
    @classmethod
    def get_active_patterns(cls, difficulty=None, pattern_type=None):
        """Get active patterns with optional filtering"""
        query = cls.query.filter_by(is_active=True)
        
        if difficulty:
            query = query.filter_by(difficulty=difficulty)
        
        if pattern_type:
            query = query.filter_by(pattern_type=pattern_type)
        
        return query.order_by(cls.weight.desc()).all()
    
    def record_usage(self, successful=True):
        """Record pattern usage and update success rate"""
        self.usage_count += 1
        
        if successful:
            # Update success rate using running average
            current_successes = self.success_rate * (self.usage_count - 1) / 100.0
            new_successes = current_successes + 1
            self.success_rate = (new_successes / self.usage_count) * 100.0
        else:
            # Recalculate success rate
            current_successes = self.success_rate * (self.usage_count - 1) / 100.0
            self.success_rate = (current_successes / self.usage_count) * 100.0
        
        self.updated_at = datetime.utcnow()


class WordAnalysis(db.Model):
    """Model for storing word analysis results"""
    __tablename__ = 'word_analyses'
    
    id = Column(Integer, primary_key=True)
    word = Column(String(100), unique=True, nullable=False, index=True)
    
    # spaCy analysis results
    lemma = Column(String(100))
    pos = Column(String(20))
    tag = Column(String(20))
    is_alpha = Column(Boolean)
    is_stop = Column(Boolean)
    dependency = Column(String(20))
    has_vector = Column(Boolean)
    vector_norm = Column(Float)
    
    # Additional analysis
    syllable_count = Column(Integer)
    frequency_rank = Column(Integer)  # Word frequency ranking
    difficulty_level = Column(SQLEnum(DifficultyLevel))
    
    # Similar words (cached)
    similar_words = Column(JSON)  # Store list of similar words
    
    # Timestamps
    created_at = Column(DateTime, default=datetime.utcnow, nullable=False)
    updated_at = Column(DateTime, default=datetime.utcnow, onupdate=datetime.utcnow, nullable=False)
    
    def __repr__(self):
        return f'<WordAnalysis {self.word}>'
    
    def to_dict(self):
        """Convert model to dictionary"""
        return {
            'id': self.id,
            'word': self.word,
            'lemma': self.lemma,
            'pos': self.pos,
            'tag': self.tag,
            'is_alpha': self.is_alpha,
            'is_stop': self.is_stop,
            'dependency': self.dependency,
            'has_vector': self.has_vector,
            'vector_norm': self.vector_norm,
            'syllable_count': self.syllable_count,
            'frequency_rank': self.frequency_rank,
            'difficulty_level': self.difficulty_level.value if self.difficulty_level else None,
            'similar_words': self.similar_words,
            'created_at': self.created_at.isoformat(),
            'updated_at': self.updated_at.isoformat()
        }
    
    @classmethod
    def get_or_create_analysis(cls, word):
        """Get existing analysis or create placeholder for new analysis"""
        analysis = cls.query.filter_by(word=word.lower()).first()
        if not analysis:
            analysis = cls(word=word.lower())
            db.session.add(analysis)
            db.session.flush()  # Get the ID without committing
        return analysis