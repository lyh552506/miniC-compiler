
file(GLOB_RECURSE ANALYSIS_SOURCES "${CMAKE_CURRENT_SOURCE_DIR}/Analysis/*.cpp")
file(GLOB_RECURSE OPT_SOURCES "${CMAKE_CURRENT_SOURCE_DIR}/opt/*.cpp")


add_subdirectory(Analysis)
add_subdirectory(opt)



