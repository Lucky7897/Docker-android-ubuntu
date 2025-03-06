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

echo "Docker installation complete."