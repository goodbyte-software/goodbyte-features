#!bin/bash

set -ex
[[ -n $1 ]] && image=$1 || image='mcr.microsoft.com/devcontainers/base:ubuntu-22.04'
[[ -n $2 ]] && options=$2 || options='{}'

SRC_DIR="./src/NCS_toolchain"

temp_dir=$(mktemp -d)
trap 'rm -rf "$temp_dir"' SIGINT SIGTERM ERR EXIT

pushd "$temp_dir"
mkdir -p .devcontainer

cat <<EOF | tee .devcontainer/devcontainer.json
{
  "image": "$image",
  "features": {
    "./feature": $options
  }
}
EOF

rsync -av --exclude .git "$SRC_DIR/" "$temp_dir/.devcontainer/feature/"

container_id=$(devcontainer up --workspace-folder . | jq -r .containerId)

devcontainer exec --workspace-folder . nrfutil toolchain-manager --version

docker kill "$container_id"

