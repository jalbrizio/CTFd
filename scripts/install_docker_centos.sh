#!/bin/bash

# Script to install docker in Debian Guest VM
# per: https://docs.docker.com/engine/installation/linux/debian/#install-docker-ce

# Install packages to allow apt to use a repository over HTTPS
sudo yum -y install \
    python-pip
    yum-transport-https \
    ca-certificates \
    curl \
    gnupg2 \
    software-properties-common

# Add Docker’s official GPG key
curl -fsSL https://download.docker.com/linux/centos/gpg > /etc/pki/rpm-gpg/docker-gpg
sudo rpm --import /etc/pki/rpm-gpg/docker-gpg

# Set up the stable repository. 
curl -fsSL https://download.docker.com/linux/centos/docker-ce.repo > /etc/yum.repos.d/docker-ce.repo

# Update the OS
sudo yum -y  update

# Install the latest version of Docker
sudo yum -y install docker-ce

# Add user to the docker group
# Warning: The docker group grants privileges equivalent to the root user. 

#sudo usermod -aG docker ubuntu

# Configure Docker to start on boot
sudo systemctl enable docker

# Install docker-compose
sudo pip install docker-compose
