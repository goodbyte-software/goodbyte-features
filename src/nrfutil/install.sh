#!/bin/bash
NCS_VERSION="2.7.0"
NRFUTIL_URL="https://developer.nordicsemi.com/.pc-tools/nrfutil/x64-linux/nrfutil"

wget -q "$NRFUTIL_URL"

if [ $? -ne 0 ]; then
    echo "Error: Downloading nrfutil failed!"
    exit 1
else
    echo "nrfutil downloaded successfully."
fi

mv nrfutil /usr/local/bin

chmod +x /usr/local/bin/nrfutil

nrfutil install nrf5sdk-tools
nrfutil install device
nrfutil install toolchain-manager

nrfutil toolchain-manager install --ncs-version v${NCS_VERSION}

if [ $? -ne 0 ]; then
    echo "Error: Installing NCS version v${NCS_VERSION} failed!"
    exit 1
else
    echo "NCS version v${NCS_VERSION} installed successfully."
fi


nrfutil toolchain-manager env --ncs-version v${NCS_VERSION} --as-script > ~/.zephyrrc
