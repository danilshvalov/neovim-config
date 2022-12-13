cmake_minimum_required(VERSION __CMAKE-VERSION__)
project(__PROJECT-NAME__)

set(TARGET_NAME ${PROJECT_NAME})

file(GLOB TARGET_SRCS CONFIGURE_DEPENDS "${PROJECT_SOURCE_DIR}/src/*.cpp")

include(${PROJECT_BINARY_DIR}/conanbuildinfo.cmake)
conan_basic_setup()

add_executable(${TARGET_NAME} ${TARGET_SRCS})
target_compile_features(${TARGET_NAME} PRIVATE cxx_std_17)
target_include_directories(${TARGET_NAME} PRIVATE "${PROJECT_SOURCE_DIR}/src/include")
target_link_libraries(${TARGET_NAME} ${CONAN_LIBS})
