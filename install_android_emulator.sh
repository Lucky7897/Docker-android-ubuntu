#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

# Function to print an error message and exit
function error_exit {
    echo "$1" 1>&2
    exit 1
}

# Update package list and upgrade all packages
echo "Updating package list and upgrading all packages..."
sudo apt-get update || error_exit "Failed to update package list"
sudo apt-get upgrade -y || error_exit "Failed to upgrade packages"

# Install Docker
echo "Installing Docker..."
sudo apt-get install -y docker.io || error_exit "Failed to install Docker"
sudo systemctl start docker || error_exit "Failed to start Docker"
sudo systemctl enable docker || error_exit "Failed to enable Docker to start on boot"

# Pull the Docker image for Android 9 emulator
echo "Pulling Docker image for Android 9 emulator..."
sudo docker pull butomo1989/docker-android-x86-9.0 || error_exit "Failed to pull Docker image"

# Run the Android emulator in Docker
echo "Running Android emulator in Docker..."
sudo docker run --privileged -d -p 6080:6080 -p 5554:5554 -p 5555:5555 butomo1989/docker-android-x86-9.0 || error_exit "Failed to run Android emulator in Docker"

# Optimize system performance
echo "Optimizing system performance..."

# Set swappiness to 10
echo "Setting swappiness to 10..."
sudo sysctl vm.swappiness=10 || error_exit "Failed to set swappiness to 10"
echo "vm.swappiness=10" | sudo tee -a /etc/sysctl.conf || error_exit "Failed to persist swappiness setting"

# Set vm.overcommit_memory to 1
echo "Setting vm.overcommit_memory to 1..."
sudo sysctl vm.overcommit_memory=1 || error_exit "Failed to set vm.overcommit_memory to 1"
echo "vm.overcommit_memory=1" | sudo tee -a /etc/sysctl.conf || error_exit "Failed to persist vm.overcommit_memory setting"

# Disable transparent hugepages
echo "Disabling transparent hugepages..."
echo never | sudo tee /sys/kernel/mm/transparent_hugepage/enabled || error_exit "Failed to disable transparent hugepages"
echo never | sudo tee /sys/kernel/mm/transparent_hugepage/defrag || error_exit "Failed to disable transparent hugepage defrag"
echo "echo never > /sys/kernel/mm/transparent_hugepage/enabled" | sudo tee -a /etc/rc.local || error_exit "Failed to persist transparent hugepages setting"
echo "echo never > /sys/kernel/mm/transparent_hugepage/defrag" | sudo tee -a /etc/rc.local || error_exit "Failed to persist transparent hugepage defrag setting"
sudo chmod +x /etc/rc.local || error_exit "Failed to make /etc/rc.local executable"

# Clean up
echo "Cleaning up..."
sudo apt-get clean || error_exit "Failed to clean up"

echo "Installation and optimization complete. Android emulator is running and can be accessed via VNC at http://<server-ip>:6080."