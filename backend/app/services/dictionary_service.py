from typing import Dict, Any, Optional, List
from sqlalchemy import func, desc
from flask import current_app
from app.models.word import Word
from app.models.article import WordLookup, ReadingSession
from app.models.user import User
from app import db
import requests
import json


class DictionaryService:
    """Service for handling dictionary operations including word definitions and lookups."""
    
    @staticmethod
    def get_word_definition(word: str, user_id: int = None) -> Dict[str, Any]:
        """
        Get word definition from local database or external API.
        
        Args:
            word: The word to look up
            user_id: Optional user ID for tracking lookups
            
        Returns:
            Dictionary containing word definition and metadata
        """
        # Clean the word
        clean_word = word.lower().strip()
        
        # First try to get from local database
        db_word = Word.query.filter_by(word=clean_word).first()
        
        if db_word:
            result = {
                'word': db_word.word,
                'phonetic': db_word.phonetic,
                'definition': db_word.definition,
                'part_of_speech': db_word.part_of_speech,
                'grade_level': db_word.grade_level,
                'difficulty': db_word.difficulty,
                'frequency': db_word.frequency,
                'source': 'local'
            }
            
            # Track lookup if user provided
            if user_id:
                DictionaryService._track_word_lookup(user_id, clean_word, result)
            
            return result
        
        # If not found locally, try external API
        try:
            external_definition = DictionaryService._fetch_external_definition(clean_word)
            if external_definition:
                # Save to local database for future use
                DictionaryService._save_word_to_database(clean_word, external_definition)
                
                # Track lookup if user provided
                if user_id:
                    DictionaryService._track_word_lookup(user_id, clean_word, external_definition)
                
                return external_definition
        except Exception as e:
            current_app.logger.error(f"Error fetching external definition for '{clean_word}': {str(e)}")
        
        # Return empty result if not found
        return {
            'word': clean_word,
            'definition': 'Definition not found',
            'source': 'not_found'
        }
    
    @staticmethod
    def _fetch_external_definition(word: str) -> Optional[Dict[str, Any]]:
        """
        Fetch word definition from external dictionary API.
        
        Args:
            word: The word to look up
            
        Returns:
            Dictionary containing word definition or None if not found
        """
        try:
            # Use Free Dictionary API
            url = f"https://api.dictionaryapi.dev/api/v2/entries/en/{word}"
            response = requests.get(url, timeout=5)
            
            if response.status_code == 200:
                data = response.json()
                if data and len(data) > 0:
                    entry = data[0]
                    
                    # Extract phonetic
                    phonetic = None
                    if 'phonetics' in entry and entry['phonetics']:
                        for phonetic_entry in entry['phonetics']:
                            if 'text' in phonetic_entry and phonetic_entry['text']:
                                phonetic = phonetic_entry['text']
                                break
                    
                    # Extract definition and part of speech
                    definition = None
                    part_of_speech = None
                    example = None
                    
                    if 'meanings' in entry and entry['meanings']:
                        meaning = entry['meanings'][0]
                        part_of_speech = meaning.get('partOfSpeech', '')
                        
                        if 'definitions' in meaning and meaning['definitions']:
                            definition_entry = meaning['definitions'][0]
                            definition = definition_entry.get('definition', '')
                            example = definition_entry.get('example', '')
                    
                    return {
                        'word': word,
                        'phonetic': phonetic,
                        'definition': definition,
                        'part_of_speech': part_of_speech,
                        'example': example,
                        'source': 'external'
                    }
        except Exception as e:
            current_app.logger.error(f"Error fetching external definition: {str(e)}")
        
        return None
    
    @staticmethod
    def _save_word_to_database(word: str, definition_data: Dict[str, Any]) -> None:
        """
        Save word definition to local database.
        
        Args:
            word: The word to save
            definition_data: Dictionary containing word definition data
        """
        try:
            new_word = Word(
                word=word,
                phonetic=definition_data.get('phonetic'),
                definition=definition_data.get('definition'),
                part_of_speech=definition_data.get('part_of_speech'),
                grade_level=5,  # Default grade level
                difficulty=3,   # Default difficulty
                frequency=1     # Default frequency
            )
            
            db.session.add(new_word)
            db.session.commit()
            
            current_app.logger.info(f"Saved word '{word}' to database")
        except Exception as e:
            db.session.rollback()
            current_app.logger.error(f"Error saving word '{word}' to database: {str(e)}")
    
    @staticmethod
    def _track_word_lookup(user_id: int, word: str, definition_data: Dict[str, Any],
                          context_sentence: str = None, article_position: int = None,
                          reading_session_id: int = None) -> None:
        """
        Track user's word lookup activity.
        
        Args:
            user_id: User ID
            word: The looked up word
            definition_data: Dictionary containing word definition data
            context_sentence: Optional context sentence
            article_position: Optional position in article
            reading_session_id: Optional reading session ID
        """
        try:
            # Check if lookup already exists for this session
            existing_lookup = None
            if reading_session_id:
                existing_lookup = WordLookup.query.filter_by(
                    user_id=user_id,
                    reading_session_id=reading_session_id,
                    looked_up_word=word
                ).first()
            
            if existing_lookup:
                # Increment lookup count
                existing_lookup.lookup_count += 1
                existing_lookup.context_sentence = context_sentence or existing_lookup.context_sentence
                existing_lookup.article_position = article_position or existing_lookup.article_position
            else:
                # Create new lookup record
                word_lookup = WordLookup(
                    user_id=user_id,
                    reading_session_id=reading_session_id,
                    looked_up_word=word,
                    context_sentence=context_sentence,
                    article_position=article_position,
                    lookup_count=1
                )
                db.session.add(word_lookup)
            
            db.session.commit()
            
        except Exception as e:
            db.session.rollback()
            current_app.logger.error(f"Error tracking word lookup: {str(e)}")
    
    @staticmethod
    def get_user_lookup_history(user_id: int, limit: int = 50) -> List[Dict[str, Any]]:
        """
        Get user's word lookup history.
        
        Args:
            user_id: User ID
            limit: Maximum number of lookups to return
            
        Returns:
            List of word lookup records
        """
        try:
            lookups = WordLookup.query.filter_by(user_id=user_id)\
                .order_by(desc(WordLookup.created_at))\
                .limit(limit)\
                .all()
            
            result = []
            for lookup in lookups:
                result.append({
                    'id': lookup.id,
                    'word': lookup.looked_up_word,
                    'context_sentence': lookup.context_sentence,
                    'article_position': lookup.article_position,
                    'lookup_count': lookup.lookup_count,
                    'created_at': lookup.created_at.isoformat() if lookup.created_at else None
                })
            
            return result
            
        except Exception as e:
            current_app.logger.error(f"Error getting user lookup history: {str(e)}")
            return []
    
    @staticmethod
    def get_popular_words(limit: int = 20) -> List[Dict[str, Any]]:
        """
        Get most looked up words across all users.
        
        Args:
            limit: Maximum number of words to return
            
        Returns:
            List of popular words with lookup counts
        """
        try:
            popular_words = db.session.query(
                WordLookup.looked_up_word,
                func.sum(WordLookup.lookup_count).label('total_lookups'),
                func.count(WordLookup.user_id.distinct()).label('unique_users')
            ).group_by(WordLookup.looked_up_word)\
            .order_by(desc('total_lookups'))\
            .limit(limit)\
            .all()
            
            result = []
            for word, total_lookups, unique_users in popular_words:
                # Get word definition if available
                word_definition = Word.query.filter_by(word=word).first()
                
                result.append({
                    'word': word,
                    'total_lookups': total_lookups,
                    'unique_users': unique_users,
                    'definition': word_definition.definition if word_definition else None,
                    'part_of_speech': word_definition.part_of_speech if word_definition else None,
                    'difficulty': word_definition.difficulty if word_definition else None
                })
            
            return result
            
        except Exception as e:
            current_app.logger.error(f"Error getting popular words: {str(e)}")
            return []
    
    @staticmethod
    def get_user_vocabulary_stats(user_id: int) -> Dict[str, Any]:
        """
        Get user's vocabulary learning statistics.
        
        Args:
            user_id: User ID
            
        Returns:
            Dictionary containing vocabulary statistics
        """
        try:
            # Count total unique words looked up
            total_lookups = WordLookup.query.filter_by(user_id=user_id).count()
            unique_words = db.session.query(WordLookup.looked_up_word)\
                .filter_by(user_id=user_id)\
                .distinct()\
                .count()
            
            # Get most looked up words for this user
            frequent_words = db.session.query(
                WordLookup.looked_up_word,
                func.sum(WordLookup.lookup_count).label('total_lookups')
            ).filter_by(user_id=user_id)\
            .group_by(WordLookup.looked_up_word)\
            .order_by(desc('total_lookups'))\
            .limit(10)\
            .all()
            
            frequent_words_list = [
                {'word': word, 'lookups': lookups} 
                for word, lookups in frequent_words
            ]
            
            # Calculate difficulty distribution
            difficulty_stats = db.session.query(
                Word.difficulty,
                func.count(WordLookup.id).label('lookup_count')
            ).join(WordLookup, Word.word == WordLookup.looked_up_word)\
            .filter(WordLookup.user_id == user_id)\
            .group_by(Word.difficulty)\
            .all()
            
            difficulty_distribution = {
                str(difficulty): count for difficulty, count in difficulty_stats
            }
            
            return {
                'total_lookups': total_lookups,
                'unique_words': unique_words,
                'frequent_words': frequent_words_list,
                'difficulty_distribution': difficulty_distribution,
                'average_lookups_per_word': round(total_lookups / unique_words, 2) if unique_words > 0 else 0
            }
            
        except Exception as e:
            current_app.logger.error(f"Error getting vocabulary stats: {str(e)}")
            return {
                'total_lookups': 0,
                'unique_words': 0,
                'frequent_words': [],
                'difficulty_distribution': {},
                'average_lookups_per_word': 0
            }
    
    @staticmethod
    def save_word_lookup(user_id: int, word: str, context_sentence: str = None,
                        article_position: int = None, reading_session_id: int = None) -> bool:
        """
        Save a word lookup event.
        
        Args:
            user_id: User ID
            word: The looked up word
            context_sentence: Optional context sentence
            article_position: Optional position in article
            reading_session_id: Optional reading session ID
            
        Returns:
            True if saved successfully, False otherwise
        """
        try:
            # Get word definition to ensure it exists
            definition_data = DictionaryService.get_word_definition(word)
            
            # Track the lookup
            DictionaryService._track_word_lookup(
                user_id=user_id,
                word=word,
                definition_data=definition_data,
                context_sentence=context_sentence,
                article_position=article_position,
                reading_session_id=reading_session_id
            )
            
            return True
            
        except Exception as e:
            current_app.logger.error(f"Error saving word lookup: {str(e)}")
            return False