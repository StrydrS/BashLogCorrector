#!/bin/bash

#echos proper usage if script is not given one input
if [ $# -ne 1 ] ; then
	echo "Usage:./ipsh LOG_FILE"
	exit 1
fi 

#takes correct lines from given input directory structure using grep
grep -rh '[0-9]\{2\}/[0-9]\{4\}' $1 >> output.txt

FILE='./output.txt'
chmod u+x $FILE

#mkdir correctedLogs
mkdir correctedLogs
#reads lines individually, takes year, month, day out of each line and creates the proper date in UK standard
while read -r line; do

	YEAR=$(echo $line | grep -o '/[0-9]\{4\}')
	MONTH=$(echo $line | grep -o '[a-zA-Z]\{3\}/' | head -n 2 | tail -n 1)
	DAY=$(echo $line | grep -o '/[0-9]\{2\}/')
	DAY=${DAY:1:2}
	YEAR=${YEAR:1:4}
	MONTH=${MONTH:0:3}

	case $MONTH in 
		Jan|Mar|May|Jul|Aug|Oct|Dec)
			if ((10#$DAY >= 31)); then
				DAY=31
			fi
			;;
		Feb)
			if ((10#$DAY >= 29)) && ((10#$YEAR % 4 != 0)); then
				DAY=28
			elif ((10#$DAY >= 29)) && ((10#$YEAR % 4 == 0)); then
				DAY=29
			fi
			;;
		Apr|Sep|Jun|Nov)
			if ((10#$DAY >= 30)); then
				DAY=30
			fi
			;;
	esac

	DATE=$DAY/$MONTH/$YEAR
	PARTBEFOREDATE=$(echo $line | grep -o '^[^[]*\[')
        PARTAFTERDATE=$(echo $line | grep -o ':[^:]*.*') 	
	
	if ! [ -d ./correctedLogs/$YEAR ]; then
		mkdir ./correctedLogs/$YEAR	
	fi

	 
	UKDATELINE=$PARTBEFOREDATE$DATE$PARTAFTERDATE
	echo $UKDATELINE >> ./correctedLogs/$YEAR/$MONTH-$YEAR'_'log.txt	

done < $FILE

rm output.txt
