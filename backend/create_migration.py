#!/usr/bin/env python3
"""
Script to create database migration for vocabulary models
"""
import os
import sys

# Add the current directory to Python path
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))

# Set Flask app environment
os.environ['FLASK_APP'] = 'run.py'

try:
    from flask_migrate import init, migrate
    from app import create_app
    
    app = create_app()
    
    with app.app_context():
        try:
            # Try to initialize migrations if not already done
            init()
            print("Migrations initialized")
        except:
            print("Migrations already initialized")
        
        # Create migration for vocabulary models
        migrate(message="Add vocabulary learning models")
        print("Migration created successfully")
        
except ImportError as e:
    print(f"Import error: {e}")
    print("Please ensure all dependencies are installed")
except Exception as e:
    print(f"Error creating migration: {e}")