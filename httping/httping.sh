#!/bin/sh
NOW=$(date +%s)
HOST=$1
TODAY=$(date -d $(date +%Y-%m-%d) +%s)
D15=$(date -d "14 day ago" +%s)
D4=$(date -d "3 day ago" +%s)
D1=$(date -d "1 day ago" +%s)
## 保存先ディレクトリを指定する(最後はスラッシュ不要)
DIR="/home/USER/Documents"
## RRD ファイルの存在確認
if [ ! -f ${DIR}/${HOST}.rrd ]; then
	if [ -f ./initial.sh ]; then
		sh ./initial.sh ${HOST} ${DIR}
	else
		echo "Error: Unable to create a RRD file."
		exit 2
	fi
fi
## httping 値を取得する
httping -c 1 ${HOST} -I "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_1) AppleWebKit/605.1.13 (KHTML, like Gecko) Version/12.1.2 Safari/605.1.14" | grep round-trip |cut -d " " -f 4|cut -d "/" -f 1 > ${DIR}/${HOST}.tmp
##
rrdtool update ${DIR}/${HOST}.rrd ${NOW}:`cat ${DIR}/${HOST}.tmp`
## 1day
rrdtool graph ${DIR}/1day_${HOST}.png --title "httping(1 Day)[${HOST}]" --vertical-label "Time [msec]" --width 600 --height 240 --start ${D1} --end ${NOW} DEF:rrt=${DIR}/${HOST}.rrd:rrt:AVERAGE AREA:rrt#00FF00
## 3 days
rrdtool graph ${DIR}/3days_${HOST}.png --title "httping(3 Days)[${HOST}]" --vertical-label "Time [msec]" --width 600 --height 240 --start ${D4} --end ${NOW} DEF:rrt=${DIR}/${HOST}.rrd:rrt:AVERAGE AREA:rrt#00FF00
## 14 days
rrdtool graph ${DIR}/14days_${HOST}.png --title "httping RTT(14 Days)[${HOST}]" --vertical-label "Time [msec]" --width 600 --height 240 --start ${D15} --end ${NOW} DEF:rrt=${DIR}/${HOST}.rrd:rrt:AVERAGE AREA:rrt#00FF00
