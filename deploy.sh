#!/bin/bash

# Tips:
#
# - add `|| true` to commands that you allow to fail.

# set -e
# exit when command fails.
set -o errexit

# set -u
# exit when script tries to use undeclated variables.
set -o nounset

# catch `mysqldump` fails.
set -o pipefail

# set -x
# trace what gets executed.
set -o xtrace

readonly TARGET_HOST=rpi
readonly TARGET_PATH=/home/kali/ws/hello-rpi
readonly TARGET_ARCH=aarch64-unknown-linux-gnu
readonly SOURCE_PATH=./target/${TARGET_ARCH}/release/hello-rpi

cargo build --release --target=${TARGET_ARCH}
rsync ${SOURCE_PATH} ${TARGET_HOST}:${TARGET_PATH}
ssh -v -t ${TARGET_HOST} sudo systemctl restart hello-rpi.service
