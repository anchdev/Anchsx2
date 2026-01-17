# PCSX2 Fork Development Instructions

This workspace is configured for PCSX2 PlayStation 2 emulator development.

## Project Setup

- PCSX2 is a C++20 emulator project using CMake build system
- Requires Visual Studio Build Tools or MSVC compiler
- Dependencies include Qt6, SDL2, and various audio/video libraries

## Building the Project

```bash
cd build
cmake -G "Visual Studio 17 2022" -A x64 ..
cmake --build . --config Release
```

## Development

- Code is organized in modular components (CPU, GPU, SPU, etc.)
- Use the build folder for out-of-source builds
- Refer to CMakeLists.txt for dependency management

## Contributing

When forking and making changes:
1. Create a feature branch for your changes
2. Test thoroughly on various games
3. Follow the existing code style and conventions
