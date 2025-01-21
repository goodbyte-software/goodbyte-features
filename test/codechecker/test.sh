#!/bin/bash

set -ex

source dev-container-features-test-lib

check "CodeChecker exists" CodeChecker version

reportResults

