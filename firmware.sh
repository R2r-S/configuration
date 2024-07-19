#!/bin/bash

# Set up locale directory
LOCALE_DIR="./locale"

# Export variables for gettext
export TEXTDOMAINDIR=$LOCALE_DIR
export TEXTDOMAIN=messages
export LANGUAGE

# Debugging - check if variables are set correctly
echo "LOCALE_DIR=$LOCALE_DIR"
echo "TEXTDOMAIN=$TEXTDOMAIN"
echo "LANGUAGE=$LANGUAGE"

# Translation function
function translate {
  gettext "$1"
}

# Script to install firmware packages

# Function to display a question and wait for the user's response
ask_question() {
    local answer
    printf "\e[33m%s\e[0m (y/n): " "$(translate "$1")"
    while true; do
        read -rsn1 answer
        if [[ $answer =~ ^[yYnN]$ ]]; then
            printf "%s " "$answer"  # print the answer without a newline
            break
        fi
    done
    echo ""  # move to a new line
    if [[ $answer == [Yy] ]]; then
        return 0
    else
        return 1
    fi
}

clear
printf "\e[34m%s\e[0m\n" "$(translate "Installing firmware packages")"

# Ask about INTEL WiFi drivers
if ask_question "Do you want to install INTEL WiFi drivers?"; then
    intel=true
fi
read -rsn1 -p "$(translate "Press Enter to continue...")"
clear
printf "\e[34m%s\e[0m\n" "$(translate "Installing firmware packages")"
# Ask about Broadcom drivers
if ask_question "Do you want to install Broadcom WiFi drivers?"; then
    broadcom=true
fi
read -rsn1 -p "$(translate "Press Enter to continue...")"
clear
printf "\e[34m%s\e[0m\n" "$(translate "Installing firmware packages")"
# Ask about NVIDIA drivers
if ask_question "Do you want to install NVIDIA drivers?"; then
    nvidia=true
fi
read -rsn1 -p "$(translate "Press Enter to continue...")"
clear
printf "\e[34m%s\e[0m\n" "$(translate "Installing firmware packages")"
# Ask about non-free drivers
if ask_question "Do you want to install non-free drivers?"; then
    nonfree=true
fi
read -rsn1 -p "$(translate "Press Enter to continue...")"
clear
printf "\e[34m%s\e[0m\n" "$(translate "Installing firmware packages")"

# Install the appropriate firmware packages based on the responses
if [[ $intel ]]; then
    echo "$(translate "Installing INTEL WiFi drivers...")"
    apt install -y firmware-iwlwifi
fi

if [[ $broadcom ]]; then
    echo "$(translate "Installing Broadcom WiFi drivers...")"
    apt install -y firmware-brcm80211
fi

if [[ $nvidia ]]; then
    echo "$(translate "Installing NVIDIA drivers...")"
    apt install -y linux-headers-amd64 nvidia-driver firmware-misc-nonfree
fi

if [[ $nonfree ]]; then
    echo "$(translate "Installing non-free drivers...")"
    apt install -y firmware-linux-nonfree firmware-misc-nonfree
fi

if [[ $nonfree ]]; then
    echo "$(translate "Installing firmware-realtek drivers...")"
    apt install -y firmware-realtek
fi

echo "$(translate "Firmware installation completed.")"
