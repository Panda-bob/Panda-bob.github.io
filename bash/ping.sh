#!/bin/bash

COUNT=100
# Get arguments
function usage() {
	echo "Usage: $0 {ip} [count]"
}

[ $# -lt 1 ] && {
	usage
	exit 0
}

if [ $# -eq 2 ];then
	COUNT=$2
fi
ip=$1

echo "ping start ,the count is :${COUNT}" > ./ping_fail.log

count=0;
while [ true ]
do
	ping=`ping -c 1 $ip|grep loss|awk '{split($0, arr, ",");for (i in arr) {print arr[i]}}'|grep loss|awk -F "%" '{print $1}'`
	if [ $ping -eq 100 ];then
		let count+=1 
		echo "ping $ip loss!"
		echo `date +"%Y-%m-%d %H:%M:%S"` >> ./ping_fail.log
		echo  "ping $ip loss" >> ./ping_fail.log
		if [ $count -eq $COUNT ];then
			exit 0
		fi
		#usleep 10000
	else
		#echo $i >>ping_ok.lst
		echo "ping $ip ok!"
		sleep 1
	fi

done



