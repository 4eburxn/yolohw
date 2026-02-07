#!/bin/bash

cd "$(dirname "${BASH_SOURCE[0]}")"

cd .build
make
cd ..

python tools/gst-rtsp-srv.py samples/vtest.avi &
sleep 1 && ./yolohw
exit $?

