#!/usr/bin/env python3
"""
Export vocabulary data from local PostgreSQL database
This script exports words, vocabulary libraries, and related data to SQL files
"""

import os
import sys
import psycopg2
from datetime import datetime
import argparse

def get_db_connection():
    """Get database connection from environment or defaults"""
    db_url = os.getenv('DATABASE_URL', 'postgresql://postgres:password@localhost/learning_english')
    
    # Parse database URL
    if db_url.startswith('postgresql://'):
        # Extract connection components
        from urllib.parse import urlparse
        parsed = urlparse(db_url)
        return psycopg2.connect(
            host=parsed.hostname,
            port=parsed.port or 5432,
            database=parsed.path[1:],  # Remove leading slash
            user=parsed.username,
            password=parsed.password
        )
    else:
        raise ValueError("Invalid database URL format")

def export_table_data(cursor, table_name, output_file, exclude_columns=None):
    """Export table data to SQL file"""
    exclude_columns = exclude_columns or []
    
    # Get table structure
    cursor.execute(f"""
        SELECT column_name, data_type, is_nullable
        FROM information_schema.columns 
        WHERE table_name = '{table_name}' 
        ORDER BY ordinal_position
    """)
    columns_info = cursor.fetchall()
    
    if not columns_info:
        print(f"Warning: Table {table_name} not found")
        return 0
    
    # Filter out excluded columns
    columns = [col[0] for col in columns_info if col[0] not in exclude_columns]
    
    if not columns:
        print(f"Warning: No columns to export for table {table_name}")
        return 0
    
    # Get data count
    cursor.execute(f"SELECT COUNT(*) FROM {table_name}")
    total_count = cursor.fetchone()[0]
    
    if total_count == 0:
        print(f"Warning: Table {table_name} is empty")
        return 0
    
    print(f"Exporting {total_count} records from {table_name}...")
    
    # Export data
    columns_str = ', '.join(columns)
    cursor.execute(f"SELECT {columns_str} FROM {table_name} ORDER BY id")
    
    with open(output_file, 'w', encoding='utf-8') as f:
        f.write(f"-- Export of {table_name} table\n")
        f.write(f"-- Generated on {datetime.now().isoformat()}\n")
        f.write(f"-- Total records: {total_count}\n\n")
        
        # Write table structure comment
        f.write(f"-- Columns: {', '.join(columns)}\n\n")
        
        batch_size = 1000
        processed = 0
        
        while processed < total_count:
            cursor.execute(f"""
                SELECT {columns_str} FROM {table_name} 
                ORDER BY id 
                LIMIT {batch_size} OFFSET {processed}
            """)
            
            rows = cursor.fetchall()
            if not rows:
                break
            
            # Generate INSERT statements
            for row in rows:
                values = []
                for i, value in enumerate(row):
                    if value is None:
                        values.append('NULL')
                    elif isinstance(value, str):
                        # Escape single quotes in strings
                        escaped_value = value.replace("'", "''")
                        values.append(f"'{escaped_value}'")
                    elif isinstance(value, datetime):
                        values.append(f"'{value.isoformat()}'")
                    elif isinstance(value, bool):
                        values.append('TRUE' if value else 'FALSE')
                    else:
                        values.append(str(value))
                
                values_str = ', '.join(values)
                f.write(f"INSERT INTO {table_name} ({columns_str}) VALUES ({values_str});\n")
            
            processed += len(rows)
            if processed % 1000 == 0:
                print(f"  Processed {processed}/{total_count} records...")
    
    print(f"Exported {total_count} records from {table_name} to {output_file}")
    return total_count

def export_vocabulary_data(output_dir="./export"):
    """Export all vocabulary-related data"""
    
    # Create output directory
    os.makedirs(output_dir, exist_ok=True)
    
    # Connect to database
    try:
        conn = get_db_connection()
        cursor = conn.cursor()
        
        print("Connected to database successfully")
        
        # Export words table
        words_file = os.path.join(output_dir, "words.sql")
        words_count = export_table_data(cursor, "words", words_file)
        
        # Export vocabulary_libraries table  
        libraries_file = os.path.join(output_dir, "vocabulary_libraries.sql")
        libraries_count = export_table_data(cursor, "vocabulary_libraries", libraries_file)
        
        # Export library_words association table
        library_words_file = os.path.join(output_dir, "library_words.sql")
        library_words_count = export_table_data(cursor, "library_words", library_words_file)
        
        # Export library_assignments table if it exists
        cursor.execute("""
            SELECT EXISTS (
                SELECT FROM information_schema.tables 
                WHERE table_name = 'library_assignments'
            )
        """)
        if cursor.fetchone()[0]:
            assignments_file = os.path.join(output_dir, "library_assignments.sql")
            assignments_count = export_table_data(cursor, "library_assignments", assignments_file)
        else:
            assignments_count = 0
            print("Table library_assignments not found, skipping...")
        
        # Create import script
        import_script = os.path.join(output_dir, "import_vocabulary.sql")
        with open(import_script, 'w', encoding='utf-8') as f:
            f.write("-- Import script for vocabulary data\n")
            f.write(f"-- Generated on {datetime.now().isoformat()}\n\n")
            f.write("-- Disable foreign key checks temporarily\n")
            f.write("SET foreign_key_checks = 0;\n\n")
            
            f.write("-- Import words\n")
            f.write("\\i words.sql\n\n")
            
            f.write("-- Import vocabulary libraries\n") 
            f.write("\\i vocabulary_libraries.sql\n\n")
            
            f.write("-- Import library-word associations\n")
            f.write("\\i library_words.sql\n\n")
            
            if assignments_count > 0:
                f.write("-- Import library assignments\n")
                f.write("\\i library_assignments.sql\n\n")
            
            f.write("-- Re-enable foreign key checks\n")
            f.write("SET foreign_key_checks = 1;\n\n")
            
            f.write("-- Update sequences\n")
            f.write("SELECT setval('words_id_seq', (SELECT MAX(id) FROM words));\n")
            f.write("SELECT setval('vocabulary_libraries_id_seq', (SELECT MAX(id) FROM vocabulary_libraries));\n")
            if assignments_count > 0:
                f.write("SELECT setval('library_assignments_id_seq', (SELECT MAX(id) FROM library_assignments));\n")
        
        # Create transfer script
        transfer_script = os.path.join(output_dir, "transfer_to_server.sh")
        with open(transfer_script, 'w') as f:
            f.write("#!/bin/bash\n")
            f.write("# Transfer vocabulary data to remote server\n")
            f.write("# Usage: ./transfer_to_server.sh [server_host] [username]\n\n")
            f.write("SERVER_HOST=${1:-your-server-host}\n")
            f.write("USERNAME=${2:-your-username}\n")
            f.write("REMOTE_DIR=/tmp/vocabulary_import\n\n")
            f.write("echo \"Transferring files to $SERVER_HOST...\"\n\n")
            f.write("# Create remote directory\n")
            f.write("ssh $USERNAME@$SERVER_HOST \"mkdir -p $REMOTE_DIR\"\n\n")
            f.write("# Transfer SQL files\n")
            f.write("scp *.sql $USERNAME@$SERVER_HOST:$REMOTE_DIR/\n\n")
            f.write("echo \"Files transferred to $SERVER_HOST:$REMOTE_DIR\"\n")
            f.write("echo \"To import on remote server, run:\"\n")
            f.write("echo \"  ssh $USERNAME@$SERVER_HOST\"\n")
            f.write("echo \"  cd $REMOTE_DIR\"\n")
            f.write("echo \"  psql -d your_database -f import_vocabulary.sql\"\n")
        
        # Make transfer script executable
        os.chmod(transfer_script, 0o755)
        
        # Summary
        print(f"\n=== Export Summary ===")
        print(f"Words exported: {words_count}")
        print(f"Vocabulary libraries exported: {libraries_count}")
        print(f"Library-word associations exported: {library_words_count}")
        if assignments_count > 0:
            print(f"Library assignments exported: {assignments_count}")
        print(f"\nFiles created in {output_dir}:")
        print(f"  - words.sql")
        print(f"  - vocabulary_libraries.sql")
        print(f"  - library_words.sql")
        if assignments_count > 0:
            print(f"  - library_assignments.sql")
        print(f"  - import_vocabulary.sql (import script)")
        print(f"  - transfer_to_server.sh (transfer script)")
        
        return True
        
    except Exception as e:
        print(f"Error exporting data: {e}")
        return False
    
    finally:
        if 'cursor' in locals():
            cursor.close()
        if 'conn' in locals():
            conn.close()

def main():
    parser = argparse.ArgumentParser(description='Export vocabulary data from PostgreSQL')
    parser.add_argument('--output-dir', '-o', default='./export',
                        help='Output directory for exported files (default: ./export)')
    
    args = parser.parse_args()
    
    print("Starting vocabulary data export...")
    success = export_vocabulary_data(args.output_dir)
    
    if success:
        print("\nExport completed successfully!")
        print(f"Use the transfer_to_server.sh script to upload files to your remote server.")
    else:
        print("\nExport failed!")
        sys.exit(1)

if __name__ == "__main__":
    main()