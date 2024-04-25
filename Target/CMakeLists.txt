file(GLOB Target_Src "*.cpp")
add_library(Target ${Target_Src})
target_link_libraries(Target Lib)
target_include_directories(Target PUBLIC ${PROJECT_SOURCE_DIR}/lib)