#!/bin/bash

if [[ ! ${BARANCH} ]]; then
    echo -e "\033[31m 比对分支未选择，请在gitlab-ci.yml中添加 \033[0m"
    exit 1
fi

if [[ ! ${SUFFIX} ]];
	then
		echo `git diff --name-only origin/${BARANCH}`
	else
		echo `git diff --name-only origin/${BARANCH}|grep "${SUFFIX}"$`
fi