#!/bin/bash

mkdir -p .build && cd .build
cmake .. -DCMAKE_BUILD_TYPE=Release -DDEBUG_ENABLED=0 && make -j3 || \
	$( echo something went wrong && exit 1 )
cd ..
