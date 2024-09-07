#!/bin/bash

# 本地上传文件夹的绝对路径
LOCAL_DIR="./uploadfolder"

# 远程服务器的目标路径
REMOTE_USER="user"
REMOTE_HOST="10.26.2.77"
REMOTE_PATH="/home/user/Compiler_test"

# 使用scp命令上传文件夹
scp -r "$LOCAL_DIR" "$REMOTE_USER@$REMOTE_HOST:$REMOTE_PATH"
