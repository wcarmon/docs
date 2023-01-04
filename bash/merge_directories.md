# Overview
1. Examples for merging directories


# via RSync
```bash
SRC="..." # End with trailing slash
DEST="..." # End with trailing slash

rsync \
--backup \
--dry-run \
--executability \
--itemize-changes \
--recursive \
--suffix=".bak" \
--verbose \
$SRC $DEST
```


# Other resources
1. https://linux.die.net/man/1/rsync