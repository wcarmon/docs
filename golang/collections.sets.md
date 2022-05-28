# Overview
- Key features & common operations on sets
- See [maps](./collections.maps.md) doc


# Key features of Sets
1. Implement using `map[T]bool`
1. Alternative: `map[T]struct{}` (empty struct as value)
    1. Set operations are a little more verbose, but consume less memory
    1. See [struct](./structs.md) doc


# Creation
```go
visited := make(map[string]bool)

visited["a"] = true
visited["b"] = true

if visited["a"] {
    fmt.Print("yep")
}
```


# Size
```go
theSize := len(theSet)
```


# Insertion/Update
```go
visited := make(map[string]bool)

visited["a"] = true
```

# Removal
```go
delete(theSet, "foo")
```


# Check for value
```go
visited["a"] = true
//...

if visited["a"] {
    fmt.Print("yep")
}
```


# Iteration
1. Iteration order is random
```go
for value, found := range visited {
    if !found {
        continue
    }

    fmt.Println(value)
}
```


# Shallow copy
```go
srcSet := make(map[string]bool)
//...

destSet := make(map[string]bool, len(srcSet))
for value, contains := range srcSet {
    if !contains {
        continue
    }

    destSet[value] = true
}
```


# Sorting
- See [sorting](./sorting.md) doc


# Other resources
1. TODO
