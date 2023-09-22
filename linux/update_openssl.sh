#!/bin/bash
set -e

echo "current openssl version: $(openssl version)"
echo "current openssl path: $(which openssl)"
cd /usr/local &&
echo "下载openssl"

apt update &&
apt install -y zlib1g zlib1g-dev gcc &&

echo "安装perl..."
wget https://www.cpan.org/src/5.0/perl-5.38.0.tar.gz &&
tar -zxvf perl-5.38.0.tar.gz &&
mkdir /usr/local/perl &&
cd perl-5.38.0 &&
./Configure -des -Dprefix=/usr/local/perl -Dusethreads -Uversiononly &&
make && make install &&

mv /usr/bin/perl /usr/bin/perl.old &&
ln -s /usr/local/perl/bin/perl /usr/bin/perl &&

echo "安装openssl..." &&
wget https://www.openssl.org/source/openssl-3.0.11.tar.gz &&
tar -zxvf openssl-3.0.11.tar.gz &&
cd openssl-3.0.11 &&
./config shared zlib &&
make && make install &&

mv /usr/bin/openssl /usr/bin/openssl.old &&
ln -s /usr/local/bin/openssl /usr/bin/openssl &&
ln -s /usr/local/include/openssl/ /usr/include/openssl &&
echo "/usr/local/lib/" >> /etc/ld.so.conf
ldconfig -v &&

echo "new openssl version: $(openssl version)"
