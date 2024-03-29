# Overview
1. Key features of Basic types
1. See also [variables](./variables.md) doc


# Numeric types
- See [numbers](./types.numbers.md) doc


# Boolean
- `bool`
   - not ~~`boolean`~~
- Literal: `true` or `false`


# Characters, Strings, Runes
- See [strings](./strings.md) doc


# Type definition & Aliases
## Alias declaration
```go
type T2 = T1
```
1. No new type created, just a new name
1. Can assign directly (cast is redundant)
1. Same fields
1. Same methods
1. See [Language Spec](https://go.dev/ref/spec#Type_declarations)

## Type definition (behaves similar to an alias)
```go
type T2 T1
```
1. Creates a new type
1. Cannot assign directly (you must cast)
1. Same fields
1. Does NOT get/inherit methods
1. See [Language Spec](https://go.dev/ref/spec#Type_declarations)
K

# Conversions
1. Other languages call this casting
1. Conversion with pointer may require extra parentheses
    1. See [Official doc](https://go.dev/ref/spec#Conversions)


# Idioms
- TODO ...


# Other Resources
1. TODO ...
