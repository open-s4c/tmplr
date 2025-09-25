cmake_minimum_required(VERSION 3.16)

project(
  tmplr
  VERSION 1.2
  LANGUAGES C)

add_executable(tmplr tmplr.c)
target_compile_definitions(tmplr PRIVATE _XOPEN_SOURCE=700)
