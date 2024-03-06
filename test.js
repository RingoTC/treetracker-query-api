const fs = require('fs');

// 读取.releaserc文件内容
fs.readFile('.releaserc', 'utf8', (err, data) => {
  if (err) {
    console.error('Error reading file:', err);
    return;
  }

  try {
    const config = JSON.parse(data);
    const branches = config.branches;

    // 函数用于查找匹配的通道
    function findChannel(branchName) {
      for (const branch of branches) {
        const regex = new RegExp('^' + branch.name.replace('*', '.*') + '$');
        if (regex.test(branchName)) {
          return branch.channel;
        }
      }
      return null; // 如果没有匹配项，则返回null
    }

    // 测试分支名
    const branchName = 'beta/123';
    const channel = findChannel(branchName);
    if (channel) {
      console.log(`Branch '${branchName}' matches channel '${channel}'.`);
    } else {
      console.log(`No matching channel found for branch '${branchName}'.`);
    }

    // 可以根据需要对其他分支进行测试

  } catch (error) {
    console.error('Error parsing JSON:', error);
  }
});
