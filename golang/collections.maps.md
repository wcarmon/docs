# Overview
- Key features & common operations for Maps


# Maps
1. Key-value pairs
1. Key can be any type with equality operator defined
    1. eg. string, integer, float, pointer, struct, array, most interfaces
    1. NOT slices

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

# Idioms
TODO ...


# Other resources
- https://gobyexample.com/maps
