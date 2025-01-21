#!/bin/bash

set -ex

source dev-container-features-test-lib

check "gcc exists" arm-none-eabi-gcc --version
check "g++ exists" arm-none-eabi-g++ --version
check "as exists" arm-none-eabi-as --version
check "ld exists" arm-none-eabi-ld --version
check "objcopy exists" arm-none-eabi-objcopy --version
check "objdump exists" arm-none-eabi-objdump --version
check "gdb exists" arm-none-eabi-gdb --version

reportResults
