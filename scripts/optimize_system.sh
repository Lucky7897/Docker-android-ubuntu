#!/bin/bash

# Function to print an error message and exit
function error_exit {
    echo "$1" 1>&2
    exit 1
}

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

echo "System optimization complete."