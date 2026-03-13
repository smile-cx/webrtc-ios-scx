#!/bin/bash
# Local patch testing script for iOS
# Usage: ./scripts/test_patch_locally.sh [webrtc_branch]

set -e

WEBRTC_BRANCH="${1:-7680}"
TEST_DIR="$(pwd)/webrtc-ios-patch-test-$$"

echo "📦 Creating test directory: $TEST_DIR"
mkdir -p "$TEST_DIR"
cd "$TEST_DIR"

echo "📥 Checking out depot_tools..."
git clone https://chromium.googlesource.com/chromium/tools/depot_tools.git
export PATH="$TEST_DIR/depot_tools:$PATH"

echo "📥 Fetching WebRTC iOS..."
fetch --nohooks webrtc_ios

cd src
echo "🔄 Checking out branch-heads/$WEBRTC_BRANCH..."
git checkout "branch-heads/$WEBRTC_BRANCH"

cd ..
echo "🔄 Running gclient sync..."
gclient sync --with_branch_heads --with_tags

cd src
echo "🩹 Testing patch application..."

# Find the repo directory (where this script is located)
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"
PATCH_FILE="${GITHUB_WORKSPACE:-$REPO_DIR}/patches/apple_prefix_smilecx.patch"

if [ ! -f "$PATCH_FILE" ]; then
    echo "❌ Patch file not found: $PATCH_FILE"
    echo "Repo dir: $REPO_DIR"
    echo "GITHUB_WORKSPACE: ${GITHUB_WORKSPACE:-not set}"
    exit 1
fi

echo "Using patch file: $PATCH_FILE"

echo "Applying patch with git apply --check..."
if git apply --check --verbose "$PATCH_FILE" 2>&1; then
    echo "✅ git apply check passed!"
    echo "Applying patch..."
    git apply "$PATCH_FILE"
    echo "✅ Patch applied successfully with git apply!"
else
    echo "⚠️  git apply failed, trying patch --dry-run..."
    if patch -p1 --dry-run --verbose < "$PATCH_FILE"; then
        echo "✅ patch dry-run passed!"
        patch -p1 < "$PATCH_FILE"
        echo "✅ Patch applied successfully with patch!"
    else
        echo "❌ Patch failed!"
        echo "Showing reject files:"
        find . -name "*.rej" -exec echo "=== {} ===" \; -exec cat {} \;
        exit 1
    fi
fi

echo ""
echo "✅ Verification:"
grep -q "SCX" sdk/objc/base/RTCMacros.h && echo "✓ ObjC prefix updated to SCX" || echo "✗ ObjC prefix NOT updated"
grep -q "SmileCXWebRTC" sdk/BUILD.gn && echo "✓ Framework name updated" || echo "✗ Framework name NOT updated"
grep -q "cx.smile.SmileCXWebRTC" sdk/objc/Info.plist && echo "✓ Bundle ID updated" || echo "✗ Bundle ID NOT updated"

echo ""
echo "🧹 Cleanup test directory? (y/n)"
read -r cleanup
if [ "$cleanup" = "y" ]; then
    cd "$(dirname "$TEST_DIR")"
    rm -rf "$TEST_DIR"
    echo "✅ Cleaned up $TEST_DIR"
else
    echo "📂 Test directory preserved at: $TEST_DIR"
fi
