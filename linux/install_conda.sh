#!/bin/bash


echo "start install miniconda3..."
mkdir -p ~/miniconda3
wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O ~/miniconda3/miniconda.sh
bash ~/miniconda3/miniconda.sh -b -u -p ~/miniconda3 &&
rm -rf ~/miniconda3/miniconda.sh
echo "delete miniconda.sh..."
echo "init miniconda..."
~/miniconda3/bin/conda init bash &&
echo "export ENV..."
echo 'export PATH=/root/miniconda3/bin:$PATH' >> ~/.bashrc &&
source ~/.bashrc &&
echo "install success!"
