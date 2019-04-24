# 代码检查工具

## 一、运行步骤

`clone`本项目到项目根目录，然后运行`build.sh`即可

## 二、添加`gitlab-ci.yml`文件

```
# 拉取的docker镜像，licunchang/php:7.2.13是一个配置并打包好的php运行环境
image: licunchang/php:7.2.13

# 系统级常量
variables:
  BARANCH: dev  # 提交后比对的分支，如当前是yangzh-dev-0508分支，将会和dev分支做比较，获取差异文件
  SUFFIX: php   # 需要检测的文件后缀，如果不指定，则会包含非php文件的改动检查
  MODULE: userprofile   # 需要检测的模块
  JOB_URL: 'https://git.afpai.com/fudao/userprofile/-/jobs'     # gitlab执行ci的地址，暂时没有做具体指定到某个job的链接上，所以直接指定在首页上
  GIT_URL: 'https://git.afpai.com/fudao/userprofile'            # 项目的地址
  DD_NOTICE_URL: 'https://oapi.dingtalk.com/robot/send?access_token=4313cdaba3ba399c9ce90c062f1cadfda4e8d708d6322c4c45425efbfa9ed04f'   # 钉钉机器人通知地址，每次触发job时，会向对应群发送钉钉消息，可以查看php是否存在断点调试，语法错误等

stages:
  - check

check_syntax:
  stage: check
  script:
    - bash .rider/init.sh
```

## 二、代码检查工具目录

```
rider
├── changefiles.sh  # 变动的文件获取
├── changepakg.sh   # 检查语法、断点信息，后期可以集成更多语法规范检查，单元测试等都需要在该处进行实现
├── fileignore      # 需要屏蔽的文件，写绝对路径，暂不支持’*‘号等特殊符号
├── init.sh         # 初始化
└── massage.sh      # 消息推送
```