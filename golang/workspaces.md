# Overview
1. How workspaces work
1. Requires go [1.18](https://go.dev/blog/go1.18)+
1. See [modules](./modules.md) doc first


# Key Concepts
1. Workspaces allow code to access packages in other (local) modules
1. Workspaces obsolete [replace](https://go.dev/ref/mod#go-mod-file-replace) directives in go.mod
1. Workspaces obsolete `GOPATH`


# Creating
1. Create the modules first (`go.mod`)
    1. See [modules doc](./modules.md)
1. cd to some parent dir of the modules
```bash
go work init
go work use -r ./
```

# Current workspace
```bash
go env GOWORK
```


# Tidy/cleanup
```go
go work sync
```

# Goland
1. You have to add packages to `go.work` for some imports to resolve


# Other resources
1. https://go.dev/doc/tutorial/workspaces
1. https://go.dev/blog/get-familiar-with-workspaces
