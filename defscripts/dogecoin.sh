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
	# Dogecoin Core installation directory
	DOGECOIN_INSTALL_DIR="$HOME/Dogecoin"
	
	# Create Dogecoin installation directory if it doesn't exist
	mkdir -p "$DOGECOIN_INSTALL_DIR"
	
	# Download and install Dogecoin Core
	DOGECOIN_CORE_URL="https://github.com/dogecoin/dogecoin/releases/download/v1.14.6/dogecoin-1.14.6-osx-signed.dmg"
	DOGECOIN_CORE_DMG="$DOGECOIN_INSTALL_DIR/dogecoin-core.dmg"
	
	echo "Downloading Dogecoin Core..."
	curl -L -o "$DOGECOIN_CORE_DMG" "$DOGECOIN_CORE_URL"
	
	# Mount the DMG file
	hdiutil attach "$DOGECOIN_CORE_DMG"
	
	# Copy the Dogecoin Core app to the Applications directory
	cp -R "/Volumes/Dogecoin Core/Dogecoin-Qt.app" "/Applications/"
	
	# Unmount the DMG file
	hdiutil detach "/Volumes/Dogecoin Core"
	
	# Create Dogecoin data directory
	DOGECOIN_DATA_DIR="$HOME/Library/Application Support/Dogecoin"
	mkdir -p "$DOGECOIN_DATA_DIR"
	
	# Create Dogecoin configuration file
	DOGECOIN_CONF_FILE="$DOGECOIN_DATA_DIR/dogecoin.conf"
	echo "server=1" > "$DOGECOIN_CONF_FILE"
	echo "rpcuser=yourusername" >> "$DOGECOIN_CONF_FILE"
	echo "rpcpassword=yourpassword" >> "$DOGECOIN_CONF_FILE"
	
	echo "Dogecoin Core is installed in /Applications"
	echo "Starting Dogecoin Core..."
	
	# Start Dogecoin Core
	open -a "/Applications/Dogecoin-Qt.app" --args -datadir="$DOGECOIN_DATA_DIR"
	
	# Keep the terminal open
	read -p "Press Enter to exit..."
	exit 0

else
    echo "Unsupported operating system."
fi
exit 1