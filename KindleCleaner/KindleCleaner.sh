#--------------------------------------------
# 这是一个自动清除Kindle残留文件的脚本:
# https://github.com/marebito/KindleCleaner/KindleCleaner/KindleCleaner.sh
# 功能：自动删除Kindle残留sdr文件夹
# 特色：全自动删除无需人工干预
#--------------------------------------------

#!/bin/bash

MODULE_NAME="功能：删除残留sdr文件夹"
VERSION="1.0.0"
AUTHOR="Yuri Boyka"
function usage()
{
echo ""
echo "\033[33m$MODULE_NAME 版本: $VERSION 作者: $AUTHOR\033[0m"
echo ""
echo "\033[46;30m参数 : Kindle的documents文件夹\033[0m"
echo ""
echo "\033[32me.g. ./KindleCleaner.sh /Volumes/Kindle/documents\033[0m"
echo ""
exit 0
}

if [ -z "$1" ];then
echo ""
echo "\033[31mKindle文档路径不存在\033[0m"
usage
fi

SDR_DIR=$1
cd $SDR_DIR
SDR_LIST=$(find $1 -name "*.sdr")

for SDR in $SDR_LIST; do
  if [ -d "$SDR" ]; then
    FILE_NAME=$(echo $(basename $SDR .sdr))
    FILE_DIR=$(echo $(dirname $SDR))
    RESULT=$(find $FILE_DIR -name "$FILE_NAME*" | grep -v "$FILE_NAME.sdr")
    if [[ $RESULT == "" ]]; then
      rm -rf $SDR
    fi
  fi
done

deleteempty() {
  find ${1:-.} -mindepth 1 -maxdepth 1 -type d | while read -r dir; do
    if [[ -z "$(find "$dir" -mindepth 1 -type f)" ]] >/dev/null; then
      echo "$dir"
      rm -rf ${dir} 2>&- && echo "Empty, Deleted!" || echo "Delete error"
    fi
    if [ -d ${dir} ]; then
      deleteempty "$dir"
    fi
  done
}
deleteempty

echo 0
