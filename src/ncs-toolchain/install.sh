#!/bin/bash
# Installation made according to: https://docs.nordicsemi.com/bundle/ncs-latest/page/nrf/installation/install_ncs.html
set -e

NRFUTIL_URL="https://files.nordicsemi.com/artifactory/swtools/external/nrfutil/executables/x86_64-unknown-linux-gnu/nrfutil"
ZEPHYR_SDK_URL="https://github.com/zephyrproject-rtos/sdk-ng/releases/download/v${VERSION}/zephyr-sdk-${VERSION}_linux-x86_64.tar.xz"
ZEPHYR_SDK_SHA_URL="https://github.com/zephyrproject-rtos/sdk-ng/releases/download/v${VERSION}/sha256.sum"

export DEBIAN_FRONTEND=noninteractive
export TZ=Europe/Warsaw

USERNAME="${USERNAME:-"${_REMOTE_USER:-"automatic"}"}"

if [ "${USERNAME}" = "auto" ] || [ "${USERNAME}" = "automatic" ]; then
    USERNAME=""
    POSSIBLE_USERS=("vscode" "node" "codespace" "$(awk -v val=1000 -F ":" '$3==val{print $1}' /etc/passwd)")
    for CURRENT_USER in "${POSSIBLE_USERS[@]}"; do
        if id -u "${CURRENT_USER}" >/dev/null 2>&1; then
            USERNAME=${CURRENT_USER}
            break
        fi
    done
    if [ "${USERNAME}" = "" ]; then
        USERNAME=NON_ROOT
    fi
elif [ "${USERNAME}" = "none" ] || ! id -u "${USERNAME}" >/dev/null 2>&1; then
    USERNAME=root
fi

export USERNAME_VAR="${USERNAME}"

if [ "${USERNAME}" = "root" ]; then
    USER_HOME="/root"
else
    USER_HOME="/home/${USERNAME}"
fi

PYTHON_DIR=$(find /usr/local/python/ -maxdepth 1 -type d -name "[0-9]*.*" | sort -V | tail -n 1)
export PATH="${PYTHON_DIR}/bin:$PATH"

sudo -u "${USERNAME}" bash -c "export PATH=${PATH}; pip3 install --user -U west"
sudo -u "${USERNAME}" bash -c 'echo "export PATH=\$HOME/.local/bin:\$PATH" >> ~/.bashrc'
sudo -u "${USERNAME}" bash -c 'source ~/.bashrc'

if [ -n "$ZEPHYR_SDK_URL" ]; then
    wget -P /tmp "$ZEPHYR_SDK_URL" "$ZEPHYR_SDK_SHA_URL"
    
    sudo -u "${USERNAME}" mkdir -p "${USER_HOME}/.local"
    sudo -u "${USERNAME}" tar xf /tmp/zephyr-sdk-${VERSION}_linux-x86_64.tar.xz -C "${USER_HOME}/.local"
    sudo -u "${USERNAME}" cp /tmp/sha256.sum "${USER_HOME}/.local"
    sudo -u "${USERNAME}" cd ${USER_HOME}/.local/zephyr-sdk-${VERSION} && ./setup.sh
    sudo -u "${USERNAME}" cp "${USER_HOME}/.local/zephyr-sdk-${VERSION}/sysroots/x86_64-pokysdk-linux/usr/share/openocd/contrib/60-openocd.rules" /etc/udev/rules.d/ && udevadm control --reload-rules
    for DIR in "${USER_HOME}/.local/zephyr-sdk-${VERSION}"/*; do
        if [[ "$DIR" != *"$ARCHITECTURE"* ]] && [[ "$DIR" != *"cmake"* ]] && [[ "$DIR" != *"sdk_toolchains"* ]] && [[ "$DIR" != *"sdk_version"* ]] && [[ "$DIR" != *"setup.sh"* ]] && [[ "$DIR" != *"hosttools-standalone"* ]]; then
            rm -rf "$DIR"
        fi
    done
else
    echo "Skipping Zephyr SDK installation (URL not provided)"
    exit 1
fi

if [ -d "${USER_HOME}/.local/zephyr-sdk-${VERSION}" ]; then
    rm /tmp/zephyr-sdk-${VERSION}_linux-x86_64.tar.xz
    rm /tmp/sha256.sum
else
    echo "Zephyr SDK not found! - Exiting"
    exit 1
fi

if [ -n "$NRFUTIL_URL" ]; then
    TEMP_DIR=$(mktemp -d)
    cd "$TEMP_DIR"

    curl -fSL "$NRFUTIL_URL" -o nrfutil || {
        echo "Download error"
        exit 1
    }
    chmod +x nrfutil
    mv nrfutil /usr/local/bin/
        cd - || exit 1
    rm -rf "$TEMP_DIR"
 
else
    echo "Skipping nrfutil installation (URL not provided)"
    exit 1
fi

