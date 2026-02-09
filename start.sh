#!/bin/bash

cd "$(dirname "${BASH_SOURCE[0]}")"
command -v cowsay &> /dev/null && cowsay -e 00 $USER has cowsay

./tools/simpbuild.sh
ls yolohw &>/dev/null || ln -s .build/yolohw yolohw

echo loading model and video
./tools/load_env.sh

echo $(pwd)/yolohw was build
