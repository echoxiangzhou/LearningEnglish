import { useState } from 'react'
import './App.css'
import ImportManager from './components/admin/ImportManager'
import './components/admin/ImportManager.css'
import WordCardViewer from './components/vocabulary/WordCardViewer'
import DictationPractice from './components/dictation/DictationPractice'
import type { Word } from './types/vocabulary'

// Sample data for testing the WordCard component
const sampleWords: Word[] = [
  {
    id: 1,
    word: "vocabulary",
    phonetic: "/vəˈkæbjʊˌlɛri/",
    definition: "All the words used by a particular person, or all the words that exist in a particular language or subject.",
    part_of_speech: "noun",
    grade_level: 6,
    frequency: 2000,
    difficulty: 3,
    created_at: new Date().toISOString(),
    updated_at: new Date().toISOString()
  },
  {
    id: 2,
    word: "pronunciation",
    phonetic: "/prəˌnʌnsiˈeɪʃən/",
    definition: "The way in which a word is pronounced, especially the accepted standard way.",
    part_of_speech: "noun", 
    grade_level: 7,
    frequency: 3500,
    difficulty: 4,
    created_at: new Date().toISOString(),
    updated_at: new Date().toISOString()
  },
  {
    id: 3,
    word: "learning",
    phonetic: "/ˈlɜrnɪŋ/",
    definition: "The acquisition of knowledge or skills through experience, study, or by being taught.",
    part_of_speech: "noun",
    grade_level: 4,
    frequency: 800,
    difficulty: 2,
    created_at: new Date().toISOString(),
    updated_at: new Date().toISOString()
  }
];

function App() {
  const [currentView, setCurrentView] = useState<'home' | 'dictation' | 'vocabulary' | 'import'>('home')
  const [words, setWords] = useState<Word[]>(sampleWords)

  return (
    <div className="app">
      <header className="app-header">
        <h1>Smart English Learning</h1>
        <nav className="app-nav">
          <button 
            className={currentView === 'home' ? 'active' : ''}
            onClick={() => setCurrentView('home')}
          >
            Dashboard
          </button>
          <button 
            className={currentView === 'dictation' ? 'active' : ''}
            onClick={() => setCurrentView('dictation')}
          >
            听写练习
          </button>
          <button 
            className={currentView === 'vocabulary' ? 'active' : ''}
            onClick={() => setCurrentView('vocabulary')}
          >
            Vocabulary
          </button>
          <button 
            className={currentView === 'import' ? 'active' : ''}
            onClick={() => setCurrentView('import')}
          >
            Content Import
          </button>
        </nav>
      </header>

      <main className="app-main">
        {currentView === 'home' && (
          <div className="dashboard">
            <h2>Welcome to Smart English Learning</h2>
            <p>选择"听写练习"进行听写训练，"Vocabulary"练习单词卡片，或"Content Import"管理文件。</p>
          </div>
        )}
        
        {currentView === 'dictation' && (
          <DictationPractice 
            onExit={() => setCurrentView('home')}
          />
        )}
        
        {currentView === 'vocabulary' && (
          <div className="vocabulary-section">
            <h2>Vocabulary Practice</h2>
            <WordCardViewer 
              words={words}
              onWordsChange={setWords}
              showDifficulty={true}
              showProgress={true}
              autoLoadUserVocabulary={false}
            />
          </div>
        )}
        
        {currentView === 'import' && (
          <ImportManager />
        )}
      </main>
    </div>
  )
}

export default App
