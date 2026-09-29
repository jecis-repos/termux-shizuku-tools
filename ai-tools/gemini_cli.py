#!/data/data/com.termux/files/usr/bin/python
import os
import sys
from google import genai

def main():
    api_key = os.environ.get('GOOGLE_AI_API_KEY')
    if not api_key:
        print("Error: Please set GOOGLE_AI_API_KEY environment variable")
        print("export GOOGLE_AI_API_KEY='your-key-here'")
        sys.exit(1)

    client = genai.Client(api_key=api_key)
    model = os.environ.get('GEMINI_MODEL', 'gemini-3.1-pro-preview')

    if len(sys.argv) > 1:
        prompt = ' '.join(sys.argv[1:])
    else:
        print("Enter your prompt (Ctrl+D to finish):")
        prompt = sys.stdin.read().strip()

    try:
        response = client.models.generate_content(model=model, contents=prompt)
        print(response.text)
    except Exception as e:
        print(f"Error: {e}", file=sys.stderr)
        sys.exit(1)

if __name__ == "__main__":
    main()
