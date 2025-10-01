#!/bin/bash

# FocusCTL Install Script
# Installs the built binary to /usr/local/bin

set -e

echo "FocusCTL Install Script"
echo "======================="
echo

# Check if we're on macOS
if [[ "$OSTYPE" != "darwin"* ]]; then
    echo "Error: FocusCTL is designed for macOS only"
    exit 1
fi

# Check if binary exists
BINARY_PATH=".build/release/focusctl"
if [ ! -f "$BINARY_PATH" ]; then
    echo "Binary not found. Building first..."
    ./build.sh
    echo
fi

# Check if binary exists after build
if [ ! -f "$BINARY_PATH" ]; then
    echo "Error: Binary still not found after build"
    exit 1
fi

# Install binary
INSTALL_PATH="/usr/local/bin/focusctl"
echo "Installing FocusCTL to $INSTALL_PATH..."

# Create /usr/local/bin if it doesn't exist
sudo mkdir -p /usr/local/bin

# Copy binary
sudo cp "$BINARY_PATH" "$INSTALL_PATH"

# Make executable
sudo chmod +x "$INSTALL_PATH"

echo "✓ Installation complete!"
echo

# Test installation
echo "Testing installation..."
if command -v focusctl &> /dev/null; then
    focusctl --version
    echo
    echo "FocusCTL is now available system-wide!"
    echo
    echo "Usage examples:"
    echo "  focusctl work on"
    echo "  focusctl presentation off"
    echo "  focusctl sleep toggle"
    echo "  focusctl shortcuts install"
    echo
    echo "Run 'focusctl help' for more information."
else
    echo "Error: focusctl command not found in PATH"
    echo "You may need to restart your terminal or add /usr/local/bin to your PATH"
    exit 1
fi