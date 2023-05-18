# Overview
1. Utility Bash scripts for removing empty files and directories


# Removing empty directories under current path
```bash
#!/bin/bash

echo "|--- Removing empty directories in `pwd`";

for i in {1..4}
do
    echo "|--- Iteration #${i} of 4";
    find . -type d -empty -exec rmdir {} \;
done
```


# Removing empty files under current path
```bash
#!/bin/bash
find . -type f -empty -delete 2>/dev/null
```


# Other resources
1. https://man7.org/linux/man-pages/man1/find.1.html
1. https://www.cyberciti.biz/faq/unix-linux-find-all-empty-files/
