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
            url: "https://github.com/smile-cx/webrtc-ios-scx/releases/download/158.0.0/SmileCXWebRTC-158.xcframework.zip",
            checksum: "1a9d4fc85149014526ad2c300225e8281f51586d2207e7eb547eaa482b0bc4e4"
        )
    ]
)
