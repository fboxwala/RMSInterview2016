## Distributed File Indexer

This is a small coding project I completed as part of an interview process.

fileindex.sh is a distributed file indexer which will take an arbitrary number
of plaintext files as arguments, and will print the top ten words that occur
in them.

### *nix Environment 
To use the tool simply save the fileindexer directory in a place convenient 
for usage, such as the directory containing the files you would like to pass as arguments.

Then:
`cd fileindexer`

Ensure that fileindex.sh, tokenizer.sh, and counter.sh  have executable 
permissions:

`chmod u+x fileindex.sh tokenizer.sh counter.sh`

Then simply run the script:

`./fileindex.sh [-n] PATH/FILE1 PATH/FILE2 ...`

For full usage and instructions, try:

`./fileindex.sh --help`

### Windows Environment

In order to use this script in Windows, you will have to emulate a bash 
environment.

To do this, navigate [here](http://www.mingw.org/wiki/Getting_Started) to 
install Minimalistic GNU for Windows.

Once you have completed this setup, follow the steps for *nix environments.

### Testing

I have included some unittests in this repo.

`cd fileindexer`
`./unittest.sh`

will run these unittests using the data in fileindexer/tests

These public domain text files were retrieved from [Project Gutenberg](http://gutenburg.org)
and top ten words for comparison were calculated on [WriteWords](http://www.writewords.org.uk/word_count.asp).

