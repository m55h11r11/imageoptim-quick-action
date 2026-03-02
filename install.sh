#!/bin/bash
set -e

echo "🖼️  ImageOptim Quick Action Installer"
echo "======================================"
echo ""

# Check if Homebrew is installed
if ! command -v brew &> /dev/null; then
    echo "❌ Homebrew is required. Install it from https://brew.sh"
    exit 1
fi

# Install ImageOptim
if [ ! -d "/Applications/ImageOptim.app" ]; then
    echo "📦 Installing ImageOptim..."
    brew install --cask imageoptim
else
    echo "✅ ImageOptim already installed"
fi

# Install imageoptim-cli
if ! command -v imageoptim &> /dev/null; then
    echo "📦 Installing imageoptim-cli..."
    brew install imageoptim-cli
else
    echo "✅ imageoptim-cli already installed"
fi

# Configure lossy compression (50-70% savings, similar to TinyPNG)
echo ""
echo "⚙️  Configuring ImageOptim for optimal compression..."
defaults write net.pornel.ImageOptim LossyEnabled -bool true
defaults write net.pornel.ImageOptim JpegOptimMaxQuality -int 80
defaults write net.pornel.ImageOptim PngMinQuality -int 40
defaults write net.pornel.ImageOptim PngMaxQuality -int 80

# Install the Quick Action
echo ""
echo "🔧 Installing Quick Action..."
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
WORKFLOW="$SCRIPT_DIR/Optimize Images.workflow"

# Remove quarantine flags
xattr -cr "$WORKFLOW" 2>/dev/null || true

# Open the workflow — macOS will show its built-in installer dialog
# User just clicks "Install" and it's properly registered
open "$WORKFLOW"

echo ""
echo "👆 A dialog should appear — click \"Install\" to add the Quick Action."
echo ""
echo "After installing:"
echo "  1. Select image(s) in Finder"
echo "  2. Right-click → Quick Actions → Optimize Images"
echo ""
