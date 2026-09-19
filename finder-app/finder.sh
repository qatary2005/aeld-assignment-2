#!/bin/sh
# Finder script for Assignment 1 & 2

set -e
set -u

if [ $# -lt 2 ]
then
    echo "Error: Two arguments required: <filesdir> <searchstr>"
    exit 1
fi

FILESDIR=$1
SEARCHSTR=$2

if [ ! -d "$FILESDIR" ]
then
    echo "Error: Directory $FILESDIR does not exist."
    exit 1
fi

NUMFILES=$(find "$FILESDIR" -type f | wc -l)
NUMMATCHES=$(grep -r "$SEARCHSTR" "$FILESDIR" 2>/dev/null | wc -l)

echo "The number of files are $NUMFILES and the number of matching lines are $NUMMATCHES"
