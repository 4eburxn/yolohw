cmake_minimum_required(VERSION 3.21)
project(yolohw)
find_package( OpenCV REQUIRED )

include(FetchContent)
FetchContent_Declare(
    tomlplusplus
    GIT_REPOSITORY https://github.com/marzer/tomlplusplus.git
    GIT_TAG        v3.4.0
)
FetchContent_MakeAvailable(tomlplusplus)

function(define_use name defvalue)
	if(${${name}})
		message(${name}\ set\ to\ ${${name}})
		add_definitions(-D_${name}=${${name}})
	else()
		message(${name}\ set\ to\ ${defvalue})
		add_definitions(-D_${name}=${defvalue})
	endif()
endfunction()

define_use(HEADLESS_ENABLED true)

if (CMAKE_BUILD_TYPE STREQUAL "Debug")
	# set(CMAKE_BUILD_TYPE "Release")
	set(CMAKE_INTERPROCEDURAL_OPTIMIZATION TRUE)
	# add_compile_options(-fsanitize=address)
	# add_link_options(-fsanitize=address)
	define_use(DEBUG_ENABLED true)
endif()
if (CMAKE_BUILD_TYPE STREQUAL "Profiling")
	set(CMAKE_BUILD_TYPE "Release")
	set(CMAKE_INTERPROCEDURAL_OPTIMIZATION TRUE)
	add_compile_options(-pg)
	add_link_options(-pg)
	# add_compile_options(-fsanitize=address)
	# add_link_options(-fsanitize=address)
endif()
if (CMAKE_BUILD_TYPE STREQUAL "Release")
	set(CMAKE_INTERPROCEDURAL_OPTIMIZATION TRUE)
	set(CMAKE_BUILD_TYPE "Release")
	add_compile_options(-march=native -pipe)
	add_link_options(-pipe)
	define_use(DEBUG_ENABLED false)
endif()

include_directories(${OpenCV_INCLUDE_DIRS})

file(GLOB SOURCES src/*.cpp)

file(GLOB HEADERS lib/*.h)

add_executable( 
    yolohw
    ${HEADERS}
    ${SOURCES}
    main.cpp
)

target_include_directories(yolohw PUBLIC "lib")

target_link_libraries(yolohw PUBLIC ${OpenCV_LIBS} tomlplusplus::tomlplusplus)

