# PCSX2 on iOS via LiveContainer

## Quick Start

**Bundle ID:** `com.anchdev.pcsx2`  
**Minimum iOS:** 14.0  
**Architecture:** ARM64 (all modern iPhones/iPads)

## Installation Steps

### 1. Install LiveContainer
Download LiveContainer from the App Store or Sideload Store

### 2. Get PCSX2 IPA
Download the latest unsigned IPA from releases:
- `PCSX2-unsigned.ipa`

### 3. Install in LiveContainer
1. Open LiveContainer
2. Tap "+" to add new app
3. Select `PCSX2-unsigned.ipa`
4. LiveContainer handles the rest
5. Launch from Home Screen

## Using PCSX2

### First Run
- App will request Document access permission
- Grant access to load ROM files

### Loading ROMs
1. Tap the folder icon in the app
2. Navigate to your PS2 ISO files
3. Select a ROM to load

### Controls
- **Play** (▶) - Start emulation
- **Pause** (⏸) - Pause emulation  
- **Stop** (⏹) - Stop emulation

## File Management

### Adding ROMs to iOS

#### Method 1: Files App
1. Files app → On My iPhone → PCSX2
2. Drag and drop ISO files

#### Method 2: Document Picker
- Use in-app file picker to browse Documents folder

#### Supported Formats
- `.iso` (ISO 9660 disc images)
- `.cso` (Compressed ISO)
- `.bin/.cue` (Multi-file disc)

## GPU Acceleration

PCSX2 uses **Metal** for GPU rendering:
- Automatic detection
- No additional setup needed
- Provides best performance

Fallback to software rendering if Metal unavailable.

## Performance Tips

1. **Device Matters**
   - iPhone 15 / A17 Pro: Excellent
   - iPhone 14 / A16 Bionic: Very Good
   - iPhone 13 / A15 Bionic: Good
   - Older devices: Limited

2. **Graphics Settings**
   - Lower resolution = Better FPS
   - Metal enabled by default
   - Software rendering available if needed

3. **Game Selection**
   - Simpler games run faster
   - Avoid heavy CPU-intensive titles on older devices

## Troubleshooting

### App Won't Launch
- Force quit and reopen
- Check LiveContainer has permission
- Reinstall IPA in LiveContainer

### Black Screen on Startup
- Try different game ROM
- Check console output in LiveContainer logs
- Ensure ROM file is valid

### Low Performance
- Check device temperature
- Try lower resolution
- Close background apps

### Permission Issues
- Go to iOS Settings → PCSX2
- Enable "Documents & Folders" permission
- Grant Full Disk Access if available

## System Requirements

| Component | Requirement |
|-----------|------------|
| iOS Version | 14.0+ |
| RAM | 3GB minimum (4GB+ recommended) |
| Storage | 500MB for app + game ROMs |
| Processor | A11 Bionic or newer |
| GPU | Metal support (all modern devices) |

## Known Limitations

1. **No USB Controller Support** - Currently touch only
2. **Save Files** - Stored in app Documents
3. **Network Features** - Limited
4. **Aspect Ratio** - Letterboxed on some devices

## Legal Notice

- PCSX2 is open-source under GPLv3
- You must own PS2 games you emulate
- This tool is for legitimate preservation and testing

## Support

For issues:
1. Check GitHub Issues: github.com/anchdev/pcsx2
2. Verify app permissions in iOS Settings
3. Try fresh install in LiveContainer
4. Check system requirements above

## Build Info

**App Details:**
- Name: PCSX2
- Bundle ID: com.anchdev.pcsx2
- Version: 1.0
- Build: 1

**Graphics:**
- Primary: Metal (iOS)
- Fallback: Software rendering

**Architecture:**
- ARM64 (native for modern iOS)
- Optimized for Apple Silicon M-series Macs

---

Enjoy playing PS2 classics on your iPhone/iPad!
