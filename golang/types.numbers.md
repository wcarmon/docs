# Overview
- Key features of numeric types
- See also [variables](./variables.md) doc
- See also [general types info](./types.basic.md) doc


# Literals
1. See [Official docs](https://go.dev/ref/spec#Integer_literals)
1. Examples
```go
n := -7
n := 3e4		// 30,000
n := 30_000		// 30,000
n := 0xFF		// 255
```


# Ranges
|Type|Range|
| ---|--- |
|`int8` | `-128` through `127` (`math.MaxInt8`) |
|`int16` | `-32,768` through `32,767` (`math.MaxInt16`) |
|`int32` | `-2,147,483,648` through `2,147,483,647` (`math.MaxInt32`) |
|`int64` | `-9,223,372,036,854,775,808` through `9,223,372,036,854,775,807` (`math.MaxInt64`) |
|`uint8` | `0` through `255` (`math.MaxUint8`) |
|`uint16` | `0` through `65,535` (`math.MaxUint16`) |
|`uint32` | `0` through `4,294,967,295` (`math.MaxUint32`) |
|`uint64` | `0` through `18,446,744,073,709,551,615` (`math.MaxUint64`) |
|`int` | at least 32-bits, but not an alias for `int32`|
|`uint` | TODO ...|

- TODO: floating

## Complex/Imaginary numbers
1. See [Official docs](https://go.dev/ref/spec#Imaginary_literals)
- TODO: more here
- `complex128`
- `complex64`



# Common operations

## max & min of numbers
TODO


## Formatting to string
TODO


## Parsing
TODO


## Absolute value
TODO


## Rounding
TODO


# Other resources
1. [Predefined constants](https://pkg.go.dev/math#pkg-constants)
