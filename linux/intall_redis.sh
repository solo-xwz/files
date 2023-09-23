#!/bin/bash
set -e


name="redis-stable"
install_path="/usr/local/${name}"

cd /usr/local &&
wget "https://download.redis.io/${name}.tar.gz" &&
tar -xzvf "${name}.tar.gz" &&
cd $name &&
make && make install

# Redis配置文件路径
config_file="${install_path}/redis.conf"

# 使用sed命令修改daemonize选项为yes
sed -i 's/^daemonize no/daemonize yes/' "$config_file"


echo "[Unit]
Description=Redis
After=network.target
[Service]
#Type=forking
ExecStart="${install_path}/redis-server" "$config_file"
ExecReload="${install_path}/redis-server" -s reload
ExecStop="${install_path}/redis-server"r -s stop
PrivateTmp=true
[Install]
WantedBy=multi-user.target" > /usr/lib/systemd/system/redis.service &&

systemctl enable redis.service

echo ">>>安装完成<<<"