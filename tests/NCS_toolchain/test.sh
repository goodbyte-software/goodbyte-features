#!/bin/bash

set -ex

source dev-container-features-test-lib

check "Is remote user valid" test -f /home/${USERNAME}

check "West validation" west --version

check "Python3 validation" which python3

check "Pip3 validation" which pip3

check "Validate toolchain path and version" test -f home/${USERNAME}/.local/zephyr-sdk-${VERSION}

check "Validate toolchain architecture" test -f /home/${USERNAME}/.local/zephyr-sdk-${VERSION}/${ARCHITECTURE}*

check "Nrf-command-line-tools validation" nrfjprog --version 

reportResults
