# ./backend/CMakeLists.txt
file(GLOB BACKEND_SRC "*.cpp")
add_library(Backend ${BACKEND_SRC})
target_link_libraries(Backend Lib)
target_include_directories(Backend PUBLIC ${PROJECT_SOURCE_DIR}/lib)