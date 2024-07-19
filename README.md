# Debian Configuration Scripts

This repository contains a collection of Bash scripts for configuring a Debian-based system. These scripts are designed to help with various system setups and configurations.

## Scripts

Here is a list of available scripts and their purposes:

- `beep.sh`: Disables the beep sound on logout.
- `bluetooth.sh`: Installs necessary Bluetooth packages.
- `firmware.sh`: Installs firmware packages for various drivers (Intel, Broadcom, NVIDIA, non-free).
- `install.sh`: Main script to run various configurations interactively.
- `lang.sh`: Configures the system language.
- `repo.sh`: Installs `software-properties-common` for managing repositories.
- `sbin.sh`: Adds `/sbin` to the `PATH` variable for a specified user.

## Installation

git clone https://github.com/R2r-S/configuration.git

cd configuration

./install


Running Individual Scripts

You can also run individual scripts directly. For example, to disable the beep sound:


./beep.sh

Translation

The scripts support both English and Polish languages. The language is detected automatically based on the system settings. If the detected language is not supported, the default language is English.
Contributions

Feel free to fork this repository and contribute by submitting pull requests. Any improvements or suggestions are welcome!
License

This project is licensed under the MIT License - see the LICENSE file for details.

Author

    Artur Stachera - R2r-S
