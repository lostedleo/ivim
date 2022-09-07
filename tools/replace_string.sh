#!/bin/bash
DIR="$(cd "$(dirname "$0")" && pwd)"
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

files=$(grep -rl $2 $1)
if (($? == 1));then
  warn "not match $2 in any files"
  exit -2
fi

${execution} -i "s/${src}/${dst}/g" ${files}
success "replaced string in ${files}"

