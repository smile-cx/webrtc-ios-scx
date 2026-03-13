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
            url: "https://github.com/smile-cx/webrtc-ios-scx/releases/download/146.7680.0/SmileCXWebRTC-M146.xcframework.zip",
            checksum: "619fd1f0f1cf66b3582ae98958a5c756351dcc783dfe06372538455dc8a3f618"
        )
    ]
)
