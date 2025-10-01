# FocusCTL

Switch macOS Focus modes from the terminal.

```bash
focusctl work on
focusctl presentation off
```

## Install

```bash
brew install focusctl
```

## Use

| Command | What it does |
|---|---|
| `focusctl work on` | Turn Work focus on |
| `focusctl work off` | Turn Work focus off |
| `focusctl` | List all modes and current state |

## Shortcuts & Automation

FocusCTL exposes a Shortcuts action, so you can toggle focus from shell scripts, Alfred, Raycast, or any CI job.

## Build from source

```bash
git clone https://github.com/makalin/focusctl.git
cd focusctl
swift build -c release
sudo cp .build/release/focusctl /usr/local/bin
```

## How it works

Tiny Swift wrapper around the private FocusMode.framework (reverse-engineered headers already on GitHub).  
No SIP disable, no extra daemons—just calls the same API the System Preferences pane uses.

## License

MIT © 2025 Mehmet T. AKALIN
