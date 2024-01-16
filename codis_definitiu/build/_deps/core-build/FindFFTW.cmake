
find_package(PkgConfig)
pkg_check_modules ( PKG_FFTW QUIET fftw3 )


# Include directories for the whole package
find_path(FFTW_INCLUDE_DIRS
    NAMES fftw3.h
    PATHS ${PKG_FFTW_INCLUDE_DIRS} ${INCLUDE_INSTALL_DIR}
)


# FFTW libraries for various precisions
find_library(FFTW_fftw_LIBRARY
    NAMES fftw3
    PATHS ${PKG_FFTW_LIBRARY_DIRS} ${LIB_INSTALL_DIR}
)
if (FFTW_fftw_LIBRARY)
    set(FFTW_fftw_FOUND TRUE)
    set(FFTW_LIBRARIES ${FFTW_LIBRARIES} ${FFTW_fftw_LIBRARY})
    add_library(FFTW::fftw INTERFACE IMPORTED)
    set_target_properties(FFTW::fftw
        PROPERTIES INTERFACE_INCLUDE_DIRECTORIES "${FFTW_INCLUDE_DIRS}"
        INTERFACE_LINK_LIBRARIES "${FFTW_fftw_LIBRARY}"
    )
else()
    set(FFTW_fftw_FOUND FALSE)
endif()

find_library(FFTW_fftwf_LIBRARY
    NAMES fftw3f
    PATHS ${PKG_FFTW_LIBRARY_DIRS} ${LIB_INSTALL_DIR}
)
if (FFTW_fftwf_LIBRARY)
    set(FFTW_fftwf_FOUND TRUE)
    set(FFTW_LIBRARIES ${FFTW_LIBRARIES} ${FFTW_fftwf_LIBRARY})
    add_library(FFTW::fftwf INTERFACE IMPORTED)
    set_target_properties(FFTW::fftwf
        PROPERTIES INTERFACE_INCLUDE_DIRECTORIES "${FFTW_INCLUDE_DIRS}"
        INTERFACE_LINK_LIBRARIES "${FFTW_fftwf_LIBRARY}"
    )
else()
    set(FFTW_fftwf_FOUND FALSE)
endif()

find_library(FFTW_fftwl_LIBRARY
    NAMES fftw3l
    PATHS ${PKG_FFTW_LIBRARY_DIRS} ${LIB_INSTALL_DIR}
)
if (FFTW_fftwl_LIBRARY)
    set(FFTW_fftwl_FOUND TRUE)
    set(FFTW_LIBRARIES ${FFTW_LIBRARIES} ${FFTW_fftwl_LIBRARY})
    add_library(FFTW::fftwl INTERFACE IMPORTED)
    set_target_properties(FFTW::fftwl
        PROPERTIES INTERFACE_INCLUDE_DIRECTORIES "${FFTW_INCLUDE_DIRS}"
        INTERFACE_LINK_LIBRARIES "${FFTW_fftwl_LIBRARY}"
    )
else()
    set(FFTW_fftwl_FOUND FALSE)
endif()

find_library(FFTW_fftwq_LIBRARY
    NAMES fftw3q
    PATHS ${PKG_FFTW_LIBRARY_DIRS} ${LIB_INSTALL_DIR}
)
if (FFTW_fftwq_LIBRARY)
    set(FFTW_fftwq_FOUND TRUE)
    set(FFTW_LIBRARIES ${FFTW_LIBRARIES} ${FFTW_fftwq_LIBRARY})
    add_library(FFTW::fftwq INTERFACE IMPORTED)
    set_target_properties(FFTW::fftwq
        PROPERTIES INTERFACE_INCLUDE_DIRECTORIES "${FFTW_INCLUDE_DIRS}"
        INTERFACE_LINK_LIBRARIES "${FFTW_fftwq_LIBRARY}"
    )
else()
    set(FFTW_fftwq_FOUND FALSE)
endif()


# FFTW_threads libraries
find_library(FFTW_fftw_threads_LIBRARY
    NAMES fftw3_threads
    PATHS ${PKG_FFTW_LIBRARY_DIRS} ${LIB_INSTALL_DIR}
)
if (FFTW_fftw_threads_LIBRARY)
    set(FFTW_fftw_threads_FOUND TRUE)
    set(FFTW_LIBRARIES ${FFTW_LIBRARIES} ${FFTW_fftw_threads_LIBRARY})
    add_library(FFTW::fftw_threads INTERFACE IMPORTED)
    set_target_properties(FFTW::fftw_threads
        PROPERTIES INTERFACE_INCLUDE_DIRECTORIES "${FFTW_INCLUDE_DIRS}"
        INTERFACE_LINK_LIBRARIES "${FFTW_fftw_threads_LIBRARY}"
    )
else()
    set(FFTW_fftw_threads_FOUND FALSE)
endif()

find_library(FFTW_fftwf_threads_LIBRARY
    NAMES fftw3f_threads
    PATHS ${PKG_FFTW_LIBRARY_DIRS} ${LIB_INSTALL_DIR}
)
if (FFTW_fftwf_threads_LIBRARY)
    set(FFTW_fftwf_threads_FOUND TRUE)
    set(FFTW_LIBRARIES ${FFTW_LIBRARIES} ${FFTW_fftwf_threads_LIBRARY})
    add_library(FFTW::fftwf_threads INTERFACE IMPORTED)
    set_target_properties(FFTW::fftwf_threads
        PROPERTIES INTERFACE_INCLUDE_DIRECTORIES "${FFTW_INCLUDE_DIRS}"
        INTERFACE_LINK_LIBRARIES "${FFTW_fftwf_threads_LIBRARY}"
    )
else()
    set(FFTW_fftwf_threads_FOUND FALSE)
endif()

find_library(FFTW_fftwl_threads_LIBRARY
    NAMES fftw3l_threads
    PATHS ${PKG_FFTW_LIBRARY_DIRS} ${LIB_INSTALL_DIR}
)
if (FFTW_fftwl_threads_LIBRARY)
    set(FFTW_fftwl_threads_FOUND TRUE)
    set(FFTW_LIBRARIES ${FFTW_LIBRARIES} ${FFTW_fftwl_threads_LIBRARY})
    add_library(FFTW::fftwl_threads INTERFACE IMPORTED)
    set_target_properties(FFTW::fftwl_threads
        PROPERTIES INTERFACE_INCLUDE_DIRECTORIES "${FFTW_INCLUDE_DIRS}"
        INTERFACE_LINK_LIBRARIES "${FFTW_fftwl_threads_LIBRARY}"
    )
else()
    set(FFTW_fftwl_threads_FOUND FALSE)
endif()

find_library(FFTW_fftwq_threads_LIBRARY
    NAMES fftw3q_threads
    PATHS ${PKG_FFTW_LIBRARY_DIRS} ${LIB_INSTALL_DIR}
)
if (FFTW_fftwq_threads_LIBRARY)
    set(FFTW_fftwq_threads_FOUND TRUE)
    set(FFTW_LIBRARIES ${FFTW_LIBRARIES} ${FFTW_fftwq_threads_LIBRARY})
    add_library(FFTW::fftwq_threads INTERFACE IMPORTED)
    set_target_properties(FFTW::fftwq_threads
        PROPERTIES INTERFACE_INCLUDE_DIRECTORIES "${FFTW_INCLUDE_DIRS}"
        INTERFACE_LINK_LIBRARIES "${FFTW_fftwq_threads_LIBRARY}"
    )
else()
    set(FFTW_fftwq_threads_FOUND FALSE)
endif()


# FFTW OMP libraries
find_library(FFTW_fftw_omp_LIBRARY
    NAMES fftw3_omp
    PATHS ${PKG_FFTW_LIBRARY_DIRS} ${LIB_INSTALL_DIR}
)
if (FFTW_fftw_omp_LIBRARY)
    set(FFTW_fftw_omp_FOUND TRUE)
    set(FFTW_LIBRARIES ${FFTW_LIBRARIES} ${FFTW_fftw_omp_LIBRARY})
    add_library(FFTW::fftw_omp INTERFACE IMPORTED)
    set_target_properties(FFTW::fftw_omp
        PROPERTIES INTERFACE_INCLUDE_DIRECTORIES "${FFTW_INCLUDE_DIRS}"
        INTERFACE_LINK_LIBRARIES "${FFTW_fftw_omp_LIBRARY}"
    )
else()
    set(FFTW_fftw_omp_FOUND FALSE)
endif()

find_library(FFTW_fftwf_omp_LIBRARY
    NAMES fftw3f_omp
    PATHS ${PKG_FFTW_LIBRARY_DIRS} ${LIB_INSTALL_DIR}
)
if (FFTW_fftwf_omp_LIBRARY)
    set(FFTW_fftwf_omp_FOUND TRUE)
    set(FFTW_LIBRARIES ${FFTW_LIBRARIES} ${FFTW_fftwf_omp_LIBRARY})
    add_library(FFTW::fftwf_omp INTERFACE IMPORTED)
    set_target_properties(FFTW::fftwf_omp
        PROPERTIES INTERFACE_INCLUDE_DIRECTORIES "${FFTW_INCLUDE_DIRS}"
        INTERFACE_LINK_LIBRARIES "${FFTW_fftwf_omp_LIBRARY}"
    )
else()
    set(FFTW_fftwf_omp_FOUND FALSE)
endif()

find_library(FFTW_fftwl_omp_LIBRARY
    NAMES fftw3l_omp
    PATHS ${PKG_FFTW_LIBRARY_DIRS} ${LIB_INSTALL_DIR}
)
if (FFTW_fftwl_omp_LIBRARY)
    set(FFTW_fftwl_omp_FOUND TRUE)
    set(FFTW_LIBRARIES ${FFTW_LIBRARIES} ${FFTW_fftwl_omp_LIBRARY})
    add_library(FFTW::fftwl_omp INTERFACE IMPORTED)
    set_target_properties(FFTW::fftwl_omp
        PROPERTIES INTERFACE_INCLUDE_DIRECTORIES "${FFTW_INCLUDE_DIRS}"
        INTERFACE_LINK_LIBRARIES "${FFTW_fftwl_omp_LIBRARY}"
    )
else()
    set(FFTW_fftwl_omp_FOUND FALSE)
endif()

find_library(FFTW_fftwq_omp_LIBRARY
    NAMES fftw3q_omp
    PATHS ${PKG_FFTW_LIBRARY_DIRS} ${LIB_INSTALL_DIR}
)
if (FFTW_fftwq_omp_LIBRARY)
    set(FFTW_fftwq_omp_FOUND TRUE)
    set(FFTW_LIBRARIES ${FFTW_LIBRARIES} ${FFTW_fftwq_omp_LIBRARY})
    add_library(FFTW::fftwq_omp INTERFACE IMPORTED)
    set_target_properties(FFTW::fftwq_omp
        PROPERTIES INTERFACE_INCLUDE_DIRECTORIES "${FFTW_INCLUDE_DIRS}"
        INTERFACE_LINK_LIBRARIES "${FFTW_fftwq_omp_LIBRARY}"
    )
else()
    set(FFTW_fftwq_omp_FOUND FALSE)
endif()


# FFTW MPI libraries
find_library(FFTW_fftw_mpi_LIBRARY
    NAMES fftw3_mpi
    PATHS ${PKG_FFTW_LIBRARY_DIRS} ${LIB_INSTALL_DIR}
)
if (FFTW_fftw_mpi_LIBRARY)
    set(FFTW_fftw_mpi_FOUND TRUE)
    set(FFTW_LIBRARIES ${FFTW_LIBRARIES} ${FFTW_fftw_mpi_LIBRARY})
    add_library(FFTW::fftw_mpi INTERFACE IMPORTED)
    set_target_properties(FFTW::fftw_mpi
        PROPERTIES INTERFACE_INCLUDE_DIRECTORIES "${FFTW_INCLUDE_DIRS}"
        INTERFACE_LINK_LIBRARIES "${FFTW_fftw_mpi_LIBRARY}"
    )
else()
    set(FFTW_fftw_mpi_FOUND FALSE)
endif()

find_library(FFTW_fftwf_mpi_LIBRARY
    NAMES fftw3f_mpi
    PATHS ${PKG_FFTW_LIBRARY_DIRS} ${LIB_INSTALL_DIR}
)
if (FFTW_fftwf_mpi_LIBRARY)
    set(FFTW_fftwf_mpi_FOUND TRUE)
    set(FFTW_LIBRARIES ${FFTW_LIBRARIES} ${FFTW_fftwf_mpi_LIBRARY})
    add_library(FFTW::fftwf_mpi INTERFACE IMPORTED)
    set_target_properties(FFTW::fftwf_mpi
        PROPERTIES INTERFACE_INCLUDE_DIRECTORIES "${FFTW_INCLUDE_DIRS}"
        INTERFACE_LINK_LIBRARIES "${FFTW_fftwf_mpi_LIBRARY}"
    )
else()
    set(FFTW_fftwf_mpi_FOUND FALSE)
endif()

find_library(FFTW_fftwl_mpi_LIBRARY
    NAMES fftw3l_mpi
    PATHS ${PKG_FFTW_LIBRARY_DIRS} ${LIB_INSTALL_DIR}
)
if (FFTW_fftwl_mpi_LIBRARY)
    set(FFTW_fftwl_mpi_FOUND TRUE)
    set(FFTW_LIBRARIES ${FFTW_LIBRARIES} ${FFTW_fftwl_mpi_LIBRARY})
    add_library(FFTW::fftwl_mpi INTERFACE IMPORTED)
    set_target_properties(FFTW::fftwl_mpi
        PROPERTIES INTERFACE_INCLUDE_DIRECTORIES "${FFTW_INCLUDE_DIRS}"
        INTERFACE_LINK_LIBRARIES "${FFTW_fftwl_mpi_LIBRARY}"
    )
else()
    set(FFTW_fftwl_mpi_FOUND FALSE)
endif()

find_library(FFTW_fftwq_mpi_LIBRARY
    NAMES fftw3q_mpi
    PATHS ${PKG_FFTW_LIBRARY_DIRS} ${LIB_INSTALL_DIR}
)
if (FFTW_fftwq_mpi_LIBRARY)
    set(FFTW_fftwq_mpi_FOUND TRUE)
    set(FFTW_LIBRARIES ${FFTW_LIBRARIES} ${FFTW_fftwq_mpi_LIBRARY})
    add_library(FFTW::fftwq_mpi INTERFACE IMPORTED)
    set_target_properties(FFTW::fftwq_mpi
        PROPERTIES INTERFACE_INCLUDE_DIRECTORIES "${FFTW_INCLUDE_DIRS}"
        INTERFACE_LINK_LIBRARIES "${FFTW_fftwq_mpi_LIBRARY}"
    )
else()
    set(FFTW_fftwq_mpi_FOUND FALSE)
endif()


set(FFTW_VERSION ${PKG_FFTW_VERSION})

include(FindPackageHandleStandardArgs)
find_package_handle_standard_args(FFTW
    REQUIRED_VARS FFTW_INCLUDE_DIRS
    VERSION_VAR FFTW_VERSION
    HANDLE_COMPONENTS
)

mark_as_advanced(
    FFTW_INCLUDE_DIRS
    FFTW_LIBRARIES
    FFTW_fftw_LIBRARY
    FFTW_fftwf_LIBRARY
    FFTW_fftwl_LIBRARY
    FFTW_fftwq_LIBRARY
    FFTW_fftw_threads_LIBRARY
    FFTW_fftwf_threads_LIBRARY
    FFTW_fftwl_threads_LIBRARY
    FFTW_fftwq_threads_LIBRARY
    FFTW_fftw_omp_LIBRARY
    FFTW_fftwf_omp_LIBRARY
    FFTW_fftwl_omp_LIBRARY
    FFTW_fftwq_omp_LIBRARY
    FFTW_fftw_mpi_LIBRARY
    FFTW_fftwf_mpi_LIBRARY
    FFTW_fftwl_mpi_LIBRARY
    FFTW_fftwq_mpi_LIBRARY
)

