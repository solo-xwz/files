#!/bin/bash


cd /usr/local &&
git clone https://github.com/pgbouncer/pgbouncer.git &&
echo "dowload success!" &&
cd pgbouncer &&
git submodule init &&
git submodule update &&
./autogen.sh &&
./configure ... &&
make &&
make install
echo "install success!"