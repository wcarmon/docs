# Overview
1. How modules work
1. See also [workspaces](./workspaces.md) doc after


# Purpose
- TODO


# Create a module
- TODO: get from ~/git-repos/go/steps-to-make-new-module.md
```sh
```


# Clear cache
```sh
cd $PROJ_ROOT;
rm -vf ./go.mod;
rm -vf ./go.sum;
go clean -modcache;

go mod init wcarmon.com/codegen;
go mod tidy;
```


# Replacing repo with fork
```sh
go mod edit -replace github.com/dave/dst=github.com/hawkinsw/dst@generics
```

# Version control
1. commit `go.sum` and `go.mod` files


# Goland
1. Goland will auto-import new dependencies only after you setup a module


# Listing old dependencies
```sh
go list -u -m -f '{{if .Update}}{{.}}{{end}}' all
```
1. See also: https://github.com/psampaz/go-mod-outdated
```sh
go list -u -m -json all | $HOME/go/bin/go-mod-outdated;
```

# Deprecated
1. [replace](https://go.dev/ref/mod#go-mod-file-replace) directives should be replaced with [workspaces](./workspaces.md)


# Other resources
1. https://go.dev/doc/tutorial/create-module
1. https://go.dev/blog/using-go-modules
1. https://www.practical-go-lessons.com/chap-17-go-modules
1. https://www.practical-go-lessons.com/chap-41-cheatsheet#go-modules