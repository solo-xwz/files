#!/bin/bash
set -e

cd /usr/local/ &&
wget https://go.dev/dl/go1.21.1.linux-amd64.tar.gz &&
rm -rf /usr/local/go && tar -C /usr/local -xzf go1.21.1.linux-amd64.tar.gz &&
export PATH=$PATH:/usr/local/go/bin && export GO111MODULE=on
echo "$(go version)"
