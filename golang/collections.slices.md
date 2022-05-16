# Overview
- Key features & common operations on Arrays, Slices, ...


# Slices
1. dynamically-sized, in-memory sequence
1. [Pass-by-reference](https://www.educative.io/edpresso/pass-by-value-vs-pass-by-reference) (not by-value)
    - If you pass a map to a function, it can mutate
1. **NOT** [Thread safe](https://en.wikipedia.org/wiki/Thread_safety)   <--- TODO: verify
1. Like an [`ArrayList`](https://docs.oracle.com/en/java/javase/11/docs/api/java.base/java/util/ArrayList.html) in java
1. [How slices work](https://go.dev/blog/slices-intro)

# Creation
1. Via literal
```go
s0 := []string{"a", "b", "c"}
```
1. Via `make`
```go

// capacity is 3
// contains 3 items with zero value (empty string)
s1 := make([]string, 3)

// capacity is 10
// contains 3 items with zero value (empty string)
s2 := make([]string, 3, 10)
```

# Size
```go
theSize := len(mySlice)
```

# Append
```go
TODO
```

# Iteration
```go
for index, value := range mySlice {
    total += value
}
```


# Shallow copy
```go
src := []string{"a", "b"}

dest := make([]string, len(src))
copy(dest, src)
```


# ~~Arrays~~
1. Fixed size, length is part of the type
1. Rarely used in practice (Use slice instead)
1. [Official Tour guide](https://go.dev/tour/moretypes/6)
1. [go by example](https://gobyexample.com/arrays) doc
1. Primary use case is as a building block for slices


# Other resources
- https://go.dev/tour/moretypes/7
- https://ueokande.github.io/go-slice-tricks/
- https://gobyexample.com/slices
