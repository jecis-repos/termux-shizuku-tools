# Termux Shizuku Tools 🚀

A comprehensive collection of tools and scripts for Termux with Shizuku/rish integration on Android 16+.

## 📋 Features

- **Shizuku Integration** - Full rish support for elevated privileges without root
- **Wireless ADB** - Easy wireless debugging setup
- **Lucky Patcher Extensions** - Advanced app patching capabilities
- **AI CLI Tools** - Claude and Gemini integration
- **System Tools** - Enhanced package management and system control
- **Android 16 Support** - Fixes and workarounds for latest Android

## 🛠️ Installation

```bash
# Clone the repository
git clone https://github.com/jecis-repos/termux-shizuku-tools.git
cd termux-shizuku-tools

# Run the setup script
chmod +x setup.sh
./setup.sh
```

## 📦 Included Tools

### 1. Shizuku/rish Setup
- `shizuku/rish` - Pre-configured rish launcher (requires `rish_shizuku.dex`, see Configuration)
- `shizuku/shizuku_control.sh` - Shizuku control center (start/stop/status)
- `shizuku/shizuku_env.sh` - Environment setup (`spm`, `sam`, `sdumpsys`, ...)
- `shizuku/shizuku_rish.sh` - Shizuku management using rish
- `shizuku/rish_direct.sh` - Direct rish launcher (for ADB use)
- `shizuku/rish_wrapper.sh` - rish wrapper for Android 16
- `shizuku/shizuku_advanced_fix.sh` - Advanced fixes for Android 16 (phantom process killing, ...)
- `shizuku/shizuku_keepalive.sh` - Shizuku keep-alive daemon
- `shizuku/shizuku_monitor.sh` - Monitor Shizuku status
- `shizuku/shizuku_notify.sh` - Notifications about Shizuku status

### 2. Lucky Patcher Extensions
- `lucky-patcher/lp_ultimate.sh` - Ultimate patching functions
- `lucky-patcher/lp_advanced.sh` - Advanced app modifications
- `lucky-patcher/lp_analyze.sh` - App component analyzer
- `lucky-patcher/lucky_patcher_rish.sh` - Lucky Patcher helpers via rish

### 3. AI CLI Tools
- `ai-tools/ai` - Universal AI CLI wrapper
- `ai-tools/claude_cli.py` - Claude AI integration
- `ai-tools/gemini_cli.py` - Gemini AI integration
- `ai-tools/ai_cli_simple.sh` - One-shot installer for the AI CLIs
- `ai-tools/ai_analyze.sh` - AI-powered system analyzer (uses rish)

### 4. System Tools
- `system/grant_termux_privileges.sh` - Enhanced permissions
- `system/setup_termux_tasker.sh` - Tasker integration
- `system/setup_wireless_adb.sh` - Wireless ADB setup
- `system/connect_adb_hotspot.sh` - ADB connection over hotspot
- `system/termux_complete_setup.sh` - Complete Termux setup

## 🚀 Quick Start

### Enable Shizuku
```bash
./shizuku/shizuku_control.sh start
./shizuku/shizuku_control.sh status
```

### Use rish Commands
```bash
# Package management
spm list packages -3
spm disable com.example.app

# System control
sam force-stop com.example.app
sdumpsys battery
```

### Lucky Patcher Extensions
```bash
# List patchable apps
./lucky-patcher/lp_ultimate.sh list-patchable

# Patch an app
./lucky-patcher/lp_ultimate.sh super-patch com.example.app
```

### AI Tools
```bash
# Setup API keys
./ai-tools/ai setup

# Use AI assistants
ai claude "Write a Python script"
ai gemini "Explain quantum computing"
```

## 📱 Requirements

- Android 7.0+ (Android 16 recommended)
- Termux (F-Droid version)
- Shizuku v13.5+
- 300MB+ free storage

## 🔧 Configuration

### API Keys
Store your API keys in `~/.ai_keys`:
```bash
export ANTHROPIC_API_KEY='your-key'
export GOOGLE_AI_API_KEY='your-key'
```

Optional model overrides:
```bash
export CLAUDE_MODEL='claude-haiku-4-5'          # default
export GEMINI_MODEL='gemini-3.1-pro-preview'    # default
```

### Shizuku Setup
1. Install Shizuku from Play Store
2. Start it via Wireless Debugging
3. Place `rish_shizuku.dex` next to `shizuku/rish` (it ships with the Shizuku
   project and is not committed here because `*.dex` is gitignored)
4. Run `./setup.sh`, then verify with `./shizuku/shizuku_control.sh status`

## 📚 Documentation

- [Quick Start Guide](docs/QUICK_START.md)

## ⚠️ Legal Notice

These tools are for educational and testing purposes only. Users are responsible for complying with all applicable laws and regulations. Do not use these tools on apps or systems you don't own or have permission to test.

## 🤝 Contributing

Contributions are welcome! Please read [CONTRIBUTING.md](CONTRIBUTING.md) for guidelines.

## 📄 License

This project is licensed under the MIT License - see [LICENSE](LICENSE) file for details.

## 🙏 Credits

- Shizuku by RikkaApps
- Termux development team
- All contributors

---

**Note**: This repository is not affiliated with Lucky Patcher, Shizuku, or any mentioned apps.
