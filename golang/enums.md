# Overview
- How enums work
- [`iota`](https://go.dev/ref/spec#Iota) (not [`itoa`](https://pkg.go.dev/strconv#Itoa))


# iota
1. [iota](https://go.dev/ref/spec#Iota) is a constant
    1. only works inside a [`const` declaration](https://go.dev/ref/spec#Constant_declarations)
1. Starts at `0` (not `1`)


# Enum Definition Example
```go
type GameDirection uint8

const (
	Unknown = GameDirection(iota)
	Up
	Down
	Left
	Right
)

// Helper method example
func (d GameDirection) IsHorizontal() bool {
	switch d {
	case Left, Right:
		return true
    default:
        return false
	}
}
```


# Lookup Function Examples
```go
//TODO: lookup by string
//TODO: lookup by number
//TODO: iteration
```


# String/Labels Example
## Using a Switch
1. Faster than `map` approach, but harder to maintain
```go
// signature matches fmt.Stringer interface
func (d GameDirection) String() string {
	switch d {
	case Down:
		return "Down"
	case Left:
		return "Left"
	case Right:
		return "Right"
	case Up:
		return "Up"
	default:
		return "N/A"
	}
}
```

## Using a [Map](./collections.maps.md)
1. Indirect lookups, but simpler to maintain than `switch` approach
```go
var directionLabels = map[GameDirection]string{
	Down:  "Down",
	Left:  "Left",
	Right: "Right",
	Up:    "Up",
}

// signature matches fmt.Stringer interface
func (d GameDirection) String() string {
	s, ok := directionLabels[d]
	if !ok {
		return "N/A"
	}

	return s
}
```


# Iteration Example
```go
TODO: do I need this?
```


# Idioms
1. Prefer unsigned numeric type
1. Declare a new type (not an alias)
    1. Compiler distinguishes from other enums
1. Start with `Unknown` (as zero value)
    1. Helps detect unset value
    1. Helps integrate with [gRPC](https://grpc.io/) and [Protocol Buffers](https://developers.google.com/protocol-buffers)


# Other resources
1. [Official docs](https://go.dev/ref/spec#Iota)
1. https://dlintw.github.io/gobyexample/public/constants-and-iota.html
1. https://yourbasic.org/golang/iota/
1. https://golangbyexample.com/iota-in-golang/
1. https://medium.com/swlh/iota-create-effective-constants-in-golang-b399f94aac31
