#!/bin/bash

# Linux ARM64 版本打包脚本

export GO111MODULE=on
LDFLAGS="-s -w"

# 获取版本号
version=$(grep 'const version' cmd/frps-panel/cmd.go | grep -oE '[0-9.]+')
echo "Building frps-panel version: $version"

# 创建 release 目录
mkdir -p release

# 编译 Linux ARM64 版本
echo "Building linux-arm64..."
env CGO_ENABLED=0 GOOS=linux GOARCH=arm64 go build -ldflags "$LDFLAGS" -o ./release/frps-panel ./cmd/frps-panel

# 复制配置文件和静态资源
cp ./config/frps-panel.toml ./release/
cp ./config/frps-tokens.toml ./release/
cp -r ./assets/ ./release/

# 进入 release 目录打包
cd ./release || exit

# 打包为 zip
zip -r "frps-panel-linux-arm64-$version.zip" frps-panel frps-panel.toml frps-tokens.toml assets -x "*.git*" "*.idea*" "*.DS_Store" "*.contentFlavour"

# 清理临时文件
rm -rf frps-panel frps-panel.toml frps-tokens.toml assets

echo "Package created: frps-panel-linux-arm64-$version.zip"
