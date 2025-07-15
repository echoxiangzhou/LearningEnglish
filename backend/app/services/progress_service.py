from flask_socketio import emit, join_room, leave_room
from app import socketio
import logging
from datetime import datetime
from typing import Optional, Dict, Any

class ProgressService:
    """Service for managing real-time progress updates via WebSocket"""
    
    def __init__(self):
        self.logger = logging.getLogger(__name__)
    
    def emit_progress(self, room: str, event: str, data: Dict[Any, Any]):
        """Emit progress update to specific room"""
        try:
            socketio.emit(event, data, room=room)
            self.logger.debug(f"Emitted {event} to room {room}: {data}")
        except Exception as e:
            self.logger.error(f"Failed to emit {event} to room {room}: {str(e)}")
    
    def emit_import_progress(self, import_id: int, progress: int, status: str, 
                           message: Optional[str] = None, error: Optional[str] = None):
        """Emit import processing progress update"""
        room = f"import_{import_id}"
        data = {
            'import_id': import_id,
            'progress': progress,
            'status': status,
            'timestamp': str(datetime.utcnow()),
        }
        
        if message:
            data['message'] = message
        if error:
            data['error'] = error
            
        self.emit_progress(room, 'import_progress', data)
    
    def emit_import_completed(self, import_id: int, success: bool, 
                            items_created: int = 0, error: Optional[str] = None):
        """Emit import completion notification"""
        room = f"import_{import_id}"
        data = {
            'import_id': import_id,
            'success': success,
            'items_created': items_created,
            'timestamp': str(datetime.utcnow()),
        }
        
        if error:
            data['error'] = error
            
        self.emit_progress(room, 'import_completed', data)
    
    def emit_batch_progress(self, batch_id: str, completed: int, total: int, 
                          current_file: Optional[str] = None):
        """Emit batch processing progress"""
        room = f"batch_{batch_id}"
        data = {
            'batch_id': batch_id,
            'completed': completed,
            'total': total,
            'progress': (completed / total * 100) if total > 0 else 0,
            'timestamp': str(datetime.utcnow()),
        }
        
        if current_file:
            data['current_file'] = current_file
            
        self.emit_progress(room, 'batch_progress', data)


# WebSocket event handlers
@socketio.on('join_import_room')
def handle_join_import_room(data):
    """Handle client joining import progress room"""
    import_id = data.get('import_id')
    if import_id:
        room = f"import_{import_id}"
        join_room(room)
        emit('joined_room', {'room': room, 'import_id': import_id})

@socketio.on('leave_import_room')
def handle_leave_import_room(data):
    """Handle client leaving import progress room"""
    import_id = data.get('import_id')
    if import_id:
        room = f"import_{import_id}"
        leave_room(room)
        emit('left_room', {'room': room, 'import_id': import_id})

@socketio.on('join_batch_room')
def handle_join_batch_room(data):
    """Handle client joining batch progress room"""
    batch_id = data.get('batch_id')
    if batch_id:
        room = f"batch_{batch_id}"
        join_room(room)
        emit('joined_room', {'room': room, 'batch_id': batch_id})

@socketio.on('connect')
def handle_connect():
    """Handle client connection"""
    emit('connected', {'message': 'Connected to progress updates'})

@socketio.on('disconnect')
def handle_disconnect():
    """Handle client disconnection"""
    print('Client disconnected')


# Service instance
progress_service = ProgressService()