# 代码检查工具

## 一、运行步骤

`clone`本项目到项目根目录，然后运行`./gitlab-tools`即可

## 二、代码检查工具目录

```
rider
├── changefiles.sh  # 变动的文件获取
├── changepakg.sh   # 检查语法、断点信息，后期可以集成更多语法规范检查，单元测试等都需要在该处进行实现
├── fileignore      # 需要屏蔽的文件，写绝对路径，暂不支持’*‘号等特殊符号
├── init.sh         # 初始化
└── massage.sh      # 消息推送
```