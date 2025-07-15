from app import db
from datetime import datetime

class ContentImport(db.Model):
    """Track PDF and other content imports"""
    __tablename__ = 'content_imports'
    
    id = db.Column(db.Integer, primary_key=True)
    user_id = db.Column(db.Integer, db.ForeignKey('users.id'), nullable=False)
    filename = db.Column(db.String(255), nullable=False)
    original_filename = db.Column(db.String(255), nullable=False)
    file_path = db.Column(db.String(500), nullable=False)
    file_size = db.Column(db.Integer)
    file_type = db.Column(db.String(50), nullable=False)  # 'pdf', 'csv', 'xlsx', 'txt'
    content_type = db.Column(db.String(50))  # 'vocabulary', 'sentences', 'articles', 'mixed'
    status = db.Column(db.String(50), default='uploaded')  # 'uploaded', 'processing', 'completed', 'failed', 'reviewing'
    processing_progress = db.Column(db.Integer, default=0)  # 0-100 percentage
    extracted_text = db.Column(db.Text)
    processed_data = db.Column(db.JSON)  # Structured data extracted from file
    error_message = db.Column(db.Text)
    review_notes = db.Column(db.Text)
    is_approved = db.Column(db.Boolean, default=False)
    approved_by = db.Column(db.Integer, db.ForeignKey('users.id'))
    approved_at = db.Column(db.DateTime)
    items_created = db.Column(db.Integer, default=0)  # Number of words/sentences/articles created
    created_at = db.Column(db.DateTime, default=datetime.utcnow)
    updated_at = db.Column(db.DateTime, default=datetime.utcnow, onupdate=datetime.utcnow)
    
    # Relationships
    uploader = db.relationship('User', foreign_keys=[user_id], backref='content_imports')
    approver = db.relationship('User', foreign_keys=[approved_by])
    
    def to_dict(self, include_data=False):
        result = {
            'id': self.id,
            'user_id': self.user_id,
            'filename': self.filename,
            'original_filename': self.original_filename,
            'file_size': self.file_size,
            'file_type': self.file_type,
            'content_type': self.content_type,
            'status': self.status,
            'processing_progress': self.processing_progress,
            'error_message': self.error_message,
            'review_notes': self.review_notes,
            'is_approved': self.is_approved,
            'approved_by': self.approved_by,
            'approved_at': self.approved_at.isoformat() if self.approved_at else None,
            'items_created': self.items_created,
            'created_at': self.created_at.isoformat(),
            'updated_at': self.updated_at.isoformat()
        }
        
        if include_data:
            result.update({
                'extracted_text': self.extracted_text,
                'processed_data': self.processed_data
            })
        
        return result
    
    def update_progress(self, progress, status=None):
        """Update processing progress"""
        self.processing_progress = min(100, max(0, progress))
        if status:
            self.status = status
        self.updated_at = datetime.utcnow()
    
    def mark_completed(self, items_created=0):
        """Mark import as completed"""
        self.status = 'completed'
        self.processing_progress = 100
        self.items_created = items_created
        self.updated_at = datetime.utcnow()
    
    def mark_failed(self, error_message):
        """Mark import as failed with error message"""
        self.status = 'failed'
        self.error_message = error_message
        self.updated_at = datetime.utcnow()


class GeneratedContent(db.Model):
    """Track AI-generated sentences and content"""
    __tablename__ = 'generated_content'
    
    id = db.Column(db.Integer, primary_key=True)
    content_type = db.Column(db.String(50), nullable=False)  # 'sentence', 'article', 'question'
    target_word_id = db.Column(db.Integer, db.ForeignKey('words.id'))
    generated_text = db.Column(db.Text, nullable=False)
    generation_prompt = db.Column(db.Text)
    generation_model = db.Column(db.String(100))
    difficulty_level = db.Column(db.Integer, default=1)
    grade_level = db.Column(db.Integer)
    topic = db.Column(db.String(100))
    quality_score = db.Column(db.Float)  # Automated quality assessment
    status = db.Column(db.String(50), default='pending')  # 'pending', 'approved', 'rejected', 'needs_review'
    review_notes = db.Column(db.Text)
    reviewed_by = db.Column(db.Integer, db.ForeignKey('users.id'))
    reviewed_at = db.Column(db.DateTime)
    is_published = db.Column(db.Boolean, default=False)
    published_item_id = db.Column(db.Integer)  # ID of created word/sentence/article
    created_at = db.Column(db.DateTime, default=datetime.utcnow)
    updated_at = db.Column(db.DateTime, default=datetime.utcnow, onupdate=datetime.utcnow)
    
    # Relationships
    target_word = db.relationship('Word', backref='generated_content')
    reviewer = db.relationship('User', foreign_keys=[reviewed_by])
    
    def to_dict(self):
        return {
            'id': self.id,
            'content_type': self.content_type,
            'target_word_id': self.target_word_id,
            'target_word': self.target_word.word if self.target_word else None,
            'generated_text': self.generated_text,
            'generation_prompt': self.generation_prompt,
            'generation_model': self.generation_model,
            'difficulty_level': self.difficulty_level,
            'grade_level': self.grade_level,
            'topic': self.topic,
            'quality_score': self.quality_score,
            'status': self.status,
            'review_notes': self.review_notes,
            'reviewed_by': self.reviewed_by,
            'reviewed_at': self.reviewed_at.isoformat() if self.reviewed_at else None,
            'is_published': self.is_published,
            'published_item_id': self.published_item_id,
            'created_at': self.created_at.isoformat()
        }
    
    def approve_and_publish(self, reviewer_id, item_id=None):
        """Approve content and mark as published"""
        self.status = 'approved'
        self.reviewed_by = reviewer_id
        self.reviewed_at = datetime.utcnow()
        self.is_published = True
        if item_id:
            self.published_item_id = item_id
        self.updated_at = datetime.utcnow()
    
    def reject(self, reviewer_id, notes):
        """Reject content with review notes"""
        self.status = 'rejected'
        self.reviewed_by = reviewer_id
        self.reviewed_at = datetime.utcnow()
        self.review_notes = notes
        self.updated_at = datetime.utcnow()


class ContentTemplate(db.Model):
    """Template patterns for content generation"""
    __tablename__ = 'content_templates'
    
    id = db.Column(db.Integer, primary_key=True)
    template_type = db.Column(db.String(50), nullable=False)  # 'sentence_pattern', 'question_template'
    name = db.Column(db.String(100), nullable=False)
    template_text = db.Column(db.Text, nullable=False)
    description = db.Column(db.Text)
    difficulty_level = db.Column(db.Integer, default=1)
    grade_level = db.Column(db.Integer)
    part_of_speech = db.Column(db.String(50))  # For word templates
    topic = db.Column(db.String(100))
    usage_count = db.Column(db.Integer, default=0)
    is_active = db.Column(db.Boolean, default=True)
    created_by = db.Column(db.Integer, db.ForeignKey('users.id'))
    created_at = db.Column(db.DateTime, default=datetime.utcnow)
    updated_at = db.Column(db.DateTime, default=datetime.utcnow, onupdate=datetime.utcnow)
    
    # Relationships
    creator = db.relationship('User', backref='content_templates')
    
    def to_dict(self):
        return {
            'id': self.id,
            'template_type': self.template_type,
            'name': self.name,
            'template_text': self.template_text,
            'description': self.description,
            'difficulty_level': self.difficulty_level,
            'grade_level': self.grade_level,
            'part_of_speech': self.part_of_speech,
            'topic': self.topic,
            'usage_count': self.usage_count,
            'is_active': self.is_active,
            'created_by': self.created_by,
            'created_at': self.created_at.isoformat()
        }
    
    def increment_usage(self):
        """Increment usage counter"""
        self.usage_count += 1
        self.updated_at = datetime.utcnow()


class SystemLog(db.Model):
    """System activity and error logging"""
    __tablename__ = 'system_logs'
    
    id = db.Column(db.Integer, primary_key=True)
    log_level = db.Column(db.String(20), nullable=False)  # 'DEBUG', 'INFO', 'WARNING', 'ERROR', 'CRITICAL'
    category = db.Column(db.String(50), nullable=False)  # 'auth', 'import', 'generation', 'tts', 'system'
    message = db.Column(db.Text, nullable=False)
    details = db.Column(db.JSON)  # Additional structured data
    user_id = db.Column(db.Integer, db.ForeignKey('users.id'))
    ip_address = db.Column(db.String(45))
    user_agent = db.Column(db.String(500))
    request_path = db.Column(db.String(200))
    session_id = db.Column(db.String(100))
    created_at = db.Column(db.DateTime, default=datetime.utcnow)
    
    # Relationships
    user = db.relationship('User', backref='system_logs')
    
    def to_dict(self):
        return {
            'id': self.id,
            'log_level': self.log_level,
            'category': self.category,
            'message': self.message,
            'details': self.details,
            'user_id': self.user_id,
            'ip_address': self.ip_address,
            'user_agent': self.user_agent,
            'request_path': self.request_path,
            'session_id': self.session_id,
            'created_at': self.created_at.isoformat()
        }
    
    @staticmethod
    def log(level, category, message, details=None, user_id=None, request=None):
        """Create a new log entry"""
        log_entry = SystemLog(
            log_level=level.upper(),
            category=category,
            message=message,
            details=details,
            user_id=user_id
        )
        
        if request:
            log_entry.ip_address = request.remote_addr
            log_entry.user_agent = request.headers.get('User-Agent', '')[:500]
            log_entry.request_path = request.path
        
        db.session.add(log_entry)
        try:
            db.session.commit()
        except Exception as e:
            db.session.rollback()
            print(f"Failed to create log entry: {e}")


class AuditLog(db.Model):
    """Audit trail for administrative actions"""
    __tablename__ = 'audit_logs'
    
    id = db.Column(db.Integer, primary_key=True)
    user_id = db.Column(db.Integer, db.ForeignKey('users.id'), nullable=False)
    action = db.Column(db.String(100), nullable=False)  # 'CREATE', 'UPDATE', 'DELETE', 'APPROVE', 'REJECT'
    resource_type = db.Column(db.String(50), nullable=False)  # 'user', 'word', 'sentence', 'article', 'import'
    resource_id = db.Column(db.Integer)
    old_values = db.Column(db.JSON)
    new_values = db.Column(db.JSON)
    description = db.Column(db.Text)
    ip_address = db.Column(db.String(45))
    user_agent = db.Column(db.String(500))
    created_at = db.Column(db.DateTime, default=datetime.utcnow)
    
    # Relationships
    user = db.relationship('User', backref='audit_logs')
    
    def to_dict(self):
        return {
            'id': self.id,
            'user_id': self.user_id,
            'username': self.user.username if self.user else None,
            'action': self.action,
            'resource_type': self.resource_type,
            'resource_id': self.resource_id,
            'old_values': self.old_values,
            'new_values': self.new_values,
            'description': self.description,
            'ip_address': self.ip_address,
            'user_agent': self.user_agent,
            'created_at': self.created_at.isoformat()
        }
    
    @staticmethod
    def log_action(user_id, action, resource_type, resource_id=None, 
                   old_values=None, new_values=None, description=None, request=None):
        """Create an audit log entry"""
        audit_entry = AuditLog(
            user_id=user_id,
            action=action.upper(),
            resource_type=resource_type,
            resource_id=resource_id,
            old_values=old_values,
            new_values=new_values,
            description=description
        )
        
        if request:
            audit_entry.ip_address = request.remote_addr
            audit_entry.user_agent = request.headers.get('User-Agent', '')[:500]
        
        db.session.add(audit_entry)
        try:
            db.session.commit()
        except Exception as e:
            db.session.rollback()
            print(f"Failed to create audit log: {e}")