# Use the base image from butomo1989
FROM butomo1989/docker-android-x86-9.0

# Set environment variables
ENV DEVICE="Nexus 5"
ENV RESOLUTION="1280x720"
ENV DENSITY="320"
ENV API_LEVEL="28"
ENV TAG="default"
ENV ABI="x86"

# Expose necessary ports
EXPOSE 6080 5554 5555

# Start the emulator
CMD ["/bin/bash", "/root/start.sh"]