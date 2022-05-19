# Overview
- Key features & common operations for Maps


# Key features of Maps
1. Key-value pairs
1. **NOT** [Thread safe](https://en.wikipedia.org/wiki/Thread_safety)
    1. [Official docs](https://go.dev/doc/faq#atomic_maps)
1. [Pass-by-reference](https://www.educative.io/edpresso/pass-by-value-vs-pass-by-reference)
    - If you pass a map to a function, it can mutate
1. Key can be any type with equality operator defined
    1. eg. string, integer, float, pointer, struct, array, most interfaces
    1. NOT slices
1. Like [`HashMap`](https://docs.oracle.com/en/java/javase/11/docs/api/java.base/java/util/HashMap.html) in java


# Creation
1. Via literal
```go
var m = map[string]int{
  "alice": 30,
  "janet": 28,
  "olivia": 42,
}
```
1. Via `make`
```go
m := make(map[string]int)
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
m := map[string]int{
  "a": 7,
  "b": 5,
}

delete(m, "b")
delete(m, "notPresent") // noop

fmt.Println(m) // map[a:1]
```


# Retrieval
1. when value missing, returns zero-value
```go
m := map[string]int{
  "a": 7,
  "b": 5,
}

fmt.Println(m["a"]) // 7
fmt.Println(m["c"]) // 0  zero value, not robust :-(

// -- Better pattern:
value, ok := m["c"]
if ok {  // ok == map-contains-c
    fmt.Println(value)
}
```


# Check for key
```go
if value, found := m["a"]; found {
    fmt.Println(value)
}
```


# Iteration
1. iteration order is random
```go
for key, value := range someMap {
  someMap[key] = value
}

// -- keys only
for k := range someMap {
  // do something with k
}

// -- values only
for _, v := range someMap {
    fmt.Println(v)
}
```

# Shallow copy
```go
src := map[string]int {
    "a": 7,
}

dest := make(map[string]int, len(src))
for k, v := range src {
    dest[k] = v
}
```

# Put-if-absent
```go
// Use a sync.Mutex when concurrent
if _,exists := m[key]; !exists {
    m[key] = "foo"
}
```


# Printing
```go
m := make(...)
fmt.Printf("Data: %#v\n", m)
```


# Idioms
1. Only use [`sync.Map`](https://pkg.go.dev/sync#Map) when you can demonstrate high lock contention
1. If you must **mutate** the map *value* (structs values), use pointer
    1. eg. `map[string]*myStruct`
1. If your *value* is complicated, use a [type alias](TODO)


# Other resources
1. [Official docs](https://go.dev/blog/maps)
1. [gobyexample.com](https://gobyexample.com/maps)
1. [Syncronized map](https://pkg.go.dev/sync#Map)
