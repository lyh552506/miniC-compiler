
file(GLOB_RECURSE SOURCE_FILES "${CMAKE_CURRENT_SOURCE_DIR}/opt/*.cpp")

add_library(opt  ${SOURCE_FILES})

#指定编译opt时需要包含的目录
target_include_directories(opt PUBLIC
    ${CMAKE_CURRENT_SOURCE_DIR}
    ${PROJECT_SOURCE_DIR}/lib
)

target_link_libraries(opt Lib)