# SmileCX WebRTC for iOS

Pre-built WebRTC XCFramework for iOS and macOS with symbol prefixing to prevent collisions with other WebRTC implementations.

## Overview

This repository provides WebRTC binaries for iOS/macOS with SmileCX-prefixed Objective-C symbols. This ensures that the Vivocha SDK won't have symbol collision with other libraries embedded in the customer app.

### Symbol Isolation Strategy

All public Objective-C classes are prefixed with `SCX`:
- Original: `RTCAudioSession`, `RTCPeerConnection`, `RTCVideoTrack`
- Prefixed: `SCXRTCAudioSession`, `SCXRTCPeerConnection`, `SCXRTCVideoTrack`

This prevents conflicts with standard WebRTC libraries (using `RTC` prefix) or other prefixed versions.

## Installation

### Swift Package Manager

Add to your `Package.swift`:

```swift
dependencies: [
    .package(url: "https://github.com/smile-cx/webrtc-ios-scx.git", from: "146")
]
```

Or in Xcode:
1. File → Add Package Dependencies
2. Enter URL: `https://github.com/smile-cx/webrtc-ios-scx.git`
3. Select version (e.g., 144, 146)

### Manual Installation

Download the XCFramework from [Releases](https://github.com/smile-cx/webrtc-ios-scx/releases) and drag it into your Xcode project.

## Usage

Import and use WebRTC classes with the `SCX` prefix:

```swift
import SmileCXWebRTC

// Create peer connection factory
let config = SCXRTCConfiguration()
let constraints = SCXRTCMediaConstraints(mandatoryConstraints: nil, optionalConstraints: nil)
let factory = SCXRTCPeerConnectionFactory()

// Create peer connection
let peerConnection = factory.peerConnection(with: config,
                                           constraints: constraints,
                                           delegate: self)

// Create video track
let videoSource = factory.videoSource()
let videoTrack = factory.videoTrack(with: videoSource, trackId: "video0")
```

## Versioning

We use milestone-based versioning:

- `144` - WebRTC Milestone 144
- `146` - WebRTC Milestone 146
- etc.

Each release includes the full WebRTC version in the release notes (e.g., 146.7680.0).

## How It Works

### Build Process

1. **WebRTC Build**: Patches are applied during build to add Objective-C type prefixes
   - Uses `RTC_OBJC_TYPE` macro expansion with custom prefix
   - Modifies build system to inject `SCX` prefix
   - Outputs: XCFramework with prefixed symbols

2. **Distribution**:
   - XCFramework uploaded to GitHub releases
   - Swift Package Manager references binary from GitHub
   - `Package.swift` specifies download URL and checksum

### Architecture

```
webrtc-ios-scx/
├── patches/                    # Patches for symbol prefixing
│   └── objc_prefix_smile.patch # Objective-C type prefix modifications
├── scripts/                    # Build scripts
├── Package.swift              # SPM binary target configuration
└── .github/workflows/         # CI/CD for WebRTC builds
```

## Platform Support

- **iOS**: 14.0+
- **macOS**: 11.0+

Architectures:
- iOS: arm64, arm64-simulator (Apple Silicon), x86_64-simulator (Intel)
- macOS: arm64 (Apple Silicon), x86_64 (Intel)

## Documentation

- **[DISTRIBUTION.md](DISTRIBUTION.md)**: Complete guide for users and maintainers
- **[BUILD_REPLICATION_PLAN.md](BUILD_REPLICATION_PLAN.md)**: How to replicate the build system

## For Maintainers

See [DISTRIBUTION.md](DISTRIBUTION.md) for:
- Publishing new releases
- Updating Package.swift
- Build configuration

## License

WebRTC is licensed under the BSD 3-Clause License. See [LICENSE](LICENSE) for details.

## References

- [WebRTC Official Documentation](https://webrtc.github.io/webrtc-org/native-code/ios/)
- [Official WebRTC iOS Builds](https://cocoapods.org/pods/GoogleWebRTC)
