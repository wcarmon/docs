# Overview
- How to install/upgrade go


# SDK install
- See [Official docs](https://go.dev/doc/install)

# Goland
- See [Jetbrains docs](https://www.jetbrains.com/help/go/installation-guide.html)

# VSCode
- See [visual studio docs](https://code.visualstudio.com/docs/languages/go)



# Linux setup example
1. First, Download from [https://go.dev/doc/install](https://go.dev/doc/install)
```sh
DOWNLOADS_DIR=$HOME/Downloads
GO_SDKS_DIR=$HOME/opt/golang
GO_VERSION=1.20

NEW_GO_SDK_ROOT="$GO_SDKS_DIR/go$GO_VERSION"

mkdir -pv $GO_SDKS_DIR;
cd $GO_SDKS_DIR;

rm -vf ./go*linux-amd64.tar.gz;
mv -nv $DOWNLOADS_DIR/go1.*.linux-amd64.tar.gz $GO_SDKS_DIR/;

rm -rf $NEW_GO_SDK_ROOT/* || true
rmdir $NEW_GO_SDK_ROOT || true

tar -xzf ./go1.*.linux-amd64.tar.gz
rm -vf ./go*linux-amd64.tar.gz;
 
mv -v ./go $NEW_GO_SDK_ROOT

rm -fv $HOME/bin/go
rm -fv $HOME/bin/gofmt
ln -sv $NEW_GO_SDK_ROOT/bin/go $HOME/bin/go
ln -sv $NEW_GO_SDK_ROOT/bin/gofmt $HOME/bin/gofmt


# For Global
sudo rm -fv /usr/bin/go
sudo rm -fv /usr/bin/gofmt
sudo ln -sv $NEW_GO_SDK_ROOT/bin/go /usr/bin/go
sudo ln -sv $NEW_GO_SDK_ROOT/bin/gofmt /usr/bin/gofmt
```


## verify
```sh
which go;
which gofmt;

go version
$HOME/bin/go version
/usr/bin/go version
```
