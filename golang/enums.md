# Overview
1. How enums work
1. [`iota`](https://go.dev/ref/spec#Iota) (not [`itoa`](https://pkg.go.dev/strconv#Itoa))
1. See also [`stringer`](./stringer.md) doc


# iota
1. [iota](https://go.dev/ref/spec#Iota) is a constant
    1. only works inside a [`const` declaration](https://go.dev/ref/spec#Constant_declarations)
1. Starts at `0` (not `1`)


# Enum Definition Example
1. [Zero value](https://dave.cheney.net/2013/01/19/what-is-the-zero-value-and-why-is-it-useful) is `UnknownFoo`
1. Suffix `Unknown` with distinct type to void collision with other enums in the package
```go
type GameDirection uint8

const (
	UnknownDirection = GameDirection(iota)
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
		//NOTE: Unknown case is here
		return false
	}
}
```


# String/Labels Example
## Using a [Map](./collections.maps.md)
1. Pro: simpler to maintain than `switch` approach
1. Pro: simpler reverse lookups
1. Pro: (sligtly) less code
1. Con: Indirect lookups
```go
var directionLabels = map[GameDirection]string{
	Down:  "Down",
	Left:  "Left",
	Right: "Right",
	Up:    "Up",
}

// NOTE: You can also generate these via stringer program
// signature matches fmt.Stringer interface
func (d GameDirection) String() string {
	s, ok := directionLabels[d]
	if !ok {
		return "N/A"
	}

	return s
}
```


## Using a Switch
1. Pro: Faster than `map` approach
1. Con: harder to maintain
1. Con: harder to do reverse lookups
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


# Lookup Function Examples
```go
func FromLabel(label string) GameDirection {
	candidate := strings.TrimSpace(label)

	for key, lbl := range directionLabels {
		if strings.EqualFold(lbl, candidate) {
			return key
		}
	}

	return Unknown
}

func FromValue(value uint8) GameDirection {
	switch GameDirection(value) {
	case Down:
		return Down
	case Left:
		return Left
	case Right:
		return Right
	case Up:
		return Up

	default:
		return Unknown
	}
}
```


# Iteration Example
```go
TODO: do I need this?
```


# Idioms
1. Prefer unsigned numeric type
1. Declare a new type (not an [alias](https://go.dev/ref/spec#Type_declarations))
    1. Compiler distinguishes from other enums
1. Start with `Unknown` (as zero value)
    1. Helps detect unset value
    1. Helps integrate with [gRPC](https://grpc.io/) and [Protocol Buffers](https://developers.google.com/protocol-buffers)

- TODO: catching missing branches in enum switch


# Other resources
1. [Official docs](https://go.dev/ref/spec#Iota)
1. https://threedots.tech/post/safer-enums-in-go/
1. https://dlintw.github.io/gobyexample/public/constants-and-iota.html
1. https://yourbasic.org/golang/iota/
1. https://www.practical-go-lessons.com/chap-27-enum-iota-and-bitmask
1. https://golangbyexample.com/iota-in-golang/
1. https://medium.com/swlh/iota-create-effective-constants-in-golang-b399f94aac31
