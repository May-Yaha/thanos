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

skip_ignore_file(){

    error_no=0

    for patten in `cat .rider/fileignore`
    do
        if [[ ${file} =~ (${patten}*) ]]; then
            echo -e "\033[33m 忽略检查文件：${file} \033[0m"
            error_no=4
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

	    if [[ ${error_no} -eq 4 || ${error_no} -eq 5 ]]
	    then
	        continue
	    fi

	    check_php_debug

	    check_php_syntax
	done

	exit ${error_no}
}

main
