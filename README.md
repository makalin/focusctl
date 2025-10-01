# FocusCTL

Switch macOS Focus modes from the terminal with a simple command-line interface.

```bash
focusctl work on
focusctl presentation off
focusctl sleep toggle
```

## Features

- 🎯 **All Focus Modes**: Control work, personal, sleep, presentation, gaming, driving, fitness, mindfulness, reading, writing, research, creative, social, family, and friends modes
- 📱 **Shortcuts Integration**: Install actions for the Shortcuts app to automate focus mode switching
- 🚀 **Fast & Lightweight**: Native Swift implementation with minimal dependencies
- 🔧 **Developer Friendly**: Easy to integrate into scripts, CI/CD pipelines, and automation tools

## Installation

### Option 1: Build from Source (Recommended)

```bash
git clone https://github.com/makalin/focusctl.git
cd focusctl
make install
```

### Option 2: Manual Build

```bash
git clone https://github.com/makalin/focusctl.git
cd focusctl
swift build -c release
sudo cp .build/release/focusctl /usr/local/bin/focusctl
```

### Option 3: Using Scripts

```bash
git clone https://github.com/makalin/focusctl.git
cd focusctl
./build.sh
./install.sh
```

## Usage

### Basic Commands

| Command | What it does |
|---|---|
| `focusctl work on` | Turn Work focus on |
| `focusctl work off` | Turn Work focus off |
| `focusctl work toggle` | Toggle Work focus state |
| `focusctl` | List all modes and current state |

### Available Focus Modes

- `work` - Work focus mode
- `personal` - Personal focus mode  
- `sleep` - Sleep focus mode
- `presentation` - Presentation focus mode
- `gaming` - Gaming focus mode
- `driving` - Driving focus mode
- `fitness` - Fitness focus mode
- `mindfulness` - Mindfulness focus mode
- `reading` - Reading focus mode
- `writing` - Writing focus mode
- `research` - Research focus mode
- `creative` - Creative focus mode
- `social` - Social focus mode
- `family` - Family focus mode
- `friends` - Friends focus mode

### Examples

```bash
# Turn on work focus
focusctl work on

# Turn off presentation mode
focusctl presentation off

# Toggle sleep mode
focusctl sleep toggle

# List all focus modes and their status
focusctl

# Show help
focusctl help

# Show version
focusctl version
```

## Shortcuts & Automation

FocusCTL provides seamless integration with macOS Shortcuts app:

```bash
# Install all Shortcuts actions
focusctl shortcuts install

# List installed actions
focusctl shortcuts list

# Uninstall Shortcuts actions
focusctl shortcuts uninstall
```

Once installed, you can:
- Use focus mode toggles in Shortcuts workflows
- Create automations based on time, location, or other triggers
- Integrate with Alfred, Raycast, or other productivity tools
- Use in shell scripts and CI/CD pipelines

## Development

### Building

```bash
# Build in debug mode
swift build

# Build in release mode
swift build -c release

# Or use Makefile
make build
```

### Testing

```bash
# Test the installation
make test

# Test specific functionality
focusctl work on
focusctl work off
focusctl work toggle
```

### Project Structure

```
focusctl/
├── Package.swift              # Swift package configuration
├── Sources/focusctl/
│   ├── main.swift            # Command-line interface
│   ├── FocusManager.swift    # Core focus mode management
│   └── ShortcutsAction.swift # Shortcuts app integration
├── build.sh                  # Build script
├── install.sh                # Installation script
├── uninstall.sh              # Uninstallation script
├── Makefile                  # Build automation
└── README.md                 # This file
```

## How it Works

FocusCTL is a native Swift application that interfaces with macOS Focus system through:

1. **NSUserDefaults Integration**: Stores focus mode states in user preferences
2. **Notification System**: Posts system notifications to update focus states
3. **Shortcuts Framework**: Creates Shortcuts app actions for automation
4. **Command-Line Interface**: Provides intuitive terminal commands

No SIP disable required, no extra daemons—just clean, efficient integration with the macOS Focus system.

## Requirements

- macOS 12.0 or later
- Xcode 13.0 or later (for building from source)
- Swift 5.5 or later

## Troubleshooting

### Permission Issues

If you encounter permission errors during installation:

```bash
# Ensure /usr/local/bin exists and is writable
sudo mkdir -p /usr/local/bin
sudo chown $(whoami) /usr/local/bin
```

### Command Not Found

If `focusctl` command is not found after installation:

```bash
# Check if it's installed
ls -la /usr/local/bin/focusctl

# Add to PATH if needed
echo 'export PATH="/usr/local/bin:$PATH"' >> ~/.zshrc
source ~/.zshrc
```

### Shortcuts Actions Not Working

If Shortcuts actions don't appear:

```bash
# Reinstall Shortcuts actions
focusctl shortcuts uninstall
focusctl shortcuts install

# Check Shortcuts directory
ls -la ~/Library/Shortcuts/
```

## Contributing

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## License

MIT © 2025 Mehmet T. AKALIN

See [LICENSE](LICENSE) file for details.
