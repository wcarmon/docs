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

# Gotcha
1. [`gofmt`](https://pkg.go.dev/cmd/gofmt) and [`go fmt`](https://pkg.go.dev/cmd/go#hdr-Gofmt__reformat__package_sources) are different
    1. Arguments are different


# Other resources
- https://go.dev/blog/gofmt
- https://pkg.go.dev/cmd/gofmt
