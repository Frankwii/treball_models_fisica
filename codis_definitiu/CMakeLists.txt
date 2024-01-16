cmake_minimum_required(VERSION 3.20)
project(retinex VERSION 0.1)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${CMAKE_SOURCE_DIR}/bin)
set(CMAKE_CXX_FLAGS_RELEASE "-O3 -funroll-loops -fomit-frame-pointer -ffast-math -ftree-vectorize")


include(cmake/CPM.cmake)

CPMAddPackage("gh:cfa3352d-ea38-451b-8f61-5babfb542852/core@0.2")

set(RETINEX_LIBS
        ${PROJECT_SOURCE_DIR}/src/libRetinexNL.cpp
)

add_library(retinex ${RETINEX_LIBS})
target_include_directories(retinex
        PUBLIC
        $<INSTALL_INTERFACE:include>
        $<BUILD_INTERFACE:${PROJECT_SOURCE_DIR}/include>
        PRIVATE
        ${PROJECT_SOURCE_DIR}/src
        ${PROJECT_SOURCE_DIR}/include/tami/retinex
)
target_link_libraries(retinex
        PRIVATE
        TAMI::Core
)

add_library(TAMI::Retinex ALIAS retinex)

set(SOURCE_FILES
        ${PROJECT_SOURCE_DIR}/src/src_pxs_RetinexNL.cpp
)

##############################################
# Installation instructions

include(GNUInstallDirs)
foreach(src ${SOURCE_FILES})
    cmake_path(GET src STEM exe)
    add_executable(${exe} ${src})
    target_include_directories(${exe}
            PUBLIC
            $<INSTALL_INTERFACE:include>
            $<BUILD_INTERFACE:${PROJECT_SOURCE_DIR}/include>
            PRIVATE
            ${PROJECT_SOURCE_DIR}/src
            ${PROJECT_SOURCE_DIR}/include/tami/retinex
    )
    target_link_libraries(${exe}
            TAMI::Core
            TAMI::Retinex
    )

    install(TARGETS ${exe}
            RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
    )
endforeach()


set(INSTALL_CONFIGDIR ${CMAKE_INSTALL_LIBDIR}/cmake/tami/retinex)

install(TARGETS retinex
        EXPORT retinex-targets
        LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}/tami
        ARCHIVE DESTINATION ${CMAKE_INSTALL_LIBDIR}/tami
)

install(DIRECTORY include/ DESTINATION ${CMAKE_INSTALL_INCLUDEDIR})

install(EXPORT retinex-targets
        FILE
        RetinexTargets.cmake
        NAMESPACE
        TAMI::
        DESTINATION
        ${INSTALL_CONFIGDIR}
)

include(CMakePackageConfigHelpers)
write_basic_package_version_file(
        ${CMAKE_CURRENT_BINARY_DIR}/RetinexConfigVersion.cmake
        VERSION ${PROJECT_VERSION}
        COMPATIBILITY AnyNewerVersion
)

configure_package_config_file(${CMAKE_CURRENT_LIST_DIR}/cmake/RetinexConfig.cmake.in
        ${CMAKE_CURRENT_BINARY_DIR}/RetinexConfig.cmake
        INSTALL_DESTINATION ${INSTALL_CONFIGDIR}
)

install(FILES
        ${CMAKE_CURRENT_BINARY_DIR}/RetinexConfig.cmake
        ${CMAKE_CURRENT_BINARY_DIR}/RetinexConfigVersion.cmake
        DESTINATION ${INSTALL_CONFIGDIR}
)


##############################################
## Exporting from the build tree

export(EXPORT retinex-targets
        FILE ${CMAKE_CURRENT_BINARY_DIR}/RetinexTargets.cmake
        NAMESPACE TAMI::
)

export(PACKAGE retinex)