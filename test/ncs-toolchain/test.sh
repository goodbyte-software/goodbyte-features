#!/bin/bash

set -ex

source dev-container-features-test-lib


check "West validation" west --version

check "Python3 validation" which python3

check "Pip3 validation" which pip3

reportResults
