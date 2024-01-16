# Distributed under the OSI-approved BSD 3-Clause License.  See accompanying
# file Copyright.txt or https://cmake.org/licensing for details.

cmake_minimum_required(VERSION 3.5)

file(MAKE_DIRECTORY
  "/home/frank/Documents/colaboracio_joan_catalina/codis/codis_definitiu/build/_deps/core-src"
  "/home/frank/Documents/colaboracio_joan_catalina/codis/codis_definitiu/build/_deps/core-build"
  "/home/frank/Documents/colaboracio_joan_catalina/codis/codis_definitiu/build/_deps/core-subbuild/core-populate-prefix"
  "/home/frank/Documents/colaboracio_joan_catalina/codis/codis_definitiu/build/_deps/core-subbuild/core-populate-prefix/tmp"
  "/home/frank/Documents/colaboracio_joan_catalina/codis/codis_definitiu/build/_deps/core-subbuild/core-populate-prefix/src/core-populate-stamp"
  "/home/frank/Documents/colaboracio_joan_catalina/codis/codis_definitiu/build/_deps/core-subbuild/core-populate-prefix/src"
  "/home/frank/Documents/colaboracio_joan_catalina/codis/codis_definitiu/build/_deps/core-subbuild/core-populate-prefix/src/core-populate-stamp"
)

set(configSubDirs )
foreach(subDir IN LISTS configSubDirs)
    file(MAKE_DIRECTORY "/home/frank/Documents/colaboracio_joan_catalina/codis/codis_definitiu/build/_deps/core-subbuild/core-populate-prefix/src/core-populate-stamp/${subDir}")
endforeach()
if(cfgdir)
  file(MAKE_DIRECTORY "/home/frank/Documents/colaboracio_joan_catalina/codis/codis_definitiu/build/_deps/core-subbuild/core-populate-prefix/src/core-populate-stamp${cfgdir}") # cfgdir has leading slash
endif()
