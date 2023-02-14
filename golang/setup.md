# Overview
- How to install/upgrade go


# SDK install
- See [Official docs](https://go.dev/doc/install)

# Goland
- See [Jetbrains docs](https://www.jetbrains.com/help/go/installation-guide.html)

# VSCode
- See [visual studio docs](https://code.visualstudio.com/docs/languages/go)



# Linux setup example
```sh
# Download from https://go.dev/doc/install

GO_SDKS_DIR=$HOME/opt/golang
GO_VERSION=1.20

mkdir -p $GO_SDKS_DIR;
cd $GO_SDKS_DIR;

mv -nv ~/Downloads/go1.*.linux-amd64.tar.gz $GO_SDKS_DIR/;
tar -xzf ./go1.*.linux-amd64.tar.gz
rm -vf ./go*linux-amd64.tar.gz;

NEW_SDK_ROOT=$GO_SDKS_DIR/go$GO_VERSION
# rm -rfv $NEW_SDK_ROOT

mv -v ./go $NEW_SDK_ROOT

rm -fv $HOME/bin/go
rm -fv $HOME/bin/gofmt

ln -s $NEW_SDK_ROOT/bin/go $HOME/bin/go
ln -s $NEW_SDK_ROOT/bin/gofmt $HOME/bin/gofmt

rm -fv /usr/bin/go
rm -fv /usr/bin/gofmt
ln -sv $NEW_SDK_ROOT/bin/go /usr/bin/go
ln -sv $NEW_SDK_ROOT/bin/gofmt /usr/bin/gofmt
```


## verify
```sh
which go;
which gofmt;

go version;
```
