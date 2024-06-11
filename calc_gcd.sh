#!/bin/bash

# Exit status is as follows:
# 0: Normal exit
# 1: Insufficient or excessive number of arguments
# 2: Argument is not a natural number
# 3: Argument exceeds the maximum value

CHECK_ARG_COUNT () {
    if [ $# -ne 2 ]; then
        echo "Two arguments are required."
        exit 1
    fi
}


CHECK_IS_NATURAL_NUMBER () {
    # expr returns exit status 1 when the result is 0
    # Returns exit status 2 if not a number   
    expr $1 + 0 >/dev/null 2>&1

    if [ $? -ne 0 ]; then
        echo "$1 is not a natural number."
        exit 2
    # Check if exceeding the maximum value of an integer
    # Check if it doesn't match as a string due to overflow
    elif [ $(( $1 + 0 )) != $1 ]; then
        echo "The argument exceeds the maximum value for an integer."
        exit 3
    # Check if it's a negative number
    elif [ $1 -lt 0 ]; then
        echo "$1 is not a natural number."
        exit 2
    fi
}

CALCULATE_GREATEST_COMMON_DIVISOR () {
    # Use Euclidean algorithm to find the greatest common divisor   
    if [ $1 -ge $2 ]; then
        a=$1
        b=$2
    else
        a=$2
        b=$1
    fi

    remainder=1 # Initial value
    while [ ${remainder} -gt 0 ]; do
        remainder=$(( ${a} % ${b} )) 

        a=${b}
        b=${remainder}
    done

    echo "The greatest common divisor of $1 and $2 is $a."
}

# Main
CHECK_ARG_COUNT $@

for i in "$@"; do
    CHECK_IS_NATURAL_NUMBER ${i}
done

CALCULATE_GREATEST_COMMON_DIVISOR $1 $2
