#!/bin/bash

push_notice(){
    curl ${DD_NOTICE_URL} -H 'Content-Type: application/json' -d '{"msgtype": "text","at": {"isAtAll": true},"text": {"content": "'${MODULE}'模块触发代码语法、断点检查,比对分支为'${BARANCH}'，Job链接'${JOB_URL}'"}}'
}

push_manger_notice(){
    curl ${DD_NOTICE_URL} -H 'Content-Type: application/json' -d '{"msgtype": "text","at": {"isAtAll": true},"text": {"content": "'${MODULE}'向dev合并代码，git链接'${GIT_URL}'"}}'
}
