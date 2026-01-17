# PCSX2 iOS Build Guide

## Overview
This fork includes Swift UI and iOS build support for PCSX2. The project uses a hybrid approach:
- **C++ Core**: Original PCSX2 emulator engine
- **Swift UI**: Modern iOS interface using SwiftUI
- **Metal/Vulkan**: GPU acceleration via Metal on iOS

## Project Structure

```
pcsx2/
├── pcsx2/                 # Main C++ emulator core
├── pcsx2-ios/            # Swift iOS app
│   ├── PCSX2Controller.swift  # Bridge to C++ core
│   ├── ContentView.swift      # Main UI
│   └── project.json          # iOS project config
├── .github/workflows/
│   └── build-ios.yml         # GitHub Actions CI/CD
└── ExportOptions.plist       # iOS export settings
```

## Building for iOS

### Prerequisites
- macOS 12.0 or later
- Xcode 13.0 or later
- CMake 3.21+
- Command line tools

### Build Steps

#### 1. Configure CMake for iOS
```bash
cd build
cmake -G Xcode \
  -DCMAKE_SYSTEM_NAME=iOS \
  -DCMAKE_OSX_ARCHITECTURES=arm64 \
  -DCMAKE_OSX_DEPLOYMENT_TARGET=14.0 \
  -DBUILD_SHARED_LIBS=OFF \
  -DCMAKE_BUILD_TYPE=Release \
  -DMETAL=ON \
  -DVULKAN=ON \
  ..
```

#### 2. Build for iOS Device
```bash
xcodebuild -scheme Pcsx2 \
  -configuration Release \
  -arch arm64 \
  -sdk iphoneos \
  -derivedDataPath build
```

#### 3. Create IPA Archive
```bash
xcodebuild -exportArchive \
  -archivePath ./build/Pcsx2.xcarchive \
  -exportOptionsPlist ExportOptions.plist \
  -exportPath ./output
```

### Building in Xcode

1. Open the generated `build/Pcsx2.xcodeproj`
2. Select "Pcsx2" as the target
3. Select "Generic iOS Device" or your connected device
4. Press `Cmd+B` to build
5. Press `Cmd+R` to run

## Swift-C++ Interoperability

The `PCSX2Controller.swift` file provides the bridge between the Swift UI and C++ core:

```swift
// Objective-C++ bridging header (PCSX2Controller-Bridging-Header.h)
#ifndef PCSX2_BRIDGING_HEADER_H
#define PCSX2_BRIDGING_HEADER_H

#include "pcsx2/Pcsx2Defs.h"
#include "pcsx2/R5900.h"
#include "common/FileSystem.h"

// Forward declarations
void PCSX2_Initialize();
void PCSX2_LoadGame(const char* path);
void PCSX2_Play();
void PCSX2_Pause();
void PCSX2_Stop();
uint32_t* PCSX2_GetFrameBuffer();

#endif
```

## GitHub Actions Workflow

The `.github/workflows/build-ios.yml` automates:
1. Building the C++ core for iOS
2. Compiling the Swift UI
3. Creating the IPA package
4. Uploading artifacts
5. Creating releases on tags

### Triggering Builds
- Push to `master`, `main`, or `develop` branches
- Create a pull request
- Tag commits for releases: `git tag v1.0.0 && git push --tags`

## GPU Acceleration

### Metal (Recommended for iOS)
Metal is Apple's low-level graphics API. It's automatically enabled for iOS builds:
```cmake
-DMETAL=ON
```

### Features
- Native Metal shaders for PS2 GPU emulation
- Better performance than software rendering
- Compatible with all iOS 14+ devices

## Testing ROM Files

1. Place PS2 ISO files in app's Documents directory
2. Use the file picker in the app to select a ROM
3. Press Play to start emulation

## Troubleshooting

### Build Fails with "Vulkan not found"
Remove Vulkan requirement for iOS:
```bash
cmake ... -DVULKAN=OFF
```

### Memory Issues
iOS has stricter memory limits. Disable debug symbols:
```bash
-DCMAKE_BUILD_TYPE=Release
```

### Code Signing Errors
Update `ExportOptions.plist` with your Apple Team ID:
```xml
<key>teamID</key>
<string>YOUR_TEAM_ID</string>
```

## Performance Considerations

- iOS A15+ recommended for playable frame rates
- Older devices will have reduced performance
- Some CPU-intensive games may not run at playable speeds
- Lower resolution rendering can improve performance

## License

PCSX2 is licensed under GPLv3. See `COPYING.GPLv3` for details.
