# WebRTC Modification Patches

This directory contains patches applied to the upstream WebRTC source code to enable symbol prefixing and framework renaming for the SmileCX distribution.

## Patch: apple_prefix_smilecx.patch

**Purpose**: Applies Objective-C symbol prefixing and framework renaming to prevent symbol collisions in customer applications.

**License Compliance**: These modifications are made in accordance with the BSD 3-Clause License under which WebRTC is distributed. The original copyright notices and license terms are preserved in the LICENSE.md file at the repository root.

### Modified Files

1. **sdk/objc/base/RTCMacros.h**
   - Changes: Set `RTC_OBJC_TYPE_PREFIX` to `SCX` and `RTC_CONSTANT_TYPE_PREFIX` to `kSCX`
   - Effect: All public Objective-C types are prefixed with `SCX` (e.g., `SCXRTCPeerConnection`)

2. **sdk/BUILD.gn**
   - Changes: Rename framework output from `WebRTC` to `SmileCXWebRTC`
   - Effect: Generated framework is named `SmileCXWebRTC.framework`

3. **sdk/objc/Info.plist**
   - Changes: Update bundle identifier and display names
   - Effect: Bundle ID changed to `cx.smile.SmileCXWebRTC`

4. **tools_webrtc/ios/generate_umbrella_header.py**
   - Changes: Update import statements in generated umbrella header
   - Effect: Generated headers reference `<SmileCXWebRTC/...>` instead of `<WebRTC/...>`

5. **tools_webrtc/apple/copy_framework_header.py**
   - Changes: Update import path rewriting logic
   - Effect: Framework headers properly reference the renamed framework

6. **tools_webrtc/ios/build_ios_libs.py**
   - Changes: Update framework and XCFramework output names
   - Effect: Build system generates `SmileCXWebRTC.xcframework`

### Application Process

The patch is applied during the build process before compilation. See the GitHub Actions workflows in `.github/workflows/` for the exact application sequence.

### Verification

After applying the patch, the following checks verify successful application:
- `grep -q "SCX" sdk/objc/base/RTCMacros.h` - Verifies symbol prefix
- `grep -q "SmileCXWebRTC" sdk/BUILD.gn` - Verifies framework name
- `grep -q "cx.smile.SmileCXWebRTC" sdk/objc/Info.plist` - Verifies bundle ID

### Purpose of Modifications

These modifications enable the Vivocha SDK to embed WebRTC without conflicting with other WebRTC implementations that may be present in customer applications. This is particularly important for:
- Preventing linker errors when multiple WebRTC versions are present
- Avoiding runtime symbol resolution conflicts
- Ensuring proper framework isolation in iOS/macOS applications

### Upstream Compatibility

The patch is designed to be forward-compatible with WebRTC updates. The modifications leverage WebRTC's built-in prefix customization mechanism (as documented in RTCMacros.h comments), making the changes less invasive and more maintainable across WebRTC version updates.

## License Information

**Original WebRTC**: BSD 3-Clause License (Copyright 2011, The WebRTC project authors)
**This Distribution**: Same BSD 3-Clause License with modifications documented in NOTICE file

See the repository root for:
- **LICENSE.md**: Complete license texts
- **NOTICE**: Detailed modification notices
