#!/bin/bash

# 读取.releaserc文件内容，并提取branches部分的JSON数据
releaserc_content=$(cat .releaserc)
branches_json=$(echo "$releaserc_content" | jq -r '.branches')

# 输入要检索的branch name
read -p "请输入要检索的branch name: " branch_name

# 遍历branches数组，检查是否匹配branch name
matched=false
while IFS= read -r branch_info; do
    name=$(echo "$branch_info" | jq -r '.name')
    channel=$(echo "$branch_info" | jq -r '.channel')

    echo $branch_info
    echo $name

    # 判断是否匹配
    if [[ "$branch_name" == $name || "$branch_name" == $name* ]]; then
        echo "匹配成功，$branch_name 对应的channel 是: $channel"
        matched=true
        break
    fi
done <<< "$branches_json"

# 若没有找到匹配的branch name，则输出未找到匹配信息
if ! $matched; then
    echo "未找到与 $branch_name 匹配的channel"
fi
