#!/bin/bash
set -e

DIR="$(cd "$(dirname "$0")" && pwd)"
echo $DIR
source $DIR/common.sh

if (($# != 3));then
  warn "Please input replace directory src dst!"
  exit -1
fi

execution=sed
#check is Mac then use gsed
if [ "$(uname)" == "Darwin" ];then
  execution=gsed
fi

src=$(echo $2|sed 's/\//\\\//g')
dst=$(echo $3|sed 's/\//\\\//g')

${execution} -i "s/${src}/${dst}/g" `grep -rl $2 $1`

