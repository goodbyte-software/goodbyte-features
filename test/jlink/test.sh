#!/bin/bash

set -ex

source dev-container-features-test-lib

check "SEGGER JFlashExe exists" test -f /usr/bin/JFlashExe
check "SEGGER JFlashExe exists" test -f /usr/bin/JFlashExe

reportResults

