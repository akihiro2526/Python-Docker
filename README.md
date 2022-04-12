# Python Docker

Python 実行環境

## 特徴

- SSH 接続時のパスワード入力不要
- pyenv から python をインストール

## インストール

1.ssh キーを作成 ` ssh-keygen`

2.公開鍵を Docker Context にコピー `cp ~/.ssh/id_rsa.pub ./id_rsa.pub`

3.環境変数を設定

```
# username
USERNAME=********
# ssh port
CONTAINER_PORT=****
```

4.コンテナ起動 `docker compose up -d`
