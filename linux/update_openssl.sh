#!/bin/bash

echo "当前 OpenSSL 版本: $(openssl version)"
echo "当前 OpenSSL 路径: $(which openssl)"

# 更新软件包列表并安装依赖项
apt update
apt install -y zlib1g zlib1g-dev gcc wget

echo "安装 Perl..."
wget https://www.cpan.org/src/5.0/perl-5.38.0.tar.gz
tar -zxvf perl-5.38.0.tar.gz
cd perl-5.38.0
./Configure -des -Dprefix=/usr/local/perl -Dusethreads -Uversiononly
make
make install

echo "安装 OpenSSL..."
cd /usr/local
wget https://www.openssl.org/source/openssl-1.1.1w.tar.gz
tar -zxvf openssl-1.1.1w.tar.gz
cd openssl-1.1.1w
./config shared zlib
make
make install

# 备份旧的 OpenSSL
mv /usr/bin/openssl /usr/bin/openssl.old
mv /usr/include/openssl /usr/include/openssl.old
mv /usr/lib/openssl /usr/lib/openssl.old

# 创建符号链接
ln -s /usr/local/bin/openssl /usr/bin/openssl
ln -s /usr/local/include/openssl /usr/include/openssl

# 更新库路径并加载动态链接器配置
echo "/usr/local/lib" >> /etc/ld.so.conf
ldconfig -v

echo "新 OpenSSL 版本: $(openssl version)"
