#!/bin/bash
#
# Install development prerequisites for source distributions of Drake on macOS.
#
# The development and runtime prerequisites for binary distributions should be
# installed before running this script.

set -euxo pipefail

if [[ "${EUID}" -eq 0 ]]; then
  echo 'This script must NOT be run as root' >&2
  exit 1
fi

/usr/local/bin/brew update
# TODO(jamiesnape): Remove this line on or after 9/30/18.
/usr/local/bin/brew uninstall --force bazel
/usr/local/bin/brew bundle --file="${BASH_SOURCE%/*}/Brewfile"
/usr/local/bin/brew tap-pin bazelbuild/tap

/usr/local/bin/pip2 install --upgrade --requirement "${BASH_SOURCE%/*}/requirements.txt"
