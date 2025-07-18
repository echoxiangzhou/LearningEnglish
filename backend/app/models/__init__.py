from app.models.user import User
from app.models.word import Word
from app.models.sentence import Sentence, sentence_words
from app.models.learning_session import (
    LearningSession, Progress, UserWordProgress, AdminSettings
)
from app.models.article import (
    Article, ComprehensionQuestion, ReadingSession, 
    QuestionAttempt, WordLookup
)
from app.models.content_import import (
    ContentImport, GeneratedContent, ContentTemplate,
    SystemLog, AuditLog
)
from app.models.generated_sentence import (
    GeneratedSentence, SentenceGenerationPattern, WordAnalysis
)
from app.models.dictation_practice import (
    DictationSession, DictationWordAttempt, DictationProgress,
    DictationSettings, DictationDifficulty, HintType
)
from app.models.vocabulary_library import (
    VocabularyLibrary, LibraryAssignment, LibraryType, GradeLevel,
    library_words
)
from app.models.analytics import (
    UserProgress, LearningStats, UserAchievements, ErrorAnalysis,
    LearningRecommendations, AnalyticsCache, ModuleType, ActivityType,
    CompletionStatus, AchievementType, ErrorCategory, RecommendationType
)
from app.models.user_category import UserCategoryAssignment
from app.models.word_error import (
    WordError, ErrorPattern, ErrorReview, ErrorType
)

__all__ = [
    'User', 'Word', 'Sentence', 'sentence_words',
    'LearningSession', 'Progress', 'UserWordProgress', 'AdminSettings',
    'Article', 'ComprehensionQuestion', 'ReadingSession', 
    'QuestionAttempt', 'WordLookup',
    'ContentImport', 'GeneratedContent', 'ContentTemplate',
    'SystemLog', 'AuditLog',
    'GeneratedSentence', 'SentenceGenerationPattern', 'WordAnalysis',
    'DictationSession', 'DictationWordAttempt', 'DictationProgress',
    'DictationSettings', 'DictationDifficulty', 'HintType',
    'VocabularyLibrary', 'LibraryAssignment', 'LibraryType', 'GradeLevel',
    'library_words',
    'UserProgress', 'LearningStats', 'UserAchievements', 'ErrorAnalysis',
    'LearningRecommendations', 'AnalyticsCache', 'ModuleType', 'ActivityType',
    'CompletionStatus', 'AchievementType', 'ErrorCategory', 'RecommendationType',
    'UserCategoryAssignment',
    'WordError', 'ErrorPattern', 'ErrorReview', 'ErrorType'
]