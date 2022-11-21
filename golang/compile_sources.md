# Overview
1. How to download (clone) and build go from source


# Clone repo
```bash
GO_SDK_SRC_DIR=$HOME/sdk/official-golang-repo;
mkdir -pv $GO_SDK_SRC_DIR;

PARENT_DIR=$(readlink -f "$(dirname "${GO_SDK_SRC_DIR[0]}")")
DIR_NAME="$(basename "${GO_SDK_SRC_DIR[0]}")"

cd $PARENT_DIR;
git clone https://go.googlesource.com/go $DIR_NAME
cd $GO_SDK_SRC_DIR
```


# Build Sources
1. Install an older version of go first
1. Add the older version of go to the $PATH
1. Build & test
```bash
GO_SDK_SRC_DIR=$HOME/sdk/official-golang-repo;

cd $GO_SDK_SRC_DIR

# or some tag like: "go1.19"
git checkout master

cd src;
./all.bash
```


# Verify
```bash
GO_SDK_SRC_DIR=$HOME/sdk/official-golang-repo;

cd $GO_SDK_SRC_DIR/bin
ls -l
```
- look for `go` and `gofmt`


# Other Resources
1. https://go.dev/doc/install/source



# GO_SDK_SRC_DIR=$HOME/tmp/go-sdk-source;