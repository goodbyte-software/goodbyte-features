#!/bin/bash

# Test 1: Check if JLink directory exists in /opt/SEGGER
if [[ -d "/opt/SEGGER/JLink" ]]; then
    echo "JLink installation directory found in /opt/SEGGER."
else
    echo "Error: JLink directory not found in /opt/SEGGER."
    exit 1
fi

# Test 2: Check if nrf-command-line-tools were installed in /opt
if [[ -d "/opt/nrf-command-line-tools" ]]; then
    echo "nrf-command-line-tools directory found in /opt."
else
    echo "Error: nrf-command-line-tools directory not found in /opt."
    exit 1
fi

# Test 3: Check if symbolic link for nrfjprog exists and points to the correct binary
if [[ -L "/usr/local/bin/nrfjprog" && "$(readlink /usr/local/bin/nrfjprog)" == "/opt/nrf-command-line-tools/bin/nrfjprog" ]]; then
    echo "Symbolic link for nrfjprog is correctly set."
else
    echo "Error: Symbolic link for nrfjprog is missing or incorrect."
    exit 1
fi

# Test 4: Check if symbolic link for mergehex exists and points to the correct binary
if [[ -L "/usr/local/bin/mergehex" && "$(readlink /usr/local/bin/mergehex)" == "/opt/nrf-command-line-tools/bin/mergehex" ]]; then
    echo "Symbolic link for mergehex is correctly set."
else
    echo "Error: Symbolic link for mergehex is missing or incorrect."
    exit 1
fi

echo "All tests passed: nRF Command Line Tools and dependencies are installed correctly."

