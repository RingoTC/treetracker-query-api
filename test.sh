#!/bin/bash

# 获取当前分支名
branch_name=$(git rev-parse --abbrev-ref HEAD)

# 读取.releaserc文件内容
releaserc_file=".releaserc"
content=$(cat $releaserc_file)

# 使用jq解析json内容，提取branches数组
branches=$(echo $content | jq -r '.branches')

# 遍历branches数组
matched_channel=""

for row in $(echo "${branches}" | jq -r '.[] | @base64'); do
    _jq() {
        echo ${row} | base64 --decode | jq -r ${1}
    }

    name=$(_jq '.name')
    channel=$(_jq '.channel')

    # 检查分支名是否匹配当前分支
    if [[ "$branch_name" == $name ]]; then
        matched_channel=$channel
        break
    fi
done

# 输出匹配的channel name
echo "Matched channel for branch $branch_name is: $matched_channel"
