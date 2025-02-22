#! /bin/bash

# Initial host update
sudo apt update

# Uninstall Docker
sudo apt-get purge docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin docker-ce-rootless-extras

# Delete all images, containers, volumes
sudo rm -rf /var/lib/docker
sudo rm -rf /var/lib/containerd

# Remove source.list
sudo rm /etc/apt/sources.list.d/docker.list
sudo rm /etc/apt/keyrings/docker.asc

# Install dependencies
sudo apt install apt-transport-https ca-certificates curl software-properties-common -y

# Docker GPG key
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc

# Add latest Docker repository
echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

# Update package index
sudo apt update

# Install Docker
sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

# Add user to docker group
usermod -aG docker $USER

# Enable Docker service to start automatically
sudo systemctl enable docker

# Restart Docker
sudo service docker restart
