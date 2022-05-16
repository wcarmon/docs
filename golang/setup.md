# Overview
- ...


# Binaries
```bash
GO_SDK_ROOT=$HOME/sdk/go1.18.1;

rm -fv $HOME/bin/go;
rm -fv $HOME/bin/gofmt;

ln -s $GO_SDK_ROOT/bin/go $HOME/bin/;
ln -s $GO_SDK_ROOT/bin/gofmt $HOME/bin/;
```

## verify
```bash
go version
```