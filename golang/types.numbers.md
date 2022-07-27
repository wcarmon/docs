# Overview
- Key features of numeric types
- See also [variables](./variables.md) doc
- See also [general types info](./types.basic.md) doc


# Literals
1. See [Official docs](https://go.dev/ref/spec#Integer_literals)
1. Examples
```go
n := -7
n := 3e4		// 30,000  (4 zeros)
n := 1e+7 == 10_000_000 (7 zeros)
n := 30_000		// 30,000
n := 0xFF		// 255
```


# Ranges
1. See [Language spec](https://go.dev/ref/spec#Numeric_types)
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

# Floating point
1. [`float64`](https://go.dev/ref/spec#Numeric_types)
    1. can represent about **16 decimal digits**.
    1. same as rust [`f64`](https://doc.rust-lang.org/std/primitive.f64.html)
    1. same as java [`double`](https://docs.oracle.com/en/java/javase/17/docs/api/java.base/java/lang/Double.html)
    1. same as c++ [`double`](https://en.cppreference.com/w/cpp/language/types)
    1. same as dart [`double`](https://api.dart.dev/stable/2.17.5/dart-core/double-class.html)
    1. See https://en.wikipedia.org/wiki/IEEE_754-1985
1. [`float32`](https://go.dev/ref/spec#Numeric_types)
    1. can represent about **7 decimal digits**
    1. same as rust [`f32`](https://doc.rust-lang.org/std/primitive.f32.html)
    1. same as java [`float`](https://docs.oracle.com/en/java/javase/17/docs/api/java.base/java/lang/Float.html)
    1. same as c++ [`float`](https://en.cppreference.com/w/cpp/language/types)


# [`big.Float`](https://pkg.go.dev/math/big)
1. Use `string` in json, `"3.1e+08"` syntax works
1. Prefer pointer for for fields in structs: ``Foo *big.Float `json:"foo"` ``
    1. simplifies json & printing

## Print
```go
fmt.Printf("%s\n", myBigFloat.Text('f', 20)) // <-- 20 decimal places

fmt.Printf("%g\n", myBigFloat)
```

## Parse string
```go
f := new(big.Float)
_, ok := f.SetString(str)
if !ok {
    ...
}
```

## Addition
- [`.Add`](https://pkg.go.dev/math/big#Float.Add) will replace the value on the receiver (thing before the dot)
```go
a := big.NewFloat(1.6)
b := big.NewFloat(2.4)
c := big.NewFloat(6.0)

sum := new(big.Float)
sum.Add(sum, a) // works like: sum += a
sum.Add(sum, b)
sum.Add(sum, c)
// sum is 10.0
```

## [Subtraction](https://pkg.go.dev/math/big#Float.Sub)
```go
a := big.NewFloat(1.0)
b := big.NewFloat(4.4)

diff := new(big.Float).Sub(a, b)  // -3.4000000000000004
```

## [Multiplication](https://pkg.go.dev/math/big#Float.Mul)
```go
a := big.NewFloat(-1.3)
b := big.NewFloat(4.4)

product := new(big.Float).Mul(a, b) // -5.720000000000001
```


## Flexible json unmarshal:
```go
var f = new(big.Float)

switch amt := rawAmount.(type) {
case int8:
    f.SetInt64(int64(amt))
case int16:
    f.SetInt64(int64(amt))
case int32:
    f.SetInt64(int64(amt))
case int64:
    f.SetInt64(amt)

case float32:
    f.SetFloat64(float64(amt))
case float64:
    f.SetFloat64(amt)

case string:
    f.SetString(amt)
default:
    return fmt.Errorf("TODO: handle type: %T", amt)
}
```

## Test for Equality
```go
a := big.NewFloat(1.6)
b := big.NewFloat(1.6000)
areEqual := a.Cmp(b) == 0 // true
```
## Test for Positive/Negative
1. Recall: zero value of `big.Float` is `0.0`
```go
n := ...
isNegative := new(big.Float).Cmp(n) > 0
```

## Close enough (small delta)
```go
func IsCloseEnough(
	want, got *big.Float,
	tolerance float64,
) bool {
    if want == nil && got == nil {
        return true
    }

	delta := new(big.Float).Sub(got, want)

	return delta.Abs(delta).Cmp(big.NewFloat(tolerance)) < 0
}
```

## Absolute value
```go
n = ...
alwsyPositive := new(big.Float).Abs(n)
```


# Complex/Imaginary numbers
1. See [Official docs](https://go.dev/ref/spec#Imaginary_literals)
- TODO: more here
- `complex128`
- `complex64`


# Common operations

## max & min of numbers
1. Easy for float: [`math.Min(f0, f1)`](https://pkg.go.dev/math#Min)
1. Hard for other numbers
    1. See https://stackoverflow.com/questions/27516387/what-is-the-correct-way-to-find-the-min-between-two-integers-in-go
    1. See https://unexpected-go.com/theres-no-min-function.html
```go
if a < b {
  ...
} else {
  ...
}
```

## Formatting to string
### Print hex
```
fmt.Printf("%x\n", 16)   // 10
fmt.Printf("%x\n", 10)   // a
```


## Parsing
TODO


## Absolute value
TODO


## Rounding
TODO


# Other resources
1. [Predefined constants](https://pkg.go.dev/math#pkg-constants)
