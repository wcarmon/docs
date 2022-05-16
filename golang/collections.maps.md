# Overview
- Key features & common operations for Maps


# Maps
1. Key-value pairs
1. **NOT** [Thread safe](https://en.wikipedia.org/wiki/Thread_safety)
1. [Pass-by-reference](https://www.educative.io/edpresso/pass-by-value-vs-pass-by-reference)
    - If you pass a map to a function, it can mutate
1. Key can be any type with equality operator defined
    1. eg. string, integer, float, pointer, struct, array, most interfaces
    1. NOT slices
1. Like [`HashMap`](https://docs.oracle.com/en/java/javase/11/docs/api/java.base/java/util/HashMap.html) in java

## Creation
1. Via literal
```go
var map0 = map[string]int{
  "alice": 30,
  "janet": 28,
  "olivia": 42,
}
```
1. Separate declaration and init
```go
TODO
```

# Size
```go
theSize := len(myMap)
```

# Insertion/Update
```go
myMap["foo"] = 7
```

# Removal
```go
TODO
```

# Iteration
```go
for key, value := range someMap {
  someMap[key] = value
}

for key := range someMap {
  // do something with key
}
```

# Shallow copy
```go
TODO
```


# Idioms
TODO ...


# Other resources
- https://gobyexample.com/maps
