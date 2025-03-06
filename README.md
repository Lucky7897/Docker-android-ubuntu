# Docker Android Emulator Setup

This repository contains scripts to set up and optimize an Android emulator on a fresh Ubuntu server using Docker. The setup includes options for different Android versions and optimizes the host machine for better performance.

## Prerequisites

- A fresh Ubuntu server
- sudo privileges

## Installation

1. **Clone the repository:**

   ```bash
   git clone https://github.com/Lucky7897/Docker-android-ubuntu.git
   cd Docker-android-ubuntu
   ```

2. **Run the installation scripts:**

   ```bash
   sudo ./scripts/install_docker.sh
   sudo ./scripts/optimize_system.sh
   ```

3. **Run the Android emulator:**

   ```bash
   sudo ./scripts/run_emulator.sh [android-version]
   ```

   Replace `[android-version]` with the desired Android version (e.g., `android-x86-9.0`). If no version is specified, it defaults to Android 9.0.

4. **Using Docker Compose:**

   Alternatively, you can use Docker Compose to manage the emulator:

   ```bash
   sudo docker-compose up -d
   ```

## Accessing the Emulator

The Android emulator can be accessed via VNC at `http://<server-ip>:6080`.

## Available Android Versions

- `android-x86-8.1`
- `android-x86-9.0`
- `android-x86-10.0`
- `android-x86-11.0`

## System Optimization

The `optimize_system.sh` script sets the following optimizations:
- Sets `vm.swappiness` to 10 to reduce swap usage.
- Sets `vm.overcommit_memory` to 1 to allow memory overcommitment.
- Disables transparent hugepages to improve performance with certain workloads.

## Contributing

Feel free to submit issues or pull requests if you have any improvements or suggestions.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.