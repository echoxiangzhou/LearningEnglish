"""
User-Category Assignment Model

Stores the many-to-many relationship between users and sentence categories.
"""

from app import db
from datetime import datetime

class UserCategoryAssignment(db.Model):
    """Model for user-category assignments"""
    __tablename__ = 'user_category_assignments'
    
    id = db.Column(db.Integer, primary_key=True)
    user_id = db.Column(db.Integer, db.ForeignKey('users.id'), nullable=False)
    category_id = db.Column(db.Integer, nullable=False)  # Virtual ID from source_category
    category_name = db.Column(db.String(100), nullable=False)  # Store category name for reference
    assigned_by = db.Column(db.String(100), nullable=False)
    assigned_at = db.Column(db.DateTime, default=datetime.utcnow)
    
    # Indexes for better query performance
    __table_args__ = (
        db.Index('idx_user_category', 'user_id', 'category_id'),
        db.UniqueConstraint('user_id', 'category_id', name='uq_user_category'),
    )
    
    def to_dict(self):
        """Convert to dictionary"""
        return {
            'id': self.id,
            'user_id': self.user_id,
            'category_id': self.category_id,
            'category_name': self.category_name,
            'assigned_by': self.assigned_by,
            'assigned_at': self.assigned_at.isoformat() if self.assigned_at else None
        }