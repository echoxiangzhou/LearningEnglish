#!/usr/bin/env python3
"""
Start script for Learning English Flask application
"""
import os
import sys

# Add current directory to Python path
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))

from app import create_app, socketio

if __name__ == '__main__':
    app = create_app()
    
    print("=== Learning English Backend Server ===")
    print("Starting Flask application with SocketIO...")
    print(f"Database URL: {app.config['SQLALCHEMY_DATABASE_URI']}")
    print("Server will be available at: http://localhost:5000")
    print("API Documentation: http://localhost:5000/api")
    print("=========================================")
    
    # Run with SocketIO support
    socketio.run(
        app, 
        debug=True, 
        host='0.0.0.0', 
        port=5000,
        allow_unsafe_werkzeug=True  # For development only
    )