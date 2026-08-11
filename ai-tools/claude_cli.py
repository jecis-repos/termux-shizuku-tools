#!/data/data/com.termux/files/usr/bin/python
import os
import sys
import anthropic
from datetime import datetime

def main():
    api_key = os.environ.get('ANTHROPIC_API_KEY')
    if not api_key:
        print("Error: Please set ANTHROPIC_API_KEY environment variable")
        print("export ANTHROPIC_API_KEY='your-key-here'")
        sys.exit(1)
    
    client = anthropic.Anthropic(api_key=api_key)
    
    if len(sys.argv) > 1:
        prompt = ' '.join(sys.argv[1:])
    else:
        print("Enter your prompt (Ctrl+D to finish):")
        prompt = sys.stdin.read().strip()
    
    try:
        message = client.messages.create(
            model=os.environ.get('CLAUDE_MODEL', 'claude-haiku-4-5'),
            max_tokens=1000,
            messages=[{"role": "user", "content": prompt}]
        )
        print(message.content[0].text)
    except Exception as e:
        print(f"Error: {e}")

if __name__ == "__main__":
    main()
