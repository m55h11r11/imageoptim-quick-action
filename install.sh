#!/bin/bash
set -e

echo "🖼️  ImageOptim Quick Action Installer"
echo "======================================"
echo ""

# Check if ImageOptim is installed
if [ ! -d "/Applications/ImageOptim.app" ]; then
    echo "📦 ImageOptim not found. Installing via Homebrew..."
    if ! command -v brew &> /dev/null; then
        echo "❌ Homebrew is required. Install it from https://brew.sh"
        exit 1
    fi
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

# Install the Quick Action workflow
SERVICES_DIR="$HOME/Library/Services"
WORKFLOW_NAME="Optimize Images.workflow"
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

mkdir -p "$SERVICES_DIR"

if [ -d "$SERVICES_DIR/$WORKFLOW_NAME" ]; then
    echo "⚠️  Removing existing Optimize Images workflow..."
    rm -rf "$SERVICES_DIR/$WORKFLOW_NAME"
fi

echo "📂 Installing Quick Action..."
cp -R "$SCRIPT_DIR/$WORKFLOW_NAME" "$SERVICES_DIR/$WORKFLOW_NAME"
xattr -cr "$SERVICES_DIR/$WORKFLOW_NAME"

# Enable lossy compression for better savings (similar to TinyPNG)
echo ""
echo "⚙️  Configuring ImageOptim for optimal compression..."
defaults write net.pornel.ImageOptim LossyEnabled -bool true
defaults write net.pornel.ImageOptim JpegOptimMaxQuality -int 80
defaults write net.pornel.ImageOptim PngMinQuality -int 40
defaults write net.pornel.ImageOptim PngMaxQuality -int 80

# Refresh services
/System/Library/CoreServices/pbs -flush 2>/dev/null || true
/System/Library/CoreServices/pbs -update 2>/dev/null || true

echo ""
echo "✅ Installation complete!"
echo ""
echo "Usage:"
echo "  1. Select image(s) in Finder"
echo "  2. Right-click → Quick Actions → Optimize Images"
echo ""
echo "If 'Optimize Images' doesn't appear in Quick Actions:"
echo "  • Restart Finder: killall Finder"
echo "  • Or log out and log back in"
echo "  • Or enable it in System Settings → Privacy & Security → Extensions → Finder"
echo ""
