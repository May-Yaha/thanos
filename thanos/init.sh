#!/bin/bash

error_no=0
project_name='thanos'

source .${project_name}/massage.sh

# 获取修改的文件
files=`.${project_name}/changefiles.sh`

# 没有文件修改时进行的操作
if [[ ! -n ${files} ]]; then
#    push_manger_notice
    exit ${error_no}
fi

if [[ ${DD_NOTICE_URL} ]]; then
    push_notice
fi

error_no=${?}

if [[ ${error_no} -ne 0  ]]; then
    .${project_name}/changefiles.sh
    exit ${error_no}
fi

echo -e '\n\033[32m ********** 本次修改的PHP文件 ********** \033[0m'
echo ${files}|tr ' '  '\n'
echo -e '\033[32m ************************************* \033[0m\n'


# 开始检查
.${project_name}/changepakg.sh ${files}

error_no=${?}

exit ${error_no}
