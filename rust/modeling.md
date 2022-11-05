# Overview
1. How to make [rustc](https://doc.rust-lang.org/rustc/what-is-rustc.html) enforce your [invariants](https://medium.com/code-design/invariants-in-code-design-557c7864a047) at [compile time](https://en.wikipedia.org/wiki/Compile_time)
1. See [abstraction doc](./abstraction.md)
1. For comparison, see the [go version of this doc](../golang/modeling.md)


# Key Concepts
1. Languages with **strong** modeling tools represent invariants with **types**
    1. Compiler is responsible for enforcing invariants
1. Languages with **weak** modeling tools represent invariants with **methods/logic**
    1. runtime is responsible for enforcing invariants


# Idioms
## Absence
1. Use [None](https://doc.rust-lang.org/std/option/enum.Option.html#variant.None)
```rust
let favorite_book: Option<Book> = None;
```


## Exactly-one
1. Use a field on a [struct](./structs.md) or enum
```rust
struct Employee {
    id: u16,      // exactly one
    name: String, // exactly one
}
```


## [At-most-one, Maybe](https://en.wikipedia.org/wiki/Option_type)
1. Use [Option](https://doc.rust-lang.org/std/option/index.html)
- TODO: code example


## Zero or more
1. Use [Vec](https://doc.rust-lang.org/std/vec/struct.Vec.html)
```rust
TODO
```


## Non-negative value
1. Use [u8](https://doc.rust-lang.org/std/primitive.u8.html), [u16](https://doc.rust-lang.org/std/primitive.u16.html), [u32](https://doc.rust-lang.org/std/primitive.u32.html), [u64](https://doc.rust-lang.org/std/primitive.u64.html), or [u128](https://doc.rust-lang.org/std/primitive.u128.html)
1. [rustc](https://doc.rust-lang.org/rustc/what-is-rustc.html) will enforce range on numeric literals
```rust

# TODO/Unorganized
- Algebraic Data Types
- ALL/AND
- at-least-one
- embedding
- enum
- has-a
- is-a
- mutability
- OR
- sharability
- struct
- TODO: defensive copy (logic)
- TODO: pattern matching
- TODO: preconditions (logic)
- TODO: sealed classes
- type safety
- visibility/encapsulation
- type: compiler enforces number literals are within range



# Other Resources
1. https://markoengelman.com/ddd-anemic-vs-rich-domain-model/
1. https://doc.rust-lang.org/std/option/
1. https://hugotunius.se/2020/05/16/making-invalid-state-unrepresentable.html