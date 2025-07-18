import React, { useState, useEffect } from 'react';
import { 
  Card, 
  CardContent, 
  CardHeader, 
  CardTitle 
} from '@/components/ui/card';
import { 
  Badge, 
  Button, 
  Tabs, 
  TabsContent, 
  TabsList, 
  TabsTab 
} from '@/components/ui';
import { 
  BookOpen, 
  Clock, 
  TrendingUp, 
  Target, 
  Sparkles, 
  Users,
  BarChart3,
  Star,
  ArrowRight,
  RefreshCw
} from 'lucide-react';
import './RecommendationDashboard.css';

interface Article {
  id: number;
  title: string;
  difficulty_level: number;
  word_count: number;
  reading_time: number;
  category: string;
  tags: string[];
  recommendation_score: number;
  recommendation_type: string;
  reason: string;
  created_at?: string;
}

interface UserProfile {
  reading_level: number;
  avg_comprehension: number;
  avg_reading_speed: number;
  performance_trend: number;
  consistency_score: number;
  total_sessions: number;
  top_categories: string[];
}

interface RecommendationStats {
  total_articles: number;
  articles_read: number;
  completion_percentage: number;
  categories_explored: number;
  recommendations_generated: string;
}

interface RecommendationData {
  challenge: Article[];
  comfort: Article[];
  explore: Article[];
  trending: Article[];
  user_profile: UserProfile;
  recommendation_stats: RecommendationStats;
}

const RecommendationDashboard: React.FC = () => {
  const [recommendations, setRecommendations] = useState<RecommendationData | null>(null);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState<string | null>(null);
  const [activeTab, setActiveTab] = useState('challenge');
  const [refreshing, setRefreshing] = useState(false);

  const fetchRecommendations = async () => {
    try {
      setLoading(true);
      const response = await fetch('/api/reading/recommendations', {
        headers: {
          'Authorization': `Bearer ${localStorage.getItem('access_token')}`
        }
      });

      if (!response.ok) {
        throw new Error('Failed to fetch recommendations');
      }

      const data = await response.json();
      setRecommendations(data.recommendations);
      setError(null);
    } catch (err) {
      setError(err instanceof Error ? err.message : 'An error occurred');
    } finally {
      setLoading(false);
    }
  };

  const refreshRecommendations = async () => {
    setRefreshing(true);
    await fetchRecommendations();
    setRefreshing(false);
  };

  useEffect(() => {
    fetchRecommendations();
  }, []);

  const getDifficultyColor = (level: number): string => {
    const colors = ['#22c55e', '#84cc16', '#eab308', '#f97316', '#ef4444'];
    return colors[Math.min(level - 1, 4)] || '#6b7280';
  };

  const getDifficultyLabel = (level: number): string => {
    const labels = ['Very Easy', 'Easy', 'Medium', 'Hard', 'Very Hard'];
    return labels[Math.min(level - 1, 4)] || 'Unknown';
  };

  const getRecommendationIcon = (type: string) => {
    switch (type) {
      case 'challenge':
        return <Target className="w-5 h-5" />;
      case 'comfort':
        return <BookOpen className="w-5 h-5" />;
      case 'explore':
        return <Sparkles className="w-5 h-5" />;
      case 'trending':
        return <TrendingUp className="w-5 h-5" />;
      default:
        return <BookOpen className="w-5 h-5" />;
    }
  };

  const getTabDescription = (type: string): string => {
    switch (type) {
      case 'challenge':
        return 'Articles to challenge and improve your skills';
      case 'comfort':
        return 'Articles at your comfortable reading level';
      case 'explore':
        return 'New topics to expand your interests';
      case 'trending':
        return 'Popular articles among similar readers';
      default:
        return '';
    }
  };

  const ArticleCard: React.FC<{ article: Article; type: string }> = ({ article, type }) => (
    <Card className="recommendation-card hover:shadow-lg transition-shadow duration-200">
      <CardHeader className="pb-3">
        <div className="flex items-start justify-between">
          <div className="flex-1">
            <CardTitle className="text-lg font-semibold line-clamp-2 mb-2">
              {article.title}
            </CardTitle>
            <div className="flex items-center gap-2 text-sm text-gray-600 mb-2">
              <Clock className="w-4 h-4" />
              <span>{article.reading_time} min read</span>
              <span>•</span>
              <span>{article.word_count} words</span>
            </div>
          </div>
          <div className="flex items-center gap-2 ml-4">
            {getRecommendationIcon(type)}
            <Badge 
              style={{ backgroundColor: getDifficultyColor(article.difficulty_level) }}
              className="text-white text-xs"
            >
              {getDifficultyLabel(article.difficulty_level)}
            </Badge>
          </div>
        </div>
      </CardHeader>
      <CardContent>
        <div className="space-y-3">
          <div className="flex items-center justify-between">
            <span className="text-sm font-medium text-gray-700">Category:</span>
            <Badge variant="outline" className="text-xs">
              {article.category}
            </Badge>
          </div>
          
          <div className="text-sm text-gray-600 bg-gray-50 p-3 rounded-md">
            <div className="flex items-start gap-2">
              <Star className="w-4 h-4 text-yellow-500 mt-0.5 flex-shrink-0" />
              <span>{article.reason}</span>
            </div>
          </div>

          {article.tags && article.tags.length > 0 && (
            <div className="flex flex-wrap gap-1">
              {article.tags.slice(0, 3).map((tag, index) => (
                <Badge key={index} variant="secondary" className="text-xs">
                  {tag}
                </Badge>
              ))}
              {article.tags.length > 3 && (
                <Badge variant="secondary" className="text-xs">
                  +{article.tags.length - 3} more
                </Badge>
              )}
            </div>
          )}

          <div className="flex items-center justify-between pt-2">
            <div className="flex items-center gap-1 text-xs text-gray-500">
              <BarChart3 className="w-3 h-3" />
              <span>Score: {Math.round(article.recommendation_score)}</span>
            </div>
            <Button 
              size="sm" 
              className="flex items-center gap-1"
              onClick={() => window.location.href = `/reading/article/${article.id}`}
            >
              Start Reading
              <ArrowRight className="w-3 h-3" />
            </Button>
          </div>
        </div>
      </CardContent>
    </Card>
  );

  const UserProfileCard: React.FC<{ profile: UserProfile }> = ({ profile }) => (
    <Card className="user-profile-card">
      <CardHeader>
        <CardTitle className="flex items-center gap-2">
          <Users className="w-5 h-5" />
          Your Reading Profile
        </CardTitle>
      </CardHeader>
      <CardContent>
        <div className="grid grid-cols-2 gap-4">
          <div className="space-y-2">
            <div className="flex justify-between items-center">
              <span className="text-sm text-gray-600">Reading Level:</span>
              <Badge style={{ backgroundColor: getDifficultyColor(profile.reading_level) }}>
                Level {profile.reading_level}
              </Badge>
            </div>
            <div className="flex justify-between items-center">
              <span className="text-sm text-gray-600">Comprehension:</span>
              <span className="font-medium">{Math.round(profile.avg_comprehension)}%</span>
            </div>
            <div className="flex justify-between items-center">
              <span className="text-sm text-gray-600">Reading Speed:</span>
              <span className="font-medium">{Math.round(profile.avg_reading_speed)} wpm</span>
            </div>
          </div>
          <div className="space-y-2">
            <div className="flex justify-between items-center">
              <span className="text-sm text-gray-600">Trend:</span>
              <div className={`flex items-center gap-1 ${profile.performance_trend > 0 ? 'text-green-600' : profile.performance_trend < 0 ? 'text-red-600' : 'text-gray-600'}`}>
                <TrendingUp className={`w-3 h-3 ${profile.performance_trend < 0 ? 'rotate-180' : ''}`} />
                <span className="text-sm font-medium">
                  {profile.performance_trend > 0 ? 'Improving' : profile.performance_trend < 0 ? 'Declining' : 'Stable'}
                </span>
              </div>
            </div>
            <div className="flex justify-between items-center">
              <span className="text-sm text-gray-600">Consistency:</span>
              <span className="font-medium">{Math.round(profile.consistency_score * 100)}%</span>
            </div>
            <div className="flex justify-between items-center">
              <span className="text-sm text-gray-600">Sessions:</span>
              <span className="font-medium">{profile.total_sessions}</span>
            </div>
          </div>
        </div>
        {profile.top_categories.length > 0 && (
          <div className="mt-4 pt-4 border-t">
            <span className="text-sm text-gray-600 mb-2 block">Favorite Categories:</span>
            <div className="flex flex-wrap gap-1">
              {profile.top_categories.map((category, index) => (
                <Badge key={index} variant="outline" className="text-xs">
                  {category}
                </Badge>
              ))}
            </div>
          </div>
        )}
      </CardContent>
    </Card>
  );

  const StatsCard: React.FC<{ stats: RecommendationStats }> = ({ stats }) => (
    <Card className="stats-card">
      <CardHeader>
        <CardTitle className="flex items-center gap-2">
          <BarChart3 className="w-5 h-5" />
          Reading Statistics
        </CardTitle>
      </CardHeader>
      <CardContent>
        <div className="grid grid-cols-2 gap-4">
          <div className="text-center p-3 bg-blue-50 rounded-lg">
            <div className="text-2xl font-bold text-blue-600">{stats.articles_read}</div>
            <div className="text-sm text-gray-600">Articles Read</div>
          </div>
          <div className="text-center p-3 bg-green-50 rounded-lg">
            <div className="text-2xl font-bold text-green-600">{Math.round(stats.completion_percentage)}%</div>
            <div className="text-sm text-gray-600">Completion Rate</div>
          </div>
          <div className="text-center p-3 bg-purple-50 rounded-lg">
            <div className="text-2xl font-bold text-purple-600">{stats.categories_explored}</div>
            <div className="text-sm text-gray-600">Categories Explored</div>
          </div>
          <div className="text-center p-3 bg-orange-50 rounded-lg">
            <div className="text-2xl font-bold text-orange-600">{stats.total_articles}</div>
            <div className="text-sm text-gray-600">Total Available</div>
          </div>
        </div>
      </CardContent>
    </Card>
  );

  if (loading) {
    return (
      <div className="recommendation-dashboard">
        <div className="flex items-center justify-center h-64">
          <div className="flex items-center gap-3">
            <RefreshCw className="w-5 h-5 animate-spin" />
            <span>Loading recommendations...</span>
          </div>
        </div>
      </div>
    );
  }

  if (error) {
    return (
      <div className="recommendation-dashboard">
        <Card>
          <CardContent className="pt-6">
            <div className="text-center">
              <p className="text-red-600 mb-4">Error: {error}</p>
              <Button onClick={fetchRecommendations}>
                <RefreshCw className="w-4 h-4 mr-2" />
                Try Again
              </Button>
            </div>
          </CardContent>
        </Card>
      </div>
    );
  }

  if (!recommendations) {
    return (
      <div className="recommendation-dashboard">
        <Card>
          <CardContent className="pt-6">
            <div className="text-center">
              <p className="text-gray-600">No recommendations available</p>
            </div>
          </CardContent>
        </Card>
      </div>
    );
  }

  return (
    <div className="recommendation-dashboard">
      <div className="dashboard-header">
        <div className="flex items-center justify-between mb-6">
          <div>
            <h1 className="text-3xl font-bold text-gray-900">Reading Recommendations</h1>
            <p className="text-gray-600 mt-1">Personalized content suggestions based on your reading progress</p>
          </div>
          <Button 
            onClick={refreshRecommendations}
            disabled={refreshing}
            variant="outline"
            className="flex items-center gap-2"
          >
            <RefreshCw className={`w-4 h-4 ${refreshing ? 'animate-spin' : ''}`} />
            Refresh
          </Button>
        </div>

        <div className="grid grid-cols-1 lg:grid-cols-2 gap-6 mb-8">
          <UserProfileCard profile={recommendations.user_profile} />
          <StatsCard stats={recommendations.recommendation_stats} />
        </div>
      </div>

      <div className="recommendations-content">
        <Tabs value={activeTab} onValueChange={setActiveTab} className="w-full">
          <TabsList className="grid w-full grid-cols-4">
            <TabsTab value="challenge" className="flex items-center gap-2">
              <Target className="w-4 h-4" />
              Challenge
            </TabsTab>
            <TabsTab value="comfort" className="flex items-center gap-2">
              <BookOpen className="w-4 h-4" />
              Comfort
            </TabsTab>
            <TabsTab value="explore" className="flex items-center gap-2">
              <Sparkles className="w-4 h-4" />
              Explore
            </TabsTab>
            <TabsTab value="trending" className="flex items-center gap-2">
              <TrendingUp className="w-4 h-4" />
              Trending
            </TabsTab>
          </TabsList>

          {Object.entries(recommendations).map(([type, articles]) => {
            if (!Array.isArray(articles)) return null;
            
            return (
              <TabsContent key={type} value={type} className="mt-6">
                <div className="mb-4">
                  <h3 className="text-xl font-semibold mb-2">
                    {type.charAt(0).toUpperCase() + type.slice(1)} Articles
                  </h3>
                  <p className="text-gray-600">{getTabDescription(type)}</p>
                </div>
                
                {articles.length > 0 ? (
                  <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
                    {articles.map((article) => (
                      <ArticleCard 
                        key={article.id} 
                        article={article} 
                        type={type}
                      />
                    ))}
                  </div>
                ) : (
                  <Card>
                    <CardContent className="pt-6">
                      <div className="text-center text-gray-500">
                        <BookOpen className="w-12 h-12 mx-auto mb-3 text-gray-300" />
                        <p>No {type} recommendations available at the moment.</p>
                        <p className="text-sm mt-1">Try reading more articles to get better recommendations!</p>
                      </div>
                    </CardContent>
                  </Card>
                )}
              </TabsContent>
            );
          })}
        </Tabs>
      </div>
    </div>
  );
};

export default RecommendationDashboard;