"""
Sound Configuration Model

Database model for managing sound effects settings.
"""

from datetime import datetime
from sqlalchemy import Column, Integer, String, Boolean, Float, DateTime, Text
from sqlalchemy.dialects.postgresql import JSON
import enum

from .. import db


class SoundType(enum.Enum):
    """Sound effect types"""
    KEYBOARD = "keyboard"
    SUCCESS = "success"
    ERROR = "error"
    COMPLETION = "completion"


class SoundConfig(db.Model):
    """Model for sound configuration settings"""
    __tablename__ = 'sound_configs'
    
    id = Column(Integer, primary_key=True)
    
    # Sound settings
    keyboard_sound_enabled = Column(Boolean, default=True)
    keyboard_sound_volume = Column(Float, default=0.3)
    keyboard_sound_file = Column(String(200), default='keyboard_click_01')
    
    success_sound_enabled = Column(Boolean, default=True)
    success_sound_volume = Column(Float, default=0.5)
    success_sound_file = Column(String(200), default='success_bell_01')
    
    error_sound_enabled = Column(Boolean, default=True)
    error_sound_volume = Column(Float, default=0.5)
    error_sound_file = Column(String(200), default='error_buzz_01')
    
    completion_sound_enabled = Column(Boolean, default=True)
    completion_sound_volume = Column(Float, default=0.6)
    completion_sound_file = Column(String(200), default='completion_fanfare_01')
    
    # Global settings
    master_volume = Column(Float, default=0.8)
    sounds_enabled = Column(Boolean, default=True)
    
    # Additional settings
    settings_json = Column(JSON)  # For extensible settings
    notes = Column(Text)  # Admin notes
    
    # Timestamps
    created_at = Column(DateTime, default=datetime.utcnow, nullable=False)
    updated_at = Column(DateTime, default=datetime.utcnow, onupdate=datetime.utcnow, nullable=False)
    
    def __repr__(self):
        return f'<SoundConfig {self.id}>'
    
    def to_dict(self):
        """Convert model to dictionary"""
        return {
            'id': self.id,
            'keyboard_sound_enabled': self.keyboard_sound_enabled,
            'keyboard_sound_volume': self.keyboard_sound_volume,
            'keyboard_sound_file': self.keyboard_sound_file,
            'success_sound_enabled': self.success_sound_enabled,
            'success_sound_volume': self.success_sound_volume,
            'success_sound_file': self.success_sound_file,
            'error_sound_enabled': self.error_sound_enabled,
            'error_sound_volume': self.error_sound_volume,
            'error_sound_file': self.error_sound_file,
            'completion_sound_enabled': self.completion_sound_enabled,
            'completion_sound_volume': self.completion_sound_volume,
            'completion_sound_file': self.completion_sound_file,
            'master_volume': self.master_volume,
            'sounds_enabled': self.sounds_enabled,
            'settings_json': self.settings_json,
            'notes': self.notes,
            'created_at': self.created_at.isoformat() if self.created_at else None,
            'updated_at': self.updated_at.isoformat() if self.updated_at else None
        }
    
    @classmethod
    def get_default_config(cls):
        """Get or create default sound configuration"""
        config = cls.query.first()
        if not config:
            config = cls()
            db.session.add(config)
            db.session.commit()
        return config
    
    def update_from_dict(self, data):
        """Update model from dictionary"""
        for key, value in data.items():
            if hasattr(self, key):
                setattr(self, key, value)