#!/bin/bash
set -e
PROXY=https://ghproxy.com
if [[ $# -lt 1 ]];then
  echo "Please input the git repo [other options]"
  exit -1
fi

git clone $PROXY/$@
