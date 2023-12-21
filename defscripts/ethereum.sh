#!/bin/bash

# Check if the operating system is Linux
if [[ "$(uname)" == "Linux" ]]; then
    # Ethereum Nice Node installation directory
    ETH_INSTALL_DIR="$HOME/Ethereum"
    
    # Create Ethereum installation directory if it doesn't exist
    mkdir -p "$ETH_INSTALL_DIR"
    
    # Download and install Ethereum Nice Node
    echo "Downloading Ethereum NiceNode..."
    curl -L "https://github.com/NiceNode/nice-node/releases/download/v4.7.3-alpha/NiceNode-4.7.3-alpha.AppImage" -o "$ETH_INSTALL_DIR/NiceNode.AppImage"
    
    # Add execute permission
    chmod +x "$ETH_INSTALL_DIR/NiceNode.AppImage"
    
    echo "Running NiceNode..."
    "$ETH_INSTALL_DIR/NiceNode.AppImage"
    
    echo "NiceNode is installed in $ETH_INSTALL_DIR"
    echo "Waiting for NiceNode to start..."
    
    read -p "Press Enter to exit..."
    exit 0
    
    # Check if the operating system is Windows
elif [[ "$(uname)" == "MINGW"* || "$(uname)" == "CYGWIN"* ]]; then
    # Ethereum Nice Node installation directory
    ETH_INSTALL_DIR="C:/Ethereum"
    
    # Create Ethereum installation directory if it doesn't exist
    mkdir -p "$ETH_INSTALL_DIR"
    
    # Download and install Ethereum Nice Node
    echo "Downloading Ethereum NiceNode..."
    curl -L "https://github.com/NiceNode/nice-node/releases/download/v4.7.3-alpha/NiceNode-Setup-4.7.3-alpha.exe" -o "$ETH_INSTALL_DIR/NiceNode.exe"
    
    echo "Running NiceNode..."
    "$ETH_INSTALL_DIR/NiceNode.exe"
    
    echo "NiceNode is installed in $ETH_INSTALL_DIR"
    echo "Waiting for NiceNode to start..."
    
    read -p "Press Enter to exit..."
    exit 0
    
elif [[ "$(uname)" == "Darwin" ]]; then

	# Ethereum Nice Node installation directory
	ETH_INSTALL_DIR="$HOME/Ethereum"
	
	# Create Ethereum installation directory if it doesn't exist
	mkdir -p "$ETH_INSTALL_DIR"
	
	# Download and install Ethereum Nice Node
	echo "Downloading Ethereum NiceNode..."
	curl -L "https://github.com/NiceNode/nice-node/releases/download/v4.7.3-alpha/NiceNode-4.7.3-alpha-arm64.dmg" -o "$ETH_INSTALL_DIR/NiceNode.dmg"
	
	# Mount the DMG file
	hdiutil attach "$ETH_INSTALL_DIR/NiceNode.dmg"
	
	# Copy the app to the Applications directory
	cp -R "/Volumes/NiceNode/NiceNode.app" "/Applications/"
	
	# Unmount the DMG file
	hdiutil detach "/Volumes/NiceNode"
	
	echo "NiceNode is installed in /Applications"
	echo "Waiting for NiceNode to start..."
	
	read -p "Press Enter to exit..."
	exit 0

else
    echo "Unsupported operating system."
fi
exit 1
