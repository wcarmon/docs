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

# Golangci-lint
1. Aggregates `go vet`, deadcode, errcheck, gosimple, govet, ineffassign, staticcheck, structcheck, typecheck, unused, varcheck, ...
1. See https://golangci-lint.run/

## Install locally
1. See https://golangci-lint.run/usage/install/

## Run via docker
```sh
cd /dir/with/go.mod;

docker run \
    --rm \
    -v $(pwd):/app \
    --workdir /app \
    golangci/golangci-lint:v1.46.2 \
    golangci-lint run ./...
```


## Run
```sh
cd /dir/with/go.mod;

golangci-lint run ./...
# golangci-lint run  -v ./...
```


# Go-critic
1. See https://go-critic.com/overview
1. Run as part of [golangci-lint](https://golangci-lint.run/)


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