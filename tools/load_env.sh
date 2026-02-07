#!/bin/bash

RED='\033[0;31m'
NC='\033[0m'
cd samples
curl -O -L -s "https://raw.githubusercontent.com/opencv/opencv/aea90a9e314d220dcaa80a616808afc38e1c78b6/samples/data/vtest.avi" || printf "${RED}VIDEO SAMPLES ARE NOT LOADED${NC}\n"
cd ..

python -m venv .venv && source .venv/bin/activate
if [ "$?" -eq 1 ]; then
    printf "${RED}CAN'T CREATE OR ACTIVATE VENV\n\tAborting.${NC}\n"
	exit 1
fi

pip install ultralytics onnx
python tools/load_yolo.py

exit $?
