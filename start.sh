#!/bin/bash

cd "$(dirname "${BASH_SOURCE[0]}")"
command -v cowsay &> /dev/null && cowsay -e 00 $USER has cowsay


mkdir -p .build && cd .build
cmake .. -DCMAKE_BUILD_TYPE=Release && make -j3 || \
	$( echo something went wrong && exit 1 )
cd ..
ls yolohw &>/dev/null || ln -s .build/yolohw yolohw

echo loading samples
./tools/get_samples.sh || echo SAMPLES ARE NOT LOADED

echo $(pwd)/yolohw was build
