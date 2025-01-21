#!/bin/bash
set -ex

source dev-container-features-test-lib
HardCodedVersion="0.16.8"
HardCodedArchitecture="arm"

check "NCS_toolchain" test -d "$HOME/.local/zephyr-sdk-${HardCodedVersion}"
check "Architecture" ls -d "$HOME/.local/zephyr-sdk-${HardCodedVersion}/${HardCodedArchitecture}"* >/dev/null 2>&1
reportResults
