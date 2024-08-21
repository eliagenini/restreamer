FROM ubuntu:latest

WORKDIR /usr/src

RUN apt-get update; \
    apt-get install -y --no-install-recommends ffmpeg nginx supervisor; \
    rm -rf /var/lib/apt/list/*

ARG USERNAME=user
ARG USER_UID=1001
ARG USER_GID=$USER_UID

RUN mkdir -p /var/log/supervisor; \
    mkdir -p /var/www/html; \
    groupadd --gid $USER_GID $USERNAME; \
    useradd --uid $USER_UID --gid $USERNAME --shell /bin/bash --create-home $USERNAME; \
    chown $USERNAME /var/www/html;

COPY supervisord.conf entrypoint.sh restream.sh ./
COPY favicon.png index.html /var/www/html/
COPY nginx.conf /etc/nginx/sites-enabled/default

RUN chmod +x entrypoint.sh;
RUN chmod +x restream.sh;

ENV USER=$USERNAME

ENTRYPOINT ["bash", "./entrypoint.sh"]