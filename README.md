# Hackintosh y7000p fix 脚本
> 

## 功能

- 双系统时间同步
- 小键盘驱动补丁

## 小键盘驱动教程

1. 初始化环境
```
sudo sh -c "$(curl -fsSL https://gitee.com/gclm/Hackintosh/raw/master/fix.sh)"
```

2. 配置小键盘
   1. 打开终端执行 open /usr/local/bin/
   2. 打开 系统偏好设置 > 安全性与隐私 > 隐私 > 辅助功能
   3. 将 setleds 添加到辅助功能

## 参考教程

- [小键盘](https://github.com/damieng/setledsmac)
- [双系统时间同步](https://leeyr.com/249.html)
