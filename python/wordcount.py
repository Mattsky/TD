#!/usr/bin/env python3
# Time taken: 30 min
import sys
import re
from operator import itemgetter 

word_list = {}

content = open(str(sys.argv[1]), 'r')

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

sorted_list = sorted(word_list.items(), key = itemgetter(1), reverse = True)
print(sorted_list[0:10])