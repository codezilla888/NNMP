# To use CUDA please uncomment the following line:
FROM nvidia/cuda:11.3.0-cudnn8-devel-ubuntu20.04
# And comment the following one:
# FROM ubuntu:20.04

EXPOSE 9009

# configure timezone, our app depends on it.
ARG DEBIAN_FRONTEND=noninteractive
ENV TZ=Europe/Moscow
# RUN /usr/bin/ln -sf /usr/share/zoneinfo/America/Toronto /etc/localtime


RUN apt-get update && \
    apt-get install --no-install-recommends -y curl screen python3 build-essential python3-pip
RUN apt-get install ffmpeg libsm6 libxext6  -y && apt clean

#RUN apt update
RUN apt install -y git-lfs
RUN apt install -y git
RUN apt install -y wget 
RUN apt install -y unzip 
RUN apt install -y python3-dev 

RUN mkdir /mydata/
RUN mkdir /ProjectMoney/
WORKDIR /ProjectMoney/
COPY . /ProjectMoney/
#RUN wget https://github.com/ultralytics/yolov5/releases/download/v6.2/yolov5m.pt -o yolov5/yolov5s.pt

#или
RUN pip3 install -r yolov5/requirements.txt

WORKDIR /ProjectMoney/yolov5/
CMD python3 train.py --img 640 --batch 8 --epochs 50 --data ../data.yaml --weights ../yolov5s.pt --workers 0 --device cpu 


#doker build money -t .
#doker run money -v ./ProjectMoney/train:./ProjectMoney/train -v ./ProjectMoney/results:/./ProjectMoney/results -it money
