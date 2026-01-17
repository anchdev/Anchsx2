# ios.toolchain.cmake

set(CMAKE_SYSTEM_NAME Darwin)
set(CMAKE_SYSTEM_VERSION 18) # iOS 12+
set(CMAKE_OSX_SYSROOT /Applications/Xcode_14.0.app/Contents/Developer/Platforms/iPhoneOS.platform/Developer/SDKs/iPhoneOS.sdk)

# Set the target architecture
set(CMAKE_CROSSCOMPILING TRUE)
set(CMAKE_SYSTEM_PROCESSOR aarch64)

# Set compiler flags
set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -miphoneos-version-min=14.0")
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -miphoneos-version-min=14.0")

# Linker flags
set(CMAKE_EXE_LINKER_FLAGS "${CMAKE_EXE_LINKER_FLAGS} -Wl,-search_paths_first, -framework,CoreFoundation -framework,UIKit -framework,Foundation")
set(CMAKE_SHARED_LINKER_FLAGS "${CMAKE_SHARED_LINKER_FLAGS} -Wl,-search_paths_first, -framework,CoreFoundation -framework,UIKit -framework,Foundation")

# Add Metal support
find_package(Metal REQUIRED)
if(NOT Metal_FOUND)
  message(FATAL_ERROR "Metal library not found!")
else()
  message(STATUS "Metal found: ${Metal_VERSION}")
endif()

# Add Vulkan support
find_package(Vulkan REQUIRED)
if(NOT Vulkan_FOUND)
  message(FATAL_ERROR "Vulkan library not found!")
else()
  message(STATUS "Vulkan found: ${Vulkan_VERSION}")
endif()