#!/bin/bash
# Local build script for iOS WebRTC with SmileCX patches
# Usage: ./scripts/build_local.sh [branch_number] [target] [build_dir]
# Example: ./scripts/build_local.sh 7680 device ./local-build

set -e

WEBRTC_BRANCH="${1:-7680}"
BUILD_TARGET="${2:-device}"  # device, simulator, or all
BUILD_DIR="${3:-$(pwd)/local-build}"

echo "================================================"
echo "SmileCX WebRTC iOS Local Build"
echo "================================================"
echo "Branch: branch-heads/$WEBRTC_BRANCH"
echo "Target: $BUILD_TARGET"
echo "Build directory: $BUILD_DIR"
echo "================================================"
echo ""

# Create build directory
mkdir -p "$BUILD_DIR"
cd "$BUILD_DIR"

# Step 1: Checkout depot_tools
if [ ! -d depot_tools ]; then
    echo "📥 Checking out depot_tools..."
    git clone https://chromium.googlesource.com/chromium/tools/depot_tools.git
else
    echo "✓ depot_tools already exists"
fi

export PATH="$(pwd)/depot_tools:$PATH"

# Step 2: Fetch WebRTC iOS
if [ ! -d src ]; then
    echo "📥 Fetching WebRTC iOS (this will take a while)..."
    fetch --nohooks webrtc_ios
else
    echo "✓ WebRTC source already exists"
fi

cd src

# Step 3: Checkout branch
echo "🔄 Checking out branch-heads/$WEBRTC_BRANCH..."
git checkout "branch-heads/$WEBRTC_BRANCH"

cd ..

# Step 4: Sync dependencies
echo "🔄 Running gclient sync (this will take a while)..."
gclient sync --with_branch_heads --with_tags

cd src

# Step 5: Apply SmileCX patches
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"
PATCH_FILE="$REPO_DIR/patches/apple_prefix_smilecx.patch"

echo "🩹 Applying SmileCX patches..."
echo "Patch file: $PATCH_FILE"

if [ ! -f "$PATCH_FILE" ]; then
    echo "❌ Patch file not found: $PATCH_FILE"
    exit 1
fi

# Try git apply first
if git apply --check --verbose "$PATCH_FILE" 2>&1; then
    echo "Using git apply..."
    git apply "$PATCH_FILE"
else
    echo "git apply failed, trying patch with fuzz..."
    patch -p1 --fuzz=3 --verbose < "$PATCH_FILE" || {
        echo "❌ Patch failed!"
        echo "Showing reject files:"
        find . -name "*.rej" -exec echo "=== {} ===" \; -exec cat {} \;
        exit 1
    }
fi

echo "✓ Patch applied successfully!"
echo ""
echo "Verifying patch application..."
grep -q "SCX" sdk/objc/base/RTCMacros.h && echo "✓ ObjC prefix updated to SCX" || echo "✗ ObjC prefix NOT updated"
grep -q "kSCX" sdk/objc/base/RTCMacros.h && echo "✓ Constant prefix updated to kSCX" || echo "✗ Constant prefix NOT updated"
grep -q "SmileCXWebRTC" sdk/BUILD.gn && echo "✓ Framework name updated to SmileCXWebRTC" || echo "✗ Framework name NOT updated"
grep -q "cx.smile.SmileCXWebRTC" sdk/objc/Info.plist && echo "✓ Bundle ID updated" || echo "✗ Bundle ID NOT updated"
echo ""

# Step 6: Build
OUTPUT_DIR="./out"

build_target() {
    local TARGET_OS=$1
    local TARGET_CPU=$2
    local ENVIROMENT=$3

    echo "🔨 Building iOS $TARGET_CPU $ENVIROMENT..."

    gen_args="target_os=\"${TARGET_OS}\" \
target_cpu=\"${TARGET_CPU}\" \
is_debug=false \
is_component_build=false \
rtc_include_tests=false \
rtc_libvpx_build_vp9=true \
rtc_enable_objc_symbol_export=true \
rtc_enable_protobuf=false \
treat_warnings_as_errors=false \
enable_stripping=true \
enable_dsyms=false \
target_environment=\"${ENVIROMENT}\" \
ios_deployment_target=\"11.0\" \
ios_enable_code_signing=false \
use_xcode_clang=true \
use_goma=false"

    gen_dir="${OUTPUT_DIR}/${TARGET_OS}-${TARGET_CPU}-${ENVIROMENT}"

    gn gen "${gen_dir}" --args="${gen_args}"
    ninja -C "${gen_dir}" framework_objc || exit 1

    echo "✓ Build complete: ${gen_dir}"
}

if [ "$BUILD_TARGET" = "device" ] || [ "$BUILD_TARGET" = "all" ]; then
    build_target "ios" "arm64" "device"
fi

if [ "$BUILD_TARGET" = "simulator" ] || [ "$BUILD_TARGET" = "all" ]; then
    build_target "ios" "arm64" "simulator"
    build_target "ios" "x64" "simulator"
fi

echo ""
echo "================================================"
echo "✅ Build Complete!"
echo "================================================"
echo "Build directory: $BUILD_DIR/src"
echo "Output directory: $BUILD_DIR/src/out"
echo ""
echo "Built frameworks:"
find "$OUTPUT_DIR" -name "SmileCXWebRTC.framework" -type d 2>/dev/null || echo "No frameworks found"
echo ""
echo "To create an XCFramework, run:"
echo "cd $BUILD_DIR/src && XCFRAMEWORK_NAME=SmileCXWebRTC GITHUB_WORKSPACE=$REPO_DIR bash $REPO_DIR/scripts/create_xcframework.sh"
echo ""
echo "Note: LICENSE.md and NOTICE files from the repository will be included in the XCFramework for compliance."
