# Distribution Guide - iOS

This repository publishes SmileCXWebRTC as an XCFramework via Swift Package Manager.

## For Users - Installing via SPM

Add to your `Package.swift`:

```swift
dependencies: [
    .package(url: "https://github.com/smile-cx/webrtc-ios-scx.git", from: "146")
]
```

Or in Xcode:
1. File → Add Package Dependencies
2. Enter URL: `https://github.com/smile-cx/webrtc-ios-scx.git`
3. Select version (e.g., M144, M146)

## For Maintainers - Publishing New Releases

### Automated Daily Workflow

The repository has two GitHub Actions workflows:

1. **Scheduled Workflow** (`build_last_mstone.yml`) - Runs daily at midnight (UTC)
   - Checks for new stable WebRTC milestones
   - **Smart build detection**: Only rebuilds if new branch detected (~40 min)
   - **Fast path**: Reuses existing XCFramework if same branch (~2 min)
   - Updates Package.swift with correct checksum automatically

2. **On-Demand Workflow** (`build_mstones.yml`) - Manual trigger for specific milestones
   - Build specific milestone versions
   - Can reuse existing XCFramework or force rebuild

### What the Workflows Do

**For new WebRTC branches:**
1. Checkout WebRTC source
2. Apply SmileCX patches (Objective-C prefix)
3. Build XCFramework for iOS (x64 simulator, arm64 simulator, arm64 device)
4. Calculate checksum
5. Update Package.swift with new URL and checksum
6. Commit Package.swift changes
7. Create/update milestone tag (e.g., `146`)
8. Create or update GitHub release with XCFramework asset

**For existing releases (same branch):**
1. Download existing XCFramework from release
2. Extract checksum
3. Update Package.swift if needed
4. Commit only if changes detected
5. Skip tag push (already correct)
6. Update release if needed

### Manual Release (if needed)

To trigger a build manually:
1. Go to Actions → "OnDemand Release SmileCXWebRTC"
2. Click "Run workflow"
3. Wait for completion (~2 minutes if reusing XCFramework, ~40 minutes for new build)

## Versioning

We use **milestone-only tags** with full version in release notes:

- **Milestone tag**: `146` (used for releases and SPM)
- **Release notes**: "WebRTC Version: 146.7680.0" (full version info)
- **Release title**: "M146"

When a new branch version is available (e.g., 146.7680.1), the workflow:
1. Detects new branch by parsing release notes
2. Rebuilds XCFramework
3. Force-updates milestone tag `146` to point to new commit
4. Updates release with new asset

**Benefits:**
- Tags remain clean and updatable
- Full version tracking in release body
- SPM dependencies use stable milestone tags: `.package(url: "...", from: "146")`
- Daily automation prevents manual intervention
