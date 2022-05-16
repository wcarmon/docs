# Overview
- ...

# Long declaration
```go
var ...
TODO: more here
```

# Short declaration
```go
f, err := os.Open("/foo")
```

# Naming
1. Naming: Use MixedCaps or mixedCaps


## Visibility
1 Exported: **upper** case first letter
1 Package private: **lower** case first letter


# Grouping
- Group related variables
```go
var (
    myLock sync.Mutex
    varThatRequiresLocking int32
)
```

TODO: underscore (blank identifier)

# Other resources
