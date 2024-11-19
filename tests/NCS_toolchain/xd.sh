#!/bin/bash

set -ex
image=$1


SRC_DIR=$(realpath "$(dirname "$0")/../../src/NCS_toolchain")
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

rsync -av "$SRC_DIR/" "$temp_dir/.devcontainer/feature/"



