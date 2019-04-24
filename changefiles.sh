#!/bin/bash

branch=${1}
suffix=${2}

if [[ ! "${branch}" ]]; then
    echo -e "\033[31m 比对分支未选择，请在gitlab-ci.yml中添加 \033[0m"
    exit 1
fi


if [[ ! "${suffix}" ]]; 
	then
		echo `git diff --name-only origin/${branch}`
	else
		echo `git diff --name-only origin/${branch}|grep "${suffix}"$`
fi