# ./yacc/CMakeLists.txt
file(GLOB YACC_SRC "*.cpp")
add_library(Yacc ${YACC_SRC})
target_link_libraries(Yacc Lib)