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
            checksum: "e5c9dd4d651b2f808b01bbe3a9479793e3add5ba055557d4037ba605aa3c99cb"
        )
    ]
)
