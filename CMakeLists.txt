cmake_minimum_required(VERSION 3.10.0)
set(CMAKE_CXX_STANDARD 17) 
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -fdebug-prefix-map=${CMAKE_BINARY_DIR}=${CMAKE_SOURCE_DIR}") #fix gdb can't find source path
message(${CMAKE_CXX_FLAGS})
set(CMAKE_BUILD_TYPE "Debug")



project(SYSY-compiler VERSION 0.1.0 LANGUAGES C CXX)

include(CTest)
enable_testing()

set(CMAKE_EXPORT_COMPILECOMMANDS ON)
set(CMAKE_CXX_FLAGS "-DCMAKE_EXPORT_COMPILE_COMMANDS=1")

include_directories(${CMAKE_SOURCE_DIR}/util)

add_executable(SYSY-compiler main.cpp)
add_subdirectory(${PROJECT_SOURCE_DIR}/yacc)
add_subdirectory(${PROJECT_SOURCE_DIR}/ir)
add_subdirectory(${PROJECT_SOURCE_DIR}/lib)
add_subdirectory(${PROJECT_SOURCE_DIR}/backend)
target_link_libraries(SYSY-compiler Yacc Lib Backend opt Analysis)

target_include_directories(SYSY-compiler PRIVATE ${PROJECT_SOURCE_DIR}/yacc)
target_include_directories(SYSY-compiler PRIVATE ${PROJECT_SOURCE_DIR}/lib)
target_include_directories(SYSY-compiler PRIVATE ${PROJECT_SOURCE_DIR}/backend)
target_include_directories(SYSY-compiler PRIVATE ${PROJECT_SOURCE_DIR}/ir)

set(CPACK_PROJECT_NAME ${PROJECT_NAME})
set(CPACK_PROJECT_VERSION ${PROJECT_VERSION})
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -Wno-unused-variable")
include(CPack)
