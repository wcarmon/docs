# Overview
1. How to make go enforce your [invariants](https://medium.com/code-design/invariants-in-code-design-557c7864a047)
1. See [abstraction doc](./abstraction.md)
1. For comparison, see the [rust version of this doc](../rust/modeling.md)


# Key Concepts
1. **Goal**: Make illegal states in the domain model unrepresentable (compiler enforced)
1. Languages with **strong** modeling tools represent invariants with **types**
    1. **Compiler** is responsible for enforcing invariants
1. Languages with **weak** modeling tools represent invariants with **methods/logic**
    1. **Runtime** is responsible for enforcing invariants

1. Go has relatively weak modeling tools
    1. (but still stronger than c, javascript, python, all dynamic languages, ...)
    1. [Compare to rust](../rust/modeling.md)
    1. [Compare to kotlin](TODO)


# Patterns
## Absence
1. Use nilable type
1. [`sql`](https://pkg.go.dev/database/sql#NullBool) package also provides nilable types
```go
var favoriteBook *Book = nil
```


## [At-most-one](https://en.wikipedia.org/wiki/Option_type) (aka "Maybe")
1. Use nilable type
```go
type Employee struct {
    FavoriteBook *Book // at most one
}
```


## Zero-or-more
1. Use a [slice](./collections.slices.md)
```go
type Employee struct {
    PreviousEmployers []Employer // zero or more
}
```


## Exactly-one
1. TODO
```go
TODO
```


## Exactly-one of bounded set ([Sum Algebraic data type](https://en.wikipedia.org/wiki/Tagged_union))
1. TODO
```go
TODO
```


## At-least-one
1. TODO
```go
TODO
```


## Non-negative value
1. Use [`uint8`](https://pkg.go.dev/builtin#uint8), [`uint16`](https://pkg.go.dev/builtin#uint16), [`uint32`](https://pkg.go.dev/builtin#uint32) or [`uint64`](https://pkg.go.dev/builtin#uint64)
```go
var age uint8 = 30 // compiler enforced non-negative
```


## Group of related fields ([Product Algebraic data type](https://en.wikipedia.org/wiki/Product_type))
1. Use a [`struct`](./structs.md)


## Semantic wrapper (user-defined primitive types)
1. TODO
```go
TODO
```


## [Has-a](https://en.wikipedia.org/wiki/Has-a)
1. Use a field on a [`struct`](./structs.md)
```go
TODO
```


## [Is-a](https://en.wikipedia.org/wiki/Is-a)
1. Implement an [interface](./interfaces.md)
    1. REMINDER: almost any type can implement an interface (numbers, strings, structs, ...)


## Visibility/Encapsulation
1. Use Upper/lower case
1. Separate code into different [packages](./packages.md)
    1. See [abstraction doc](./abstraction.md)


## Mutability
1. TODO


## [Thread-safety](https://en.wikipedia.org/wiki/Thread_safety)
1. TODO


# TODO/Unorganized
- TODO: embedding
- TODO: pattern matching
- TODO: preconditions (logic)


# Other Resources
1. https://markoengelman.com/ddd-anemic-vs-rich-domain-model/
