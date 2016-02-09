# file for storing output
OUTPUT=`mktemp -p . out.XXX`
COUNT=0;


# TESTS FOR TOKENIZER

# TEST ONE: INCORRECT NUM OF ARGS
./tokenizer.sh > /dev/null
if [ $? -eq 0 ]; then
    echo "Tokenizer test 1 failed: no error on wrong number of args"
    echo " "
    ${COUNT} = {$COUNT}+1
fi

# TEST TWO: REMOVE NON-ALPHA CHARS
./tokenizer.sh tests/tokenizerdata/delimIN.txt ${OUTPUT}

diff tests/tokenizerdata/delimOUT.txt ${OUTPUT} > /dev/null

if [ $? -eq 1 ]; then
    echo "Tokenizer test 2 failed: did not correctly remove non-alpha
          characters"
    echo " "
    echo "actual output:"
    echo " "
    cat ${OUTPUT}
    ${COUNT} = {$COUNT}+1
fi
echo "" > ${OUTPUT}

# TEST THREE: REMOVE NON-NUMERIC CHAR
./tokenizer.sh tests/tokenizerdata/numsIN.txt ${OUTPUT}

diff tests/tokenizerdata/numsOUT.txt ${OUTPUT} > /dev/null

if [ $? -eq 1 ]; then
    echo "Tokenizer test 3 failed: did not correctly remove non-numeric
        characters"
    echo " "
    echo "actual output:"
    echo " "
    cat ${OUTPUT}
    ${COUNT} = {$COUNT}+1
fi
echo "" > ${OUTPUT}


# TESTS FOR COUNTER

# TEST ONE: INCORRECT NUM OF ARGS
./counter.sh > /dev/null
if [ $? -eq 0 ]; then
    echo "Counter test 1 failed: no error on wrong number of args"
    echo " "
    ${COUNT} = ${COUNT}+1
fi

# TEST TWO: CORRECTLY CALCULATES COUNTS OF WORDS
./counter.sh tests/counterdata/numIN.txt 1  > ${OUTPUT}

diff tests/counterdata/numOUT.txt ${OUTPUT} > /dev/null

if [ $? -eq 1 ]; then
    echo "Counter test 2 failed: did not calculate number of words correctly"
    echo " "
    echo "actual output:"
    echo " "
    cat ${OUTPUT}

    ${COUNT} = {$COUNT}+1
fi
echo "" > ${OUTPUT}

# TEST THREE: CORRECTLY OUTPUTS TOP TEN WORDS
./counter.sh tests/counterdata/toptenIN.txt 10 > ${OUTPUT}

diff tests/counterdata/toptenOUT.txt ${OUTPUT} > /dev/null

if [ $? -eq 1 ]; then
    echo "Counter test 3 failed: did not calculate top ten correctly"
    echo " "
    echo "actual output:"
    echo " "
    cat ${OUTPUT}

    ${COUNT} = {$COUNT}+1
fi
echo "" > ${OUTPUT}

# TESTS FOR FILEINDEX

# TEST ONE: ERRORS ON NO ARGS
./fileindex.sh > /dev/null

if [ $? -eq 0 ]; then
    echo "Fileindex test 1 failed: no error on wrong number of args"
    echo " "
    ${COUNT} = {$COUNT}+1
fi

# TEST 2: PRINTS MAN WHEN --help

./fileindex.sh --help > ${OUTPUT}

diff ${OUTPUT} man_fileindex.txt > /dev/null

if [ $? -eq 1 ]; then
    echo "Fileindex test 2 failed: did not print man when --help"
    echo " "
    echo "actual output:"
    echo " "
    cat ${OUTPUT}
    ${COUNT} = {$COUNT}+1
fi

echo "" > ${OUTPUT}

# TEST 3: ACCEPTS INTEGERS AS FIRST ARG

./fileindex.sh -5 tests/emma.txt > ${OUTPUT}

diff ${OUTPUT} tests/emma5OUT.txt > /dev/null

if [ $? -eq 1 ]; then
    echo "Fileindex test 3 failed: did not accept different topn integer"
    echo " "
    echo "actual output:"
    echo " "
    cat ${OUTPUT}
    ${COUNT} = {$COUNT}+1
fi

echo "" > ${OUTPUT}

# TEST 4: DEFAULTS TO TOP TEN
./fileindex.sh tests/emma.txt > ${OUTPUT}

diff ${OUTPUT} tests/emma10OUT.txt > /dev/null

if [ $? -eq 1 ]; then
    echo "Fileindex test 4 failed: did not print top ten as default correctly"
    echo " "
    echo "actual output:"
    echo " "
    cat ${OUTPUT}
    ${COUNT} = {$COUNT}+1
fi

echo "" > ${OUTPUT}

# TEST 5: ACCEPTS MULTIPLE FILES AS ARGUMENTS

./fileindex.sh tests/emma.txt tests/humane_understanding.txt tests/three_musketeers.txt > ${OUTPUT}

diff ${OUTPUT} tests/multifileOUT.txt > /dev/null

if [ $? -eq 1 ]; then
    echo "Fileindex test 5 failed: did not compute multiple files correctly"
    echo " "
    echo "actual output:"
    echo " "
    cat ${OUTPUT}
    echo " "
    ${COUNT} = {$COUNT}+1
fi

echo "" > ${OUTPUT}


if [ ${COUNT} -eq 0 ]; then
    echo "All tests passed successfully"
else
    echo "${COUNT} tests failed"
fi

rm ${OUTPUT}
