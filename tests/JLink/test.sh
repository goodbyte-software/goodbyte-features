#!/bin/bash

set -ex

source dev-container-features-test-lib

check "SEGGER JFlashExe exists" test -f /opt/SEGGER/JLink/JFlashExe

reportResults

