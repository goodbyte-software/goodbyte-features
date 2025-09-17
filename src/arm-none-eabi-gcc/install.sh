#!/bin/bash

set -euo pipefail

GCC_TOOLCHAIN_NAME=arm-gnu-toolchain-$VERSION.rel1-x86_64-arm-none-eabi

download_arm_gcc() {
    mkdir -p /usr/share/$GCC_TOOLCHAIN_NAME
    wget https://developer.arm.com/-/media/Files/downloads/gnu/$VERSION.rel1/binrel/${GCC_TOOLCHAIN_NAME}.tar.xz -O /tmp/$GCC_TOOLCHAIN_NAME
    tar xvf /tmp/$GCC_TOOLCHAIN_NAME -C /usr/share/$GCC_TOOLCHAIN_NAME --strip-components=1
    rm /tmp/$GCC_TOOLCHAIN_NAME
}

install_arm_gcc() {
    for exe in /usr/share/$GCC_TOOLCHAIN_NAME/bin/*; do
        ln -s $exe /usr/bin/$(basename $exe)
    done

    # gdb-multiarch supports importing python modules
    sudo apt-get install -y gdb-multiarch
    ln -sf `which gdb-multiarch` /usr/bin/arm-none-eabi-gdb
}

download_arm_gcc
install_arm_gcc
