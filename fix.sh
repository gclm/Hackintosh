#!/bin/bash

#Git路径
fix_path=https://gitee.com/gclm/Hackintosh/raw/master/fixs

# 基础配置
daemon_path=/Library/LaunchDaemons/
bin_path=/usr/local/bin/
temp_path=$HOME/Downloads/
time_fix_file=localtime
time_daemon_name=club.gclmit.localtime
time_daemon_file=$time_daemon_name.plist
num_fix_file=setleds
num_daemon_name=club.gclmit.setleds
num_daemon_file=$num_daemon_name.plist

# 初始化环境
init(){

    sudo spctl --master-disable

    sudo pmset -a hibernatemode 0

    sudo rm -rf /var/vm/sleepimage
    sudo mkdir /var/vm/sleepimage

    if [ ! -d "$bin_path" ] ; then
        mkdir "$bin_path" ;
    fi
}

# 小键盘
fix_numlock(){
    echo "开始安装小键盘补丁"
    echo "===================================================="
    
    echo "下载 FixNumLock 补丁"
    sudo curl -o $temp_path$num_fix_file $fix_path"/NumLock/"$num_fix_file
    sudo curl -o $temp_path$num_daemon_file $fix_path"/NumLock/"$num_daemon_file
    
    echo "赋权并安装 FixNumLock 补丁" 
    sudo cp $temp_path$num_fix_file $bin_path
    sudo cp $temp_path$num_daemon_file $daemon_path
    sudo rm $temp_path$num_fix_file
    sudo chmod +x $bin_path$num_fix_file
    sudo chown root:wheel $daemon_path$num_daemon_file
    
    echo "加载 FixNumLock 并设置默认自启" 
    if sudo launchctl list | grep --quiet $num_daemon_name; then
        echo "暂停 FixNumLock daemon..."
    sudo launchctl unload $daemon_path$num_daemon_file
    fi
    sudo launchctl load -w $daemon_path$num_daemon_file
}

# 双系统时间同步
fix_os_time(){
    echo "开始安装双系统时间同步补丁"
    echo "===================================================="
    echo "下载 FixOsTime 补丁"
    sudo curl -o $temp_path$time_fix_file $fix_path"/LocalTime/"$time_fix_file
    sudo curl -o $temp_path$time_daemon_file $fix_path"/LocalTime/"$time_daemon_file

    echo "赋权并安装 FixOsTime 补丁" 
    sudo cp -R $temp_path$time_fix_file $bin_path
    sudo cp -R $temp_path$time_daemon_file $daemon_path
    sudo rm $temp_path$time_fix_file
    sudo rm $temp_path$time_daemon_file
    sudo chmod +x $bin_path$time_fix_file
    sudo chown root $daemon_path$time_daemon_file
    sudo chmod 644 $daemon_path$time_daemon_file

    echo "加载 FixOsTime 并设置默认自启" 
    if sudo launchctl list | grep --quiet $time_daemon_name; then
        echo "暂停 FixOsTime daemon..."
        sudo launchctl unload $daemon_path$time_daemon_file
    fi
    sudo launchctl load -w $daemon_path$time_daemon_file
}

main(){
    init
    fix_numlock
    fix_os_time

    echo "清理缓存"
    sudo kextcache -i /
    echo "补丁安装完成"
    exit 0
}

main





