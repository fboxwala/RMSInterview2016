#!/bin/bash

if [ $# -ne 2 ]; then
    echo "tokenizer expected 2 args"
    echo "usage: ./tokenizer INFILE OUTFILE"
    exit 7
fi

# tokenize a file into a list of words:
# remove non alphanumeric chars with tr
# put each word on a newline with sed. 
# map all to lowercase with tr for eezy sort
# redirect into outfile

tr -c '[A-Z][a-z][0-9]' ' ' < ${1} | sed 's/\s\+/\n/g' |
tr '[:upper:]' '[:lower:]'  >  ${2}
