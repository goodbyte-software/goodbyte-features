#!/bin/bash

# Ensure the script exits if any command fails
set -e

# 1. Test that essential packages are installed
check_packages_installed() {
    echo "Testing if essential packages are installed..."
    for package in wget unzip vim libusb-1.0-0; do
        dpkg -s $package >/dev/null 2>&1 && echo "$package installed." || { echo "$package not installed!"; exit 1; }
    done
}

# 2. Test if nrfutil was downloaded and made executable
check_nrfutil_installed() {
    echo "Testing if nrfutil was downloaded and made executable..."
    if [[ -x "/usr/local/bin/nrfutil" ]]; then
        echo "nrfutil is installed and executable."
    else
        echo "nrfutil is not installed or not executable!"
        exit 1
    fi
}

# 3. Test if nrf-command-line-tools were installed and symlinked
check_nrf_command_line_tools() {
    echo "Testing if nrf-command-line-tools were installed and symlinked..."
    if [[ -L "/usr/local/bin/nrfjprog" && -x "/usr/local/bin/nrfjprog" ]]; then
        echo "nrfjprog symlink created and executable."
    else
        echo "nrfjprog symlink not found or not executable!"
        exit 1
    fi

    if [[ -L "/usr/local/bin/mergehex" && -x "/usr/local/bin/mergehex" ]]; then
        echo "mergehex symlink created and executable."
    else
        echo "mergehex symlink not found or not executable!"
        exit 1
    fi
}

# 4. Test if Zephyr environment setup script is created
check_zephyr_env() {
    echo "Testing if Zephyr environment setup script was created..."
    if [[ -f "$HOME/.zephyrrc" ]]; then
        echo "Zephyr environment setup script (.zephyrrc) exists."
    else
        echo "Zephyr environment setup script not found!"
        exit 1
    fi
}

# Execute tests
check_packages_installed
check_nrfutil_installed
check_nrf_command_line_tools
check_zephyr_env

echo "All tests passed successfully."

