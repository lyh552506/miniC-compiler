cmake_minimum_required(VERSION 3.0.0)
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -fdebug-prefix-map=${CMAKE_BINARY_DIR}=${CMAKE_SOURCE_DIR}") #fix gdb can't find source path
project(SYSY-compiler VERSION 0.1.0 LANGUAGES C CXX)

include(CTest)
enable_testing()

add_executable(SYSY-compiler main.cpp)

add_subdirectory(${PROJECT_SOURCE_DIR}/yacc)

target_link_libraries(SYSY-compiler FrontEnd)
target_include_directories(SYSY-compiler PRIVATE ${PROJECT_SOURCE_DIR}/yacc)
target_include_directories(SYSY-compiler PRIVATE ${PROJECT_SOURCE_DIR}/lib)

set(CPACK_PROJECT_NAME ${PROJECT_NAME})
set(CPACK_PROJECT_VERSION ${PROJECT_VERSION})
include(CPack)
