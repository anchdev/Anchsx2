# PCSX2 Fork Development Instructions

A PlayStation 2 emulator fork with iOS/Swift support and Metal GPU acceleration.

## Architecture

**Hybrid C++/Swift Approach:**
- **C++ Core** (`pcsx2/`): High-performance emulation engine
- **Swift UI** (`pcsx2-ios/`): Modern iOS interface
- **GPU**: Metal API for iOS, Vulkan for desktop

## Building

### Windows/Linux (Desktop)
```bash
mkdir build && cd build
cmake -G "Visual Studio 17 2022" -A x64 ..
cmake --build . --config Release
```

### macOS/iOS
```bash
mkdir build && cd build
cmake -G Xcode -DCMAKE_SYSTEM_NAME=iOS -DCMAKE_OSX_ARCHITECTURES=arm64 -DMETAL=ON ..
xcodebuild -scheme Pcsx2 -configuration Release -arch arm64 -sdk iphoneos
```

## GitHub Actions CI/CD

Automated builds for:
- iOS IPA generation (`.github/workflows/build-ios.yml`)
- Arm64 Metal-accelerated builds
- Release artifact upload

## Project Structure
```
pcsx2/
├── pcsx2/              # Emulator core
├── pcsx2-ios/          # Swift iOS app
├── .github/workflows/  # CI/CD pipelines
├── docs/
│   └── iOS_Build_Guide.md
└── cmake/              # Build configuration
```

## Development Workflow

1. Create feature branch: `git checkout -b feature/your-feature`
2. Make changes with proper C++ or Swift conventions
3. Test on target platform (desktop/iOS)
4. Commit with descriptive messages
5. Push to fork at github.com/anchdev/pcsx2
