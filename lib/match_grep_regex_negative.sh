#!/bin/bash

# Match function that returns 0 if the regex doesn't match any line in the file.

match() {
    if [ ! -z ${var+FILTER} ]; then
        echo "FILTER variable must be set."
        exit 1
    fi

    count=$(grep "$FILTER" "$1" | wc -l)
    echo "COUNT: $count"
    if [ $count -eq 0 ]; then
        return 0
    else
        return 1
    fi
}
