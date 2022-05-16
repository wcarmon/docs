# Overview
- Control flow structures & idioms


# Conditional
1. Simple example
```go
if x < 3 {
    return z
}
```

1. Compound example, checks for error
```go
if err := file.Chmod(0755); err != nil {
    return err
}
```

# Loops (iteration)
1. Like a [`while`](https://docs.oracle.com/javase/tutorial/java/nutsandbolts/while.html)
```go
for shouldContinue {
  // ...
}
```
1. Run until explicit exit
```go
for {
    // ...
    // break or return
}
```
1. Fixed iterations
```go
for i := 0; i < 10; i++ {
  // ...
}
```
1. Map iteration: See [maps](./collections.maps.md) doc
1. Slice iteration: See [slices](./collections.slices.md) doc

# Switch
1. No automatic fall thru
1. General switch, alternative to if-elseif chains
```go
switch {
case isBlue && isAlive:
    return "smurf"
case isYellow && isAlive:
    return "minion"
}
```

- TODO: switch on enum
- TODO: switch on character
- TODO: switch on number
- TODO: switch on string
- TODO: type switch
- TODO: switch: multiple cases (comma separated)


# Idioms
1. Rarely use `else`, use multiple `return`s instead


# Other resources
1. https://gobyexample.com/if-else
1. https://gobyexample.com/for

