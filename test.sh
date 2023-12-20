#!/bin/bash

# Define variables
GETH_VERSION="latest"
PLATFORM=$(uname -s | tr '[:upper:]' '[:lower:]')
ARCH=$(uname -m)
GETH_DOWNLOAD_URL="https://gethstore.blob.core.windows.net/builds"
GETH_LINUX_ARCHIVE="geth-linux-${ARCH}-${GETH_VERSION}.tar.gz"
GETH_MAC_ARCHIVE="geth-darwin-${ARCH}-${GETH_VERSION}.tar.gz"
GETH_WINDOWS_ARCHIVE="geth-windows-${ARCH}-${GETH_VERSION}.zip"
INSTALL_DIR="/usr/local/bin"
DATA_DIR="$HOME/ethereum_data"
NODE_NAME="eth-node"

# Check for curl or wget and use whichever is available
DOWNLOAD_CMD=""
if command -v curl > /dev/null; then
    DOWNLOAD_CMD="curl -L -O"
elif command -v wget > /dev/null; then
    DOWNLOAD_CMD="wget"
else
    echo "Error: curl or wget is required to download Geth."
    exit 1
fi

# Create a folder for Ethereum data
mkdir -p "${DATA_DIR}"

# Download and install Geth
download_and_install_geth() {
    local archive_name=$1
    local download_url="${GETH_DOWNLOAD_URL}/${archive_name}"

    echo "Downloading Geth from ${download_url}..."
    ${DOWNLOAD_CMD} "${download_url}"

    if [ "${PLATFORM}" = "linux" ] || [ "${PLATFORM}" = "darwin" ]; then
        tar -xzf "${archive_name}" -C "${INSTALL_DIR}" --strip-components=1
        rm "${archive_name}"
    elif [ "${PLATFORM}" = "mingw" ]; then
        unzip "${archive_name}" -d "${INSTALL_DIR}"
        rm "${archive_name}"
    else
        echo "Unsupported platform: ${PLATFORM}"
        exit 1
    fi
}

# Determine the platform and download the appropriate version of Geth
case "${PLATFORM}" in
    linux)
        download_and_install_geth "${GETH_LINUX_ARCHIVE}"
        ;;
    darwin)
        download_and_install_geth "${GETH_MAC_ARCHIVE}"
        ;;
    mingw*)
        download_and_install_geth "${GETH_WINDOWS_ARCHIVE}"
        ;;
    *)
        echo "Unsupported operating system: ${PLATFORM}"
        exit 1
        ;;
esac

# Initialize Geth node
geth --datadir "${DATA_DIR}" init "${NODE_NAME}/genesis.json"

# Start Geth node
geth --datadir "${DATA_DIR}" --networkid 1 --nodiscover --maxpeers 0 console

echo "Geth node has been deployed and started."