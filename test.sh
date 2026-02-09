#!/bin/bash

cd "$(dirname "${BASH_SOURCE[0]}")"

cd .build
cmake .. -DDEBUG_ENABLED=1 
make -j4
cd ..

python3 tools/gst-rtsp-srv.py samples/vtest.avi &
sleep 1 && ./yolohw | python3 ./tools/find_confidence.py
EXIT=$?
./tools/simpbuild.sh

exit $EXIT

