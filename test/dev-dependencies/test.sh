#!/bin/bash

set -ex

source dev-container-features-test-lib

check "Cmake exists" cmake --version
check "Gperf exists" gperf --version
check "Ccache exists" ccache --version
check "Dfu-util exists" dfu-util --version
check "File exists" file --version
check "Make exists" make --version
check "Gcc exists" gcc --version
check "G++ exists" g++ --version

reportResults

