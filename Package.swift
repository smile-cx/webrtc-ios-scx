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
            url: "https://github.com/smile-cx/webrtc-ios-scx/releases/download/149.0.0/SmileCXWebRTC-149.xcframework.zip",
            checksum: "2f37538916e78b2f9e1e2b1a92b6e1fbfb4d316821683afc5f4208dbf3c81203"
        )
    ]
)
