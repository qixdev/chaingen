#!/bin/bash

# Define the Geth download URL
GETH_LINUX_URL="https://gethstore.blob.core.windows.net/builds/geth-linux-amd64-1.10.17-25c9b49f.tar.gz"
GETH_MAC_URL="https://gethstore.blob.core.windows.net/builds/geth-darwin-amd64-1.10.17-25c9b49f.tar.gz"

# Function to install Geth for Linux
install_geth_linux() {
    echo "Downloading Geth for Linux..."
    curl -O $GETH_LINUX_URL
    tar -xvzf geth-linux-amd64-*.tar.gz
    mv geth-linux-amd64-*/geth /usr/local/bin
    rm -rf geth-linux-amd64-*
    echo "Geth installation completed."
}

# Function to install Geth for macOS
install_geth_mac() {
    echo "Downloading Geth for macOS..."
    curl -O $GETH_MAC_URL
    tar -xvzf geth-darwin-amd64-*.tar.gz
    mv geth-darwin-amd64-*/geth /usr/local/bin
    rm -rf geth-darwin-amd64-*
    echo "Geth installation completed."
}

# Check the OS and install Geth accordingly
OS="$(uname)"
case $OS in
  "Linux")
    install_geth_linux
    ;;
  "Darwin")
    install_geth_mac
    ;;
  *)
    echo "Unsupported operating system: $OS"
    exit 1
    ;;
esac

# Initialize and run the Ethereum node
echo "Initializing Ethereum node..."
geth --datadir ~/.ethereum/mainnet init

echo "Starting Ethereum node on Mainnet..."
geth --datadir ~/.ethereum/mainnet

# The script ends here. The node will continue to run in the foreground.
# Use Ctrl+C to stop the node.