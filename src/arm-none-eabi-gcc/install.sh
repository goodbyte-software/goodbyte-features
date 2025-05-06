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
    # gdb-multiarch supports importing python modules
    sudo apt-get install -y gdb-multiarch
    ln -sf `which gdb-multiarch` /usr/bin/arm-none-eabi-gdb

    ln -s /usr/share/$GCC_TOOLCHAIN_NAME/bin/arm-none-eabi-gcc /usr/bin/arm-none-eabi-gcc
    ln -s /usr/share/$GCC_TOOLCHAIN_NAME/bin/arm-none-eabi-g++ /usr/bin/arm-none-eabi-g++
    ln -s /usr/share/$GCC_TOOLCHAIN_NAME/bin/arm-none-eabi-ar /usr/bin/arm-none-eabi-ar
    ln -s /usr/share/$GCC_TOOLCHAIN_NAME/bin/arm-none-eabi-as /usr/bin/arm-none-eabi-as
    ln -s /usr/share/$GCC_TOOLCHAIN_NAME/bin/arm-none-eabi-ld /usr/bin/arm-none-eabi-ld
    ln -s /usr/share/$GCC_TOOLCHAIN_NAME/bin/arm-none-eabi-strip /usr/bin/arm-none-eabi-strip
    ln -s /usr/share/$GCC_TOOLCHAIN_NAME/bin/arm-none-eabi-size /usr/bin/arm-none-eabi-size
    ln -s /usr/share/$GCC_TOOLCHAIN_NAME/bin/arm-none-eabi-objcopy /usr/bin/arm-none-eabi-objcopy
    ln -s /usr/share/$GCC_TOOLCHAIN_NAME/bin/arm-none-eabi-objdump /usr/bin/arm-none-eabi-objdump
    ln -s /usr/share/$GCC_TOOLCHAIN_NAME/bin/arm-none-eabi-nm /usr/bin/arm-none-eabi-nm
}

download_arm_gcc
install_arm_gcc
