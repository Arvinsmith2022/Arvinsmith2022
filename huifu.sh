#!/bin/bash

# 提示用户输入压缩包的下载地址
read -p "请输入压缩包的下载地址: " url

# 定义下载和解压路径
download_path="/root/ceremonyclient"
node_path="$download_path/node"
config_path="$node_path/.config"
backup_path="$node_path/.config_backup"
temp_path="$download_path/temp_download"
temp_config_path="$download_path/temp_download/.config"

# 创建临时下载目录
mkdir -p $temp_path

# 下载压缩包到临时目录
echo "正在下载压缩包..."
wget -O $temp_path/archive.zip $url

# 检查下载是否成功
if [ $? -ne 0 ]; then
  echo "下载失败。请检查下载地址是否正确。"
  exit 1
fi

# 备份原有的 .config 目录
if [ -d $config_path ]; then
  echo "正在备份原有的 .config 目录..."
  mv $config_path $backup_path
fi

# 解压下载的压缩包
echo "正在解压压缩包..."
unzip $temp_path/archive.zip -d $temp_path

# 检查解压是否成功
if [ $? -ne 0 ]; then
  echo "解压失败。请检查压缩包是否正确。"
  exit 1
fi

# 移动解压后的 .config 文件夹到目标目录
echo "正在移动 .config 文件夹..."
mv $temp_config_path $node_path

# 检查移动是否成功
if [ $? -ne 0 ]; then
  echo "移动 .config 文件夹失败。请检查权限和路径是否正确。"
  exit 1
fi

# 清理临时文件
echo "正在清理临时文件..."
rm -rf $temp_path

echo "操作完成。新 .config 文件夹已替换，并备份原有 .config 文件夹为 .config_backup。"