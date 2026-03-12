// swift-tools-version:5.3

import PackageDescription

let package = Package(
    name: "SmileCXWebRTC",
    products: [
        .library(
            name: "SmileCXWebRTC",
            targets: ["SmileCXWebRTC"]),
    ],
    dependencies: [],
    targets: [
        .binaryTarget(
            name: "SmileCXWebRTC",
            url: "https://github.com/smile-cx/webrtc-ios-scx/releases/download/95.4638.0/SmileCXWebRTC-M95.xcframework.zip",
            checksum: "b49d47cdbbd7d72b03a340aa1b55591b82824926ada8a54be992addf614c8325"
        )
    ]
)
