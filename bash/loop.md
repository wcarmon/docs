# Overview
1. How to iterate in bash


# All files matching a pattern
```bash
for F in ./*.txt
do
    echo "current: $F"
done
```


# Loop over strings
```bash
SOURCES=(
  "AA"
  "BB"
  "CC"
)
for SRC in ${SOURCES[*]}; do
  echo "${SRC}"
done
```


# Other Resources
1. https://www.cyberciti.biz/faq/bash-loop-over-file/
1. https://www.digitalocean.com/community/tutorials/workflow-loop-through-files-in-a-directory
