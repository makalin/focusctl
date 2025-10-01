# FocusCTL Makefile
# Provides convenient targets for building, installing, and managing FocusCTL

.PHONY: all build install uninstall clean test help

# Default target
all: build

# Build the project
build:
	@echo "Building FocusCTL..."
	@swift build -c release
	@echo "✓ Build complete!"

# Install the binary
install: build
	@echo "Installing FocusCTL..."
	@sudo cp .build/release/focusctl /usr/local/bin/
	@sudo chmod +x /usr/local/bin/focusctl
	@echo "✓ Installation complete!"

# Uninstall the binary
uninstall:
	@echo "Uninstalling FocusCTL..."
	@sudo rm -f /usr/local/bin/focusctl
	@echo "✓ Uninstallation complete!"

# Clean build artifacts
clean:
	@echo "Cleaning build artifacts..."
	@swift package clean
	@echo "✓ Clean complete!"

# Test the installation
test: install
	@echo "Testing FocusCTL..."
	@focusctl --version
	@focusctl help
	@echo "✓ Tests passed!"

# Install Shortcuts actions
shortcuts: install
	@echo "Installing Shortcuts actions..."
	@focusctl shortcuts install
	@echo "✓ Shortcuts actions installed!"

# Show help
help:
	@echo "FocusCTL Makefile"
	@echo "================="
	@echo
	@echo "Available targets:"
	@echo "  build      Build the project in release mode"
	@echo "  install    Build and install the binary to /usr/local/bin"
	@echo "  uninstall  Remove the installed binary"
	@echo "  clean      Clean build artifacts"
	@echo "  test       Install and test the binary"
	@echo "  shortcuts  Install Shortcuts app actions"
	@echo "  help       Show this help message"
	@echo
	@echo "Examples:"
	@echo "  make build"
	@echo "  make install"
	@echo "  make shortcuts"