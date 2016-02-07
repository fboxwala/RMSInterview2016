#!/bin/bash

# Test one Pride and Prejudice

echo "Testing Pride and Prejudice"
echo " "
echo "Top ten words from WriteWords:"
echo "the, to, of, and, her, i, a, in, was, she"
echo " "
echo "Results of fileindex.sh:"
./fileindex.sh tests/p_and_p.txt

echo " "
echo "Testing John Locke Essay"
echo " "
echo "Top ten words from WriteWords:"
echo "the, of, and, to, in, that, it, is, a, be"
echo " "
echo "Results of fileindex.sh:"
./fileindex.sh tests/humane_understanding.txt

echo " "
echo "Testing Emma"
echo " "
echo "Top ten words from WriteWords:"
echo "the, to, and, of, a, i, it, her, was, she"
echo " "
echo "Results of fileindex.sh:"
./fileindex.sh tests/emma.txt

echo " "
echo "The Three Musketeers"
echo " "
echo "Top ten words from WriteWords:"
echo "the, to, of, and, a, you, i, that, in, he"
echo " "
echo "Results of fileindex.sh:"
./fileindex.sh tests/three_musketeers.txt
