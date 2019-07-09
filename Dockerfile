FROM debian:buster-slim

RUN apt-get update && \
    apt-get install -y python python-pip python3 python3-pip libffi-dev && \
    apt-get autoclean && \
    rm -rf /var/lib/apt/lists/*

RUN pip install --upgrade setuptools --user
RUN pip3 install --upgrade setuptools --user

