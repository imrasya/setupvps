#!/bin/bash

# Update repositories and upgrade packages
echo "Updating system packages..."
apt update && apt upgrade -y

# Install essential tools
echo "Installing essential tools..."
apt install -y curl wget git htop nano

# Setup SWAP (2GB)
echo "Setting up 2GB SWAP..."
if [ ! -f /swapfile ]; then
    fallocate -l 2G /swapfile
    chmod 600 /swapfile
    mkswap /swapfile
    swapon /swapfile
    echo '/swapfile none swap sw 0 0' >> /etc/fstab
    echo "SWAP created and activated"
else
    echo "SWAP file already exists"
fi

# Set swappiness to 70
echo "Setting swappiness to 70..."
sysctl vm.swappiness=70
echo 'vm.swappiness=70' >> /etc/sysctl.conf

# Install Node.js 20.x
echo "Installing Node.js 20.x and npm..."
curl -fsSL https://deb.nodesource.com/setup_20.x | bash -
apt install -y nodejs
npm install -g npm@latest

# Install Python3 and pip
echo "Installing Python3 and pip..."
apt install -y python3 python3-pip

# Set alias cls=clear
echo "Setting up cls alias for all users..."
echo "alias cls='clear'" >> /etc/bash.bashrc
echo "alias cls='clear'" >> /etc/zsh/zshrc

# Apply alias changes immediately
echo "Applying alias changes immediately..."
source /etc/bash.bashrc 2>/dev/null || true
if [ -f /etc/zsh/zshrc ]; then
    source /etc/zsh/zshrc 2>/dev/null || true
fi
echo "Alias cls=clear is now active"

# Install PM2
echo "Installing PM2..."
npm install -g pm2

# Print versions of installed packages
echo "Setup completed. Installed versions:"
echo "Node.js: $(node -v)"
echo "NPM: $(npm -v)"
echo "Python: $(python3 --version)"
echo "Pip: $(pip3 --version)"
echo "PM2: $(pm2 -v)"

echo "VPS setup complete. Please log out and log back in for alias changes to take effect." 
