#----------------------------------------------------------------
# Generated CMake target import file for configuration "Debug".
#----------------------------------------------------------------

# Commands may need to know the format version.
set(CMAKE_IMPORT_FILE_VERSION 1)

# Import target "TAMI::retinex" for configuration "Debug"
set_property(TARGET TAMI::retinex APPEND PROPERTY IMPORTED_CONFIGURATIONS DEBUG)
set_target_properties(TAMI::retinex PROPERTIES
  IMPORTED_LINK_INTERFACE_LANGUAGES_DEBUG "CXX"
  IMPORTED_LOCATION_DEBUG "${_IMPORT_PREFIX}/lib/tami/libretinex.a"
  )

list(APPEND _cmake_import_check_targets TAMI::retinex )
list(APPEND _cmake_import_check_files_for_TAMI::retinex "${_IMPORT_PREFIX}/lib/tami/libretinex.a" )

# Commands beyond this point should not need to know the version.
set(CMAKE_IMPORT_FILE_VERSION)
