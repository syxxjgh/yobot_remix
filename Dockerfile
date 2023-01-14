FROM python:3.8-slim-buster
LABEL maintainer="yobot"

ENV PYTHONIOENCODING=utf-8

ADD src/client/ /yobot

RUN ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
    && echo 'Asia/Shanghai' >/etc/timezone \
    && apt update \
    && apt upgrade -y \
    && apt install build-essential -y \
    && cd /yobot \
    && pip3 install aiocqhttp==0.6.8 Quart==0.6.15 markupsafe==2.0.1 --no-cache-dir \
    && pip3 install -r requirements.txt --no-cache-dir \
    && cd /yobot/ybplugins/Steam_watcher \
    && pip3 install -r requirements.txt --no-cache-dir \
    && cd /yobot \
    && python3 main.py \
    && chmod +x yobotg.sh

WORKDIR /yobot

EXPOSE 9222

VOLUME /yobot/yobot_data

ENTRYPOINT /yobot/yobotg.sh