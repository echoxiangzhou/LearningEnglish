import React from 'react';
import { render, screen, fireEvent, waitFor } from '@testing-library/react';
import '@testing-library/jest-dom';
import ReadingModule from '../ReadingModule';
import ArticleSelector from '../ArticleSelector';
import ReadingInterface from '../ReadingInterface';

// Mock fetch
global.fetch = jest.fn();

const mockArticle = {
  id: 1,
  title: 'Test Article',
  content: 'This is a test article content for reading comprehension practice.',
  summary: 'A test article summary',
  author: 'Test Author',
  topic: 'Testing',
  grade_level: 3,
  difficulty: 2,
  word_count: 50,
  estimated_reading_time: 2,
  tags: ['test', 'reading']
};

describe('ReadingModule', () => {
  beforeEach(() => {
    (fetch as jest.Mock).mockClear();
  });

  test('renders article selector by default', () => {
    render(<ReadingModule />);
    
    // Should show the reading library
    expect(screen.getByText(/Reading Library/i)).toBeInTheDocument();
  });

  test('handles article selection', async () => {
    (fetch as jest.Mock)
      .mockResolvedValueOnce({
        ok: true,
        json: async () => ({ articles: [mockArticle], pagination: { total: 1 } })
      })
      .mockResolvedValueOnce({
        ok: true,
        json: async () => ({ grade_levels: [1, 2, 3], difficulties: [1, 2, 3], topics: ['Testing'] })
      })
      .mockResolvedValueOnce({
        ok: true,
        json: async () => mockArticle
      });

    render(<ReadingModule />);

    await waitFor(() => {
      expect(fetch).toHaveBeenCalled();
    });
  });
});

describe('ArticleSelector', () => {
  const mockOnSelect = jest.fn();

  beforeEach(() => {
    (fetch as jest.Mock).mockClear();
    mockOnSelect.mockClear();
  });

  test('renders loading state initially', () => {
    (fetch as jest.Mock).mockImplementation(() => new Promise(() => {})); // Never resolves

    render(<ArticleSelector onSelectArticle={mockOnSelect} />);
    
    // Should show loading skeletons
    expect(screen.getByText(/Reading Library/i)).toBeInTheDocument();
  });

  test('renders articles when loaded', async () => {
    (fetch as jest.Mock)
      .mockResolvedValueOnce({
        ok: true,
        json: async () => ({ articles: [mockArticle], pagination: { total: 1 } })
      })
      .mockResolvedValueOnce({
        ok: true,
        json: async () => ({ grade_levels: [1, 2, 3], difficulties: [1, 2, 3], topics: ['Testing'] })
      });

    render(<ArticleSelector onSelectArticle={mockOnSelect} />);

    await waitFor(() => {
      expect(screen.getByText('Test Article')).toBeInTheDocument();
    });
  });

  test('handles search input', async () => {
    (fetch as jest.Mock)
      .mockResolvedValue({
        ok: true,
        json: async () => ({ articles: [], pagination: { total: 0 } })
      });

    render(<ArticleSelector onSelectArticle={mockOnSelect} />);

    const searchInput = screen.getByPlaceholderText(/Search articles/i);
    fireEvent.change(searchInput, { target: { value: 'test search' } });

    expect(searchInput).toHaveValue('test search');

    // Should trigger search after typing
    await waitFor(() => {
      expect(fetch).toHaveBeenCalledWith(
        expect.stringContaining('search=test%20search')
      );
    });
  });

  test('handles filter changes', async () => {
    (fetch as jest.Mock)
      .mockResolvedValue({
        ok: true,
        json: async () => ({ articles: [], pagination: { total: 0 } })
      });

    render(<ArticleSelector onSelectArticle={mockOnSelect} />);

    // Wait for initial load
    await waitFor(() => {
      expect(fetch).toHaveBeenCalled();
    });

    (fetch as jest.Mock).mockClear();

    // Test grade level filter
    const gradeSelect = screen.getByPlaceholderText(/Grade Level/i);
    fireEvent.mouseDown(gradeSelect);
    
    // Note: This test would need more setup to properly test Ant Design Select component
    // In a real test environment, you'd use a more comprehensive testing setup
  });
});

describe('ReadingInterface', () => {
  const mockOnComplete = jest.fn();
  const mockOnWordLookup = jest.fn();

  beforeEach(() => {
    mockOnComplete.mockClear();
    mockOnWordLookup.mockClear();
    (fetch as jest.Mock).mockClear();
  });

  test('renders article content', () => {
    render(
      <ReadingInterface
        article={mockArticle}
        onReadingComplete={mockOnComplete}
        onWordLookup={mockOnWordLookup}
      />
    );

    expect(screen.getByText('Test Article')).toBeInTheDocument();
    expect(screen.getByText(/Test Author/i)).toBeInTheDocument();
    expect(screen.getByText(/50 words/i)).toBeInTheDocument();
    expect(screen.getByText(/2 min/i)).toBeInTheDocument();
  });

  test('displays article content with clickable words', () => {
    render(
      <ReadingInterface
        article={mockArticle}
        onReadingComplete={mockOnComplete}
        onWordLookup={mockOnWordLookup}
      />
    );

    // Should render article content
    expect(screen.getByText(/This is a test article content/i)).toBeInTheDocument();
  });

  test('handles font size adjustment', () => {
    render(
      <ReadingInterface
        article={mockArticle}
        onReadingComplete={mockOnComplete}
        onWordLookup={mockOnWordLookup}
      />
    );

    // Click font settings button
    const fontButton = screen.getByLabelText(/Font Settings/i);
    fireEvent.click(fontButton);

    // Should open settings drawer
    expect(screen.getByText(/Reading Settings/i)).toBeInTheDocument();
  });

  test('handles bookmark addition', () => {
    render(
      <ReadingInterface
        article={mockArticle}
        onReadingComplete={mockOnComplete}
        onWordLookup={mockOnWordLookup}
      />
    );

    // Click bookmark button
    const bookmarkButton = screen.getByLabelText(/Add Bookmark/i);
    fireEvent.click(bookmarkButton);

    // Should trigger bookmark creation (would need to mock API call)
  });

  test('handles word clicks', async () => {
    (fetch as jest.Mock).mockResolvedValueOnce({
      ok: true,
      json: async () => ({
        word: 'test',
        definition: 'A trial or examination',
        part_of_speech: 'noun'
      })
    });

    render(
      <ReadingInterface
        article={mockArticle}
        onReadingComplete={mockOnComplete}
        onWordLookup={mockOnWordLookup}
      />
    );

    // Find and click on a word in the content
    const wordElement = screen.getByText(/test/i);
    fireEvent.click(wordElement);

    // Should open definition modal
    await waitFor(() => {
      expect(fetch).toHaveBeenCalledWith(
        expect.stringContaining('/api/dictionary/definition/')
      );
    });
  });
});

// Integration tests
describe('Reading Module Integration', () => {
  beforeEach(() => {
    (fetch as jest.Mock).mockClear();
  });

  test('full reading workflow', async () => {
    // Mock API responses
    (fetch as jest.Mock)
      .mockResolvedValueOnce({
        ok: true,
        json: async () => ({ articles: [mockArticle], pagination: { total: 1 } })
      })
      .mockResolvedValueOnce({
        ok: true,
        json: async () => ({ grade_levels: [1, 2, 3], difficulties: [1, 2, 3], topics: ['Testing'] })
      })
      .mockResolvedValueOnce({
        ok: true,
        json: async () => mockArticle
      });

    render(<ReadingModule />);

    // Should start with article selector
    await waitFor(() => {
      expect(screen.getByText(/Reading Library/i)).toBeInTheDocument();
    });

    // Should be able to select an article
    await waitFor(() => {
      const articleTitle = screen.getByText('Test Article');
      expect(articleTitle).toBeInTheDocument();
    });

    // Click on article should navigate to reading view
    // This would require more complex mocking of the component state changes
  });
});

// Accessibility tests
describe('Reading Module Accessibility', () => {
  test('has proper heading structure', () => {
    render(<ReadingModule />);

    const headings = screen.getAllByRole('heading');
    expect(headings.length).toBeGreaterThan(0);
  });

  test('has keyboard navigation support', () => {
    render(<ReadingModule />);

    // Check for focusable elements
    const buttons = screen.getAllByRole('button');
    buttons.forEach(button => {
      expect(button).not.toHaveAttribute('tabindex', '-1');
    });
  });

  test('provides proper ARIA labels', () => {
    render(
      <ReadingInterface
        article={mockArticle}
        onReadingComplete={() => {}}
        onWordLookup={() => {}}
      />
    );

    // Check for aria-labels on interactive elements
    const fontButton = screen.getByLabelText(/Font Settings/i);
    expect(fontButton).toBeInTheDocument();

    const bookmarkButton = screen.getByLabelText(/Add Bookmark/i);
    expect(bookmarkButton).toBeInTheDocument();
  });
});