# Overview
- How to view docs from cli
- How to view docs from browser
- How to generate docs


# Accessing doc from CLI
- [`go doc ...`](https://pkg.go.dev/cmd/doc)
- Examples
```sh
go doc regexp;
go doc -src regexp.Compile;
go doc -all regexp;
go doc -all http | grep -i tls;
```


# Browser based documentation
- [`godoc`](https://pkg.go.dev/golang.org/x/tools/cmd/godoc)
- Example: run local server
```sh
godoc -http=:6060 &
```

# Idioms
1. Every package should have a package comment
1. Don't depend on spacing for alignment
1. Every exported name should have a doc comment
1. Use complete sentences
1. First sentence should be a summary
1. First sentence should begin with name of item described


# Generating docs
TODO


# Other resources
- https://go.dev/doc/effective_go
