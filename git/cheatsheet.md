# Fork repo
1. get repo url (ends with `.git`)
1. Clone & Verify
```bash
REPO_URL=...
mkdir -p ~/root/git-repos;
git clone $REPO_URL;

# Verify
cd ./the-project-name;
git remote -v;
```
1. Add remote for personal fork
```
git remote rename origin shared;
git remote add mine $URL_FOR_MY_FORK;
```

# Push arbitrary branch
```bash
git push origin HEAD feature/FOO-123 -u;
```

# Amend a commit message
```bash
git commit --amend;
```

# Sync my fork
See [./utils/sync-forked-branch.sh](./utils/sync-forked-branch.sh)
```bash
cd ~/root/git-repos/the-project;
source .../sync-forked-branch.sh;

git fetch --all --no-tags --prune --jobs=2;
git fetch shared --tags --prune-tags --force;

OLD_BRANCH=$(git rev-parse --abbrev-ref HEAD);

sync_forked_branch "other-branch-1";
sync_forked_branch "other-branch-2";

git checkout $OLD_BRANCH;
git push mine --tags --quiet;
```

## Verify
```bash
LOCAL_BRANCH=...;
git diff --name-only shared/$LOCAL_BRANCH $LOCAL_BRANCH;
git diff --name-only $LOCAL_BRANCH mine/$LOCAL_BRANCH;
```


# Create new feature branch