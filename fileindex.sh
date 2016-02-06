#!/bin/bash

# if user asks for help print usage
if [ $1 = "--help" ]; then
    echo "usage: ./fileindex.sh [-u] FILE1 FILE2 ..."
    echo "see man_fileindex.txt for full usage"
    exit 7
fi

# create a temporary file in the current directory to hold the list
# of tokenized words

MEGAFILE=`mktemp -p . mega.XXX`

# check to see if flag -u was passed
ARGS=${@#\-u}

# if -u, use `tr -c alnum` to support unicode characters as words
# otherwise specify explicit Ascii ranges

if [ $1 = "-u" ]; then
    # concatenate all files, and tokenize them into a list of words with
    # tr and sed, redirect into our temp file
    cat ${ARGS} | tr -c '[[:alnum:]]' ' ' | sed 's/\s\+/\n/g' > ${MEGAFILE}

else
    cat $@ | tr -c '[A-Z][a-z][0-9]' ' ' | sed 's/\s\+/\n/g' > ${MEGAFILE}
fi

# sort the list of words megafiles, and use uniq -c to get a count, and 
# then sort in reverse by number, print the first ten elements
# need two sorts to protect against false positives

sort ${MEGAFILE} | uniq -c | sort -nr | head -10

#remove our temorary file
rm ${MEGAFILE}
