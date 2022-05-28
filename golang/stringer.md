# Overview
- What is `Stringer`
- How to generate string representation of a struct


TODO: generating String()
TODO: goland support
TODO: get stringer on $PATH
TODO: `//go:generate stringer -type=Foo` at top of file


# Idioms
1. You might not need `Stringer`
1. Structs are already pretty easy to print: `fmt.Printf("%#v", foo)`


# Other resources
1. https://pkg.go.dev/golang.org/x/tools/cmd/stringer
1. https://pkg.go.dev/fmt#Stringer