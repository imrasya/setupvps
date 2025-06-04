#!/bin/bash

# Setup SWAP (4GB)
echo "Setting up 4GB SWAP..."
if [ ! -f /swapfile ]; then
    fallocate -l 4G /swapfile
    chmod 600 /swapfile
    mkswap /swapfile
    swapon /swapfile
    echo '/swapfile none swap sw 0 0' >> /etc/fstab
    echo "SWAP created and activated"
else
    echo "SWAP file already exists"
fi

# Set swappiness to 80
echo "Setting swappiness to 80..."
sysctl vm.swappiness=80
echo 'vm.swappiness=80' >> /etc/sysctl.conf
