#!/bin/bash

files=${*}

# 语义检查
check_php_syntax(){
	php_lint=`php -l ${file}`
    if [ 0 -ne $? ]
    then
        echo -e "\033[31m 语法错误：${php_lint} \033[0m"
        error_no=2
    fi
}

# 断点检查
check_php_debug(){

	php_debug=$(grep -Ewrni 'die|exit' ${file}|grep -v '//')
    if [[ ${php_debug} ]]
    then
	    echo -e "\033[31m 存在调试断点，请先修改以下代码：${file} -- ${php_debug} \033[0m"
        error_no=3
    fi
}

# sql检查
check_sql(){
	sql=$(grep -Ewrni 'select|insert|update|delete' ${file}|grep -v '//')

	if [[ ${sql} ]]
    then
	    echo -e "\033[31m 存在直接拼写SQL，请先修改以下代码：${file} -- ${sql} \033[0m"
        error_no=4
    fi
}

# 屏蔽文件
skip_ignore_file(){

    for patten in `cat .thanos/fileignore`
    do
        if [[ ${file} =~ (${patten}*) ]]; then
            echo -e "\033[33m 忽略检查文件：${file} \033[0m"
            ignore_flag=1
        fi
    done
}


# 开始检查
main(){
	for file in ${files}
	do
		if [[ ! -f "${file}" ]]; then
	        continue
	    fi

	    skip_ignore_file

	    if [[ ${ignore_flag} -eq 1 ]]
	    then
	        ignore_flag=0
	        continue
	    fi

	    check_php_debug

	    check_php_syntax

	    check_sql
	done

	exit ${error_no}
}

main
