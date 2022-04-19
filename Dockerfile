FROM ubuntu:20.04

# TimeZone Setting
ENV TZ=Asia/Tokyo
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Packages
RUN apt-get update && apt-get upgrade -y
RUN apt-get install -y \
    git \
    sudo \
    openssh-server \
    libffi-dev \
    libssl-dev \
    zlib1g-dev \
    liblzma-dev \
    tk-dev \
    libbz2-dev \
    libreadline-dev \
    libsqlite3-dev\
    libopencv-dev \
    build-essential 

# User setting
ARG USERNAME=${USERNAME}
RUN useradd -m -s /bin/bash $USERNAME && \
    echo "$USERNAME   ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

USER $USERNAME
WORKDIR /home/$USERNAME/

# Install pyenv => python
ARG PYTHON_VERSION=${PYTHON_VERSION}
SHELL [ "/bin/bash", "-c" ]
RUN git clone https://github.com/pyenv/pyenv.git .pyenv
ENV PATH $PATH:/home/$USERNAME/.pyenv/bin
RUN echo 'export PYENV_ROOT="$HOME/.pyenv"' >> ~/.bashrc &&\
    echo 'export PATH="$PYENV_ROOT/bin:$PATH"' >> ~/.bashrc &&\
    echo 'eval "$(pyenv init --path)"' >> ~/.bashrc &&\
    source ~/.bashrc &&\
    pyenv -v &&\
    pyenv install $PYTHON_VERSION &&\
    pyenv global $PYTHON_VERSION

# Placement ssh public key
COPY ./id_rsa.pub /home/$USERNAME/.ssh/authorized_keys

USER root
COPY docker-entrypoint.sh /
ENTRYPOINT ["/docker-entrypoint.sh"]