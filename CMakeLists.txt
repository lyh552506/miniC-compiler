cmake_minimum_required(VERSION 3.0.0)
project(SYSY-compiler VERSION 0.1.0 LANGUAGES C CXX)

include(CTest)
enable_testing()

add_executable(SYSY-compiler main.cpp)

add_custom_command(
    OUTPUT make_front.log
    COMMAND bash ${PROJECT_SOURCE_DIR}/yacc/make_front.sh
    DEPENDS ${PROJECT_SOURCE_DIR}/yacc/make_front.sh
    COMMENT "Making Flex & Bison Front"
)

file(GLOB FrontEndSourceFile ${PROJECT_SOURCE_DIR}/yacc/*.cpp)
add_library(FrontEnd SHARED ${FrontEndSourceFile})
target_include_directories(FrontEnd PRIVATE ${PROJECT_SOURCE_DIR}/lib)

target_link_libraries(SYSY-compiler FrontEnd)
target_include_directories(SYSY-compiler PRIVATE ${PROJECT_SOURCE_DIR}/yacc)
target_include_directories(SYSY-compiler PRIVATE ${PROJECT_SOURCE_DIR}/lib)


set(CPACK_PROJECT_NAME ${PROJECT_NAME})
set(CPACK_PROJECT_VERSION ${PROJECT_VERSION})
include(CPack)
