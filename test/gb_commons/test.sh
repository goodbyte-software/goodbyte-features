#!/bin/bash

# Function to check if a command exists
check_command() {
    if command -v "$1" &> /dev/null; then
        echo "$1 is installed."
    else
        echo "Error: $1 is not installed."
        exit 1
    fi
}

# Check for wget
check_command wget

# Check for unzip
check_command unzip

# Check for vim
check_command vim

# Check for libusb-1.0-0 library
if ldconfig -p | grep -q "libusb-1.0.so.0"; then
    echo "libusb-1.0-0 is installed."
else
    echo "Error: libusb-1.0-0 is not installed."
    exit 1
fi

echo "All tests passed: all required packages are installed."

