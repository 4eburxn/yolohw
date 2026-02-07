#!/bin/bash

cd "$(dirname "${BASH_SOURCE[0]}")"

cd .build
make
cd ..

python gst-rtsp-srv.py samples/vtest.avi &
sleep 1 && ./yolohw -f=rtsp://localhost:8554/live
exit $?

