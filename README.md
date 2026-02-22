# atcoder-cpp-sample
Sample Environment for AtCoder (cpp) using maki8maki/atcoder-cpp-docker

## 概要

CLI ベースの AtCoder 学習環境です。Docker Compose + Makefile で統合され、どのディレクトリからでも問題にアクセス・テスト・提出が可能です。

## セットアップ

### 前提条件
- Docker Desktop
- Homebrew (macOS)
- fzf

### インストール

```bash
# fzf をインストール（未インストールの場合）
brew install fzf

# Docker コンテナを起動
make up

# 全ディレクトリに Makefile を生成
make make
```

## 使用方法

### 問題セット取得

```bash
# 問題セットを自動ダウンロード・生成
make gen abc001               # AtCoder Beginner Contest 001
make gen math-and-algorithm   # 競技プログラミングの鉄則
make gen tessoku-book         # その他の問題集
```

### テスト・提出

```bash
# どのディレクトリからでも実行可能
make test      # fzf で問題を選択してテスト実行
make submit    # fzf で問題を選択して提出
```

### コンテナ管理

```bash
make up        # Docker コンテナを起動
make down      # Docker コンテナを停止
```

## ディレクトリ構成

```
.
├── Makefile
├── Makefile.src
├── Makefile.submake
├── docker-compose.yml
└── src/
    └── each_contest
        ├── 001/
        │   ├── main.cpp
        │   ├── in_1.txt
        │   └── out_1.txt
        └── ...
```

## 参考

- 元の環境: https://zenn.dev/kinakomochi5250/articles/atcoder-cpp-docker
- atcoder-tools: https://github.com/kyuridenamida/atcoder-tools

## ライセンス

MIT
