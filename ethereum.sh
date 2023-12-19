#!/bin/bash

display_error_and_exit() {
    echo "Error: $1"
    exit 1
}

# Check if the operating system is Linux
if [[ "$(uname)" == "Linux" ]]; then
    echo "[ChainGen] Deploying an Ethereum node on Linux."
    ETHEREUM_INSTALL_DIR="$HOME/ethereum"

    mkdir -p "$ETHEREUM_INSTALL_DIR"

    ETHEREUM_CORE_URL="https://gethstore.blob.core.windows.net/builds/geth-linux-amd64-<ethereum-core-version>.tar.gz"
    ETHEREUM_CORE_TAR="$ETHEREUM_INSTALL_DIR/geth.tar.gz"

    echo "Downloading Geth..."
    curl -o "$ETHEREUM_CORE_TAR" "$ETHEREUM_CORE_URL"

    echo "Extracting Geth..."
    tar -xzf "$ETHEREUM_CORE_TAR" -C "$ETHEREUM_INSTALL_DIR" --strip-components=1
    rm "$ETHEREUM_CORE_TAR"

    ETHEREUM_DATA_DIR="$HOME/ethereum-data"
    mkdir -p "$ETHEREUM_DATA_DIR"
    ETHEREUM_CONF_FILE="$ETHEREUM_DATA_DIR/geth.conf"
    echo "server=1" > "$ETHEREUM_CONF_FILE"
    echo "rpcuser=<yourusername>" >> "$ETHEREUM_CONF_FILE"
    echo "rpcpassword=<yourpassword>" >> "$ETHEREUM_CONF_FILE"
    "$ETHEREUM_INSTALL_DIR/geth" --datadir="$ETHEREUM_DATA_DIR" --syncmode=full
    read -p "Press Enter to exit..."
    exit 0
# Check if the operating system is Windows
elif [[ "$(uname)" == "MINGW"* || "$(uname)" == "CYGWIN"* ]]; then
    # Ethereum installation directory
    ETHEREUM_INSTALL_DIR="C:/Ethereum"

    # Create Ethereum installation directory if it doesn't exist
    mkdir -p "$ETHEREUM_INSTALL_DIR"

    # Download and install Geth
    ETHEREUM_CORE_URL="https://gethstore.blob.core.windows.net/builds/geth-windows-amd64-<ethereum-core-version>.zip"
    ETHEREUM_CORE_ZIP="$ETHEREUM_INSTALL_DIR/geth.zip"

    echo "Downloading Geth..."
    curl -o "$ETHEREUM_CORE_ZIP" "$ETHEREUM_CORE_URL"

    echo "Extracting Geth..."
    unzip -q "$ETHEREUM_CORE_ZIP" -d "$ETHEREUM_INSTALL_DIR"
    rm "$ETHEREUM_CORE_ZIP"

    # Create Ethereum data directory
    ETHEREUM_DATA_DIR="C:/EthereumData"
    mkdir -p "$ETHEREUM_DATA_DIR"

    # Create Ethereum configuration file
    ETHEREUM_CONF_FILE="$ETHEREUM_DATA_DIR/geth.conf"
    echo "server=1" > "$ETHEREUM_CONF_FILE"
    echo "rpcuser=<yourusername>" >> "$ETHEREUM_CONF_FILE"
    echo "rpcpassword=<yourpassword>" >> "$ETHEREUM_CONF_FILE"

    # Start Geth
    "C:\Ethereum\geth.exe" --datadir="$ETHEREUM_DATA_DIR" --syncmode=full

    # Keep the terminal open
    read -p "Press Enter to exit..."
elif [[ "$(uname)" == "Darwin" ]]; then
    echo "[ChainGen] Deploying an Ethereum node on macOS."
    ETHEREUM_INSTALL_DIR="$HOME/ethereum"

    # Create installation directory
    mkdir -p "$ETHEREUM_INSTALL_DIR" || display_error_and_exit "Failed to create installation directory."

    # Download Geth tarball (replace the URL with the actual tarball URL)
    ETHEREUM_CORE_URL="https://gethstore.blob.core.windows.net/builds/geth-darwin-amd64-<ethereum-core-version>.tar.gz"
    ETHEREUM_CORE_TAR="$ETHEREUM_INSTALL_DIR/geth.tar.gz"
    echo "Downloading Geth..."
    curl -o "$ETHEREUM_CORE_TAR" "$ETHEREUM_CORE_URL" || display_error_and_exit "Failed to download Geth."

    echo "Extracting Geth..."
    tar -xzf "$ETHEREUM_CORE_TAR" -C "$ETHEREUM_INSTALL_DIR" --strip-components=1 || display_error_and_exit "Failed to extract Geth."
    rm "$ETHEREUM_CORE_TAR"

    ETHEREUM_DATA_DIR="$HOME/ethereum-data"
    mkdir -p "$ETHEREUM_DATA_DIR" || display_error_and_exit "Failed to create data directory."

    ETHEREUM_CONF_FILE="$ETHEREUM_DATA_DIR/geth.conf"
    echo "server=1" > "$ETHEREUM_CONF_FILE"
    echo "rpcuser=<yourusername>" >> "$ETHEREUM_CONF_FILE"
    echo "rpcpassword=<yourpassword>" >> "$ETHEREUM_CONF_FILE"

    "$ETHEREUM_INSTALL_DIR/geth" --datadir="$ETHEREUM_DATA_DIR" --syncmode=full || display_error_and_exit "Failed to start Geth."

    echo "Ethereum node deployed successfully."
    read -p "Press Enter to exit..."
    exit 0
else
    echo "Unsupported operating system."
fi
exit 1
