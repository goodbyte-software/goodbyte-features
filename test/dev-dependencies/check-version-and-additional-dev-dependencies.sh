#!/bin/bash
set -ex

source dev-container-features-test-lib
HardCodedNinjaVersion="1.10.2"

check "Is correct version installed" ninja --version | grep -q "$HardCodedNinjaVersion"
check "Did script install dtc" dtc --version

reportResults
