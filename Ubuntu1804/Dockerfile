FROM ubuntu:18.04

ENV LC_ALL C.UTF-8
ENV LANG C.UTF-8

RUN DEBIAN_FRONTEND=noninteractive
RUN apt-get update && apt-get install -y tzdata
RUN apt-get install -y python3.6 python3-distutils rtmpdump ffmpeg git mysql-client curl

RUN mkdir /src
WORKDIR /src

ADD ./entrypoint.sh /src
RUN chmod a+x /src/entrypoint.sh

RUN curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py
RUN python3.6 get-pip.py
RUN mkdir -p /root/.local/bin
RUN pip install pipenv

RUN git clone https://github.com/sun-yryr/Rec-adio.git -b v3.0

WORKDIR /src/Rec-adio
RUN pipenv install