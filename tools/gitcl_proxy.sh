#!/bin/bash
set -e
PROXY=https://ghproxy.com
if (($# !=1));then
  echo "Please input the git repo"
  exit -1
fi

git clone $PROXY/$1
