# Overview
1. Examples for safely merging directories


# via RSync
- All examples use Dry-run, so you can confirm it meets your requirements
- remove `--dry-run` to actually mutate the filesystem


## Merge, make backups on conflict
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
$SRC $DEST
```


## Merge, overwrite on conflict
1. This is safe if you [git commit](https://git-scm.com/docs/git-commit) first
```bash
SRC="..." # End with trailing slash
DEST="..." # End with trailing slash

rsync \
--dry-run \
--executability \
--itemize-changes \
--recursive
$SRC $DEST
```


# Other resources
1. https://linux.die.net/man/1/rsync