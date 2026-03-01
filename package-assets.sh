#!/bin/bash

# Assets 静态资源打包脚本

# 获取版本号
version=$(grep 'const version' cmd/frps-panel/cmd.go | grep -oE '[0-9.]+')
echo "Packaging assets for frps-panel version: $version"

# 创建 release 目录
mkdir -p release

# 打包静态资源为 zip
cd ./assets || exit

zip -r "../release/frps-panel-assets-$version.zip" . -x "*.git*" "*.idea*" "*.DS_Store" "*.contentFlavour"

cd ..

echo "Assets package created: release/frps-panel-assets-$version.zip"
