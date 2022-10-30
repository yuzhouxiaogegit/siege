#!/bin/bash

#=================================================
#	System Required: CentOS 6/7/8
#	Description: 压力测试脚本
#	Version: 1.0
#	Author: 宇宙小哥
#	github: https://github.com/yuzhouxiaogegit/siege
#=================================================

echo ''
read -p "请输入客户端数量(默认：10):" clientNum
read -p "请输入每个客户端请求数量(默认：10):" requestNum
read -p "请输入压力测试域名(默认：https://www.baidu.com):" domainName

if [[ $clientNum = '' ]]; 
then
clientNum=10
fi

if [[ $requestNum = '' ]]; 
then
requestNum=10
fi

if [[ $domainName = '' ]]; 
then
domainName='https://www.baidu.com'
fi

if [[ $(find / -name "siege*" ) = "" ]];
then
	# 更新yum软件
	yum -y update
	
	# 安装编译工具
	yum install -y gcc make openssl-devel
	
	# 下载压力测试工具
	wget http://download.joedog.org/siege/siege-latest.tar.gz
	
	# 解压
	tar zxvf ./siege-latest.tar.gz
	
	# 删除压缩包
	rm -rf siege-latest.tar.gz
	
	#进入目录
	cd siege-*/
	
	#开始编译安装软件
	./configure && make
	make install
	
	# 复制到目录中
	cp doc/siegerc ~/.siegerc
	
	#查看软件版本
	siege -V
	
fi

# 压力测试命令
rm -rf ./siege.log
siege -c ${clientNum} -r ${requestNum} --log=./siege.log ${domainName}

exit
