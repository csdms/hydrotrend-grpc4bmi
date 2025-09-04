# hydrotrend-grpc4bmi

cmake_minimum_required(VERSION 3.16)
project(hydrotrend-grpc4bmi
  VERSION 0.1.0
  LANGUAGES CXX
)

include(GNUInstallDirs)

find_package(PkgConfig REQUIRED)

pkg_check_modules(HYDROTREND REQUIRED IMPORTED_TARGET hydrotrend)
list(APPEND CMAKE_MESSAGE_INDENT "  ")
message(STATUS "Include directory: ${HYDROTREND_INCLUDE_DIRS}")
message(STATUS "Library path: ${HYDROTREND_LINK_LIBRARIES}")
list(POP_BACK CMAKE_MESSAGE_INDENT)

pkg_check_modules(PROTOBUF REQUIRED IMPORTED_TARGET protobuf)
list(APPEND CMAKE_MESSAGE_INDENT "  ")
message(STATUS "Include directory: ${PROTOBUF_INCLUDE_DIRS}")
message(STATUS "Library path: ${PROTOBUF_LINK_LIBRARIES}")
list(POP_BACK CMAKE_MESSAGE_INDENT)

pkg_check_modules(GRPC4BMI REQUIRED IMPORTED_TARGET grpc4bmi)
list(APPEND CMAKE_MESSAGE_INDENT "  ")
message(STATUS "Include directory: ${GRPC4BMI_INCLUDE_DIRS}")
message(STATUS "Library path: ${GRPC4BMI_LINK_LIBRARIES}")
list(POP_BACK CMAKE_MESSAGE_INDENT)

set(server_exe hydrotrend-grpc4bmi-server)
set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -lgrpc++_reflection")

add_executable(${server_exe} ${server_exe}.cxx)
target_link_libraries(${server_exe}
  ${HYDROTREND_LINK_LIBRARIES}
  ${PROTOBUF_LINK_LIBRARIES}
  ${GRPC4BMI_LINK_LIBRARIES}
)
target_include_directories(${server_exe} PUBLIC ${GRPC4BMI_INCLUDE_DIRS})

install(
  TARGETS ${server_exe}
  RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
)
