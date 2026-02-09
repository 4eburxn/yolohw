#!/bin/bash

cd "$(dirname "${BASH_SOURCE[0]}")"

cd .build
make
cd ..

python3 tools/gst-rtsp-srv.py samples/vtest.avi &
sleep 1 && ./yolohw | python3 ./tools/find_confidence.py
exit $?

