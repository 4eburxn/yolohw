#!/bin/bash

cd "$(dirname "${BASH_SOURCE[0]}")"

./tools/simpbuild.sh -DDEBUG_ENABLED=1 $(cat ./.opencvdirname)

# python3 tools/gst-rtsp-srv.py samples/vtest.avi &
sleep 1 && ./yolohw -f=./samples/vtest.avi -m=./yolov8s.onnx | python3 ./tools/find_confidence.py && \
	source .venv/bin/activate && YOLO_VERBOSE=False python3 ./tools/metrics.py 2>/dev/null

EXIT=$?
echo rebuilding

./tools/simpbuild.sh -DDEBUG_ENABLED=0 $(cat ./.opencvdirname) &>/dev/null
echo rebuilding complite

exit $EXIT

