#!/bin/bash

# 目标分支
branch=${1}
# 需要检查的文件后缀
suffix=${2}

error_no=0

# 获取修改的文件
files=`.rider/changefiles.sh ${branch} ${suffix}`

error_no=$?

if [[ ${error_no} -ne 0  ]]; then
    .rider/changefiles.sh ${branch} ${suffix}
    exit ${error_no}
fi

echo -e '\033[32m ********** 本次修改的PHP文件 ********** \033[0m'
echo ${files}|tr ' '  '\n'
echo -e '\033[32m ************************************* \033[0m\n'


# 开始检查
.rider/changepakg.sh ${files}


error_no=$?

exit ${error_no}
