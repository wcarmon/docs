# Overview
1. How to build go binaries


# Build
```sh
go build -o ~/bin/foo ./path/to/cmd/foo
```


# Cross compile
```sh
GOOS=linux GOARCH=amd64 go build -o ~/bin/foo.linux.amd64 ./path/to/cmd/foo
GOOS=darwin GOARCH=amd64 go build -o ~/bin/foo.mac.amd.64 ./path/to/cmd/foo
GOOS=windows GOARCH=amd64 go build -o ~/bin/foo.exe ./path/to/cmd/foo
```

## List available architectures
```sh
go tool dist list;
```


# Other resources
