#!/bin/bash
docker build -t gpu_drivers_and_onevpl:centos8 -f Dockerfile:centos8 .
docker build -t gpu_drivers_and_onevpl:suse15.2 -f Dockerfile:suse15.2 .
docker build -t gpu_drivers_and_onevpl:ubuntu18.04 -f Dockerfile:ubuntu18.04 .
docker build -t gpu_drivers_and_onevpl:ubuntu20.04 -f Dockerfile:ubuntu20.04 .
