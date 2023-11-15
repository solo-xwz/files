#!/bin/bash

apt update && apt install -y pkg-config libevent-dev &&
cd /usr/local &&
wget https://www.pgbouncer.org/downloads/files/1.21.0/pgbouncer-1.21.0.tar.gz &&
tar -xvf pgbouncer-1.21.0.tar.gz &&
cd pgbouncer-1.21.0 &&
./configure --prefix=/usr/local &&
make &&
make install &&
echo ">>>install pgbouncer success!<<<"