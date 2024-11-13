#!/bin/bash

NCS_VERSION="2.7.0"
NRFUTIL_URL="https://developer.nordicsemi.com/.pc-tools/nrfutil/x64-linux/nrfutil"
NCLT_URL="https://nsscprodmedia.blob.core.windows.net/prod/software-and-other-downloads/desktop-software/nrf-command-line-tools/sw/versions-10-x-x/10-24-0/nrf-command-line-tools-10.24.0_linux-amd64.tar.gz"

apt-get -y update
apt install libusb-1.0-0
if [ -n "$NCLT_URL" ]; then

    TEMP_DIR=$(mktemp -d)
    cd $TEMP_DIR


    wget -qO- "$NCLT_URL" | tar -xz || { echo "Download error"; exit 1; }


    if [ -f JLink_*.tgz ]; then
        mkdir -p /opt/SEGGER
        tar -xzf JLink_*.tgz -C /opt/SEGGER
        mv /opt/SEGGER/JLink* /opt/SEGGER/JLink
    else
        echo "JLink package not found!"
    fi
    
    cd ~
    rm -rf $TEMP_DIR
fi
