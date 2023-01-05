# Overview
1. Examples for safely merging directories


# via RSync

## Safe: Dry-run to verify it meets your requirements
```bash
SRC="..." # End with trailing slash
DEST="..." # End with trailing slash

rsync \
--backup \
--dry-run \
--executability \
--itemize-changes \
--recursive \
--suffix=".manual_merge" \
--verbose \
$SRC $DEST
```

## Safe:
```bash
SRC="..." # End with trailing slash
DEST="..." # End with trailing slash

rsync \
--backup \
--dry-run \
--executability \
--itemize-changes \
--recursive \
--suffix=".manual_merge" \
--verbose \
$SRC $DEST
```




# Other resources
1. https://linux.die.net/man/1/rsync