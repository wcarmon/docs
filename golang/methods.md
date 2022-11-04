# Overview
1. Key features of methods
1. See also [Functions](./functions.md) doc


# Methods overview
1. A [function](TODO) attached to a type
1. Almost anything can have methods (attached functions)
    1. structs (obvious), numbers, **functions**, channels
    1. CANNOT attach to interfaces
1. Method attached to a function allow decorating, proxying, ...
1. [Every type has a (possibly empty) method set associated](https://go.dev/ref/spec#Method_sets)


- TODO: mention "receiver"

# Intuition
1. Think of it like passing the receiver as first arg
```go
type Car struct {
}

func (c Car) DoFoo(arg int) int {
    // ...
}

car := Car{}
_ = car.DoFoo(7)

// equivalent to:  GenerateDoFoo(car, 7)
```

TODO: pointer receiver
TODO: non-pointer receiver


# Idioms
TODO ...


# Other resources
1. https://www.practical-go-lessons.com/chap-14-methods
