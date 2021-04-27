#!/bin/bash

xhost +
docker run -it --rm -v `pwd`:`pwd` -w `pwd` --device /dev/dri:/dev/dri -v /tmp/.X11-unix:/tmp/.X11-unix -e DISPLAY=$DISPLAY onevpl_gpu_gstreamer 

