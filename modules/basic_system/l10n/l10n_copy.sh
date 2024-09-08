#!/bin/bash

# 复制文件夹
cp -r .dart_tool/flutter_gen/gen_l10n lib

# 检查拷贝是否成功
if [ $? -eq 0 ]; then
  echo "文件夹拷贝成功"
else
  echo "文件夹拷贝失败"
fi