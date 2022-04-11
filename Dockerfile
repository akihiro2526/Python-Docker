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
    git \
    sudo \
    g++ \
    openssh-server \
    # For pyenv
    libffi-dev \
    libssl-dev \
    zlib1g-dev \
    liblzma-dev \
    tk-dev \
    libbz2-dev \
    libreadline-dev \
    libsqlite3-dev\
    libopencv-dev \
    build-essential \
    #locales
    locales

RUN locale-gen en_US.UTF-8

# user setting
ARG USERNAME=${USERNAME}
RUN useradd -m -s /bin/bash $USERNAME && \
    echo "$USERNAME   ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

USER $USERNAME
WORKDIR /home/$USERNAME/

# install pyenv python
SHELL [ "/bin/bash", "-c" ]
RUN git clone https://github.com/pyenv/pyenv.git .pyenv

ENV PYENV_ROOT "$HOME/.pyenv"
ENV PATH "$PYENV_ROOT/bin:$PATH"

# RUN echo -e '\n' >> ~/.bashrc &&\
#     echo -e '# pyenv' >> ~/.bashrc &&\
#     echo 'export PYENV_ROOT="$HOME/.pyenv"' >> ~/.bashrc &&\
#     echo 'export PATH="$PYENV_ROOT/bin:$PATH"' >> ~/.bashrc &&\
#     echo 'eval "$(pyenv init --path)"' >> ~/.bashrc &&\
#     source ~/.bashrc &&\
#     echo 'AAAAAA' >> ~/.bashrc

    # exec $SHELL -l &&\
RUN echo 'BBBBBB' >> ~/.bashrc &&\
    pyenv -v &&\
    pyenv install 3.10.4 &&\
    pyenv global 3.10.4 &&\
    python --version &&\
    pip --version &&\
    echo 'CCCCCC' >> ~/.bashrc

    #vをつけたらできるようになるかもしれない

# cp ../../.ssh/id_rsa.pub ./id_rsa.pub
COPY ./id_rsa.pub /home/$USERNAME/.ssh/authorized_keys

USER root

# 権限変更が必要 chmod +x
COPY docker-entrypoint.sh /
ENTRYPOINT ["/docker-entrypoint.sh"]