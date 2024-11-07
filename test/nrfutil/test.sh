#!/bin/bash

NCS_VERSION="2.7.0"

# Test 1: Check if nrfutil exists in /usr/local/bin and is executable
if [[ -x "/usr/local/bin/nrfutil" ]]; then
    echo "nrfutil is installed and executable."
else
    echo "Error: nrfutil is not installed in /usr/local/bin or is not executable."
    exit 1
fi

# Test 2: Verify that nrf5sdk-tools, device, and toolchain-manager are installed
# Check if `nrfutil` lists them as installed (assuming `nrfutil list` lists installed packages)
if nrfutil list | grep -q "nrf5sdk-tools"; then
    echo "nrf5sdk-tools is installed successfully."
else
    echo "Error: nrf5sdk-tools is not installed."
    exit 1
fi

if nrfutil list | grep -q "device"; then
    echo "Device package is installed successfully."
else
    echo "Error: Device package is not installed."
    exit 1
fi

if nrfutil list | grep -q "toolchain-manager"; then
    echo "toolchain-manager is installed successfully."
else
    echo "Error: toolchain-manager is not installed."
    exit 1
fi

# Test 3: Verify NCS version is installed
if nrfutil toolchain-manager list | grep -q "v${NCS_VERSION}"; then
    echo "NCS version v${NCS_VERSION} is installed successfully."
else
    echo "Error: NCS version v${NCS_VERSION} is not installed."
    exit 1
fi

# Test 4: Check if the environment setup script ~/.zephyrrc is created
if [[ -f "$HOME/.zephyrrc" ]]; then
    echo "Environment setup script ~/.zephyrrc created successfully."
else
    echo "Error: Environment setup script ~/.zephyrrc not found."
    exit 1
fi

echo "All tests passed: nrfutil and dependencies are installed and configured correctly."

