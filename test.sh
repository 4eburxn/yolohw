#!/bin/bash

cd "$(dirname "${BASH_SOURCE[0]}")"

cd .build
cmake .. -DDEBUG_ENABLED=1 
make -j4
cd ..

# python3 tools/gst-rtsp-srv.py samples/vtest.avi &
sleep 1 && ./yolohw -f=./samples/vtest.avi -m=./yolov8n.onnx | python3 ./tools/find_confidence.py && \
	source .venv/bin/activate && YOLO_VERBOSE=False python3 ./tools/metrics.py 2>/dev/null

EXIT=$?
echo rebuilding
./tools/simpbuild.sh &>/dev/null
echo rebuilding complite

exit $EXIT

