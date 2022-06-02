# Overview
- How to install and use static analysis tools


# Staticcheck
1. Install
```sh
go install honnef.co/go/tools/cmd/staticcheck@latest;
```
1. Verify
```sh
$(go env GOPATH)/bin/staticcheck -version;
```
1. Optional: Configure
```sh
cd $PROJ_ROOT;
touch staticcheck.conf;
```
1. Run
```sh
cd $PROJ_ROOT;
staticcheck ./...
```


# Sonar
- TODO: container


# gopls
- TODO: https://github.com/golang/tools/tree/master/gopls


# go vet
```sh
cd $PROJ_ROOT;
go vet ./...
```


--------
# $PATH updates
1. Symlink go binaries into ~/bin
```sh
ln -sv $(go env GOPATH)/bin/* ~/bin/
```
1. Alternative: Add the go-binary path to $PATH
```sh
echo "Add this path: " $(go env GOPATH)/bin;
```


# Other resources
1. TODO