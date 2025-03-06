#!/bin/bash

# Function to print an error message and exit
function error_exit {
    echo "$1" 1>&2
    exit 1
}

# Pull the Docker image for the selected Android version
ANDROID_VERSION=$1
if [ -z "$ANDROID_VERSION" ]; then
  ANDROID_VERSION="android-x86-9.0" # Default to Android 9.0
fi

echo "Pulling Docker image for Android emulator version $ANDROID_VERSION..."
sudo docker pull butomo1989/docker-$ANDROID_VERSION || error_exit "Failed to pull Docker image"

# Run the Android emulator in Docker
echo "Running Android emulator in Docker..."
sudo docker run --privileged -d -p 6080:6080 -p 5554:5554 -p 5555:5555 butomo1989/docker-$ANDROID_VERSION || error_exit "Failed to run Android emulator in Docker"

echo "Android emulator is running and can be accessed via VNC at http://<server-ip>:6080."