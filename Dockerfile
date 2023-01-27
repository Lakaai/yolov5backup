# to deploy YOLOv5 on the Jetson Xavier NX. 
# This container must be built on the Jetson platform.
#----------------------------------------------------------------------------------------------
# Created By:	Luke Thompson
# Created Date:	21/01/2023
# version:		1.0
# ---------------------------------------------------------------------------------------------
# Useful Commands: 
# docker build --platform linux/arm64 -t <image-name> .
# docker build -t <image-name> .
# docker run -d -p -i 8000:8000 <image-name>
# docker exec -it <container name> /bin/bash
# docker ps -a OR docker ps 
# docker run -it --rm --net=host --runtime nvidia <image-name> 
# RUN python3 -m venv venv 
# RUN source venv/bin/activate 
# ---------------------------------------------------------------------------------------------

FROM nvcr.io/nvidia/l4t-jetpack:r35.1.0
ARG DEBIAN_FRONTEND=noninteractive

# Python 3.8 Install


RUN apt update -y && apt upgrade -y 
RUN apt-get install -y python3.8 \
    python3-pip \ 
    python3.8-venv \
    wget \
    git-all 

# Download YOLOv5 Folder 

RUN git clone https://github.com/Lakaai/yolov5-jetson.git
RUN cd yolov5-jetson
RUN pip3 install -r /yolov5-jetson/requirements.txt 

# PyTorch 

RUN wget https://developer.download.nvidia.com/compute/redist/jp/v502/pytorch/torch-1.13.0a0+410ce96a.nv22.12-cp38-cp38-linux_aarch64.whl
RUN pip3 install --upgrade --force-reinstall torch-1.13.0a0+410ce96a.nv22.12-cp38-cp38-linux_aarch64.whl
RUN pip3 show torch

# TorchVision

RUN pip3 uninstall -y torchvision
RUN cd ..
RUN git clone https://github.com/pytorch/vision.git
RUN mv vision /yolov5-jetson/ 
RUN cd yolov5-jetson && cd vision
WORKDIR /yolov5-jetson/vision/
RUN python3 setup.py install
RUN pip3 show torchvision
WORKDIR /yolov5-jetson/
