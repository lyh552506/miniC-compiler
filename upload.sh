#!/bin/bash

# 本地上传文件夹的绝对路径
LOCAL_DIR="/home/nanqin/compiler/miniC-compiler/uploadfolder"

# 远程服务器的目标路径
REMOTE_USER="user"
REMOTE_HOST="192.168.31.105"
REMOTE_PATH="/home/user/Compiler_test"

# 使用scp命令上传文件夹
scp -r "$LOCAL_DIR" "$REMOTE_USER@$REMOTE_HOST:$REMOTE_PATH"
