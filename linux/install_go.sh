#!/bin/bash
set -e

cd /usr/local/ &&
wget https://go.dev/dl/go1.21.6.linux-amd64.tar.gz &&
rm -rf /usr/local/go && tar -C /usr/local -xzf go1.21.1.linux-amd64.tar.gz &&

# add env
new_path='export PATH=$PATH:/usr/local/go/bin'

# 检查~/.bashrc是否已经包含该行
if grep -qF "$new_path" ~/.bashrc; then
    echo "The PATH line already exists in ~/.bashrc. No changes made."
else
    # 如果~/.bashrc中不存在该行，则添加
    echo "$new_path" >> ~/.bashrc
    echo "PATH line added to ~/.bashrc."
fi
source ~/.bashrc && export GO111MODULE=on
echo "$(go version)"
