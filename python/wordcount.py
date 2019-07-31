#!/usr/bin/env python3
# Time taken: 30 min
import sys
import re
from operator import itemgetter 
from pathlib import Path

# Basic file existence check
filecheck = Path(sys.argv[1])
if not filecheck.is_file():
    print("WARNING: file not found. Exiting.")
    exit(1)

# Init word list
word_list = {}

# Get file content
content = open(str(sys.argv[1]), 'r')

# Process the lines and break everything down into lowercase words, also stripping special chars
lines = content.readlines()
for i in lines:
    thisline = i.split(" ")
    for j in thisline:
        formatted_word = re.sub(r'\W+', '', j.lower())

        if formatted_word not in word_list:
            word_list[formatted_word] = 1  
        elif formatted_word in word_list:
            counter = int(word_list[formatted_word])
            counter += 1
            word_list[formatted_word] = counter

# Sort the list and print the top ten results (or as many as there are, if less than ten)
sorted_list = sorted(word_list.items(), key = itemgetter(1), reverse = True)
print(sorted_list[0:10])