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
            url: "https://github.com/smile-cx/webrtc-ios-scx/releases/download/155.0.0/SmileCXWebRTC-155.xcframework.zip",
            checksum: "0cb3ccd5f7637d114df6ea681d4c8aae1e21de36fd55f1da41e705fe1060fe0e"
        )
    ]
)
