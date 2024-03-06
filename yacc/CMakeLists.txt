# ./yacc/CMakeLists.txt
file(GLOB YACC_SRC "*.cpp")
add_library(Yacc ${YACC_SRC})
target_link_libraries(Yacc Lib)
target_include_directories(Yacc PUBLIC ${PROJECT_SOURCE_DIR}/lib)