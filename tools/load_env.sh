#!/bin/bash

RED='\033[0;31m'
NC='\033[0m'
mkdir -p samples
cd samples
curl -O -L -s "https://raw.githubusercontent.com/opencv/opencv/aea90a9e314d220dcaa80a616808afc38e1c78b6/samples/data/vtest.avi" || printf "${RED}VIDEO SAMPLES ARE NOT LOADED${NC}\n"
cd ..

[ -d "$DIR" ] || python3 -m venv .venv
if [ "$?" -ne 0 ]; then
    printf "${RED}CAN'T CREATE VENV\n\tAborting.${NC}\n"
	exit 1
fi
source .venv/bin/activate && \
	pip install ultralytics onnx && \
	python3 tools/load_yolo.py
if [ "$?" -ne 0 ]; then
    printf "${RED}CAN'T ACTIVATE VENV OR RUN PYTHON SCRIPT\n\tAborting.${NC}\n"
	exit 1
fi

exit $?
