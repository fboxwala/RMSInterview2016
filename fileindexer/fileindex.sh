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
CATFILE=`mktemp -p . f.XXX`
MEGAFILE=`mktemp -p . mega.XXX`
cat ${ARGS} > ${CATFILE}

# tokenize files with tokenizer.sh
./tokenizer.sh ${CATFILE} ${MEGAFILE}

if [ $? -ne 0 ]; then 
    echo "tokenizer.sh did not finish successfully"
    exit 6
fi

# count words and return top NUM with counter.sh
./counter.sh ${MEGAFILE} ${NUM}

if [ $? -ne 0 ]; then 
    echo "counter.sh did not finish successfully"
    exit 6
fi

#remove our temorary files
rm ${CATFILE} ${MEGAFILE}
