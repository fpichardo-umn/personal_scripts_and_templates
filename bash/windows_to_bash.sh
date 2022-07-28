#!/bin/bash
####
#
#Remove any carriage return that is inserted by default by Windows.
#Makes any script supplied as an argument useable in bash.
#
#Updated: 20032019 - FMP
####

#Test parameters passed
if [ $# -ne 1 ]; then
	echo You must pass a file as an argument.
	echo Use: windows_to_bash.sh PATH_TO_FILE
	exit
fi

file=$1

if [ ! -f $file ]; then
	echo You must pass a valid file as an argument.
	exit
fi

sed -i 's/\r//g' $file
echo $file converted.
