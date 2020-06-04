#!/usr/bin/env bash

PATH="/usr/bin:/bin:/usr/sbin:/sbin"
E20_PID_FILE="${XDG_RUNTIME_DIR}/enlightenment.pid"

function read_line_from_file()
{
	while IFS='' read -r line || [[ -n "$line" ]]; do
		dlogsend -p Info -t E20_MONITOR "$line"
		#echo "Text read from file: $line"
	done < "$1"
}

function get_enlightenment_status()
{
	estat=`cat /proc/${epid}/stat | awk '{ print $3 }'`
	estat=${estat:0:1}
	echo "${estat}"
}

function display_server_check()
{
	if [ ! -e ${E20_PID_FILE} ]; then
		dlogsend -p Error -t E20_MONITOR "E20_PID_FILE : $E20_PID_FILE"
		dlogsend -p Error -t E20_MONITOR "## Enlightenment is not ready ! ##"
		echo "0"
		return
	fi

	epid=`cat ${E20_PID_FILE}`

	if [ "${epid}" = "" ]; then
		dlogsend -p Error -t E20_MONITOR "## Enlightenment is not running ! ##"
		echo "0"
		return
	fi

	estat=$(get_enlightenment_status ${epid})

	if [ "$estat" = "S" ]; then
		wchan=`cat /proc/${epid}/wchan`
		dlogsend -p Info -t E20_MONITOR "## Enlightenment (PID=$epid, STAT=$estat, WCHAN=$wchan) is running ! ##"
		echo "1"
		return
	fi

	#make the following files empty
	#: > /tmp/${epid}_status
	#: > /tmp/${epid}_wchan
	#: > /tmp/${epid}_stack

	dlogsend -p Info -t E20_MONITOR "## Enlightenment (PID=$epid, STAT=$estat, WCHAN=$wchan) is in a infinite loop or locked up ! ##"

	#top -H -bn1 -p ${epid} > /tmp/${epid}_top
	cat /proc/${epid}/stat | awk '{ print $3 }' > /tmp/${epid}_status
	cat /proc/${epid}/wchan > /tmp/${epid}_wchan
	echo "" >> /tmp/${epid}_wchan
	cat /proc/${epid}/stack > /tmp/${epid}_stack

	#dlogsend -p Info -t E20_MONITOR "## Enlightenment : Top info ##"
	#read_line_from_file "/tmp/${epid}_top"
	dlogsend -p Info -t E20_MONITOR "## Enlightenment : Process Status ##"
	read_line_from_file "/tmp/${epid}_status"
	dlogsend -p Info -t E20_MONITOR "## Enlightenment : WCHAN ##"
	read_line_from_file "/tmp/${epid}_wchan"
	dlogsend -p Info -t E20_MONITOR "## Enlightenment : STACK info ##"
	read_line_from_file "/tmp/${epid}_stack"

	echo "1"
}

if [ ! -e ${E20_PID_FILE} ]; then
	dlogsend -p Error -t E20_MONITOR "E20_PID_FILE : $E20_PID_FILE"
	dlogsend -p Error -t E20_MONITOR "## Enlightenment is not ready ! ##"
	echo "0"
	return
fi

epid=`cat ${E20_PID_FILE}`

if [ "${epid}" = "" ]; then
        dlogsend -p Error -t E20_MONITOR "## Enlightenment is not ready ! ##"
	return
fi

INTERVAL="3"

if [ "$1" != "" ]; then
	INTERVAL="$1"
fi

while [ 1 ]; do
	sleep ${INTERVAL}

	checkup=$(display_server_check)
done

