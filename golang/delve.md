# Overview
1. How to use the latest [delve](https://github.com/go-delve/delve) version
1. Goland ships with older versions of delve


# Get local installed Go sdk info
```bash
which go
ls -hl $(which go)
go version
```


## Install [Delve](https://github.com/go-delve/delve/tree/master/Documentation/installation)
```bash
go install github.com/go-delve/delve/cmd/dlv@latest

which dlv;
ls -hl $(which dlv);
dlv version;
```

## Find & replace old versions
```bash
find ~/.local -type f -name dlv | grep -i goland | grep -i linux

# eg. $HOME/.local/share/JetBrains/Toolbox/apps/Goland/ch-0/223.8617.58/plugins/go-plugin/lib/dlv/linux/dlv

OLD_DLV=$HOME/.local/share/JetBrains/Toolbox/apps/Goland/ch-0/223.7571.176/plugins/go-plugin/lib/dlv/linux/dlv
NEW_DLV=$HOME/go/bin/dlv

rm -v $OLD_DLV
ln -sv $NEW_DLV $OLD_DLV

# verify
$OLD_DLV version
```
