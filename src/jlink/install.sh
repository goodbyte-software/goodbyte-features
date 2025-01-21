#!/bin/bash

set -e


apt-get -y update
apt-get install --only-upgrade tar
apt install libusb-1.0-0

convert_version_format() {
    local version="${1:-$VERSION}"  
    version="${version//./}"
    echo "$version"
}


JLINK_VERSION=$(convert_version_format "$VERSION")
JLINK_URL="https://www.segger.com/downloads/jlink/JLink_Linux_V${JLINK_VERSION}_x86_64.tgz"


if [ -n "$JLINK_URL" ]; then

    TEMP_DIR=$(mktemp -d)
    cd $TEMP_DIR


    wget --post-data "accept_license_agreement=accepted" "$JLINK_URL" || { echo "Download error"; exit 1; }

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
