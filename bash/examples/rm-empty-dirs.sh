#!/bin/bash


#set -x # uncomment to debug script
set -e # exit on first error
set -o pipefail
set -u # fail on unset var

echo
echo "|--- Removing empty directories in `pwd`";

for i in {1..4}
do
    echo "|--- Iteration #${i} of 4";
    find . -type d -empty -exec rmdir {} \;
done
