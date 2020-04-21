#!/bin/sh
HOST=$1
TODAY=$(date -d $(date +%Y-%m-%d) +%s)
if [ $# -gt 1 ]; then
	DIR=$2
else
	DIR="."
fi
rrdtool create ${DIR}/${HOST}.rrd --start ${TODAY} --step 600 DS:rrt:GAUGE:1200:0:10000 RRA:AVERAGE:0.5:1:3000

