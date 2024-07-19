#!/bin/bash

# Set up locale directory
LOCALE_DIR="./locale"

# Detect system language
LANGUAGE=$(locale | grep LANG | cut -d= -f2 | cut -d_ -f1)

# Set default language if detected language is not supported
if [[ "$LANGUAGE" != "pl" && "$LANGUAGE" != "en" ]]; then
  LANGUAGE="en"
fi

# Export variables for gettext
export TEXTDOMAINDIR=$LOCALE_DIR
export TEXTDOMAIN=messages
export LANGUAGE

# Translation function
function translate {
  gettext "$1"
}

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

# User questions
clear
printf "\e[34m%s\e[0m\n" "$(translate 'Debian Configuration')"

if ask_question "Do you want to configure the /sbin directory?"; then
    sbin=true
fi
if [[ $sbin ]]; then
    ./sbin.sh
fi
read -rsn1 -p "$(translate 'Press Enter to continue...')"
clear
printf "\e[34m%s\e[0m\n" "$(translate 'Debian Configuration')"

if ask_question "Do you want to disable the 'beep' sound (on logout)?"; then
    beep=true
fi
read -rsn1 -p "$(translate 'Press Enter to continue...')"

clear
printf "\e[34m%s\e[0m\n" "$(translate 'Debian Configuration')"

if ask_question "Do you want to configure Bluetooth?"; then
    bluetooth=true
fi
read -rsn1 -p "$(translate 'Press Enter to continue...')"
clear
printf "\e[34m%s\e[0m\n" "$(translate 'Debian Configuration')"

if ask_question "Do you want to configure repository addition (software-properties)?"; then
    repo=true
fi
read -rsn1 -p "$(translate 'Press Enter to continue...')"
clear
printf "\e[34m%s\e[0m\n" "$(translate 'Debian Configuration')"

if ask_question "Do you want to install drivers?"; then
    firmware=true
fi
read -rsn1 -p "$(translate 'Press Enter to continue...')"
clear
printf "\e[34m%s\e[0m\n" "$(translate 'Debian Configuration')"

if ask_question "Do you want to configure the system language?"; then
    user=true
fi
if [[ $user ]]; then
    ./lang.sh
fi
read -rsn1 -p "$(translate 'Press Enter to continue...')"
clear

# Run the appropriate scripts
if [[ $firmware ]]; then
    ./firmware.sh
fi

if [[ $beep ]]; then
    ./beep.sh
fi

if [[ $bluetooth ]]; then
    ./bluetooth.sh
fi

if [[ $repo ]]; then
    ./repo.sh
fi

echo "$(translate 'Successfully completed. Please restart your computer.')"
