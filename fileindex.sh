#!/bin/bash

# if not enough args print usage
if [ $# -eq 0 ]; then
    echo "usage: ./fileindex.sh [-n] FILE1 FILE2 ..."
    echo "use flag --help for more information"
    exit 7

# if user asks for help print man
elif [ $1 = "--help" ]; then
    cat ./man_fileindex.txt
    exit 7
fi

# get the number of top n words that user would like to print
if [[ $1 =~ -[0-9]+ ]]; then
    NUM=${1#-}
    ARGS=${@#-${NUM}}
else
    NUM=10
    ARGS=$@
fi

# create a temporary file in the current directory to hold the list
# of tokenized words

MEGAFILE=`mktemp -p . mega.XXX`

# concatenate all files, and tokenize them into a list of words with
# tr and sed, redirect into our temp file

cat $ARGS | tr -c '[A-Z][a-z][0-9]' ' ' | sed 's/\s\+/\n/g' | tr '[:upper:]' '[:lower:]'  > ${MEGAFILE}

# sort the list of words megafiles, and use uniq -c to get a count, and 
# then sort in reverse by number, print the first ten elements
# need two sorts to protect against false positives

echo "Calculating top ${NUM} words..."
sort ${MEGAFILE} | uniq -c -i | sort -nr | head -${NUM}

#remove our temorary file

rm ${MEGAFILE}
