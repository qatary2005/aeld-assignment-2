#!/bin/sh
# Tester script for assignment 2
# Author: Siddhant Jajoo / Updated for Assignment 2 C writer

set -e
set -u

NUMFILES=10
WRITESTR=AELD_IS_FUN
WRITEDIR=/tmp/aeld-data
username=$(cat /etc/finder-app/conf/username.txt 2>/dev/null || cat conf/username.txt 2>/dev/null || echo "qatary2005")

if [ $# -lt 1 ]
then
	echo "Using default value ${NUMFILES} for number of files"
else
	NUMFILES=$1
fi

if [ $# -lt 2 ]
then
	echo "Using default value ${WRITESTR} for string to write"
else
	WRITESTR=$2
fi

MATCHSTR="${USERNAME:-$username}"

echo "Writing ${NUMFILES} files containing string ${WRITESTR} to ${WRITEDIR}"

rm -rf "${WRITEDIR}"
mkdir -p "${WRITEDIR}"

if [ ! -d "${WRITEDIR}" ]
then
	echo "${WRITEDIR} could not be created"
	exit 1
fi

for i in $(seq 1 $NUMFILES)
do
	./writer "${WRITEDIR}/${username}${i}.txt" "${WRITESTR}"
done

OUTPUTSTRING=$(./finder.sh "${WRITEDIR}" "${WRITESTR}")

echo "${OUTPUTSTRING}" > /tmp/assignment4-result.txt

# remove created directory
rm -rf "${WRITEDIR}"

set +e
echo "${OUTPUTSTRING}" | grep "${NUMFILES}"
if [ $? -eq 0 ]; then
	echo "Success"
	exit 0
else
	echo "Failed"
	exit 1
fi
