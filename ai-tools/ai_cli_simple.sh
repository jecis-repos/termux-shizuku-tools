#!/data/data/com.termux/files/usr/bin/bash

echo "=== Simple AI CLI Setup for Termux ==="
echo ""

# Install required packages
echo "Installing required packages..."
pkg install -y python python-pip curl jq

# Install Python AI libraries
echo ""
echo "Installing Python AI libraries..."
pip install anthropic google-genai openai requests

# Create Claude CLI script
cat > ~/claude_cli.py << 'EOF'
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
EOF
chmod +x ~/claude_cli.py

# Create Gemini CLI script
cat > ~/gemini_cli.py << 'EOF'
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
        print(f"Error: {e}")

if __name__ == "__main__":
    main()
EOF
chmod +x ~/gemini_cli.py

# Create AI CLI with rish integration
cat > ~/ai << 'EOF'
#!/data/data/com.termux/files/usr/bin/bash
# AI CLI with Shizuku integration

source ~/.shizuku_env 2>/dev/null

case "$1" in
    claude)
        shift
        python ~/claude_cli.py "$@"
        ;;
    gemini)
        shift
        python ~/gemini_cli.py "$@"
        ;;
    setup)
        echo "AI CLI Setup"
        echo ""
        read -p "Enter Anthropic API Key: " anthropic_key
        read -p "Enter Google AI API Key: " google_key
        
        cat > ~/.ai_keys << KEYS
export ANTHROPIC_API_KEY='$anthropic_key'
export GOOGLE_AI_API_KEY='$google_key'
KEYS
        chmod 600 ~/.ai_keys
        echo "Keys saved to ~/.ai_keys"
        echo "Run: source ~/.ai_keys"
        ;;
    scan)
        # Use AI to analyze system with rish
        echo "Scanning system with AI..."
        if command -v rish &> /dev/null; then
            SCAN_DATA=$(rish -c "pm list packages -3; dumpsys battery; getprop" 2>/dev/null | head -500)
        else
            SCAN_DATA=$(pm list packages 2>/dev/null; getprop)
        fi
        
        echo "$SCAN_DATA" | python ~/claude_cli.py "Analyze this Android system data for security issues"
        ;;
    chat)
        # Interactive chat mode
        shift
        model="${1:-claude}"
        echo "Starting $model chat (type 'exit' to quit)..."
        
        while true; do
            read -p "> " prompt
            [ "$prompt" = "exit" ] && break
            
            if [ "$model" = "gemini" ]; then
                echo "$prompt" | python ~/gemini_cli.py
            else
                echo "$prompt" | python ~/claude_cli.py
            fi
            echo
        done
        ;;
    *)
        echo "AI CLI - Simple AI assistant for Termux"
        echo ""
        echo "Usage: ai {claude|gemini|setup|scan|chat} [prompt]"
        echo ""
        echo "Examples:"
        echo "  ai setup                    # Configure API keys"
        echo "  ai claude 'Hello Claude'    # Ask Claude"
        echo "  ai gemini 'Hello Gemini'    # Ask Gemini"
        echo "  ai scan                     # Analyze system"
        echo "  ai chat [claude|gemini]     # Interactive chat"
        ;;
esac
EOF
chmod +x ~/ai

# Create rish-powered system analyzer
cat > ~/ai_analyze.sh << 'EOF'
#!/data/data/com.termux/files/usr/bin/bash
# AI-powered system analyzer using rish

source ~/.shizuku_env 2>/dev/null
source ~/.ai_keys 2>/dev/null

if [ -z "$ANTHROPIC_API_KEY" ] && [ -z "$GOOGLE_AI_API_KEY" ]; then
    echo "No AI API keys found. Run: ai setup"
    exit 1
fi

echo "=== AI System Analysis ==="
echo "Gathering system information..."

# Collect data with rish
DATA=""
if command -v rish &> /dev/null; then
    DATA+="=== Installed Apps ===\n"
    DATA+=$(rish -c "pm list packages -3" 2>/dev/null)
    DATA+="\n\n=== System Properties ===\n"
    DATA+=$(rish -c "getprop | grep -E 'version|model|manufacturer'" 2>/dev/null)
    DATA+="\n\n=== Memory Info ===\n"
    DATA+=$(rish -c "dumpsys meminfo | head -20" 2>/dev/null)
    DATA+="\n\n=== Battery Info ===\n"
    DATA+=$(rish -c "dumpsys battery" 2>/dev/null)
else
    DATA="Unable to use rish. Limited data available:\n"
    DATA+=$(getprop 2>/dev/null | head -20)
fi

# Analyze with AI
echo ""
echo "Analyzing with AI..."
echo -e "$DATA" | python ~/claude_cli.py "Analyze this Android system data. Identify any security concerns, unusual apps, or optimization recommendations."
EOF
chmod +x ~/ai_analyze.sh

# Add to bashrc
echo ""
echo "Adding AI commands to ~/.bashrc..."
grep -q "alias ai=" ~/.bashrc || echo "alias ai='~/ai'" >> ~/.bashrc
grep -q "source ~/.ai_keys" ~/.bashrc || echo "[ -f ~/.ai_keys ] && source ~/.ai_keys" >> ~/.bashrc

echo ""
echo "=== Setup Complete! ==="
echo ""
echo "1. Configure your API keys:"
echo "   ./ai setup"
echo ""
echo "2. Usage examples:"
echo "   ai claude 'Write a Python hello world'"
echo "   ai gemini 'Explain quantum computing'"
echo "   ai scan                  # Analyze system"
echo "   ai chat                  # Interactive mode"
echo "   ./ai_analyze.sh         # Full system analysis"
echo ""
echo "3. Get API keys from:"
echo "   Claude: https://console.anthropic.com"
echo "   Gemini: https://aistudio.google.com/apikey"
echo ""
echo "Run: source ~/.bashrc"