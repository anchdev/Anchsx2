# Setting it to a range tells it that it supports the features on the newer
# versions as well, avoiding setting policies.
cmake_minimum_required(VERSION 3.16...3.25)

# Enabling this cmake policy gets rid of warnings regarding LTO.
cmake_policy(SET CMP0069 NEW)
set(CMAKE_POLICY_DEFAULT_CMP0069 NEW)

if(${CMAKE_SOURCE_DIR} STREQUAL ${CMAKE_BINARY_DIR})
	message(FATAL_ERROR "PCSX2 does not support in-tree builds.  Please make a build directory that is not the PCSX2 source directory and generate your CMake project there using either `cmake -B build_directory` or by running cmake from the build directory.")
endif()

# Project Name
project(Pcsx2 C CXX)

# Variable to check that people use the good file
set(TOP_CMAKE_WAS_SOURCED TRUE)

# set module path
set(CMAKE_MODULE_PATH ${CMAKE_SOURCE_DIR}/cmake)

# Write binaries to the bin directory under the build directory.
# This makes it simple to run development builds directly out of the build directory.
if (UNIX AND NOT APPLE)
	set(CMAKE_RUNTIME_OUTPUT_DIRECTORY "${CMAKE_CURRENT_BINARY_DIR}/bin")
	set(CMAKE_LIBRARY_OUTPUT_DIRECTORY "${CMAKE_CURRENT_BINARY_DIR}/bin")
endif()

# include some generic functions to ensure correctness of the env
include(Pcsx2Utils)

check_no_parenthesis_in_path()
detect_operating_system()
detect_compiler()

#-------------------------------------------------------------------------------
# Include specific module
include(BuildParameters)
include(SearchForStuff)

# Must be done after SearchForStuff
get_git_version_info()
write_svnrev_h()

# make common
add_subdirectory(common)

# make pcsx2
add_subdirectory(pcsx2)

if(ENABLE_QT_UI)
	add_subdirectory(pcsx2-qt)
endif()

# Updater is Windows only for now.
if (WIN32)
	add_subdirectory(updater)
endif()

# tests
if(ENABLE_TESTS)
	add_subdirectory(3rdparty/googletest)
	add_subdirectory(tests/ctest)
endif()

# gsrunner
if(ENABLE_GSRUNNER)
	add_subdirectory(pcsx2-gsrunner)
else()
	add_subdirectory(pcsx2-gsrunner EXCLUDE_FROM_ALL)
endif()

#-------------------------------------------------------------------------------
if(NOT IS_SUPPORTED_COMPILER)
  message(WARNING "
*************** UNSUPPORTED CONFIGURATION ***************
You are not compiling PCSX2 with a supported compiler.
It may not even build successfully.
PCSX2 only supports the Clang and MSVC compilers.
No support will be provided, continue at your own risk.
*********************************************************")
endif()
 
if(_M_ARM64)
  message(WARNING "
*************** UNSUPPORTED CONFIGURATION (Apple Silicon) ***************
 
Apple Silicon support in PCSX2 is INCOMPLETE. There are
currently no EE/VU/IOP recompilers, and games will run
VERY slow. However, we now have Metal/Vulkan support detection.
You can enable Metal by setting -DMETAL=ON or Vulkan with -DVULKAN=ON.
 
We also ask that you read https://dont-ship.it/.
 
*********************************************************")
endif()
if(APPLE AND CMAKE_OSX_ARCHITECTURES MATCHES "arm64")
  message(STATUS "Apple Silicon (ARM64) detected. Metal/Vulkan support enabled.")
  if(NOT METAL)
    set(METAL ON CACHE BOOL "Enable Metal API" FORCE)
  endif()
  if(NOT VULKAN)
    set(VULKAN ON CACHE BOOL "Enable Vulkan API" FORCE)
  endif()
endif()
if(APPLE AND CMAKE_OSX_ARCHITECTURES MATCHES "x86_64")
  message(STATUS "Intel (x86_64) detected. Metal/Vulkan support available.")
  if(NOT METAL)
    set(METAL ON CACHE BOOL "Enable Metal API" FORCE)
  endif()
  if(NOT VULKAN)
    set(VULKAN ON CACHE BOOL "Enable Vulkan API" FORCE)
  endif()
endif()
if(APPLE AND CMAKE_OSX_ARCHITECTURES MATCHES "arm64")
  message(STATUS "iOS (ARM64) detected. Metal/Vulkan support enabled.")
  if(NOT METAL)
    set(METAL ON CACHE BOOL "Enable Metal API for iOS" FORCE)
  endif()
  if(NOT VULKAN)
    set(VULKAN ON CACHE BOOL "Enable Vulkan API for iOS" FORCE)
  endif()
endif()
if(APPLE AND CMAKE_OSX_ARCHITECTURES MATCHES "x86_64")
  message(STATUS "Intel (x86_64) detected. Metal/Vulkan support available.")
  if(NOT METAL)
    set(METAL ON CACHE BOOL "Enable Metal API for macOS" FORCE)
  endif()
  if(NOT VULKAN)
    set(VULKAN ON CACHE BOOL "Enable Vulkan API for macOS" FORCE)
  endif()
endif()
if(NOT (METAL OR VULKAN))
  message(STATUS "No GPU acceleration API selected. Falling back to software rendering.")

# Vulkan configuration
find_package(Vulkan REQUIRED)
if(NOT Vulkan_FOUND)
  message(FATAL_ERROR "Vulkan library not found!")
else()
  message(STATUS "Vulkan found: ${Vulkan_VERSION}")
  if(NOT VULKAN)
    set(VULKAN ON CACHE BOOL "Enable Vulkan API" FORCE)
  endif()
endif()
