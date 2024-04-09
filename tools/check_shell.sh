#!/bin/bash
DIR="$(cd "$(dirname "$0")" && pwd)"
source $DIR/common.sh

if (($# != 1)); then
  warn "Please input shell file!"
  exit 1
fi

check_shell() {
  shfmt -d -i 2 -sr $1
  shellcheck -e SC2086 $1
}

check_shell $1
