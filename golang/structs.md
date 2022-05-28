# Overview
- Key features & operations on structs

# Structs
1. [Pass-by-value](TODO)
    1. functions you invoke receive a copy of the struct
1. No inheritance ;-)
1. Fields are ordered in memory (in declaration order)
    1. Field order affects things like [Stringer](https://pkg.go.dev/golang.org/x/tools/cmd/stringer)


# Empty Struct
1. Example
```go
type Z struct{}
var z struct{}
```
1. Has size/width of 0 bits (for comparison, `bool` uses 1 bit)
1. slice of empty struct consumes only memory for slice header


- TODO: adding methods - methods.md
- TODO: := copy/assign?
- TODO: Embedding

# Equality
1. TODO: ==
1. TODO: reflect.DeepEquals


# JSON
1. See [json](./json.md) doc


# Anonymous structs
1. For ephemeral structures for one-time use
1. Infrequently useful in prod systems
1. local to a function/method
    1. Cannot be top level declaration since requires `:=`


# Idioms
1. Getters & Setters are neither required nor idiomatic
1. If you have getters, use `Owner`, not ~~`GetOwner`~~
1. If you have setters, use `SetOwner`
1. Method which converts to string is `String()` not `ToString()`
    1. Generate String() using [Stringer](./stringer.md)


# Other resources
1. https://gobyexample.com/embedding
