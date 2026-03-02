#!/bin/bash
set -e

echo "🗑️  ImageOptim Quick Action Uninstaller"
echo "========================================"
echo ""

SERVICES_DIR="$HOME/Library/Services"
WORKFLOW_NAME="Optimize Images.workflow"

if [ -d "$SERVICES_DIR/$WORKFLOW_NAME" ]; then
    rm -rf "$SERVICES_DIR/$WORKFLOW_NAME"
    echo "✅ Quick Action removed"
else
    echo "ℹ️  Quick Action not found (already removed)"
fi

/System/Library/CoreServices/pbs -flush 2>/dev/null || true

echo ""
echo "Done. Note: ImageOptim app was not removed."
echo "To fully remove: brew uninstall --cask imageoptim && brew uninstall imageoptim-cli"
echo ""
