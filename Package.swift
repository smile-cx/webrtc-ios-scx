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
            url: "https://github.com/smile-cx/webrtc-ios-scx/releases/download/146/SmileCXWebRTC-146.xcframework.zip",
            checksum: "430874ff649a8bcfb6a6118d582c1bbf3c3d9f977538b9f74ee70051c1eaac46"
        )
    ]
)
