#!/bin/bash
set -ex

source dev-container-features-test-lib
expectedVersion="14.2"

check "Is correct version installed" arm-none-eabi-gcc --version | grep -q "$expectedVersion"

reportResults
