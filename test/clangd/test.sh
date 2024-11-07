#!/bin/bash


if [[ ! -x "/usr/bin/clangd" ]]; then
    echo "Error: clangd is not installed in /usr/bin/clangd"
    exit 1
else
    echo "clangd binary is present in /usr/bin"
fi


CLANGD_VERSION=$(/usr/bin/clangd --version)
if [[ $CLANGD_VERSION == *"clangd version 19.1.0"* ]]; then
    echo "clangd is working and returns the expected version: $CLANGD_VERSION"
else
    echo "Error: clangd returned an unexpected version: $CLANGD_VERSION"
    exit 1
fi

echo "All tests passed successfully."

