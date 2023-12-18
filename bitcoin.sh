#!/bin/bash

# Check if the operating system is Linux
if [[ "$(uname)" == "Linux" ]]; then
    echo "[ChainGen] Deploying a node on linux."
    BITCOIN_INSTALL_DIR="$HOME/bitcoin"

    mkdir -p "$BITCOIN_INSTALL_DIR"

    BITCOIN_CORE_URL="https://bitcoincore.org/bin/bitcoin-core-26.0/bitcoin-26.0-x86_64-linux-gnu.tar.gz"
    BITCOIN_CORE_TAR="$BITCOIN_INSTALL_DIR/bitcoin-core.tar.gz"

    echo "Downloading Bitcoin Core..."
    curl -o "$BITCOIN_CORE_TAR" "$BITCOIN_CORE_URL"

    echo "Extracting Bitcoin Core..."
    tar -xzf "$BITCOIN_CORE_TAR" -C "$BITCOIN_INSTALL_DIR" --strip-components=1
    rm "$BITCOIN_CORE_TAR"
    BITCOIN_DATA_DIR="$HOME/bitcoin-data"
    mkdir -p "$BITCOIN_DATA_DIR"
    BITCOIN_CONF_FILE="$BITCOIN_DATA_DIR/bitcoin.conf"
    echo "server=1" > "$BITCOIN_CONF_FILE"
    echo "rpcuser=yourusername" >> "$BITCOIN_CONF_FILE"
    echo "rpcpassword=yourpassword" >> "$BITCOIN_CONF_FILE"
    "$BITCOIN_INSTALL_DIR/bin/bitcoin-qt" -datadir="$BITCOIN_DATA_DIR" -prune=2000
    read -p "Press Enter to exit..."
    exit 0
# Check if the operating system is Windows
elif [[ "$(uname)" == "MINGW"* || "$(uname)" == "CYGWIN"* ]]; then
    # Bitcoin Core installation directory
    BITCOIN_INSTALL_DIR="C:/Bitcoin"

    # Create Bitcoin installation directory if it doesn't exist
    mkdir -p "$BITCOIN_INSTALL_DIR"

    # Download and install Bitcoin Core
    BITCOIN_CORE_URL="https://bitcoincore.org/bin/bitcoin-core-26.0/bitcoin-26.0-win64.zip"
    BITCOIN_CORE_ZIP="$BITCOIN_INSTALL_DIR/bitcoin-core.zip"

    echo "Downloading Bitcoin Core..."
    curl -o "$BITCOIN_CORE_ZIP" "$BITCOIN_CORE_URL"

    echo "Extracting Bitcoin Core..."
    unzip -q "$BITCOIN_CORE_ZIP" -d "$BITCOIN_INSTALL_DIR"
    rm "$BITCOIN_CORE_ZIP"

    # Create Bitcoin data directory
    BITCOIN_DATA_DIR="C:/BitcoinData"
    mkdir -p "$BITCOIN_DATA_DIR"

    # Create Bitcoin configuration file
    BITCOIN_CONF_FILE="$BITCOIN_DATA_DIR/bitcoin.conf"
    echo "server=1" > "$BITCOIN_CONF_FILE"
    echo "rpcuser=yourusername" >> "$BITCOIN_CONF_FILE"
    echo "rpcpassword=yourpassword" >> "$BITCOIN_CONF_FILE"

    # Start Bitcoin Core with pruned mode (adjust the size as needed)
    "C:\Bitcoin\bitcoin-26.0\bin/bitcoin-qt.exe" -datadir="$BITCOIN_DATA_DIR" -prune=2000

    # Keep the terminal open
    read -p "Press Enter to exit..."
elif [[ "$(uname)" == "Darwin" ]]; then
    echo "[ChainGen] Deploying a node on macOS."
    BITCOIN_INSTALL_DIR="$HOME/bitcoin"

    # Create installation directory
    mkdir -p "$BITCOIN_INSTALL_DIR" || display_error_and_exit "Failed to create installation directory."

    # Download Bitcoin Core tarball (replace the URL with the actual tarball URL)
    BITCOIN_CORE_URL="https://bitcoincore.org/bin/bitcoin-core-26.0/bitcoin-26.0-x86_64-osx.tar.gz"
    BITCOIN_CORE_TAR="$BITCOIN_INSTALL_DIR/bitcoin-core.tar.gz"
    echo "Downloading Bitcoin Core..."
    curl -o "$BITCOIN_CORE_TAR" "$BITCOIN_CORE_URL" || display_error_and_exit "Failed to download Bitcoin Core."

    echo "Extracting Bitcoin Core..."
    tar -xzf "$BITCOIN_CORE_TAR" -C "$BITCOIN_INSTALL_DIR" --strip-components=1 || display_error_and_exit "Failed to extract Bitcoin Core."
    rm "$BITCOIN_CORE_TAR"

    BITCOIN_DATA_DIR="$HOME/bitcoin-data"
    mkdir -p "$BITCOIN_DATA_DIR" || display_error_and_exit "Failed to create data directory."

    BITCOIN_CONF_FILE="$BITCOIN_DATA_DIR/bitcoin.conf"
    echo "server=1" > "$BITCOIN_CONF_FILE"
    echo "rpcuser=yourusername" >> "$BITCOIN_CONF_FILE"
    echo "rpcpassword=yourpassword" >> "$BITCOIN_CONF_FILE"

    "$BITCOIN_INSTALL_DIR/bin/bitcoin-qt" -datadir="$BITCOIN_DATA_DIR" -prune=2000 || display_error_and_exit "Failed to start Bitcoin Core."

    echo "Bitcoin Core deployed successfully."
    read -p "Press Enter to exit..."
    exit 
else
    echo "Unsupported operating system."
fi
exit 1