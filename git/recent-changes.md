# Overview
1. TODO


# Changes
```bash
LAST_WEEK_HASH="$(git rev-list -n 1 --before="7 days ago" main)"
git diff $LAST_WEEK_HASH HEAD
```

```powershell
$LastWeekHash = git rev-list -n 1 --before="7 days ago" main
git diff $LastWeekHash HEAD
```


# Other resources
1. TODO
