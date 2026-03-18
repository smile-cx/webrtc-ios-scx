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
            checksum: "8eced03b73a3a5a564dcb2de0150dd3c11279adcba2e8bb2e6008e2c6281147c"
        )
    ]
)
