#!/usr/bin/env bash
# start: 16:56 29th July
# finish: 17:06 29th July

INSERT_STRING=$1
LINE_NUMBER=$2
FILENAME=$3


# Basic var check
if [[ $INSERT_STRING == "" ]]; then
    echo "WARNING: string to be inserted not set. Aborting."
    exit 1
fi

if [[ $LINE_NUMBER == "" ]]; then
    echo "WARNING: line number not set. Aborting."
    exit 1
fi

if [[ $FILENAME == "" ]]; then
    echo "WARNING: filename not set. Aborting."
    exit 1
fi

# Check file actually exists
if ! [[ -f "$FILENAME" ]]; then
    echo "WARNING: file doesn't exist. Aborting."
    exit 1
fi


# Awk!
awk -i inplace "(NR-1)%$LINE_NUMBER==0{print \"$INSERT_STRING\"} 1" $FILENAME 
