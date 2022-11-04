# Overview
1. Key features of variables & constants


# Basic types
- See also [types](./types.basic.md) doc


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


# Constants
1. Created at compile time
    1. Only number, character (rune), string or boolean
    1. no function calls
    1. can use some math operators (eg. `<<`)
```go
TODO
```


# Other resources
