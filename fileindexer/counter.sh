#!/bin/bash

if [ ${#} -ne 2 ]; then
    echo "counter expected three args"
    echo "usage: ./counter.sh INFILE TOPN"
    exit 7
fi

# count words by:
# sort list of words alphabetically
# use uniq -c to get count of each word 
# sort words greatest frequency to smallest
# print top n with head

sort ${1} | uniq -c -i | sort -nr | head -${2}
