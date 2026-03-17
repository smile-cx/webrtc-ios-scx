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
            url: "https://github.com/smile-cx/webrtc-ios-scx/releases/download/146.7680.0/SmileCXWebRTC-146.7680.0.xcframework.zip",
            checksum: "140734dbad5657e263d8ddaa2da6b5db74fcaccf8bf47343ae500186b6e9ee32"
        )
    ]
)
