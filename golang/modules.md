# Overview
1. How modules work
1. See also [workspaces](./workspaces.md) doc after


# Purpose
- Modules are how Go manages dependencies


# Create a module
```sh
go mod init company.com/foo;
go mod tidy;
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


# Prune unused deps
```
cd /dir/with/go.mod/

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


# Visualizing dependencies
1. https://blog.jetbrains.com/go/2020/03/16/working-with-go-modules-dependency-management/#visualizing-the-dependencies-of-a-go-project


# Deprecated
1. [replace](https://go.dev/ref/mod#go-mod-file-replace) directives should be replaced with [workspaces](./workspaces.md)

- TODO: mention package cycles


# Other resources
1. https://go.dev/ref/mod
1. https://go.dev/doc/tutorial/create-module
1. https://go.dev/blog/using-go-modules
1. https://www.practical-go-lessons.com/chap-17-go-modules
1. https://www.practical-go-lessons.com/chap-41-cheatsheet#go-modules