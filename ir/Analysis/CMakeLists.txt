file(GLOB_RECURSE SOURCE_FILES "*.cpp")

# 创建库或可执行文件
add_library(Analysis ${SOURCE_FILES})
target_include_directories(Analysis PUBLIC
    ${CMAKE_CURRENT_SOURCE_DIR}
    ${PROJECT_SOURCE_DIR}/lib
    ${PROJECT_SOURCE_DIR}/ir/opt
)