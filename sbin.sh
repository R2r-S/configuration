#!/bin/bash

# Set up locale directory
LOCALE_DIR="./locale"

# Export variables for gettext
export TEXTDOMAINDIR=$LOCALE_DIR
export TEXTDOMAIN=messages
export LANGUAGE

# Translation function
function translate {
  gettext "$1"
}

# Script to add /sbin to the PATH variable and to the user's .bashrc file

# Add /sbin to the PATH variable temporarily for the current session
export PATH=$PATH:/sbin
echo "$(translate "Added /sbin to the PATH variable for the current session.")"

# Ask for the username
read -p "$(translate "Enter the username for whom you want to add /sbin to PATH: ")" username

# Check if the user exists
if id "$username" &>/dev/null; then
    echo "$(translate "User $username exists.")"

    # Path to the .bashrc file in the user's home directory
    user_home=$(eval echo ~$username)
    bashrc_file="$user_home/.bashrc"

    # Check if the entry already exists in the .bashrc file
    if grep -Fxq 'PATH="$PATH:/sbin"' "$bashrc_file"; then
        echo "$(translate "The entry PATH=\"$PATH:/sbin\" already exists in the $bashrc_file file.")"
    else
        # Add the entry at the end of the .bashrc file
        echo 'PATH="$PATH:/sbin"' >> "$bashrc_file"
        echo "$(translate "Added PATH=\"$PATH:/sbin\" to the $bashrc_file file.")"
    fi
else
    echo "$(translate "User $username does not exist. Check the username and try again.")"
fi
