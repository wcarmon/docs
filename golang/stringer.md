# Overview
- What is `Stringer`
- How to generate string representation of a struct


# Install
```sh
go install golang.org/x/tools/cmd/stringer
```
- Verify: See `$HOME/go/bin/stringer`
- (or use `go env | grep -i path` to find your `$GOPATH` path)


# Usage
1. In a `*.go` file, add header comment above `package` declaration
    1. `//go:generate stringer -type=MyEnum`
1. `cd` to the directory with `go.mod`
1. Run `go generate -x ./...`
    1. See example in [generate.go.native.sh](../bash/examples/generate.go.native.sh)
1. Don't commit the stringer files
    1. unless build env cannot install [`stringer`](https://pkg.go.dev/golang.org/x/tools/cmd/stringer)


# Idioms
1. You might not need `Stringer`
1. Useful for enums
1. Structs are already pretty easy to print: `fmt.Printf("%#v", foo)`


- TODO: goland support

# Other resources
1. https://pkg.go.dev/golang.org/x/tools/cmd/stringer
1. https://pkg.go.dev/fmt#Stringer
1. https://musse.dev/stringer-golang/
1. https://arjunmahishi.medium.com/golang-stringer-ad01db65e306
