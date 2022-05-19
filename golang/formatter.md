# Overview
- How to auto-format the `*.go` source files
- Formatting is contentious but not consequential


# Formatting - Recursively
```sh

SRC_ROOT=$HOME/git-repos/go;
gofmt -s -w $SRC_ROOT;
```


# Goland
- [Official docs](https://www.jetbrains.com/help/go/reformat-and-rearrange-code.html#reformat_code)


# Other resources
- https://go.dev/blog/gofmt
- https://pkg.go.dev/cmd/gofmt
