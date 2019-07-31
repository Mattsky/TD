#!/usr/bin/env bash

FILENAME=$1
TARGET_REGEX=$2
REPLACEMENT_STRING=$3

# Basic var check
if [[ $FILENAME == "" ]]; then
    echo "WARNING: filename not set. Aborting."
    exit 1
fi

if [[ $TARGET_REGEX == "" ]]; then
    echo "WARNING: regex not set. Aborting."
    exit 1
fi

if [[ $REPLACEMENT_STRING == "" ]]; then
    echo "WARNING: replacement string not set. Aborting."
    exit 1
fi

# Check file actually exists
if ! [[ -f "$FILENAME" ]]; then
    echo "WARNING: file doesn't exist. Aborting."
    exit 1
fi

array=()
while IFS= read -r line
do
    array+=("$line")
done < "$FILENAME"

for lineout in "${array[@]}"
do
    echo "$(sed "s/$TARGET_REGEX/$REPLACEMENT_STRING/g" <<<$lineout )"
done

