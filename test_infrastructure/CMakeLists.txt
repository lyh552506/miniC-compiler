add_test(NAME frontend COMMAND python ${CMAKE_SOURCE_DIR}/test_infrastructure/frontend.py WORKING_DIRECTORY ${CMAKE_SOURCE_DIR})
add_test(NAME mem2reg COMMAND python ${CMAKE_SOURCE_DIR}/test_infrastructure/mem2reg.py WORKING_DIRECTORY ${CMAKE_SOURCE_DIR})
add_test(NAME inline COMMAND python ${CMAKE_SOURCE_DIR}/test_infrastructure/inline.py WORKING_DIRECTORY ${CMAKE_SOURCE_DIR})
add_test(NAME constprop COMMAND python ${CMAKE_SOURCE_DIR}/test_infrastructure/constprop.py WORKING_DIRECTORY ${CMAKE_SOURCE_DIR})