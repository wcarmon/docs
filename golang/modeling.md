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
```go
TODO
```


## [At-most-one](https://en.wikipedia.org/wiki/Option_type) (aka "Maybe")
1. TODO
```go
TODO
```


## Zero-or-more
1. TODO
```go
TODO
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
1. Use [`uint`]()
```go
TODO
```


## Group of related fields ([Product Algebraic data type](https://en.wikipedia.org/wiki/Product_type))
1. TODO
```go
TODO
```


## Semantic wrapper (user-defined primitive types)
1. TODO
```go
TODO
```


## [Has-a](https://en.wikipedia.org/wiki/Has-a)
1. TODO
```go
TODO
```


## [Is-a](https://en.wikipedia.org/wiki/Is-a)
1. TODO
```go
TODO
```


## Visibility/Encapsulation


## Mutability


## [Thread-safety](https://en.wikipedia.org/wiki/Thread_safety)



# TODO/Unorganized
- embedding
- TODO: pattern matching
- TODO: preconditions (logic)


# Other Resources
1. https://markoengelman.com/ddd-anemic-vs-rich-domain-model/
