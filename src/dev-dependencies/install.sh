#!/bin/bash

set -e

NINJA_URL="https://github.com/ninja-build/ninja/releases/download/v${NINJA_VERSION}/ninja-linux.zip"

#USER is not defined in the script, so it will be set to root - i leave it here for future development

# USERNAME="${USERNAME:-"${_REMOTE_USER:-"automatic"}"}"

# if [ "${USERNAME}" = "auto" ] || [ "${USERNAME}" = "automatic" ]; then
#     USERNAME=""
#     POSSIBLE_USERS=("vscode" "node" "codespace" "$(awk -v val=1000 -F ":" '$3==val{print $1}' /etc/passwd)")
#     for CURRENT_USER in "${POSSIBLE_USERS[@]}"; do
#         if id -u "${CURRENT_USER}" >/dev/null 2>&1; then
#             USERNAME=${CURRENT_USER}
#             break
#         fi
#     done
#     if [ "${USERNAME}" = "" ]; then
#         USERNAME=NON_ROOT
#     fi
# elif [ "${USERNAME}" = "none" ] || ! id -u "${USERNAME}" >/dev/null 2>&1; then
#     USERNAME=root
# fi

# export USERNAME_VAR="${USERNAME}"

PACKAGES_COMMON=(
    cmake
    gperf
    ccache
    dfu-util
    file
    make
    gcc
    gcc-multilib
    g++-multilib
    libsdl2-dev
    libmagic1
    libffi-dev
)

apt-get update
for PACKAGE in "${PACKAGES_COMMON[@]}"; do
apt-get -y install --no-install-recommends "${PACKAGE}"
done


if [ -n "$NINJA_URL" ]; then
    wget -P /tmp "$NINJA_URL"
    unzip -o /tmp/ninja-linux.zip -d /usr/local/bin
    chmod +x /usr/local/bin/ninja
    rm /tmp/ninja-linux.zip
else
    echo "Skipping Ninja installation (URL not provided)"
fi

if [ "$DEVICE_TREE_COMPILER" = true ]; then
    apt-get update && apt-get install -y device-tree-compiler
fi

