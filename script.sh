Here's an example of a Bash script that could help you install asdf and a Node.js version on a Linux-based system, which should help you deploy a node from it. Remember to adjust the Node.js version in this script according to your specific needs.

```bash
#!/bin/bash

echo "Checking if git is installed"
which git > /dev/null
if [ $? -ne 0 ]
then
   echo "Git is not installed."
   echo "Installing Git..."
   sudo apt-get install -y git
fi

echo "Checking if curl is installed"
which curl > /dev/null
if [ $? -ne 0 ]
then
   echo "Curl is not installed."
   echo "Installing Curl..."
   sudo apt-get install -y curl
fi

echo "Cloning asdf from GitHub"
git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.8.0

echo "Setting up asdf environment variables"
echo -e '\n. $HOME/.asdf/asdf.sh' >> ~/.bashrc
echo -e '\n. $HOME/.asdf/completions/asdf.bash' >> ~/.bashrc
source ~/.bashrc

echo "Install a plugin to manage Node.js"
asdf plugin-add nodejs https://github.com/asdf-vm/asdf-nodejs.git

echo "Checking if gpg is installed"
which gpg > /dev/null
if [ $? -ne 0 ]
then
   echo "Gpg is not installed."
   echo "Installing Gpg..."
   sudo apt-get install -y gpg
fi

echo "Import the keys needed by Node.js plugin"
bash ~/.asdf/plugins/nodejs/bin/import-release-team-keyring

echo "Install Node.js"
# Replace 14.0.0 with the Node.js version that you want
asdf install nodejs 14.0.0
asdf global nodejs 14.0.0

echo "Blockchain node was created"
```

Before running the script, make sure it has execute permissions: use the command `chmod +x script_name.sh`. You would replace "script_name.sh" with the filename you gave the script when you saved it.

Please be sure to replace '14.0.0' in the last lines with the version of Node.js you desire.

Read more about asdf here: https://asdf-vm.com/#/core-manage-asdf-vm?id=install
