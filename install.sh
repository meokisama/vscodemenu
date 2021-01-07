#!/bin/bash

# Install python3-nautilus
echo "Installing python3-nautilus..."
if type "pacman" > /dev/null 2>&1
then
    sudo pacman -S --noconfirm python3-nautilus
elif type "apt-get" > /dev/null 2>&1
then
    installed=`apt list --installed python3-nautilus -qq 2> /dev/null`
    if [ -z "$installed" ]
    then
        sudo apt-get install -y python3-nautilus
    else
        echo "python3-nautilus is already installed."
    fi
elif type "dnf" > /dev/null 2>&1
then
    installed=`dnf list --installed nautilus-python 2> /dev/null`
    if [ -z "$installed" ]
    then
        sudo dnf install -y nautilus-python
    else
        echo "nautilus-python is already installed."
    fi
else
    echo "Failed to find python3-nautilus, please install it manually."
fi

# Remove previous version and setup folder
echo "Removing previous version (if found)..."
mkdir -p ~/.local/share/nautilus-python/extensions
rm -f ~/.local/share/nautilus-python/extensions/VSCodeExtension.py
rm -f ~/.local/share/nautilus-python/extensions/code-nautilus.py
rm -f ~/.local/share/nautilus-python/extensions/vscodemenu.py

# Download and install the extension
echo "Downloading newest version...\n"
wget --show-progress -q -O ~/.local/share/nautilus-python/extensions/vscodemenu.py https://raw.githubusercontent.com/meokisama/vscodemenu/master/vscodemenu.py

# Restart nautilus
echo "Restarting nautilus...\n"
nautilus -q

echo "Installation Complete\n"
