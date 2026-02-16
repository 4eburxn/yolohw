#!/bin/bash

ERROR(){
    printf "${RED}$1${NC}\n"
	for arg in "${@:2}"; do
		printf "\t${RED}$arg${NC}\n"
	done
}

mkdir -p .build && cd .build
cmake .. -DCMAKE_BUILD_TYPE=Release $@ && make -j3 || \
	$( ERROR "something went wrong" && exit 1 )
cd ..
