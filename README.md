# Python Docker

Python 実行環境

## Feature

- Python 実行環境
- SSH 接続時のパスワード入力不要

## Usage

事前に秘密鍵と公開鍵を作成しておく
```
ssh-keygen
```
※ `id_rsa` 以外の場合は `Makefile` を変更

1.環境変数を設定
```
# username [default - user]
USERNAME=

# ssh port [default - 8022]
SSH_PORT=

# Python version [default - 3.10.4]
PYTHON_VERSION=
```

2.コンテナ起動 

```
make docker
```

## Distribution
Ubuntu 20.04

## Package
- git
- sudo
- openssh-server
- libffi-dev
- libssl-dev
- zlib1g-dev
- liblzma-dev
- tk-dev
- libbz2-dev
- libreadline-dev
- libsqlite3-dev
- libopencv-dev
- build-essential 
- pyenv
- python
- pip