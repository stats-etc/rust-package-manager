# Makefile for Rust Package Manager

.PHONY: build run test clean demo help install release

# Переменные
CARGO = cargo
TARGET_DIR = target
BINARY_NAME = rust-package-manager

# Default - build project
all: build

# Build project
build:
	@echo "🔨 Building project..."
	$(CARGO) build

# Build in release mode
release:
	@echo "🚀 Building release version..."
	$(CARGO) build --release

# Run program
run:
	@echo "▶️  Running program..."
	$(CARGO) run

# Run tests
test:
	@echo "🧪 Running tests..."
	$(CARGO) test

# Run tests with verbose output
test-verbose:
	@echo "🧪 Running tests (verbose output)..."
	$(CARGO) test -- --nocapture

# Check code
check:
	@echo "🔍 Checking code..."
	$(CARGO) check

# Format code
fmt:
	@echo "✨ Formatting code..."
	$(CARGO) fmt

# Lint code
lint:
	@echo "📋 Linting code..."
	$(CARGO) clippy -- -D warnings

# Clean build files
clean:
	@echo "🧹 Cleaning build files..."
	$(CARGO) clean
	rm -f packages.json

# Full cleanup (including packages.json)
clean-all: clean
	@echo "🗑️  Full cleanup..."
	rm -f packages.json demo_commands.txt

# Demo functions
demo:
	@echo "🎬 Demo functions..."
	@./demo.sh

# Quick test of main functions
quick-demo:
	@echo "⚡ Quick demonstration..."
	@printf "available\ninstall firefox\ninstall python 3.12.0\nlist\nsearch browser\nremove firefox\nlist\nexit\n" | $(CARGO) run

# Install dependencies (update)
deps:
	@echo "📦 Updating dependencies..."
	$(CARGO) update

# Generate documentation
doc:
	@echo "📚 Generating documentation..."
	$(CARGO) doc --open

# Check formatting without changes
check-fmt:
	@echo "🔎 Checking formatting..."
	$(CARGO) fmt -- --check

# Full check before commit
pre-commit: check-fmt lint test
	@echo "✅ All checks passed!"

# Install program to system
install-system: release
	@echo "📥 Installing to system..."
	cp $(TARGET_DIR)/release/$(BINARY_NAME) /usr/local/bin/rpm-rust || \
	cp $(TARGET_DIR)/release/$(BINARY_NAME) ~/.local/bin/rpm-rust || \
	echo "❌ Failed to install. Copy $(TARGET_DIR)/release/$(BINARY_NAME) manually"

# Benchmarks (if added)
bench:
	@echo "📊 Running benchmarks..."
	$(CARGO) bench

# Project information
info:
	@echo "ℹ️  Project information:"
	@echo "  Name: Rust Package Manager"
	@echo "  Version: $(shell grep version Cargo.toml | head -n1 | cut -d'"' -f2)"
	@echo "  Language: Rust $(shell rustc --version | cut -d' ' -f2)"
	@echo "  Cargo: $(shell cargo --version | cut -d' ' -f2)"

# Help
help:
	@echo "🦀 Rust Package Manager - Available commands:"
	@echo ""
	@echo "Build:"
	@echo "  build         - Build project in debug mode"
	@echo "  release       - Build in release mode"
	@echo ""
	@echo "Run:"
	@echo "  run           - Run program"
	@echo "  demo          - Demo functions (via demo.sh)"
	@echo "  quick-demo    - Quick demonstration of main functions"
	@echo ""
	@echo "Testing:"
	@echo "  test          - Run tests"
	@echo "  test-verbose  - Run tests with verbose output"
	@echo "  bench         - Run benchmarks"
	@echo ""
	@echo "Code quality:"
	@echo "  check         - Check code without building"
	@echo "  fmt           - Format code"
	@echo "  check-fmt     - Check formatting"
	@echo "  lint          - Lint with clippy"
	@echo "  pre-commit    - Full check before commit"
	@echo ""
	@echo "Documentation:"
	@echo "  doc           - Generate and open documentation"
	@echo ""
	@echo "Management:"
	@echo "  deps          - Update dependencies"
	@echo "  clean         - Clean build files"
	@echo "  clean-all     - Full cleanup"
	@echo "  install-system- Install to system"
	@echo ""
	@echo "Information:"
	@echo "  info          - Project information"
	@echo "  help          - This help"

# Create source archive
archive:
	@echo "📦 Creating archive..."
	tar -czf rust-package-manager.tar.gz --exclude=$(TARGET_DIR) --exclude=packages.json .
