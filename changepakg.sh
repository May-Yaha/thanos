#!/bin/bash

files=${*}

# 语义检查
check_php_syntax(){
	PHP_LINT=`php -l ${file}`
    if [ 0 -ne $? ]
    then
        echo -e "\033[31m 语法错误：${PHP_LINT} \033[0m"
        error_no=2
    fi
}
	
# 断点检查
check_php_debug(){

	PHP_DEBUG=$(grep -Ewrni 'die|exit' ${file}|grep -v '//')
    if [[ ${PHP_DEBUG} ]]
    then
	    echo -e "\033[31m 存在调试断点，请先修改以下代码：${file} -- ${PHP_DEBUG} \033[0m"
        error_no=3
    fi
}

skip_ignore_file(){

	error_no=0

	skip_file=`grep -o "${file}" .rider/fileignore`
	# IGNORE_FILE=`grep "*" .rider/fileignore`

    if [[ "${skip_file}" ]]; then
    	echo -e "\033[33m 忽略检查文件：${file} \033[0m"
    	error_no=4
    fi

    if [[ ! "${file}" =~ (\.php$) ]]; then
    	echo -e "\033[33m 忽略非PHP文件：${file} \033[0m"
    	error_no=5
    fi
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