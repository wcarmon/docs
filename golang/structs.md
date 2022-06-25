# Overview
- Key features & operations on structs

# Structs
1. [Pass-by-value](TODO)
    1. functions you invoke receive a copy of the struct
    1. behaves like `int`, `string`, `byte`, `rune`, `bool`, ...
    1. All things pass by value
1. No inheritance :-)
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
- TODO: Embedding

# Equality
1. TODO: ==
1. TODO: reflect.DeepEquals


# Shallow Copy/Clone
```go
a := Foo{
    // ... set properties ...
}

b := a
// b is a shallow copy
// change to b don't affect a
```
1. `copy(...)` function only works on [slices](./collections.slices.md), not structs


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
1. [Goland can build structs from json](https://www.jetbrains.com/help/go/working-with-json.html)


# Other resources
1. https://gobyexample.com/embedding
1. https://www.practical-go-lessons.com/chap-15-pointer-type#pointers-to-structs
