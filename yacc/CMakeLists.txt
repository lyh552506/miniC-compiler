add_custom_command(
    OUTPUT make_front.log
    COMMAND bash ${PROJECT_SOURCE_DIR}/yacc/make_front.sh
    DEPENDS ${PROJECT_SOURCE_DIR}/yacc/make_front.sh
    COMMENT "Making Flex & Bison Front"
)


file(GLOB FrontEndSourceFile ${PROJECT_SOURCE_DIR}/yacc/*.cpp)
add_library(FrontEnd SHARED ${FrontEndSourceFile})
target_include_directories(FrontEnd PRIVATE ${PROJECT_SOURCE_DIR}/lib)