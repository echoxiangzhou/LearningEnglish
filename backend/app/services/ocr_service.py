import os
import logging
import tempfile
from typing import Dict, List, Optional, Tuple
from pathlib import Path
import json

try:
    from magic_pdf.data.dataset import PyMuPDFDataset
    from magic_pdf.model.doc_analyze_by_custom_model import doc_analyze
    from magic_pdf.pipe.UNIPipe import UNIPipe
    from magic_pdf.pipe.OCRPipe import OCRPipe
    from magic_pdf.pipe.TXTPipe import TXTpipe
    MINERV_AVAILABLE = True
except ImportError:
    MINERV_AVAILABLE = False

import PyPDF2
import pdfplumber
from PIL import Image
import re


class OCRService:
    """Service for extracting text from PDF files using various methods"""
    
    def __init__(self):
        self.logger = logging.getLogger(__name__)
        
    def extract_text_from_pdf(self, file_path: str, method: str = "auto") -> Dict:
        """
        Extract text from PDF using specified method
        
        Args:
            file_path: Path to PDF file
            method: Extraction method ('auto', 'minerv', 'pypdf2', 'pdfplumber')
            
        Returns:
            Dict containing extracted text, metadata, and processing info
        """
        if not os.path.exists(file_path):
            raise FileNotFoundError(f"PDF file not found: {file_path}")
            
        result = {
            'success': False,
            'text': '',
            'pages': [],
            'method_used': method,
            'content_type': 'unknown',
            'quality_score': 0.0,
            'error': None,
            'metadata': {}
        }
        
        try:
            # Auto-detect best method
            if method == "auto":
                method = self._detect_best_method(file_path)
                result['method_used'] = method
            
            # Extract text using selected method
            if method == "minerv" and MINERV_AVAILABLE:
                result = self._extract_with_minerv(file_path, result)
            elif method == "pdfplumber":
                result = self._extract_with_pdfplumber(file_path, result)
            else:
                result = self._extract_with_pypdf2(file_path, result)
                
            # Post-process and analyze content
            if result['success']:
                result = self._analyze_content(result)
                
        except Exception as e:
            self.logger.error(f"Error extracting text from PDF: {str(e)}")
            result['error'] = str(e)
            
        return result
    
    def _detect_best_method(self, file_path: str) -> str:
        """Detect the best extraction method for a PDF"""
        try:
            # Try simple text extraction first
            with open(file_path, 'rb') as file:
                reader = PyPDF2.PdfReader(file)
                if len(reader.pages) > 0:
                    sample_text = reader.pages[0].extract_text()
                    if len(sample_text.strip()) > 50:
                        return "pypdf2"  # Text-based PDF
                        
            # If text extraction fails, try pdfplumber
            with pdfplumber.open(file_path) as pdf:
                if len(pdf.pages) > 0:
                    sample_text = pdf.pages[0].extract_text()
                    if sample_text and len(sample_text.strip()) > 50:
                        return "pdfplumber"
                        
            # Fall back to MinerV for image-based PDFs
            if MINERV_AVAILABLE:
                return "minerv"
            else:
                return "pdfplumber"  # Best available fallback
                
        except Exception as e:
            self.logger.warning(f"Error detecting best method: {str(e)}")
            return "pypdf2"  # Safe fallback
    
    def _extract_with_minerv(self, file_path: str, result: Dict) -> Dict:
        """Extract text using MinerV OCR"""
        if not MINERV_AVAILABLE:
            raise ImportError("MinerV not available")
            
        try:
            # Use MinerV for OCR processing
            with tempfile.TemporaryDirectory() as temp_dir:
                # Initialize MinerV pipeline
                pipe = UNIPipe(pdf_path=file_path, output_dir=temp_dir)
                
                # Process the PDF
                pipe_result = pipe.pipe_analyze()
                
                if pipe_result:
                    # Extract text from results
                    full_text = ""
                    pages = []
                    
                    for page_info in pipe_result:
                        page_text = page_info.get('text', '')
                        pages.append({
                            'page_number': page_info.get('page_id', len(pages) + 1),
                            'text': page_text,
                            'bbox_count': len(page_info.get('bboxes', [])),
                            'confidence': page_info.get('confidence', 0.0)
                        })
                        full_text += page_text + "\n\n"
                    
                    result.update({
                        'success': True,
                        'text': full_text.strip(),
                        'pages': pages,
                        'metadata': {
                            'total_pages': len(pages),
                            'avg_confidence': sum(p.get('confidence', 0) for p in pages) / len(pages) if pages else 0
                        }
                    })
                else:
                    raise Exception("MinerV processing failed")
                    
        except Exception as e:
            self.logger.error(f"MinerV extraction failed: {str(e)}")
            # Fallback to pdfplumber
            result = self._extract_with_pdfplumber(file_path, result)
            result['method_used'] = 'pdfplumber_fallback'
            
        return result
    
    def _extract_with_pdfplumber(self, file_path: str, result: Dict) -> Dict:
        """Extract text using pdfplumber"""
        try:
            with pdfplumber.open(file_path) as pdf:
                full_text = ""
                pages = []
                
                for i, page in enumerate(pdf.pages):
                    page_text = page.extract_text() or ""
                    
                    # Also extract tables if present
                    tables = page.extract_tables()
                    table_text = ""
                    for table in tables:
                        for row in table:
                            table_text += " | ".join(str(cell) if cell else "" for cell in row) + "\n"
                    
                    if table_text:
                        page_text += "\n\nTables:\n" + table_text
                    
                    pages.append({
                        'page_number': i + 1,
                        'text': page_text,
                        'has_tables': len(tables) > 0,
                        'table_count': len(tables)
                    })
                    
                    full_text += page_text + "\n\n"
                
                result.update({
                    'success': True,
                    'text': full_text.strip(),
                    'pages': pages,
                    'metadata': {
                        'total_pages': len(pages),
                        'total_tables': sum(p.get('table_count', 0) for p in pages)
                    }
                })
                
        except Exception as e:
            self.logger.error(f"pdfplumber extraction failed: {str(e)}")
            result['error'] = str(e)
            
        return result
    
    def _extract_with_pypdf2(self, file_path: str, result: Dict) -> Dict:
        """Extract text using PyPDF2"""
        try:
            with open(file_path, 'rb') as file:
                reader = PyPDF2.PdfReader(file)
                full_text = ""
                pages = []
                
                for i, page in enumerate(reader.pages):
                    page_text = page.extract_text()
                    pages.append({
                        'page_number': i + 1,
                        'text': page_text,
                        'char_count': len(page_text)
                    })
                    full_text += page_text + "\n\n"
                
                result.update({
                    'success': True,
                    'text': full_text.strip(),
                    'pages': pages,
                    'metadata': {
                        'total_pages': len(pages),
                        'total_chars': len(full_text)
                    }
                })
                
        except Exception as e:
            self.logger.error(f"PyPDF2 extraction failed: {str(e)}")
            result['error'] = str(e)
            
        return result
    
    def _analyze_content(self, result: Dict) -> Dict:
        """Analyze extracted content and determine type and quality"""
        text = result.get('text', '')
        
        if not text.strip():
            result['quality_score'] = 0.0
            return result
        
        # Analyze content type
        content_type = self._detect_content_type(text)
        result['content_type'] = content_type
        
        # Calculate quality score
        quality_score = self._calculate_quality_score(text, result.get('pages', []))
        result['quality_score'] = quality_score
        
        # Extract structured data based on content type
        if content_type == 'vocabulary':
            result['structured_data'] = self._extract_vocabulary_data(text)
        elif content_type == 'sentences':
            result['structured_data'] = self._extract_sentence_data(text)
        elif content_type == 'article':
            result['structured_data'] = self._extract_article_data(text)
        
        return result
    
    def _detect_content_type(self, text: str) -> str:
        """Detect the type of content in the extracted text"""
        lines = [line.strip() for line in text.split('\n') if line.strip()]
        
        if not lines:
            return 'unknown'
        
        # Count different patterns
        word_definition_pattern = 0
        sentence_pattern = 0
        paragraph_pattern = 0
        
        for line in lines[:20]:  # Check first 20 lines
            # Word definition pattern: "word - definition" or "word: definition"
            if re.match(r'^[a-zA-Z]+\s*[-:]\s*.+', line):
                word_definition_pattern += 1
            # Single word pattern
            elif re.match(r'^[a-zA-Z]+$', line):
                word_definition_pattern += 1
            # Complete sentence pattern
            elif re.match(r'^[A-Z].+[.!?]$', line):
                sentence_pattern += 1
            # Paragraph-like content
            elif len(line.split()) > 10:
                paragraph_pattern += 1
        
        # Determine content type based on patterns
        if word_definition_pattern > sentence_pattern and word_definition_pattern > paragraph_pattern:
            return 'vocabulary'
        elif sentence_pattern > paragraph_pattern:
            return 'sentences'
        elif paragraph_pattern > 0:
            return 'article'
        else:
            return 'mixed'
    
    def _calculate_quality_score(self, text: str, pages: List[Dict]) -> float:
        """Calculate a quality score for the extracted text"""
        if not text.strip():
            return 0.0
        
        score = 100.0
        
        # Check for common OCR errors
        error_patterns = [
            r'[^\w\s\-.,!?:;()"\']',  # Strange characters
            r'\b\w{20,}\b',  # Very long words (likely OCR errors)
            r'\s{3,}',  # Multiple spaces
            r'[a-z][A-Z]',  # Mixed case within words
        ]
        
        for pattern in error_patterns:
            matches = len(re.findall(pattern, text))
            score -= min(matches * 2, 20)  # Max 20 point deduction per pattern
        
        # Bonus for proper sentence structure
        sentences = re.findall(r'[.!?]+', text)
        if len(sentences) > 0:
            score += min(len(sentences), 10)
        
        # Consider confidence from OCR if available
        if pages:
            avg_confidence = sum(p.get('confidence', 100) for p in pages) / len(pages)
            score = (score + avg_confidence) / 2
        
        return max(0.0, min(100.0, score))
    
    def _extract_vocabulary_data(self, text: str) -> List[Dict]:
        """Extract vocabulary words and definitions"""
        words = []
        lines = [line.strip() for line in text.split('\n') if line.strip()]
        
        for line in lines:
            # Pattern: "word - definition" or "word: definition"
            match = re.match(r'^([a-zA-Z]+)\s*[-:]\s*(.+)', line)
            if match:
                word = match.group(1).lower()
                definition = match.group(2).strip()
                words.append({
                    'word': word,
                    'definition': definition,
                    'source_line': line
                })
            # Pattern: single word (definition might be on next line)
            elif re.match(r'^[a-zA-Z]+$', line):
                words.append({
                    'word': line.lower(),
                    'definition': '',
                    'source_line': line
                })
        
        return words
    
    def _extract_sentence_data(self, text: str) -> List[Dict]:
        """Extract individual sentences"""
        sentences = []
        
        # Split into sentences
        sentence_pattern = r'[.!?]+\s*'
        raw_sentences = re.split(sentence_pattern, text)
        
        for i, sentence in enumerate(raw_sentences):
            sentence = sentence.strip()
            if len(sentence) > 10:  # Minimum sentence length
                sentences.append({
                    'text': sentence,
                    'order': i + 1,
                    'word_count': len(sentence.split()),
                    'difficulty_estimate': self._estimate_sentence_difficulty(sentence)
                })
        
        return sentences
    
    def _extract_article_data(self, text: str) -> Dict:
        """Extract article structure and metadata"""
        paragraphs = [p.strip() for p in text.split('\n\n') if p.strip()]
        
        # Try to identify title (usually first line or paragraph)
        title = ""
        content_start = 0
        
        if paragraphs:
            first_para = paragraphs[0]
            if len(first_para.split()) <= 10 and not first_para.endswith('.'):
                title = first_para
                content_start = 1
        
        content_paragraphs = paragraphs[content_start:]
        
        return {
            'title': title,
            'paragraphs': content_paragraphs,
            'paragraph_count': len(content_paragraphs),
            'estimated_reading_time': len(' '.join(content_paragraphs).split()) // 200,  # ~200 WPM
            'difficulty_estimate': self._estimate_text_difficulty(' '.join(content_paragraphs))
        }
    
    def _estimate_sentence_difficulty(self, sentence: str) -> int:
        """Estimate sentence difficulty level (1-5)"""
        words = sentence.split()
        word_count = len(words)
        avg_word_length = sum(len(word) for word in words) / len(words) if words else 0
        
        # Simple heuristic based on length and complexity
        if word_count <= 8 and avg_word_length <= 4:
            return 1
        elif word_count <= 12 and avg_word_length <= 5:
            return 2
        elif word_count <= 16 and avg_word_length <= 6:
            return 3
        elif word_count <= 20:
            return 4
        else:
            return 5
    
    def _estimate_text_difficulty(self, text: str) -> int:
        """Estimate text difficulty level (1-5)"""
        sentences = re.split(r'[.!?]+', text)
        avg_sentence_length = sum(len(s.split()) for s in sentences) / len(sentences) if sentences else 0
        
        words = text.split()
        avg_word_length = sum(len(word) for word in words) / len(words) if words else 0
        
        # Simple readability estimate
        if avg_sentence_length <= 10 and avg_word_length <= 4:
            return 1
        elif avg_sentence_length <= 15 and avg_word_length <= 5:
            return 2
        elif avg_sentence_length <= 20 and avg_word_length <= 6:
            return 3
        elif avg_sentence_length <= 25:
            return 4
        else:
            return 5
    
    def validate_file(self, file_path: str, max_size_mb: int = 50) -> Dict:
        """Validate PDF file before processing"""
        result = {
            'valid': False,
            'errors': [],
            'warnings': [],
            'file_info': {}
        }
        
        try:
            # Check if file exists
            if not os.path.exists(file_path):
                result['errors'].append('File does not exist')
                return result
            
            # Check file size
            file_size = os.path.getsize(file_path)
            if file_size > max_size_mb * 1024 * 1024:
                result['errors'].append(f'File too large: {file_size / (1024*1024):.1f}MB > {max_size_mb}MB')
                return result
            
            # Check if it's a valid PDF
            try:
                with open(file_path, 'rb') as file:
                    reader = PyPDF2.PdfReader(file)
                    page_count = len(reader.pages)
                    
                    result['file_info'] = {
                        'size_bytes': file_size,
                        'size_mb': file_size / (1024 * 1024),
                        'page_count': page_count
                    }
                    
                    if page_count == 0:
                        result['warnings'].append('PDF has no pages')
                    elif page_count > 100:
                        result['warnings'].append(f'Large PDF: {page_count} pages')
                    
            except Exception as e:
                result['errors'].append(f'Invalid PDF file: {str(e)}')
                return result
            
            # If we get here, file is valid
            result['valid'] = True
            
        except Exception as e:
            result['errors'].append(f'File validation error: {str(e)}')
        
        return result


# Service instance
ocr_service = OCRService()