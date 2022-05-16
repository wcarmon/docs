# Overview
- Key features of common collections
- Operations on common collections


# Array
1. Fixed size, length is part of the type
1. Rarely used in practice (Use slice instead)
1. [Official Tour guide](https://go.dev/tour/moretypes/6)
1. [go by example](https://gobyexample.com/arrays) doc

# Slice
1. dynamically-sized, in-memory sequence
1. Like an [`ArrayList`](https://docs.oracle.com/en/java/javase/11/docs/api/java.base/java/util/ArrayList.html) in java
1. [How slices work](https://go.dev/blog/slices-intro)

## Creation
```go
TODO
```

## Iteration
```go
for index, value := range mySlice {
    total += value
}
```

# Map

## Creation
```go
TODO
```

## Iteration
```go
for key, value := range someMap {
  someMap[key] = value
}

for key := range someMap {
  // do something with key
}

```

# Set

## Creation
```go
TODO
```

## Iteration
```go
TODO
```

# Queue
TODO

# Stack
TODO

# Heap (Priority Queue)
TODO

# TreeMap
TODO

# Strings
See [Strings doc](./strings.md)


# Other resources
- https://go.dev/tour/moretypes/7
- https://ueokande.github.io/go-slice-tricks/
- https://gobyexample.com/slices
- https://gobyexample.com/maps
