# CMAKE generated file: DO NOT EDIT!
# Generated by "Unix Makefiles" Generator, CMake Version 3.27

# Delete rule output on recipe failure.
.DELETE_ON_ERROR:

#=============================================================================
# Special targets provided by cmake.

# Disable implicit rules so canonical targets will work.
.SUFFIXES:

# Disable VCS-based implicit rules.
% : %,v

# Disable VCS-based implicit rules.
% : RCS/%

# Disable VCS-based implicit rules.
% : RCS/%,v

# Disable VCS-based implicit rules.
% : SCCS/s.%

# Disable VCS-based implicit rules.
% : s.%

.SUFFIXES: .hpux_make_needs_suffix_list

# Command-line flag to silence nested $(MAKE).
$(VERBOSE)MAKESILENT = -s

#Suppress display of executed commands.
$(VERBOSE).SILENT:

# A target that is always out of date.
cmake_force:
.PHONY : cmake_force

#=============================================================================
# Set environment variables for the build.

# The shell in which to execute make rules.
SHELL = /bin/sh

# The CMake executable.
CMAKE_COMMAND = /snap/cmake/1336/bin/cmake

# The command to remove a file.
RM = /snap/cmake/1336/bin/cmake -E rm -f

# Escaping for special characters.
EQUALS = =

# The top-level source directory on which CMake was run.
CMAKE_SOURCE_DIR = /home/frank/Documents/colaboracio_joan_catalina/codis/codis_definitiu

# The top-level build directory on which CMake was run.
CMAKE_BINARY_DIR = /home/frank/Documents/colaboracio_joan_catalina/codis/codis_definitiu/build

# Include any dependencies generated for this target.
include _deps/core-build/CMakeFiles/core.dir/depend.make
# Include any dependencies generated by the compiler for this target.
include _deps/core-build/CMakeFiles/core.dir/compiler_depend.make

# Include the progress variables for this target.
include _deps/core-build/CMakeFiles/core.dir/progress.make

# Include the compile flags for this target's objects.
include _deps/core-build/CMakeFiles/core.dir/flags.make

_deps/core-build/CMakeFiles/core.dir/src/libBasic.cpp.o: _deps/core-build/CMakeFiles/core.dir/flags.make
_deps/core-build/CMakeFiles/core.dir/src/libBasic.cpp.o: _deps/core-src/src/libBasic.cpp
_deps/core-build/CMakeFiles/core.dir/src/libBasic.cpp.o: _deps/core-build/CMakeFiles/core.dir/compiler_depend.ts
	@$(CMAKE_COMMAND) -E cmake_echo_color "--switch=$(COLOR)" --green --progress-dir=/home/frank/Documents/colaboracio_joan_catalina/codis/codis_definitiu/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_1) "Building CXX object _deps/core-build/CMakeFiles/core.dir/src/libBasic.cpp.o"
	cd /home/frank/Documents/colaboracio_joan_catalina/codis/codis_definitiu/build/_deps/core-build && /usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -MD -MT _deps/core-build/CMakeFiles/core.dir/src/libBasic.cpp.o -MF CMakeFiles/core.dir/src/libBasic.cpp.o.d -o CMakeFiles/core.dir/src/libBasic.cpp.o -c /home/frank/Documents/colaboracio_joan_catalina/codis/codis_definitiu/build/_deps/core-src/src/libBasic.cpp

_deps/core-build/CMakeFiles/core.dir/src/libBasic.cpp.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color "--switch=$(COLOR)" --green "Preprocessing CXX source to CMakeFiles/core.dir/src/libBasic.cpp.i"
	cd /home/frank/Documents/colaboracio_joan_catalina/codis/codis_definitiu/build/_deps/core-build && /usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E /home/frank/Documents/colaboracio_joan_catalina/codis/codis_definitiu/build/_deps/core-src/src/libBasic.cpp > CMakeFiles/core.dir/src/libBasic.cpp.i

_deps/core-build/CMakeFiles/core.dir/src/libBasic.cpp.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color "--switch=$(COLOR)" --green "Compiling CXX source to assembly CMakeFiles/core.dir/src/libBasic.cpp.s"
	cd /home/frank/Documents/colaboracio_joan_catalina/codis/codis_definitiu/build/_deps/core-build && /usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S /home/frank/Documents/colaboracio_joan_catalina/codis/codis_definitiu/build/_deps/core-src/src/libBasic.cpp -o CMakeFiles/core.dir/src/libBasic.cpp.s

_deps/core-build/CMakeFiles/core.dir/src/libImageFormats.c.o: _deps/core-build/CMakeFiles/core.dir/flags.make
_deps/core-build/CMakeFiles/core.dir/src/libImageFormats.c.o: _deps/core-src/src/libImageFormats.c
_deps/core-build/CMakeFiles/core.dir/src/libImageFormats.c.o: _deps/core-build/CMakeFiles/core.dir/compiler_depend.ts
	@$(CMAKE_COMMAND) -E cmake_echo_color "--switch=$(COLOR)" --green --progress-dir=/home/frank/Documents/colaboracio_joan_catalina/codis/codis_definitiu/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_2) "Building C object _deps/core-build/CMakeFiles/core.dir/src/libImageFormats.c.o"
	cd /home/frank/Documents/colaboracio_joan_catalina/codis/codis_definitiu/build/_deps/core-build && /usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -MD -MT _deps/core-build/CMakeFiles/core.dir/src/libImageFormats.c.o -MF CMakeFiles/core.dir/src/libImageFormats.c.o.d -o CMakeFiles/core.dir/src/libImageFormats.c.o -c /home/frank/Documents/colaboracio_joan_catalina/codis/codis_definitiu/build/_deps/core-src/src/libImageFormats.c

_deps/core-build/CMakeFiles/core.dir/src/libImageFormats.c.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color "--switch=$(COLOR)" --green "Preprocessing C source to CMakeFiles/core.dir/src/libImageFormats.c.i"
	cd /home/frank/Documents/colaboracio_joan_catalina/codis/codis_definitiu/build/_deps/core-build && /usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -E /home/frank/Documents/colaboracio_joan_catalina/codis/codis_definitiu/build/_deps/core-src/src/libImageFormats.c > CMakeFiles/core.dir/src/libImageFormats.c.i

_deps/core-build/CMakeFiles/core.dir/src/libImageFormats.c.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color "--switch=$(COLOR)" --green "Compiling C source to assembly CMakeFiles/core.dir/src/libImageFormats.c.s"
	cd /home/frank/Documents/colaboracio_joan_catalina/codis/codis_definitiu/build/_deps/core-build && /usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -S /home/frank/Documents/colaboracio_joan_catalina/codis/codis_definitiu/build/_deps/core-src/src/libImageFormats.c -o CMakeFiles/core.dir/src/libImageFormats.c.s

_deps/core-build/CMakeFiles/core.dir/src/libImageFormatPM.cpp.o: _deps/core-build/CMakeFiles/core.dir/flags.make
_deps/core-build/CMakeFiles/core.dir/src/libImageFormatPM.cpp.o: _deps/core-src/src/libImageFormatPM.cpp
_deps/core-build/CMakeFiles/core.dir/src/libImageFormatPM.cpp.o: _deps/core-build/CMakeFiles/core.dir/compiler_depend.ts
	@$(CMAKE_COMMAND) -E cmake_echo_color "--switch=$(COLOR)" --green --progress-dir=/home/frank/Documents/colaboracio_joan_catalina/codis/codis_definitiu/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_3) "Building CXX object _deps/core-build/CMakeFiles/core.dir/src/libImageFormatPM.cpp.o"
	cd /home/frank/Documents/colaboracio_joan_catalina/codis/codis_definitiu/build/_deps/core-build && /usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -MD -MT _deps/core-build/CMakeFiles/core.dir/src/libImageFormatPM.cpp.o -MF CMakeFiles/core.dir/src/libImageFormatPM.cpp.o.d -o CMakeFiles/core.dir/src/libImageFormatPM.cpp.o -c /home/frank/Documents/colaboracio_joan_catalina/codis/codis_definitiu/build/_deps/core-src/src/libImageFormatPM.cpp

_deps/core-build/CMakeFiles/core.dir/src/libImageFormatPM.cpp.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color "--switch=$(COLOR)" --green "Preprocessing CXX source to CMakeFiles/core.dir/src/libImageFormatPM.cpp.i"
	cd /home/frank/Documents/colaboracio_joan_catalina/codis/codis_definitiu/build/_deps/core-build && /usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E /home/frank/Documents/colaboracio_joan_catalina/codis/codis_definitiu/build/_deps/core-src/src/libImageFormatPM.cpp > CMakeFiles/core.dir/src/libImageFormatPM.cpp.i

_deps/core-build/CMakeFiles/core.dir/src/libImageFormatPM.cpp.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color "--switch=$(COLOR)" --green "Compiling CXX source to assembly CMakeFiles/core.dir/src/libImageFormatPM.cpp.s"
	cd /home/frank/Documents/colaboracio_joan_catalina/codis/codis_definitiu/build/_deps/core-build && /usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S /home/frank/Documents/colaboracio_joan_catalina/codis/codis_definitiu/build/_deps/core-src/src/libImageFormatPM.cpp -o CMakeFiles/core.dir/src/libImageFormatPM.cpp.s

_deps/core-build/CMakeFiles/core.dir/src/libImage.cpp.o: _deps/core-build/CMakeFiles/core.dir/flags.make
_deps/core-build/CMakeFiles/core.dir/src/libImage.cpp.o: _deps/core-src/src/libImage.cpp
_deps/core-build/CMakeFiles/core.dir/src/libImage.cpp.o: _deps/core-build/CMakeFiles/core.dir/compiler_depend.ts
	@$(CMAKE_COMMAND) -E cmake_echo_color "--switch=$(COLOR)" --green --progress-dir=/home/frank/Documents/colaboracio_joan_catalina/codis/codis_definitiu/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_4) "Building CXX object _deps/core-build/CMakeFiles/core.dir/src/libImage.cpp.o"
	cd /home/frank/Documents/colaboracio_joan_catalina/codis/codis_definitiu/build/_deps/core-build && /usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -MD -MT _deps/core-build/CMakeFiles/core.dir/src/libImage.cpp.o -MF CMakeFiles/core.dir/src/libImage.cpp.o.d -o CMakeFiles/core.dir/src/libImage.cpp.o -c /home/frank/Documents/colaboracio_joan_catalina/codis/codis_definitiu/build/_deps/core-src/src/libImage.cpp

_deps/core-build/CMakeFiles/core.dir/src/libImage.cpp.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color "--switch=$(COLOR)" --green "Preprocessing CXX source to CMakeFiles/core.dir/src/libImage.cpp.i"
	cd /home/frank/Documents/colaboracio_joan_catalina/codis/codis_definitiu/build/_deps/core-build && /usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E /home/frank/Documents/colaboracio_joan_catalina/codis/codis_definitiu/build/_deps/core-src/src/libImage.cpp > CMakeFiles/core.dir/src/libImage.cpp.i

_deps/core-build/CMakeFiles/core.dir/src/libImage.cpp.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color "--switch=$(COLOR)" --green "Compiling CXX source to assembly CMakeFiles/core.dir/src/libImage.cpp.s"
	cd /home/frank/Documents/colaboracio_joan_catalina/codis/codis_definitiu/build/_deps/core-build && /usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S /home/frank/Documents/colaboracio_joan_catalina/codis/codis_definitiu/build/_deps/core-src/src/libImage.cpp -o CMakeFiles/core.dir/src/libImage.cpp.s

_deps/core-build/CMakeFiles/core.dir/src/libColorSpace.cpp.o: _deps/core-build/CMakeFiles/core.dir/flags.make
_deps/core-build/CMakeFiles/core.dir/src/libColorSpace.cpp.o: _deps/core-src/src/libColorSpace.cpp
_deps/core-build/CMakeFiles/core.dir/src/libColorSpace.cpp.o: _deps/core-build/CMakeFiles/core.dir/compiler_depend.ts
	@$(CMAKE_COMMAND) -E cmake_echo_color "--switch=$(COLOR)" --green --progress-dir=/home/frank/Documents/colaboracio_joan_catalina/codis/codis_definitiu/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_5) "Building CXX object _deps/core-build/CMakeFiles/core.dir/src/libColorSpace.cpp.o"
	cd /home/frank/Documents/colaboracio_joan_catalina/codis/codis_definitiu/build/_deps/core-build && /usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -MD -MT _deps/core-build/CMakeFiles/core.dir/src/libColorSpace.cpp.o -MF CMakeFiles/core.dir/src/libColorSpace.cpp.o.d -o CMakeFiles/core.dir/src/libColorSpace.cpp.o -c /home/frank/Documents/colaboracio_joan_catalina/codis/codis_definitiu/build/_deps/core-src/src/libColorSpace.cpp

_deps/core-build/CMakeFiles/core.dir/src/libColorSpace.cpp.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color "--switch=$(COLOR)" --green "Preprocessing CXX source to CMakeFiles/core.dir/src/libColorSpace.cpp.i"
	cd /home/frank/Documents/colaboracio_joan_catalina/codis/codis_definitiu/build/_deps/core-build && /usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E /home/frank/Documents/colaboracio_joan_catalina/codis/codis_definitiu/build/_deps/core-src/src/libColorSpace.cpp > CMakeFiles/core.dir/src/libColorSpace.cpp.i

_deps/core-build/CMakeFiles/core.dir/src/libColorSpace.cpp.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color "--switch=$(COLOR)" --green "Compiling CXX source to assembly CMakeFiles/core.dir/src/libColorSpace.cpp.s"
	cd /home/frank/Documents/colaboracio_joan_catalina/codis/codis_definitiu/build/_deps/core-build && /usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S /home/frank/Documents/colaboracio_joan_catalina/codis/codis_definitiu/build/_deps/core-src/src/libColorSpace.cpp -o CMakeFiles/core.dir/src/libColorSpace.cpp.s

# Object files for target core
core_OBJECTS = \
"CMakeFiles/core.dir/src/libBasic.cpp.o" \
"CMakeFiles/core.dir/src/libImageFormats.c.o" \
"CMakeFiles/core.dir/src/libImageFormatPM.cpp.o" \
"CMakeFiles/core.dir/src/libImage.cpp.o" \
"CMakeFiles/core.dir/src/libColorSpace.cpp.o"

# External object files for target core
core_EXTERNAL_OBJECTS =

_deps/core-build/libcore.a: _deps/core-build/CMakeFiles/core.dir/src/libBasic.cpp.o
_deps/core-build/libcore.a: _deps/core-build/CMakeFiles/core.dir/src/libImageFormats.c.o
_deps/core-build/libcore.a: _deps/core-build/CMakeFiles/core.dir/src/libImageFormatPM.cpp.o
_deps/core-build/libcore.a: _deps/core-build/CMakeFiles/core.dir/src/libImage.cpp.o
_deps/core-build/libcore.a: _deps/core-build/CMakeFiles/core.dir/src/libColorSpace.cpp.o
_deps/core-build/libcore.a: _deps/core-build/CMakeFiles/core.dir/build.make
_deps/core-build/libcore.a: _deps/core-build/CMakeFiles/core.dir/link.txt
	@$(CMAKE_COMMAND) -E cmake_echo_color "--switch=$(COLOR)" --green --bold --progress-dir=/home/frank/Documents/colaboracio_joan_catalina/codis/codis_definitiu/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_6) "Linking CXX static library libcore.a"
	cd /home/frank/Documents/colaboracio_joan_catalina/codis/codis_definitiu/build/_deps/core-build && $(CMAKE_COMMAND) -P CMakeFiles/core.dir/cmake_clean_target.cmake
	cd /home/frank/Documents/colaboracio_joan_catalina/codis/codis_definitiu/build/_deps/core-build && $(CMAKE_COMMAND) -E cmake_link_script CMakeFiles/core.dir/link.txt --verbose=$(VERBOSE)

# Rule to build all files generated by this target.
_deps/core-build/CMakeFiles/core.dir/build: _deps/core-build/libcore.a
.PHONY : _deps/core-build/CMakeFiles/core.dir/build

_deps/core-build/CMakeFiles/core.dir/clean:
	cd /home/frank/Documents/colaboracio_joan_catalina/codis/codis_definitiu/build/_deps/core-build && $(CMAKE_COMMAND) -P CMakeFiles/core.dir/cmake_clean.cmake
.PHONY : _deps/core-build/CMakeFiles/core.dir/clean

_deps/core-build/CMakeFiles/core.dir/depend:
	cd /home/frank/Documents/colaboracio_joan_catalina/codis/codis_definitiu/build && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /home/frank/Documents/colaboracio_joan_catalina/codis/codis_definitiu /home/frank/Documents/colaboracio_joan_catalina/codis/codis_definitiu/build/_deps/core-src /home/frank/Documents/colaboracio_joan_catalina/codis/codis_definitiu/build /home/frank/Documents/colaboracio_joan_catalina/codis/codis_definitiu/build/_deps/core-build /home/frank/Documents/colaboracio_joan_catalina/codis/codis_definitiu/build/_deps/core-build/CMakeFiles/core.dir/DependInfo.cmake "--color=$(COLOR)"
.PHONY : _deps/core-build/CMakeFiles/core.dir/depend
