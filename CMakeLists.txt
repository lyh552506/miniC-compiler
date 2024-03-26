cmake_minimum_required(VERSION 3.10.0)
set(CMAKE_CXX_STANDARD 17) 
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -fdebug-prefix-map=${CMAKE_BINARY_DIR}=${CMAKE_SOURCE_DIR}") #fix gdb can't find source path
message(${CMAKE_CXX_FLAGS})
set(CMAKE_BUILD_TYPE "Debug")
# 设置编译器警告选项
if (CMAKE_CXX_COMPILER_ID MATCHES "Clang" OR CMAKE_COMPILER_IS_GNUCXX)
    # 对于Clang和GCC编译器
    set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -Wall -Wextra -Wno-unused-parameter")
elseif (CMAKE_CXX_COMPILER_ID STREQUAL "MSVC")
    # 对于MSVC编译器
    set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} /W4")
endif()



project(SYSY-compiler VERSION 0.1.0 LANGUAGES C CXX)

include(CTest)
enable_testing()



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
