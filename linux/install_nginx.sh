#!/bin/bash
set -e


apt -y install libpcre3 libpcre3-dev &&

username="nginx"
# 使用 id 命令来检查用户是否存在
if id "$username" &>/dev/null; then
  echo "用户 $username 存在"
else
  echo "用户 $username 不存在，将创建用户..."
  
  # 使用 useradd 命令创建用户
  useradd "$username" -s /sbin/nologin -M
  
  # 检查创建用户是否成功
  if [ $? -eq 0 ]; then
    echo "用户 $username 创建成功"
  else
    echo "无法创建用户 $username"
  fi
fi


cd /usr/local &&
wget http://nginx.org/download/nginx-1.24.0.tar.gz &&
tar -xvf nginx-1.24.0.tar.gz
directory_path="/path/to/your/directory"
if [ -d "$directory_path" ]; then
  echo "路径已存在: $directory_path"
else
  echo "创建文件夹: $directory_path"
  
  mkdir -p "$directory_path"
  
  if [ $? -eq 0 ]; then
    echo "路径创建成功: $directory_path"
  else
    echo "无法创建路径: $directory_path"
  fi
fi

cd nginx-1.24.0 &&
./configure --prefix=/etc/nginx --sbin-path=/usr/sbin/nginx --modules-path=/usr/lib64/nginx/modules --conf-path=/etc/nginx/nginx.conf --error-log-path=/var/log/nginx/error.log --http-log-path=/var/log/nginx/access.log --pid-path=/var/run/nginx.pid --lock-path=/var/run/nginx.lock --http-client-body-temp-path=/var/cache/nginx/client_temp --http-proxy-temp-path=/var/cache/nginx/proxy_temp --http-fastcgi-temp-path=/var/cache/nginx/fastcgi_temp --http-uwsgi-temp-path=/var/cache/nginx/uwsgi_temp --http-scgi-temp-path=/var/cache/nginx/scgi_temp --user=nginx --group=nginx --with-compat --with-file-aio --with-threads --with-http_addition_module --with-http_auth_request_module --with-http_dav_module --with-http_flv_module --with-http_gunzip_module --with-http_gzip_static_module --with-http_random_index_module --with-http_realip_module --with-http_secure_link_module --with-http_slice_module --with-http_ssl_module --with-http_stub_status_module --with-http_sub_module --with-http_v2_module --with-mail --with-mail_ssl_module --with-stream --with-stream_realip_module --with-stream_ssl_module --with-stream_ssl_preread_module --with-cc-opt='-O2 -g -pipe -Wall -Wp,-D_FORTIFY_SOURCE=2 -fexceptions -fstack-protector-strong --param=ssp-buffer-size=4 -grecord-gcc-switches -m64 -mtune=generic -fPIC' --with-ld-opt='-Wl,-z,relro -Wl,-z,now -pie' --with-openssl=/usr/local/openssl-3.0.11 --with-pcre
make && make install &&
echo "[Unit]
Description=nginx
After=network.target

[Service]
Type=forking
ExecStart=/usr/sbin/nginx
ExecReload=/usr/sbin/nginx -s reload
ExecStop=/usr/sbin/nginx -s stop
PrivateTmp=true

[Install]
WantedBy=multi-user.target" > /usr/lib/systemd/system/nginx.service &&

systemctl enable nginx.service

echo ">>>安装完成<<<"
