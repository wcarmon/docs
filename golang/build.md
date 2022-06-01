# Overview
1. How to build go binaries


# Build
```sh
DEST_DIR=~/bin;
go build -o $DEST_DIR/foo ./path/to/cmd/foo
```


# Cross compile
```sh
DEST_DIR=~/bin;
GOOS=linux GOARCH=amd64 go build -o $DEST_DIR/foo.linux.amd64 ./path/to/cmd/foo
GOOS=darwin GOARCH=amd64 go build -o $DEST_DIR/foo.mac.amd.64 ./path/to/cmd/foo
GOOS=windows GOARCH=amd64 go build -o $DEST_DIR/foo.exe ./path/to/cmd/foo
```

## List available architectures
```sh
go tool dist list;
```


# Other resources
