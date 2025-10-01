#!/bin/bash

# FocusCTL Build Script
# Builds the Swift package and creates a release binary

set -e

echo "FocusCTL Build Script"
echo "====================="
echo

# Check if Swift is installed
if ! command -v swift &> /dev/null; then
    echo "Error: Swift is not installed"
    echo "Please install Xcode or Swift from https://swift.org"
    exit 1
fi

# Check Swift version
SWIFT_VERSION=$(swift --version | head -n1)
echo "Using: $SWIFT_VERSION"
echo

# Clean previous builds
echo "Cleaning previous builds..."
swift package clean
echo

# Build in release mode
echo "Building FocusCTL in release mode..."
swift build -c release
echo

# Check if build was successful
if [ $? -eq 0 ]; then
    echo "✓ Build successful!"
    echo
    
    # Show binary info
    BINARY_PATH=".build/release/focusctl"
    if [ -f "$BINARY_PATH" ]; then
        echo "Binary created: $BINARY_PATH"
        echo "Size: $(ls -lh "$BINARY_PATH" | awk '{print $5}')"
        echo
        
        # Test the binary
        echo "Testing binary..."
        "$BINARY_PATH" --version
        echo
        
        echo "Build complete! You can now install with:"
        echo "  sudo cp $BINARY_PATH /usr/local/bin/focusctl"
        echo "  or run: ./install.sh"
    else
        echo "Error: Binary not found at expected location"
        exit 1
    fi
else
    echo "✗ Build failed!"
    exit 1
fi