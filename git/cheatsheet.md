# Fork repo
1. get repo url (ends with `.git`)
1. Clone & Verify
```sh
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
```sh
git push origin HEAD feature/FOO-123 -u;
```

# Amend a commit message
```sh
git commit --amend;
```

# Sync my fork
See [./utils/sync-forked-branch.sh](./utils/sync-forked-branch.sh)
```sh
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
```sh
LOCAL_BRANCH=...;
git diff --name-only shared/$LOCAL_BRANCH $LOCAL_BRANCH;
git diff --name-only $LOCAL_BRANCH mine/$LOCAL_BRANCH;
```


# Create new feature branch
```sh
NEW_BRANCH_NAME=feature/foo-123;
STARTING_BRANCH="current_release";

cd ~/root/git-repos/the-project;
sync_forked_banch "$STARTING_BRANCH";

git checkout -b $NEW_BRANCH_NAME shared/$STARTING_BRANCH;
git push mine HEAD --set-upstream;
```

# Merge `main` into local & push to "mine"
```sh
LOCAL_FEATURE_BRANCH=feature/foo-123;
SOURCE_BRANCH=shared/current_release;
REMOTE_REPO_FOR_BRANCH=mine;  # or =shared

git fetch --all;
git checkout $LOCAL_FEATURE_BRANCH;
git pull $REMOTE_REPO_FOR_BRANCH;
git merge --no-edit $SOURCE_BRANCH;
git status;

# resolve merge conflicts here...

git push $REMOTE_REPO_FOR_BRANCH $LOCAL_FEATURE_BRANCH --set-upstream;
```

# Delete branch
```sh
BRANCH_TO_DELETE=feature/foo-123;

git fetch --all;
git checkout $BRANCH_TO_DELETE;
git pull;

git checkout main;
git branch --delete $BRANCH_TO_DELETE;
git push mine --delete $BRANCH_TO_DELETE || true;
```


# Stashing changes (temporarily shelve)
```sh
# -- Save
git stash;

# -- View
git stash list;

# -- Restore
git stash pop;    # removes from git-stash stack
git stash apply;  # keep in git-stash stack
```

# Housekeeping
```sh
git gc --prune;
```

# Cherry pick files from another branch
https://www.jetbrains.com/help/idea/apply-changes-from-one-branch-to-another.html#copy-files-to-branch


# Get mutators between hashes
```
git rev-list --ancestry-path OLD_TAG..NEW_TAG --format=short | grep -i author | sort | uniq;

git log --author=[Ww]il
git rev-list --ancestry-path OLD_TAG..NEW_TAG --author=[Ww]il
git rev-list --ancestry-path OLD_TAG..NEW_TAG --format-short --author=[Ww]il
```

# Diff patch
```sh
git fetch --all;

rm ../patchfile;
git diff OLD_TAG..NEW_TAG > ../patchfile;
dos2unix ../patchfile;

git checkout main;

git checkout -f --;
git clean -f -d;

patch -p1 < ../patchfile;

## Verify
git config core.whitespace cr-at-end;
git diff -b --name-only --ignore-space-change --ignore-space-at-eol OLD_TAG..NEW_TAG;
git duff --ignore-space-change OLD_TAG..NEW_TAG;
```


# Follow a file
```sh
git log --follow path/to/the/file.java
```
