#!/bin/bash

# Check if the operating system is Linux
if [[ "$(uname)" == "Linux" ]]; then
    echo "[ChainGen] Deploying a Litecoin node on Linux."
    LITECOIN_INSTALL_DIR="$HOME/litecoin"

    mkdir -p "$LITECOIN_INSTALL_DIR"

    LITECOIN_CORE_URL="https://download.litecoin.org/litecoin-0.18.1/linux/litecoin-0.18.1-x86_64-linux-gnu.tar.gz"
    LITECOIN_CORE_TAR="$LITECOIN_INSTALL_DIR/litecoin-core.tar.gz"

    echo "Downloading Litecoin Core..."
    curl -o "$LITECOIN_CORE_TAR" "$LITECOIN_CORE_URL"

    echo "Extracting Litecoin Core..."
    tar -xzf "$LITECOIN_CORE_TAR" -C "$LITECOIN_INSTALL_DIR" --strip-components=1
    rm "$LITECOIN_CORE_TAR"

    LITECOIN_DATA_DIR="$HOME/litecoin-data"
    mkdir -p "$LITECOIN_DATA_DIR"
    LITECOIN_CONF_FILE="$LITECOIN_DATA_DIR/litecoin.conf"
    echo "server=1" > "$LITECOIN_CONF_FILE"
    echo "rpcuser=yourusername" >> "$LITECOIN_CONF_FILE"
    echo "rpcpassword=yourpassword" >> "$LITECOIN_CONF_FILE"
    "$LITECOIN_INSTALL_DIR/bin/litecoin-qt" -datadir="$LITECOIN_DATA_DIR" -prune=2000
    read -p "Press Enter to exit..."
    exit 0

# Check if the operating system is Windows
elif [[ "$(uname)" == "MINGW"* || "$(uname)" == "CYGWIN"* ]]; then
    # Litecoin Core installation directory
    LITECOIN_INSTALL_DIR="C:/Litecoin"

    # Create Litecoin installation directory if it doesn't exist
    mkdir -p "$LITECOIN_INSTALL_DIR"

    # Download and install Litecoin Core
    LITECOIN_CORE_URL="https://download.litecoin.org/litecoin-0.18.1/win/litecoin-0.18.1-win64.zip"
    LITECOIN_CORE_ZIP="$LITECOIN_INSTALL_DIR/litecoin-core.zip"

    echo "Downloading Litecoin Core..."
    curl -o "$LITECOIN_CORE_ZIP" "$LITECOIN_CORE_URL"

    echo "Extracting Litecoin Core..."
    unzip -q "$LITECOIN_CORE_ZIP" -d "$LITECOIN_INSTALL_DIR"
    rm "$LITECOIN_CORE_ZIP"

    # Create Litecoin data directory
    LITECOIN_DATA_DIR="C:/LitecoinData"
    mkdir -p "$LITECOIN_DATA_DIR"

    # Create Litecoin configuration file
    LITECOIN_CONF_FILE="$LITECOIN_DATA_DIR/litecoin.conf"
    echo "server=1" > "$LITECOIN_CONF_FILE"
    echo "rpcuser=yourusername" >> "$LITECOIN_CONF_FILE"
    echo "rpcpassword=yourpassword" >> "$LITECOIN_CONF_FILE"

    # Start Litecoin Core with pruned mode (adjust the size as needed)
    "C:\Litecoin\litecoin-0.18.1\bin/litecoin-qt.exe" -datadir="$LITECOIN_DATA_DIR" -prune=2000

    # Keep the terminal open
    read -p "Press Enter to exit..."

elif [[ "$(uname)" == "Darwin" ]]; then
    echo "[ChainGen] Deploying a Litecoin node on macOS."
    LITECOIN_INSTALL_DIR="$HOME/litecoin"

    # Create installation directory
    mkdir -p "$LITECOIN_INSTALL_DIR" || display_error_and_exit "Failed to create installation directory."

    # Download Litecoin Core tarball (replace the URL with the actual tarball URL)
    LITECOIN_CORE_URL="https://download.litecoin.org/litecoin-0.18.1/osx/litecoin-0.18.1-x86_64-osx.tar.gz"
    LITECOIN_CORE_TAR="$LITECOIN_INSTALL_DIR/litecoin-core.tar.gz"
    echo "Downloading Litecoin Core..."
    curl -o "$LITECOIN_CORE_TAR" "$LITECOIN_CORE_URL" || display_error_and_exit "Failed to download Litecoin Core."

    echo "Extracting Litecoin Core..."
    tar -xzf "$LITECOIN_CORE_TAR" -C "$LITECOIN_INSTALL_DIR" --strip-components=1 || display_error_and_exit "Failed to extract Litecoin Core."
    rm "$LITECOIN_CORE_TAR"

    LITECOIN_DATA_DIR="$HOME/litecoin-data"
    mkdir -p "$LITECOIN_DATA_DIR" || display_error_and_exit "Failed to create data directory."

    LITECOIN_CONF_FILE="$LITECOIN_DATA_DIR/litecoin.conf"
    echo "server=1" > "$LITECOIN_CONF_FILE"
    echo "rpcuser=yourusername" >> "$LITECOIN_CONF_FILE"
    echo "rpcpassword=yourpassword" >> "$LITECOIN_CONF_FILE"

    "$LITECOIN_INSTALL_DIR/bin/litecoin-qt" -datadir="$LITECOIN_DATA_DIR" -prune=2000 || display_error_and_exit "Failed to start Litecoin Core."

    echo "Litecoin Core deployed successfully."
    read -p "Press Enter to exit..."
    exit 
else
    echo "Unsupported operating system."
fi
exit 1
