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
```go
s := make([]string, 3)
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
TODO
```

# ~~Arrays~~
1. Fixed size, length is part of the type
1. Rarely used in practice (Use slice instead)
1. [Official Tour guide](https://go.dev/tour/moretypes/6)
1. [go by example](https://gobyexample.com/arrays) doc


# Other resources
- https://go.dev/tour/moretypes/7
- https://ueokande.github.io/go-slice-tricks/
- https://gobyexample.com/slices
