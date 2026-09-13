#!/bin/bash
threhold=80
usage=$(df / | grep / | awk '{print $5}' | sed s'/%//g')

if [ $usage -gt $threhold ]; then 
	echo "alert: disk usage is above $threhold% - currently at $usage"
	else

	echo "disk usage is normal: $usage"
fi
