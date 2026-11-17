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
            url: "https://github.com/smile-cx/webrtc-ios-scx/releases/download/159.0.0/SmileCXWebRTC-159.xcframework.zip",
            checksum: "bce15f174d3b704a8c31fd9ee16bd1a6eb03af33db44ed889a2b5741b75d66cb"
        )
    ]
)
