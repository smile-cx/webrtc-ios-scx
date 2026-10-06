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
            url: "https://github.com/smile-cx/webrtc-ios-scx/releases/download/156.0.0/SmileCXWebRTC-156.xcframework.zip",
            checksum: "a5c6ccf822ba4ee5ec25f39566da4242b2c3bdc34b438fee05b1c255f9822c6b"
        )
    ]
)
