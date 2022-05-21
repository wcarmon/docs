# Overview
- Key features & common operations on Slices, Arrays, ...


# Slices
1. Dynamically-sized, in-memory sequence
1. **NOT** [Thread safe](https://en.wikipedia.org/wiki/Thread_safety)
1. [Pass-by-reference](https://www.educative.io/edpresso/pass-by-value-vs-pass-by-reference)
    - If you pass a slice to a function/method, callee can mutate the slice
1. [How slices work](https://go.dev/blog/slices-intro)
1. Like an [`ArrayList`](https://docs.oracle.com/en/java/javase/11/docs/api/java.base/java/util/ArrayList.html) in java


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
1. Auto resizes when out of capacity
```go
// length == 1, capacity 3
s := make([]int32, 1, 2)
fmt.Println(s)  // [0]

s = append(s, 1)

// When it grows the reference changes
s = append(s, 2)
s = append(s, 3)

cap(s) // capacity is 4, doubles when it grows
fmt.Println(s)  // [0 1 2 3]
```
1. Appending another slice
```go
a := []int32{2, 3, 4}
b := []int32{5, 6}

a = append(a, b...)
fmt.Println(a) // [2 3 4 5 6]
```
1. Other [useful slice tricks](https://ueokande.github.io/go-slice-tricks/)


# Iteration
```go
for index, value := range mySlice {
    total += value
}
```


# Slicing
1. Retrieve sub-slice
1. [Slicing is both common and efficient](https://go.dev/blog/slices-intro)
1. Get first `n`
```go
fmt.Println(s[:n]) // [0, 1, ...], first n-items, size=n

// Example:
s := []int{0, 1, 2, 3, 4, 5}
fmt.Println(s[:2]) // [0, 1], first 2 items, size=2
```
1. Get last `n`
```go
fmt.Println(s[n:]) // size = len(s) - n

// Example:
s := []int{0, 1, 2, 3, 4, 5}
fmt.Println(s[2:]) // [2 3 4 5], size == 4 == len(s) - n
```
1. Get middle
```go
s := []int{0, 1, 2, 3, 4, 5}
fmt.Println(s[2:4]) // [2,3], closed-open range
```
1. See [Language spec](https://go.dev/ref/spec#Slice_expressions)


# Shallow copy
```go
src := []string{"a", "b"}

dest := make([]string, len(src))
copy(dest, src)
```


# Sorting
- See [sorting](./sort.md) doc


# Printing
```go
colors := make([]string, 0)
fmt.Printf("Colors: %#v\n", colors)
```


# Casting
```go
type z string
before := []string{"a", "b", "c"}

after := make([]z, 0, len(before))
for _, v := range before {
    after = append(after, z(v))
}
```


# ~~Arrays~~
1. Fixed size
1. Length is part of the type
    1. eg. `[3]string` and `[4]string` are different types
1. Rarely useful in practice (Use slice instead)
1. Primary use case is as a building block for slices
1. Sometimes used for multi-dimensional matrices
1. [go by example](https://gobyexample.com/arrays) doc
1. Pass-by-value


# Other resources
1. [Really useful slice tricks](https://ueokande.github.io/go-slice-tricks/)
1. https://go.dev/tour/moretypes/7
1. https://gobyexample.com/slices
1. https://codeburst.io/a-comprehensive-guide-to-slices-in-golang-bacebfe46669