# Overview
- How to install go


# SDK install
- See [Official docs](https://go.dev/doc/install)

# Goland
- See [Jetbrains docs](https://www.jetbrains.com/help/go/installation-guide.html)

# VSCode
- See [visual studio docs](https://code.visualstudio.com/docs/languages/go)


# Binaries
```sh
GO_SDK_ROOT=$HOME/sdk/go1.18.1;

rm -fv $HOME/bin/go;
rm -fv $HOME/bin/gofmt;

ln -s $GO_SDK_ROOT/bin/go $HOME/bin/;
ln -s $GO_SDK_ROOT/bin/gofmt $HOME/bin/;
```

## verify
```sh
which go;
go version;
```