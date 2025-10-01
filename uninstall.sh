#!/bin/bash

# FocusCTL Uninstall Script
# Removes the installed binary and Shortcuts actions

set -e

echo "FocusCTL Uninstall Script"
echo "========================="
echo

# Check if focusctl is installed
if ! command -v focusctl &> /dev/null; then
    echo "FocusCTL is not installed or not in PATH"
    exit 1
fi

# Show current installation
echo "Current installation:"
focusctl --version
echo

# Ask for confirmation
read -p "Are you sure you want to uninstall FocusCTL? (y/N): " -n 1 -r
echo
if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    echo "Uninstall cancelled"
    exit 0
fi

# Remove binary
INSTALL_PATH="/usr/local/bin/focusctl"
if [ -f "$INSTALL_PATH" ]; then
    echo "Removing binary from $INSTALL_PATH..."
    sudo rm -f "$INSTALL_PATH"
    echo "✓ Binary removed"
else
    echo "Binary not found at $INSTALL_PATH"
fi

# Remove Shortcuts actions
echo "Removing Shortcuts actions..."
SHORTCUTS_DIR="$HOME/Library/Shortcuts"
if [ -d "$SHORTCUTS_DIR" ]; then
    # Find and remove FocusCTL actions
    FOUND_ACTIONS=$(find "$SHORTCUTS_DIR" -name "*FocusCTL*" -type f 2>/dev/null || true)
    if [ -n "$FOUND_ACTIONS" ]; then
        echo "$FOUND_ACTIONS" | while read -r action; do
            echo "  Removing: $(basename "$action")"
            rm -f "$action"
        done
        echo "✓ Shortcuts actions removed"
    else
        echo "No FocusCTL Shortcuts actions found"
    fi
else
    echo "Shortcuts directory not found"
fi

echo
echo "✓ FocusCTL has been completely uninstalled"
echo
echo "You may need to restart your terminal for PATH changes to take effect."