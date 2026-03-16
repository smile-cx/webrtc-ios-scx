# Distribution Guide - iOS

This repository publishes SmileCXWebRTC as an XCFramework via Swift Package Manager.

## For Users - Installing via SPM

Add to your `Package.swift`:

```swift
dependencies: [
    .package(url: "https://github.com/smile-cx/webrtc-ios-scx.git", from: "144.7559.01")
]
```

Or in Xcode:
1. File → Add Package Dependencies
2. Enter URL: `https://github.com/smile-cx/webrtc-ios-scx.git`
3. Select version

## For Maintainers - Publishing New Releases

### 1. Build & Release (via GitHub Actions)

The workflow automatically:
- Builds WebRTC for the latest stable milestone
- Creates XCFramework
- Publishes release with `SmileCXWebRTC-M<version>.xcframework.zip`

### 2. Update Package.swift

After release is published:

```bash
# Calculate checksum
VERSION=144.7559.01
curl -L "https://github.com/smile-cx/webrtc-ios-scx/releases/download/${VERSION}/SmileCXWebRTC-M144.xcframework.zip" | swift package compute-checksum

# Update Package.swift with the script
./update_package.sh \
    "${VERSION}" \
    "https://github.com/smile-cx/webrtc-ios-scx/releases/download/${VERSION}/SmileCXWebRTC-M144.xcframework.zip" \
    "<checksum-from-above>"

# Commit and push
git add Package.swift
git commit -m "Update Package.swift to ${VERSION}"
git push origin main
```

### 3. Tag the Package.swift update

```bash
git tag -a "${VERSION}" -m "Release ${VERSION}"
git push origin "${VERSION}"
```

Now SPM can resolve the package at this version!

## Versioning

We use WebRTC milestone versions: `<milestone>.<branch>.0`
- Example: `144.7559.01` = Milestone 144, branch 7559, patch 01
