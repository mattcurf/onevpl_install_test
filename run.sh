#!/bin/bash

xhost +
docker run -it --rm -v `pwd`:`pwd` -w `pwd` --device /dev/dri:/dev/dri -v /tmp/.X11-unix:/tmp/.X11-unix -e DISPLAY=$DISPLAY onevpl_gpu_gstreamer_ubuntu.focal /usr/bin/gst-launch-1.0 videotestsrc ! video/x-raw,width=1920,height=1080 ! vaapipostproc saturation=0.2 ! vaapih264enc tune=high-compression ! vaapidecodebin ! vaapisink

