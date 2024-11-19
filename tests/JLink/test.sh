#!/bin/bash

set -ex
image=$1

options='{}'

SRC_DIR=$(realpath "$(dirname "$0")/../../src/JLink")


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

devcontainer exec --workspace-folder . test -f /opt/SEGGER/JLink/JFlashExe

docker kill "$container_id"

