#!/bin/bash

# Check if the operating system is Linux
if [[ "$(uname)" == "Linux" ]]; then
    echo "[ChainGen] Deploying a node on linux."
    DOGECOIN_INSTALL_DIR="$HOME/dogecoin"

    mkdir -p "$DOGECOIN_INSTALL_DIR"

    DOGECOIN_CORE_URL="https://github.com/dogecoin/dogecoin/releases/download/v1.14.6/dogecoin-1.14.6-x86_64-linux-gnu.tar.gz"
    DOGECOIN_CORE_TAR="$DOGECOIN_INSTALL_DIR/dogecoin-core.tar.gz"

    echo "Downloading Dogecoin Core..."
    curl -L -o "$DOGECOIN_CORE_TAR" "$DOGECOIN_CORE_URL"

    echo "Extracting Dogecoin Core..."
    tar -xzf "$DOGECOIN_CORE_TAR" -C "$DOGECOIN_INSTALL_DIR" --strip-components=1
    rm "$DOGECOIN_CORE_TAR"
    DOGECOIN_DATA_DIR="$HOME/dogecoin-data"
    mkdir -p "$DOGECOIN_DATA_DIR"
    DOGECOIN_CONF_FILE="$DOGECOIN_DATA_DIR/bitcoin.conf"
    echo "server=1" > "$DOGECOIN_CONF_FILE"
    echo "rpcuser=yourusername" >> "$DOGECOIN_CONF_FILE"
    echo "rpcpassword=yourpassword" >> "$DOGECOIN_CONF_FILE"
    "$DOGECOIN_INSTALL_DIR/bin/dogecoin-qt" -datadir="$DOGECOIN_DATA_DIR"
    read -p "Press Enter to exit..."
    exit 0

# Check if the operating system is Windows
elif [[ "$(uname)" == "MINGW"* || "$(uname)" == "CYGWIN"* ]]; then
    # Dogecoin Core installation directory
    DOGECOIN_INSTALL_DIR="C:/Dogecoin"

    # Create Dogecoin installation directory if it doesn't exist
    mkdir -p "$DOGECOIN_INSTALL_DIR"

    # Download and install Dogecoin Core
    DOGECOIN_CORE_URL="https://github.com/dogecoin/dogecoin/releases/download/v1.14.6/dogecoin-1.14.6-win64.zip"
    DOGECOIN_CORE_ZIP="$DOGECOIN_INSTALL_DIR/dogecoin-core.zip"

    echo "Downloading Dogecoin Core..."
    curl -L -o "$DOGECOIN_CORE_ZIP" "$DOGECOIN_CORE_URL" 

    echo "Extracting Dogecoin Core..."
    unzip -q "$DOGECOIN_CORE_ZIP" -d "$DOGECOIN_INSTALL_DIR"
    rm "$DOGECOIN_CORE_ZIP"

    # Create Dogecoin data directory
    DOGECOIN_DATA_DIR="C:/DogecoinData"
    mkdir -p "$DOGECOIN_DATA_DIR"

    # Create Dogecoin configuration file
    DOGECOIN_CONF_FILE="$DOGECOIN_DATA_DIR/dogecoin.conf"
    echo "server=1" > "$DOGECOIN_CONF_FILE"
    echo "rpcuser=yourusername" >> "$DOGECOIN_CONF_FILE"
    echo "rpcpassword=yourpassword" >> "$DOGECOIN_CONF_FILE"

    # Start Dogecoin Core with pruned mode (adjust the size as needed)
    "C:\Dogecoin\dogecoin-1.14.6\bin\dogecoin-qt.exe" -datadir="$DOGECOIN_DATA_DIR"

    # Keep the terminal open
    read -p "Press Enter to exit..."

# macOS

elif [[ "$(uname)" == "Darwin" ]]; then
    echo "[ChainGen] Deploying a node on macOS."
    DOGECOIN_INSTALL_DIR="$HOME/bitcoin"

    # Create installation directory
    mkdir -p "$DOGECOIN_INSTALL_DIR" || display_error_and_exit "Failed to create installation directory."

    # Download Dogecoin Core tarball (replace the URL with the actual tarball URL)
    DOGECOIN_CORE_URL="https://bitcoincore.org/bin/bitcoin-core-26.0/bitcoin-26.0-x86_64-osx.tar.gz"
    DOGECOIN_CORE_TAR="$DOGECOIN_INSTALL_DIR/bitcoin-core.tar.gz"
    echo "Downloading Dogecoin Core..."
    curl -o "$DOGECOIN_CORE_TAR" "$DOGECOIN_CORE_URL" || display_error_and_exit "Failed to download Dogecoin Core."

    echo "Extracting Dogecoin Core..."
    tar -xzf "$DOGECOIN_CORE_TAR" -C "$DOGECOIN_INSTALL_DIR" --strip-components=1 || display_error_and_exit "Failed to extract Dogecoin Core."
    rm "$DOGECOIN_CORE_TAR"

    DOGECOIN_DATA_DIR="$HOME/bitcoin-data"
    mkdir -p "$DOGECOIN_DATA_DIR" || display_error_and_exit "Failed to create data directory."

    DOGECOIN_CONF_FILE="$DOGECOIN_DATA_DIR/dogecoin.conf"
    echo "server=1" > "$DOGECOIN_CONF_FILE"
    echo "rpcuser=yourusername" >> "$DOGECOIN_CONF_FILE"
    echo "rpcpassword=yourpassword" >> "$DOGECOIN_CONF_FILE"

    "$DOGECOIN_INSTALL_DIR/dogecoin-qt" -datadir="$DOGECOIN_DATA_DIR" || display_error_and_exit "Failed to start Dogecoin Core."

    echo "Dogecoin Core deployed successfully."
    read -p "Press Enter to exit..."
    exit 
else
    echo "Unsupported operating system."
fi
exit 1