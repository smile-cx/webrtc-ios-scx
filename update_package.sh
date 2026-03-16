#!/bin/bash
# Update Package.swift for new release
# Usage: ./update_package.sh <version> <url> <checksum>
# Example: ./update_package.sh M144 https://github.com/smile-cx/webrtc-ios-scx/releases/download/M144/SmileCXWebRTC-M144.xcframework.zip abc123...

set -e

VERSION=$1
URL=$2
CHECKSUM=$3

if [ -z "$VERSION" ] || [ -z "$URL" ] || [ -z "$CHECKSUM" ]; then
    echo "Usage: $0 <version> <url> <checksum>"
    echo "Example: $0 M144 https://github.com/.../SmileCXWebRTC-M144.xcframework.zip abc123..."
    exit 1
fi

cat > Package.swift << EOF
// swift-tools-version:5.3

import PackageDescription

let package = Package(
    name: "SmileCXWebRTC",
    platforms: [
        .iOS(.v14),
        .macOS(.v11)
    ],
    products: [
        .library(
            name: "SmileCXWebRTC",
            targets: ["SmileCXWebRTC"]),
    ],
    dependencies: [],
    targets: [
        .binaryTarget(
            name: "SmileCXWebRTC",
            url: "$URL",
            checksum: "$CHECKSUM"
        )
    ]
)
EOF

echo "✅ Package.swift updated for version $VERSION"
echo "📝 Commit and push:"
echo "   git add Package.swift"
echo "   git commit -m 'Update Package.swift to $VERSION'"
echo "   git push origin main"
