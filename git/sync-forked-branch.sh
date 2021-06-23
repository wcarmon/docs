#
# Util to pull from "src" repo and push to "dest" repo
#
# Pass the branch name
function sync_forked_branch() {

  # --------------------------------------
  # -- Params
  # --------------------------------------
  local LOCAL_BRANCH="$1"
  local SRC_REMOTE_REPO_ALIAS="shared"
  local DEST_REMOTE_REPO_ALIAS="mine"


  # --------------------------------------
  # -- Derived
  # --------------------------------------
  local SHARED_BRANCH="$SRC_REMOTE_REPO_ALIAS/$LOCAL_BRANCH"


  # --------------------------------------
  # -- Fetch
  # --------------------------------------
  echo;
  echo "|-- fetching branches ..."
  git fetch --all --no-tags --prune --jobs=2

  #  echo "|-- fetching tags ...";
  #  git fetch $SRC_REMOTE_REPO_ALIAS --tags --prune-tags --force


  # --------------------------------------
  # -- Sync
  # --------------------------------------
  git branch --track "$LOCAL_BRANCH" "$SHARED_BRANCH" 2>/dev/null

  echo;
  echo "|-- Checking out $LOCAL_BRANCH"
  git checkout --force "$LOCAL_BRANCH"
  if [ $? -ne 0 ]; then
    echo "|-- Failed to checkout $LOCAL_BRANCH"
    return 1
  fi

  git reset --hard "$SHARED_BRANCH"
  if [ $? -ne 0 ]; then
    echo "|-- Failed to reset local to $SHARED_BRANCH"
    return 2
  fi

  git merge "$SHARED_BRANCH" --strategy-option theirs
  if [ $? -ne 0 ]; then
    echo "|-- Failed to merge from $SHARED_BRANCH"
    return 3
  fi

  # --------------------------------------
  # -- Push
  # --------------------------------------
  git push "$DEST_REMOTE_REPO_ALIAS" "$LOCAL_BRANCH" --force
  if [ $? -ne 0 ]; then
    echo "|-- Failed to push to $DEST_REMOTE_REPO_ALIAS/$LOCAL_BRANCH"
    return 4
  fi

  echo;
  echo "|-- Branch is in sync $LOCAL_BRANCH"
}
