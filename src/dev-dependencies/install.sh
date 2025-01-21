#!/bin/bash

set -euo pipefail

#Some packages are installed with common-utils feature 
PACKAGES_COMMON=(
    cmake
    gperf
    ccache
    dfu-util
    file
    make
    gcc
    gcc-multilib
    g++-multilib
    libsdl2-dev
    libmagic1
    libffi-dev
)

apt-get update
for PACKAGE in "${PACKAGES_COMMON[@]}"; do
apt-get -y install --no-install-recommends "${PACKAGE}"
done

NINJA_URL="https://github.com/ninja-build/ninja/releases/download/v${NINJAVERSION}/ninja-linux.zip"
if [ -n "$NINJA_URL" ]; then
    wget -P /tmp "$NINJA_URL"
    unzip -o /tmp/ninja-linux.zip -d /usr/local/bin
    chmod +x /usr/local/bin/ninja
    rm /tmp/ninja-linux.zip
else
    echo "Skipping ninja - URL not provided"
fi

if [ "$INSTALLDEVICETREECOMPILER" = true ]; then
    apt-get update && apt-get install -y device-tree-compiler
else
    echo "Skipping device tree compiler"
fi

