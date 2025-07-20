#!/usr/bin/env python3
"""Test vocabulary API endpoints remotely"""

import requests
import json

# Server configuration
BASE_URL = "http://eng.dataisbeautiful.top/api"

# Test credentials (you need to get a valid token first)
def get_auth_token():
    """Login to get auth token"""
    login_data = {
        "username": "admin",  # Replace with actual admin username
        "password": "password"  # Replace with actual password
    }
    
    response = requests.post(f"{BASE_URL}/auth/login", json=login_data)
    if response.ok:
        return response.json().get('access_token')
    else:
        print(f"Login failed: {response.status_code} - {response.text}")
        return None

def test_vocabulary_api(token):
    """Test vocabulary management endpoints"""
    headers = {
        "Authorization": f"Bearer {token}",
        "Content-Type": "application/json"
    }
    
    # Test 1: Get libraries
    print("\n=== Testing GET /vocabulary-management/libraries ===")
    response = requests.get(f"{BASE_URL}/vocabulary-management/libraries", headers=headers)
    print(f"Status: {response.status_code}")
    if response.ok:
        data = response.json()
        print(f"Success: {data.get('success')}")
        libraries = data.get('libraries', [])
        print(f"Number of libraries: {len(libraries)}")
        for lib in libraries[:3]:  # Show first 3
            print(f"  - {lib['name']} (ID: {lib['id']}, Words: {lib.get('word_count', 0)})")
    else:
        print(f"Error: {response.text}")
    
    # Test 2: Get words from first library
    if response.ok and libraries:
        first_library_id = libraries[0]['id']
        print(f"\n=== Testing GET /vocabulary-management/libraries/{first_library_id}/words ===")
        response = requests.get(
            f"{BASE_URL}/vocabulary-management/libraries/{first_library_id}/words?page=1&per_page=10", 
            headers=headers
        )
        print(f"Status: {response.status_code}")
        if response.ok:
            data = response.json()
            print(f"Success: {data.get('success')}")
            words = data.get('words', [])
            print(f"Number of words: {len(words)}")
            print(f"Total words in library: {data.get('pagination', {}).get('total', 0)}")
            for word in words[:3]:  # Show first 3
                print(f"  - {word['word']} ({word['chinese_meaning']})")
        else:
            print(f"Error: {response.text}")

# For direct testing
if __name__ == "__main__":
    print("Testing Vocabulary Management API...")
    print(f"Server: {BASE_URL}")
    
    # You can manually set a token here if you have one
    # token = "your-token-here"
    
    # Or get it through login
    token = get_auth_token()
    
    if token:
        print(f"\nGot token: {token[:20]}...")
        test_vocabulary_api(token)
    else:
        print("\nFailed to get auth token. Please check credentials.")