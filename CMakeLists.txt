cmake_minimum_required(VERSION 3.16)

project(tmplr LANGUAGES C)

add_custom_target(
  version-gen
  COMMAND
    ${CMAKE_SOURCE_DIR}/versionize.sh #
    ${CMAKE_CURRENT_SOURCE_DIR}/version.h.in >
    ${CMAKE_CURRENT_BINARY_DIR}/version.h)

add_executable(tmplr tmplr.c)
add_dependencies(tmplr version-gen)
target_include_directories(tmplr PRIVATE ${CMAKE_CURRENT_BINARY_DIR})
target_compile_definitions(tmplr PRIVATE _XOPEN_SOURCE=700)
