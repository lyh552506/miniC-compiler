# 收集所有的源文件
file(GLOB_RECURSE SOURCE_FILES "*.cpp")

# 创建库或可执行文件
add_library(opt ${SOURCE_FILES})

