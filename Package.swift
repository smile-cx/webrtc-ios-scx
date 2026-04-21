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
            url: "https://github.com/smile-cx/webrtc-ios-scx/releases/download/148.0.0/SmileCXWebRTC-148.xcframework.zip",
            checksum: "b3d5e0907d5c641e23ff1560a532a7ca19248daa1f45a2ba720e952e69c4c8f4"
        )
    ]
)
