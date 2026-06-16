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
            url: "https://github.com/smile-cx/webrtc-ios-scx/releases/download/150.0.0/SmileCXWebRTC-150.xcframework.zip",
            checksum: "e8325fd91c4cdff6895260b39bdb64d8a166cab2c1f4ea4d871cca11d4c4acea"
        )
    ]
)
