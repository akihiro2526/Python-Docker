FROM ubuntu:20.04

# TimeZone Setting
ENV TZ=Asia/Tokyo
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# package
RUN apt-get update && apt-get install -y \
    curl \
    dpkg \
    wget \
    gnupg \
    lsof \
    vim \
    build-essential \
    git \
    sudo \
    openssh-server \
    g++

ARG USERNAME=${USERNAME}
RUN useradd -m -s /bin/bash $USERNAME && \
    echo "$USERNAME   ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

# cp ../../.ssh/id_rsa.pub ./id_rsa.pub
COPY ./id_rsa.pub /home/$USERNAME/.ssh/authorized_keys

# 権限変更が必要 chmod +x
COPY docker-entrypoint.sh /
ENTRYPOINT ["/docker-entrypoint.sh"]