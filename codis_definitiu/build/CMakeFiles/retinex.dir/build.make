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
include CMakeFiles/retinex.dir/depend.make
# Include any dependencies generated by the compiler for this target.
include CMakeFiles/retinex.dir/compiler_depend.make

# Include the progress variables for this target.
include CMakeFiles/retinex.dir/progress.make

# Include the compile flags for this target's objects.
include CMakeFiles/retinex.dir/flags.make

CMakeFiles/retinex.dir/src/libRetinexNL.cpp.o: CMakeFiles/retinex.dir/flags.make
CMakeFiles/retinex.dir/src/libRetinexNL.cpp.o: /home/frank/Documents/colaboracio_joan_catalina/codis/codis_definitiu/src/libRetinexNL.cpp
CMakeFiles/retinex.dir/src/libRetinexNL.cpp.o: CMakeFiles/retinex.dir/compiler_depend.ts
	@$(CMAKE_COMMAND) -E cmake_echo_color "--switch=$(COLOR)" --green --progress-dir=/home/frank/Documents/colaboracio_joan_catalina/codis/codis_definitiu/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_1) "Building CXX object CMakeFiles/retinex.dir/src/libRetinexNL.cpp.o"
	/usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -MD -MT CMakeFiles/retinex.dir/src/libRetinexNL.cpp.o -MF CMakeFiles/retinex.dir/src/libRetinexNL.cpp.o.d -o CMakeFiles/retinex.dir/src/libRetinexNL.cpp.o -c /home/frank/Documents/colaboracio_joan_catalina/codis/codis_definitiu/src/libRetinexNL.cpp

CMakeFiles/retinex.dir/src/libRetinexNL.cpp.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color "--switch=$(COLOR)" --green "Preprocessing CXX source to CMakeFiles/retinex.dir/src/libRetinexNL.cpp.i"
	/usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E /home/frank/Documents/colaboracio_joan_catalina/codis/codis_definitiu/src/libRetinexNL.cpp > CMakeFiles/retinex.dir/src/libRetinexNL.cpp.i

CMakeFiles/retinex.dir/src/libRetinexNL.cpp.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color "--switch=$(COLOR)" --green "Compiling CXX source to assembly CMakeFiles/retinex.dir/src/libRetinexNL.cpp.s"
	/usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S /home/frank/Documents/colaboracio_joan_catalina/codis/codis_definitiu/src/libRetinexNL.cpp -o CMakeFiles/retinex.dir/src/libRetinexNL.cpp.s

# Object files for target retinex
retinex_OBJECTS = \
"CMakeFiles/retinex.dir/src/libRetinexNL.cpp.o"

# External object files for target retinex
retinex_EXTERNAL_OBJECTS =

libretinex.a: CMakeFiles/retinex.dir/src/libRetinexNL.cpp.o
libretinex.a: CMakeFiles/retinex.dir/build.make
libretinex.a: CMakeFiles/retinex.dir/link.txt
	@$(CMAKE_COMMAND) -E cmake_echo_color "--switch=$(COLOR)" --green --bold --progress-dir=/home/frank/Documents/colaboracio_joan_catalina/codis/codis_definitiu/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_2) "Linking CXX static library libretinex.a"
	$(CMAKE_COMMAND) -P CMakeFiles/retinex.dir/cmake_clean_target.cmake
	$(CMAKE_COMMAND) -E cmake_link_script CMakeFiles/retinex.dir/link.txt --verbose=$(VERBOSE)

# Rule to build all files generated by this target.
CMakeFiles/retinex.dir/build: libretinex.a
.PHONY : CMakeFiles/retinex.dir/build

CMakeFiles/retinex.dir/clean:
	$(CMAKE_COMMAND) -P CMakeFiles/retinex.dir/cmake_clean.cmake
.PHONY : CMakeFiles/retinex.dir/clean

CMakeFiles/retinex.dir/depend:
	cd /home/frank/Documents/colaboracio_joan_catalina/codis/codis_definitiu/build && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /home/frank/Documents/colaboracio_joan_catalina/codis/codis_definitiu /home/frank/Documents/colaboracio_joan_catalina/codis/codis_definitiu /home/frank/Documents/colaboracio_joan_catalina/codis/codis_definitiu/build /home/frank/Documents/colaboracio_joan_catalina/codis/codis_definitiu/build /home/frank/Documents/colaboracio_joan_catalina/codis/codis_definitiu/build/CMakeFiles/retinex.dir/DependInfo.cmake "--color=$(COLOR)"
.PHONY : CMakeFiles/retinex.dir/depend
