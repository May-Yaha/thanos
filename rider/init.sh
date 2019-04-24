#!/bin/bash

error_no=0

source .rider/massage.sh

# 获取修改的文件
files=`.rider/changefiles.sh`

# 没有文件修改时进行的操作
if [[ ! -n ${files} ]]; then
#    push_manger_notice
    exit ${error_no}
fi

push_notice

error_no=${?}

if [[ ${error_no} -ne 0  ]]; then
    .rider/changefiles.sh
    exit ${error_no}
fi

echo -e '\n\033[32m ********** 本次修改的PHP文件 ********** \033[0m'
echo ${files}|tr ' '  '\n'
echo -e '\033[32m ************************************* \033[0m\n'


# 开始检查
.rider/changepakg.sh ${files}

error_no=${?}

exit ${error_no}
