#!/bin/bash

NCS_VERSION="2.7.0"
NRFUTIL_URL="https://developer.nordicsemi.com/.pc-tools/nrfutil/x64-linux/nrfutil"
NCLT_URL="https://nsscprodmedia.blob.core.windows.net/prod/software-and-other-downloads/desktop-software/nrf-command-line-tools/sw/versions-10-x-x/10-24-0/nrf-command-line-tools-10.24.0_linux-amd64.tar.gz"

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

if [ -n "$NCLT_URL" ]; then

    TEMP_DIR=$(mktemp -d)
    cd $TEMP_DIR


    wget -qO- "$NCLT_URL" | tar -xz || { echo "Download error"; exit 1; }

    if [ -d ./nrf-command-line-tools ]; then
        cp -r ./nrf-command-line-tools /opt
        ln -sf /opt/nrf-command-line-tools/bin/nrfjprog /usr/local/bin/nrfjprog
        ln -sf /opt/nrf-command-line-tools/bin/mergehex /usr/local/bin/mergehex
    else
        echo "nrf-command-line-tools not found!"
    fi


    cd ~
    rm -rf $TEMP_DIR
else
    echo "Skipping nRF Command Line Tools installation (URL not provided)"
fi
