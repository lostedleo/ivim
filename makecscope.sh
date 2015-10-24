#!/bin/sh

usage()
{
    echo "usage : makecscope src_path project_name"
    echo "I will create cscope db in ~/cscope/project_name"
}
if [ $# -ne 2 ]
then 
    usage
    exit
fi

SRC_PATH=$1
CSCOPE_PATH=~/cscope/$2

mkdir -p $CSCOPE_PATH
cd $CSCOPE_PATH
find $SRC_PATH -name "*.h" -o -name "*.c" -o -name "*.cpp" -o -name "Makefile" -o -name "makefile" > cscope.files
cscope -Rbqk -i ./cscope.files
