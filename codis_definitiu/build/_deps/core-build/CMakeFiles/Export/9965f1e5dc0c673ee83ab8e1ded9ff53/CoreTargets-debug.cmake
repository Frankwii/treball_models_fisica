#----------------------------------------------------------------
# Generated CMake target import file for configuration "Debug".
#----------------------------------------------------------------

# Commands may need to know the format version.
set(CMAKE_IMPORT_FILE_VERSION 1)

# Import target "TAMI::core" for configuration "Debug"
set_property(TARGET TAMI::core APPEND PROPERTY IMPORTED_CONFIGURATIONS DEBUG)
set_target_properties(TAMI::core PROPERTIES
  IMPORTED_LINK_INTERFACE_LANGUAGES_DEBUG "C;CXX"
  IMPORTED_LOCATION_DEBUG "${_IMPORT_PREFIX}/lib/tami/libcore.a"
  )

list(APPEND _cmake_import_check_targets TAMI::core )
list(APPEND _cmake_import_check_files_for_TAMI::core "${_IMPORT_PREFIX}/lib/tami/libcore.a" )

# Commands beyond this point should not need to know the version.
set(CMAKE_IMPORT_FILE_VERSION)
