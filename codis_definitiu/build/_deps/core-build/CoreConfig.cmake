cmake_path(GET CMAKE_CURRENT_LIST_FILE PARENT_PATH TAMI_CORE_CMAKE_DIR)
include(CMakeFindDependencyMacro)

list(APPEND CMAKE_MODULE_PATH ${TAMI_CORE_CMAKE_DIR})
find_dependency(FFTW )
list(REMOVE_AT CMAKE_MODULE_PATH -1)

if(NOT TARGET TAMI::Core)
    include("${TAMI_CORE_CMAKE_DIR}/CoreTargets.cmake")
endif()

set(TAMI_CORE_LIBRARIES TAMI::Core)

