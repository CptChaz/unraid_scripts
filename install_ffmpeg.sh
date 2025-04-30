#!/bin/bash
# Author: Cpt. Chaz
# Created: 2025-04-01
# Updated: 2025-04-01
# Version Number: V 1.0
# Description: Downloads and installs the latest static build of FFmpeg from johnvansickle.com.
#              Places it in a custom install directory and symlinks the binaries for system-wide use.
# Dependancies: wget, tar
# Status: Tested
#
# Credits:
#  - johnvansickle.com for providing static FFmpeg builds
#
# - This script was created with the help of ChatGPT, an OpenAI language model.
#
# Slightly more detailed and apt description: This automation script downloads the latest x86_64 static
# FFmpeg build from johnvansickle.com, extracts it to a user-defined directory on Unraid, and creates
# system-wide symlinks in /usr/bin (or your preferred location). Ensures clean install with checks and logs.
# BE SURE TO FILL IN YOUR OWN INSTALL_DIR LOCATION!!! You probably don't need to adjust the BIN_DIR or FFMPEG_URL
#
# WARNING:
# - This script installs FFmpeg at the **system level** ("bare metal") on your Unraid server.
# - It bypasses plugin management and does not isolate FFmpeg in a container or virtual machine.
# - Best practice is to install and run applications like FFmpeg within Docker containers or VMs to reduce risk.
# - This script modifies files in `/usr/bin` (or user-defined path) and assumes root access.
# - Users **assume all risk** when running this script, and should review it carefully before execution.
# - Not officially supported by Lime Technology or Unraid.

set -e  # Exit on error

# ==========================
#   USER CONFIGURATION
# ==========================
INSTALL_DIR="/mnt/user/documents/scripts/ffmpeg/program"  # Custom install path
BIN_DIR="/usr/bin"                                        # Directory for symlinks
FFMPEG_URL="https://johnvansickle.com/ffmpeg/releases/ffmpeg-release-amd64-static.tar.xz"

# ==========================
#   HELPER FUNCTIONS
# ==========================

log() {
    echo "[INFO] $1"
}

error() {
    echo "[ERROR] $1"
    exit 1
}

# ==========================
#   INSTALLATION PROCESS
#   DO NOT MODIFY BELOW
# ==========================

log "Starting FFmpeg installation..."
log "Install Directory: $INSTALL_DIR"
log "Binary Symlink Location: $BIN_DIR"

# Step 1: Create install directory
log "Creating install directory if not exists..."
mkdir -p "$INSTALL_DIR" || error "Failed to create install directory"

# Step 2: Download latest FFmpeg build
log "Downloading latest FFmpeg build..."
cd "$INSTALL_DIR"
wget --progress=bar:force "$FFMPEG_URL" -O ffmpeg.tar.xz || error "Failed to download FFmpeg"

# Step 3: Extract FFmpeg
log "Extracting FFmpeg..."
tar -xf ffmpeg.tar.xz --strip-components=1 || error "Failed to extract FFmpeg"
rm -f ffmpeg.tar.xz  # Cleanup

# Step 4: Verify FFmpeg binary exists
if [[ ! -f "$INSTALL_DIR/ffmpeg" || ! -f "$INSTALL_DIR/ffprobe" ]]; then
    error "FFmpeg or ffprobe binary is missing after extraction"
fi

# Step 5: Create symlinks in /usr/bin
log "Creating symlinks for system-wide access..."
ln -sf "$INSTALL_DIR/ffmpeg" "$BIN_DIR/ffmpeg"
ln -sf "$INSTALL_DIR/ffprobe" "$BIN_DIR/ffprobe"

# Step 6: Set executable permissions
log "Setting executable permissions..."
chmod +x "$INSTALL_DIR/ffmpeg" "$INSTALL_DIR/ffprobe"

# Step 7: Verify installation
log "Verifying FFmpeg installation..."
if command -v ffmpeg &>/dev/null; then
    log "FFmpeg installed successfully"
    ffmpeg -version
else
    error "FFmpeg installation failed"
fi

log "FFmpeg is ready to use"
