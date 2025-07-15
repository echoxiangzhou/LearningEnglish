"""
Pattern Library Service

Manages comprehensive grammar pattern libraries and templates for sentence generation.
"""

import json
import os
from typing import List, Dict, Optional
from dataclasses import dataclass, asdict
from enum import Enum
import logging

from .sentence_generation_service import DifficultyLevel, SentencePattern, GenerationPattern

logger = logging.getLogger(__name__)


class GrammarComplexity(Enum):
    """Grammar complexity levels"""
    SIMPLE = "simple"      # Basic subject-verb patterns
    COMPOUND = "compound"  # Multiple clauses
    COMPLEX = "complex"    # Dependent clauses


@dataclass
class ExtendedPattern:
    """Extended pattern with more detailed configuration"""
    id: str
    pattern_type: SentencePattern
    template: str
    difficulty: DifficultyLevel
    complexity: GrammarComplexity
    pos_requirements: Dict[str, List[str]]
    semantic_constraints: Dict[str, List[str]]
    example: str
    variations: List[str]
    weight: float  # Priority weight for selection


class PatternLibraryService:
    """Service for managing sentence generation patterns"""
    
    def __init__(self):
        self.patterns: List[ExtendedPattern] = []
        self.patterns_by_difficulty: Dict[DifficultyLevel, List[ExtendedPattern]] = {}
        self.patterns_by_type: Dict[SentencePattern, List[ExtendedPattern]] = {}
        self.load_default_patterns()
    
    def load_default_patterns(self):
        """Load default pattern library"""
        default_patterns = [
            # Elementary patterns
            ExtendedPattern(
                id="elem_svo_1",
                pattern_type=SentencePattern.SVO,
                template="The {noun} {verb} the {object}.",
                difficulty=DifficultyLevel.ELEMENTARY,
                complexity=GrammarComplexity.SIMPLE,
                pos_requirements={
                    "noun": ["NOUN"],
                    "verb": ["VERB"],
                    "object": ["NOUN"]
                },
                semantic_constraints={
                    "noun": ["animal", "person", "thing"],
                    "verb": ["action", "state"],
                    "object": ["food", "toy", "thing"]
                },
                example="The cat eats the fish.",
                variations=[
                    "A {noun} {verb} a {object}.",
                    "My {noun} {verb} the {object}.",
                    "This {noun} {verb} that {object}."
                ],
                weight=1.0
            ),
            
            ExtendedPattern(
                id="elem_svc_1",
                pattern_type=SentencePattern.SVC,
                template="The {noun} is {adjective}.",
                difficulty=DifficultyLevel.ELEMENTARY,
                complexity=GrammarComplexity.SIMPLE,
                pos_requirements={
                    "noun": ["NOUN"],
                    "adjective": ["ADJ"]
                },
                semantic_constraints={
                    "noun": ["animal", "person", "thing"],
                    "adjective": ["color", "size", "quality"]
                },
                example="The flower is beautiful.",
                variations=[
                    "A {noun} is {adjective}.",
                    "My {noun} is {adjective}.",
                    "This {noun} is very {adjective}."
                ],
                weight=1.0
            ),
            
            ExtendedPattern(
                id="elem_sv_1",
                pattern_type=SentencePattern.SV,
                template="{noun} {verb}.",
                difficulty=DifficultyLevel.ELEMENTARY,
                complexity=GrammarComplexity.SIMPLE,
                pos_requirements={
                    "noun": ["NOUN", "PRON"],
                    "verb": ["VERB"]
                },
                semantic_constraints={
                    "noun": ["animal", "person"],
                    "verb": ["action", "state"]
                },
                example="Birds fly.",
                variations=[
                    "The {noun} {verb}.",
                    "{noun} {verb} well.",
                    "{noun} {verb} every day."
                ],
                weight=0.8
            ),
            
            # Intermediate patterns
            ExtendedPattern(
                id="inter_sva_1",
                pattern_type=SentencePattern.SVA,
                template="{subject} {verb} {adverb}.",
                difficulty=DifficultyLevel.INTERMEDIATE,
                complexity=GrammarComplexity.SIMPLE,
                pos_requirements={
                    "subject": ["NOUN", "PRON"],
                    "verb": ["VERB"],
                    "adverb": ["ADV"]
                },
                semantic_constraints={
                    "subject": ["person", "animal"],
                    "verb": ["action"],
                    "adverb": ["manner", "time", "place"]
                },
                example="She runs quickly.",
                variations=[
                    "The {subject} {verb} {adverb}.",
                    "{subject} {verb} very {adverb}.",
                    "{subject} always {verb} {adverb}."
                ],
                weight=1.0
            ),
            
            ExtendedPattern(
                id="inter_compound_1",
                pattern_type=SentencePattern.SVO,
                template="{subject} {verb} {object} and {verb2} {object2}.",
                difficulty=DifficultyLevel.INTERMEDIATE,
                complexity=GrammarComplexity.COMPOUND,
                pos_requirements={
                    "subject": ["NOUN", "PRON"],
                    "verb": ["VERB"],
                    "object": ["NOUN"],
                    "verb2": ["VERB"],
                    "object2": ["NOUN"]
                },
                semantic_constraints={
                    "subject": ["person", "animal"],
                    "verb": ["action"],
                    "object": ["thing", "food"],
                    "verb2": ["action"],
                    "object2": ["thing", "food"]
                },
                example="She reads books and writes stories.",
                variations=[
                    "The {subject} {verb} {object} but {verb2} {object2}.",
                    "{subject} {verb} {object} or {verb2} {object2}."
                ],
                weight=0.7
            ),
            
            # Advanced patterns
            ExtendedPattern(
                id="adv_svoo_1",
                pattern_type=SentencePattern.SVOO,
                template="{subject} {verb} {object1} {object2}.",
                difficulty=DifficultyLevel.ADVANCED,
                complexity=GrammarComplexity.COMPLEX,
                pos_requirements={
                    "subject": ["NOUN", "PRON"],
                    "verb": ["VERB"],
                    "object1": ["NOUN", "PRON"],
                    "object2": ["NOUN"]
                },
                semantic_constraints={
                    "subject": ["person"],
                    "verb": ["transfer", "communication"],
                    "object1": ["person"],
                    "object2": ["thing", "information"]
                },
                example="I gave him a book.",
                variations=[
                    "The {subject} {verb} {object1} a {object2}.",
                    "{subject} {verb} {object1} the {object2}.",
                    "{subject} {verb} {object1} some {object2}."
                ],
                weight=0.6
            ),
            
            ExtendedPattern(
                id="adv_complex_1",
                pattern_type=SentencePattern.SVO,
                template="When {subject} {verb} {object}, {subject2} {verb2} {object2}.",
                difficulty=DifficultyLevel.ADVANCED,
                complexity=GrammarComplexity.COMPLEX,
                pos_requirements={
                    "subject": ["NOUN", "PRON"],
                    "verb": ["VERB"],
                    "object": ["NOUN"],
                    "subject2": ["NOUN", "PRON"],
                    "verb2": ["VERB"],
                    "object2": ["NOUN"]
                },
                semantic_constraints={
                    "subject": ["person", "animal"],
                    "verb": ["action"],
                    "object": ["thing"],
                    "subject2": ["person", "animal"],
                    "verb2": ["action", "state"],
                    "object2": ["thing"]
                },
                example="When she reads books, he watches TV.",
                variations=[
                    "If {subject} {verb} {object}, {subject2} {verb2} {object2}.",
                    "Because {subject} {verb} {object}, {subject2} {verb2} {object2}.",
                    "While {subject} {verb} {object}, {subject2} {verb2} {object2}."
                ],
                weight=0.5
            )
        ]
        
        self.patterns = default_patterns
        self._index_patterns()
    
    def _index_patterns(self):
        """Create indexes for quick pattern lookup"""
        self.patterns_by_difficulty = {}
        self.patterns_by_type = {}
        
        for pattern in self.patterns:
            # Index by difficulty
            if pattern.difficulty not in self.patterns_by_difficulty:
                self.patterns_by_difficulty[pattern.difficulty] = []
            self.patterns_by_difficulty[pattern.difficulty].append(pattern)
            
            # Index by pattern type
            if pattern.pattern_type not in self.patterns_by_type:
                self.patterns_by_type[pattern.pattern_type] = []
            self.patterns_by_type[pattern.pattern_type].append(pattern)
    
    def get_patterns_by_difficulty(self, difficulty: DifficultyLevel) -> List[ExtendedPattern]:
        """Get all patterns for a specific difficulty level"""
        return self.patterns_by_difficulty.get(difficulty, [])
    
    def get_patterns_by_type(self, pattern_type: SentencePattern) -> List[ExtendedPattern]:
        """Get all patterns of a specific type"""
        return self.patterns_by_type.get(pattern_type, [])
    
    def get_suitable_patterns(self, target_word_pos: str, 
                            difficulty: DifficultyLevel,
                            complexity: Optional[GrammarComplexity] = None) -> List[ExtendedPattern]:
        """Get patterns suitable for a word with specific POS"""
        suitable_patterns = []
        
        difficulty_patterns = self.get_patterns_by_difficulty(difficulty)
        
        for pattern in difficulty_patterns:
            # Check if target word can fit in any slot
            can_fit = False
            for slot, required_pos in pattern.pos_requirements.items():
                if target_word_pos in required_pos:
                    can_fit = True
                    break
            
            if can_fit:
                # Apply complexity filter if specified
                if complexity is None or pattern.complexity == complexity:
                    suitable_patterns.append(pattern)
        
        # Sort by weight (descending)
        suitable_patterns.sort(key=lambda x: x.weight, reverse=True)
        return suitable_patterns
    
    def add_custom_pattern(self, pattern: ExtendedPattern):
        """Add a custom pattern to the library"""
        # Check if pattern ID already exists
        existing_ids = [p.id for p in self.patterns]
        if pattern.id in existing_ids:
            raise ValueError(f"Pattern with ID '{pattern.id}' already exists")
        
        self.patterns.append(pattern)
        self._index_patterns()
        logger.info(f"Added custom pattern: {pattern.id}")
    
    def remove_pattern(self, pattern_id: str) -> bool:
        """Remove a pattern from the library"""
        original_count = len(self.patterns)
        self.patterns = [p for p in self.patterns if p.id != pattern_id]
        
        if len(self.patterns) < original_count:
            self._index_patterns()
            logger.info(f"Removed pattern: {pattern_id}")
            return True
        
        return False
    
    def get_pattern_variations(self, pattern_id: str) -> List[str]:
        """Get all variations of a specific pattern"""
        for pattern in self.patterns:
            if pattern.id == pattern_id:
                return [pattern.template] + pattern.variations
        
        return []
    
    def export_patterns(self, file_path: str):
        """Export patterns to JSON file"""
        patterns_data = [asdict(pattern) for pattern in self.patterns]
        
        # Convert enums to strings for JSON serialization
        for pattern_data in patterns_data:
            pattern_data['pattern_type'] = pattern_data['pattern_type'].value
            pattern_data['difficulty'] = pattern_data['difficulty'].value
            pattern_data['complexity'] = pattern_data['complexity'].value
        
        with open(file_path, 'w', encoding='utf-8') as f:
            json.dump(patterns_data, f, indent=2, ensure_ascii=False)
        
        logger.info(f"Exported {len(self.patterns)} patterns to {file_path}")
    
    def import_patterns(self, file_path: str):
        """Import patterns from JSON file"""
        if not os.path.exists(file_path):
            raise FileNotFoundError(f"Pattern file not found: {file_path}")
        
        with open(file_path, 'r', encoding='utf-8') as f:
            patterns_data = json.load(f)
        
        imported_patterns = []
        for pattern_data in patterns_data:
            # Convert string enums back to enum objects
            pattern_data['pattern_type'] = SentencePattern(pattern_data['pattern_type'])
            pattern_data['difficulty'] = DifficultyLevel(pattern_data['difficulty'])
            pattern_data['complexity'] = GrammarComplexity(pattern_data['complexity'])
            
            pattern = ExtendedPattern(**pattern_data)
            imported_patterns.append(pattern)
        
        # Add imported patterns (skip duplicates)
        existing_ids = [p.id for p in self.patterns]
        new_patterns = [p for p in imported_patterns if p.id not in existing_ids]
        
        self.patterns.extend(new_patterns)
        self._index_patterns()
        
        logger.info(f"Imported {len(new_patterns)} new patterns from {file_path}")
    
    def get_pattern_stats(self) -> Dict:
        """Get statistics about the pattern library"""
        stats = {
            "total_patterns": len(self.patterns),
            "by_difficulty": {},
            "by_complexity": {},
            "by_type": {}
        }
        
        for pattern in self.patterns:
            # Count by difficulty
            diff_key = pattern.difficulty.value
            stats["by_difficulty"][diff_key] = stats["by_difficulty"].get(diff_key, 0) + 1
            
            # Count by complexity
            comp_key = pattern.complexity.value
            stats["by_complexity"][comp_key] = stats["by_complexity"].get(comp_key, 0) + 1
            
            # Count by type
            type_key = pattern.pattern_type.value
            stats["by_type"][type_key] = stats["by_type"].get(type_key, 0) + 1
        
        return stats