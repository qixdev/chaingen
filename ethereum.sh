#!/bin/bash

# Define the Geth download URL
GETH_LINUX_URL="https://gethstore.blob.core.windows.net/builds/geth-linux-amd64-1.10.17-25c9b49f.tar.gz"
GETH_MAC_URL="https://gethstore.blob.core.windows.net/builds/geth-darwin-amd64-1.10.17-25c9b49f.tar.gz"

# Create Prysm installation directory if it doesn't exist
mkdir -p "$PRYSM_INSTALL_DIR"

# Download and install Geth
echo "Downloading Geth..."
curl -o "$ETH_INSTALL_DIR/geth.zip" "https://gethstore.blob.core.windows.net/builds/geth-windows-amd64-1.13.5-916d6a44.zip"
unzip -q "$ETH_INSTALL_DIR/geth.zip" -d "$ETH_INSTALL_DIR"
rm "$ETH_INSTALL_DIR/geth.zip"

# Download and install Prysm
echo "Downloading Prysm..."
curl -o "$PRYSM_INSTALL_DIR/prysm.zip" "https://github.com/prysmaticlabs/prysm/archive/refs/tags/v4.1.1.zip"
unzip -q "$PRYSM_INSTALL_DIR/prysm.zip" -d "$PRYSM_INSTALL_DIR"
rm "$PRYSM_INSTALL_DIR/prysm.zip"

# Initialize Prysm (replace wallet and validator information)
echo "Initializing Prysm..."
"$PRYSM_INSTALL_DIR/prysm-4.1.1/prysm.bat" validator --wallet-dir="$PRYSM_INSTALL_DIR/wallets" --accept-terms-of-use

# Start Geth (replace with your desired Geth configuration)
echo "Starting Geth..."
"$ETH_INSTALL_DIR/geth.exe" --syncmode "snap" --cache=1024

# Keep the terminal open
read -p "Press Enter to exit..."
