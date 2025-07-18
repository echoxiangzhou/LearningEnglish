import React, { useState, useEffect } from 'react';
import { 
  Card, 
  CardContent, 
  CardHeader, 
  CardTitle 
} from '@/components/ui/card';
import { 
  Badge, 
  Button 
} from '@/components/ui';
import { 
  BookOpen, 
  Clock, 
  ArrowRight, 
  RefreshCw,
  Star,
  Target
} from 'lucide-react';
import './ArticleRecommendations.css';

interface SimpleArticle {
  id: number;
  title: string;
  difficulty_level: number;
  word_count: number;
  reading_time: number;
  category: string;
  tags: string[];
  recommendation_score: number;
  reasons: string[];
}

interface ArticleRecommendationsProps {
  limit?: number;
  showTitle?: boolean;
  compact?: boolean;
  onArticleSelect?: (articleId: number) => void;
  className?: string;
}

const ArticleRecommendations: React.FC<ArticleRecommendationsProps> = ({
  limit = 6,
  showTitle = true,
  compact = false,
  onArticleSelect,
  className = ''
}) => {
  const [recommendations, setRecommendations] = useState<SimpleArticle[]>([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState<string | null>(null);

  const fetchRecommendations = async () => {
    try {
      setLoading(true);
      const response = await fetch(`/api/reading/recommendations/simple?limit=${limit}`, {
        headers: {
          'Authorization': `Bearer ${localStorage.getItem('access_token')}`
        }
      });

      if (!response.ok) {
        throw new Error('Failed to fetch recommendations');
      }

      const data = await response.json();
      setRecommendations(data.recommendations || []);
      setError(null);
    } catch (err) {
      setError(err instanceof Error ? err.message : 'An error occurred');
    } finally {
      setLoading(false);
    }
  };

  useEffect(() => {
    fetchRecommendations();
  }, [limit]);

  const getDifficultyColor = (level: number): string => {
    const colors = ['#22c55e', '#84cc16', '#eab308', '#f97316', '#ef4444'];
    return colors[Math.min(level - 1, 4)] || '#6b7280';
  };

  const getDifficultyLabel = (level: number): string => {
    const labels = ['Very Easy', 'Easy', 'Medium', 'Hard', 'Very Hard'];
    return labels[Math.min(level - 1, 4)] || 'Unknown';
  };

  const handleArticleClick = (articleId: number) => {
    if (onArticleSelect) {
      onArticleSelect(articleId);
    } else {
      window.location.href = `/reading/article/${articleId}`;
    }
  };

  if (loading) {
    return (
      <div className={`article-recommendations ${className}`}>
        {showTitle && (
          <div className="recommendations-header mb-4">
            <h3 className="text-lg font-semibold flex items-center gap-2">
              <Target className="w-5 h-5" />
              Recommended for You
            </h3>
          </div>
        )}
        <div className="space-y-4">
          {Array.from({ length: 3 }).map((_, index) => (
            <Card key={index} className="animate-pulse">
              <CardContent className="p-4">
                <div className="space-y-3">
                  <div className="h-4 bg-gray-200 rounded w-3/4"></div>
                  <div className="h-3 bg-gray-200 rounded w-1/2"></div>
                  <div className="h-3 bg-gray-200 rounded w-1/4"></div>
                </div>
              </CardContent>
            </Card>
          ))}
        </div>
      </div>
    );
  }

  if (error) {
    return (
      <div className={`article-recommendations ${className}`}>
        {showTitle && (
          <div className="recommendations-header mb-4">
            <h3 className="text-lg font-semibold flex items-center gap-2">
              <Target className="w-5 h-5" />
              Recommended for You
            </h3>
          </div>
        )}
        <Card>
          <CardContent className="p-4 text-center">
            <p className="text-red-600 mb-3">{error}</p>
            <Button size="sm" onClick={fetchRecommendations} variant="outline">
              <RefreshCw className="w-4 h-4 mr-2" />
              Try Again
            </Button>
          </CardContent>
        </Card>
      </div>
    );
  }

  if (!recommendations.length) {
    return (
      <div className={`article-recommendations ${className}`}>
        {showTitle && (
          <div className="recommendations-header mb-4">
            <h3 className="text-lg font-semibold flex items-center gap-2">
              <Target className="w-5 h-5" />
              Recommended for You
            </h3>
          </div>
        )}
        <Card>
          <CardContent className="p-4 text-center">
            <BookOpen className="w-8 h-8 mx-auto mb-2 text-gray-300" />
            <p className="text-gray-500">No recommendations available</p>
            <p className="text-sm text-gray-400 mt-1">Start reading to get personalized suggestions!</p>
          </CardContent>
        </Card>
      </div>
    );
  }

  return (
    <div className={`article-recommendations ${className}`}>
      {showTitle && (
        <div className="recommendations-header mb-4 flex items-center justify-between">
          <h3 className="text-lg font-semibold flex items-center gap-2">
            <Target className="w-5 h-5" />
            Recommended for You
          </h3>
          <Button 
            size="sm" 
            variant="ghost" 
            onClick={fetchRecommendations}
            className="text-gray-500 hover:text-gray-700"
          >
            <RefreshCw className="w-4 h-4" />
          </Button>
        </div>
      )}

      <div className={`recommendations-grid ${compact ? 'compact' : ''}`}>
        {recommendations.map((article) => (
          <Card 
            key={article.id} 
            className="recommendation-item cursor-pointer hover:shadow-md transition-shadow duration-200"
            onClick={() => handleArticleClick(article.id)}
          >
            <CardContent className={compact ? 'p-3' : 'p-4'}>
              <div className="space-y-3">
                {/* Article Title */}
                <div className="flex items-start justify-between gap-2">
                  <h4 className={`font-medium line-clamp-2 ${compact ? 'text-sm' : 'text-base'}`}>
                    {article.title}
                  </h4>
                  <Badge 
                    style={{ backgroundColor: getDifficultyColor(article.difficulty_level) }}
                    className="text-white text-xs flex-shrink-0"
                  >
                    {article.difficulty_level}
                  </Badge>
                </div>

                {/* Article Info */}
                <div className="flex items-center gap-3 text-sm text-gray-600">
                  <div className="flex items-center gap-1">
                    <Clock className="w-3 h-3" />
                    <span>{article.reading_time}m</span>
                  </div>
                  <span>•</span>
                  <span>{article.word_count} words</span>
                  <span>•</span>
                  <span className="capitalize">{article.category}</span>
                </div>

                {/* Recommendation Reason */}
                {article.reasons && article.reasons.length > 0 && (
                  <div className="text-xs text-gray-600 bg-gray-50 p-2 rounded flex items-start gap-1">
                    <Star className="w-3 h-3 text-yellow-500 mt-0.5 flex-shrink-0" />
                    <span className="line-clamp-2">{article.reasons[0]}</span>
                  </div>
                )}

                {/* Tags (if not compact) */}
                {!compact && article.tags && article.tags.length > 0 && (
                  <div className="flex flex-wrap gap-1">
                    {article.tags.slice(0, 2).map((tag, index) => (
                      <Badge key={index} variant="secondary" className="text-xs">
                        {tag}
                      </Badge>
                    ))}
                    {article.tags.length > 2 && (
                      <Badge variant="secondary" className="text-xs">
                        +{article.tags.length - 2}
                      </Badge>
                    )}
                  </div>
                )}

                {/* Action Button */}
                <div className="flex items-center justify-between pt-1">
                  <span className="text-xs text-gray-500">
                    Score: {Math.round(article.recommendation_score)}
                  </span>
                  <Button 
                    size="sm" 
                    className="flex items-center gap-1 text-xs"
                    onClick={(e) => {
                      e.stopPropagation();
                      handleArticleClick(article.id);
                    }}
                  >
                    Read
                    <ArrowRight className="w-3 h-3" />
                  </Button>
                </div>
              </div>
            </CardContent>
          </Card>
        ))}
      </div>

      {/* View All Link */}
      {recommendations.length > 0 && (
        <div className="mt-4 text-center">
          <Button 
            variant="outline" 
            size="sm"
            onClick={() => window.location.href = '/reading/recommendations'}
            className="w-full sm:w-auto"
          >
            View All Recommendations
            <ArrowRight className="w-4 h-4 ml-2" />
          </Button>
        </div>
      )}
    </div>
  );
};

export default ArticleRecommendations;