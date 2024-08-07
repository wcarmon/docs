# Overview

1. How to make [rustc](https://doc.rust-lang.org/rustc/what-is-rustc.html) enforce your [invariants](https://medium.com/code-design/invariants-in-code-design-557c7864a047) at [compile time](https://en.wikipedia.org/wiki/Compile_time)
1. See [abstraction doc](./abstraction.md)
1. For comparison, see the [golang version of this doc](../golang/modeling.md)

# Key Concepts

1. **Goal**: Make illegal states in the domain model unrepresentable (compiler enforced)
1. Languages with **strong** modeling tools represent invariants with **types**
    1. **Compiler** is responsible for enforcing invariants
1. Languages with **weak** modeling tools represent invariants with **methods/logic**
    1. **Runtime** is responsible for enforcing invariants

# Patterns

## Absence

1. Use [`None`](https://doc.rust-lang.org/std/option/enum.Option.html#variant.None)

```rust
let favorite_book: Option<Book> = None;
```

1. NOTE: safe rust [never allows null pointers](https://doc.rust-lang.org/std/ptr/index.html)

## [At-most-one](https://en.wikipedia.org/wiki/Option_type) (aka "Maybe")

1. Use [`Option`](https://doc.rust-lang.org/std/option/index.html)

```rust
struct Employee {
    favorite_book: Option<Book>, // at most one
}
```

## Zero-or-more

1. Use [`Vec`](https://doc.rust-lang.org/std/vec/struct.Vec.html)

```rust
struct Employee {
    previous_employers: Vec<Employer>, // zero or more
    ...
}
```

## Exactly-one

1. Use a field on a [`struct`](./structs.md) or [`enum`](./enums.md)

```rust
struct Employee {
    id: u16,      // exactly one
    name: String, // exactly one
    ...
}
```

## Exactly-one of bounded set ([Sum Algebraic data type](https://en.wikipedia.org/wiki/Tagged_union))

1. Use an [`enum`](./enums.md)
1. Use [Pattern matching](https://doc.rust-lang.org/book/ch18-00-patterns.html), [more info](https://doc.rust-lang.org/book/ch18-03-pattern-syntax.html)

## At-least-one

- In "Algebraic type" language
    - Product type with restrictions
    - Sum type with combinations

### ... of the same thing

- [non empty vec library](https://docs.rs/nonempty/latest/nonempty/)
- Vec with runtime enforcement

### ... of different things

- struct/tuple with optional fields with runtime enforcement
- bit fields
- builder struct + validated impl struct hidden behind pub trait

## One of Two peers
- https://crates.io/crates/either

## Non-negative value

1. Use [`u8`](https://doc.rust-lang.org/std/primitive.u8.html), [`u16`](https://doc.rust-lang.org/std/primitive.u16.html), [`u32`](https://doc.rust-lang.org/std/primitive.u32.html), [`u64`](https://doc.rust-lang.org/std/primitive.u64.html), or [`u128`](https://doc.rust-lang.org/std/primitive.u128.html)
1. [rustc](https://doc.rust-lang.org/rustc/what-is-rustc.html) will enforce range on [numeric literals](https://doc.rust-lang.org/rust-by-example/primitives/literals.html)

```rust
let age: u8 = 30; // compiler enforced non-negative
```

# Floats in specific range
- https://docs.rs/typed_floats/latest/typed_floats/

## Group of related fields ([Product Algebraic data type](https://en.wikipedia.org/wiki/Product_type))

1. Use a [`struct`](./structs.md)
1. (Less common) Use a [tuple](https://doc.rust-lang.org/std/primitive.tuple.html)

## [Has-a](https://en.wikipedia.org/wiki/Has-a)

1. Use a field on a [`struct`](./structs.md) or [`enum`](./enums.md)

```rust
struct Employee {
    department: Department,      // has-a
    ...
}
```

## [Is-a](https://en.wikipedia.org/wiki/Is-a)

1. Implement a [trait](./traits.md)

## Visibility/Encapsulation

- See [modules doc](./modules.md#visibilityencapsulation)

## Mutability

1. [Prefer immutability](../common/immutability.md), Use [mut](https://doc.rust-lang.org/book/ch03-01-variables-and-mutability.html) (only when required)
    1. [`Clone`](https://doc.rust-lang.org/std/clone/trait.Clone.html) might be applicable here too (rust's version of a [defensive copy](http://www.javapractices.com/topic/TopicAction.do?Id=15))

## [Thread-safety](https://en.wikipedia.org/wiki/Thread_safety)

1. See [fearless concurrency doc](https://doc.rust-lang.org/book/ch16-00-concurrency.html)
1. [Send](https://doc.rust-lang.org/std/marker/trait.Send.html) and [Sync](https://doc.rust-lang.org/std/sync/) marker [traits](./traits.md) may help

## Augmenting external types

- adding method(s) to a type defined in another crate

### Option-A: Define [Trait](./traits.md) with new methods

1. `impl MyTrait for ExternalType`
1. Functions can accept/return *MyTrait*

### Option-B: Wrap external types using [newtype pattern](https://doc.rust-lang.org/rust-by-example/generics/new_types.html)

1. proxy or [shrinkwrap](https://docs.rs/shrinkwraprs/latest/shrinkwraprs/) external types
    1. [example-1](https://doc.rust-lang.org/rust-by-example/generics/new_types.html)
    1. [example-2](https://rust-unofficial.github.io/patterns/patterns/behavioural/newtype.html)
    1. [example-3](https://doc.rust-lang.org/book/ch19-04-advanced-types.html)


# TypeState pattern
1. Goal: make illegal state unrepresentable
1. Steps:
    1. Draw out the state transition diagram 
    1. Make `struct` for each state
    1. Add methods on each (non-terminal) state struct for each state transition
    1. each transition method must consume `self`
       - guarantees transitions happen at-most once
    1. limit how intermediate & terminal state structs are created
        - `::new` method consumes previous state struct
        - or [`#[non_exhaustive]`](https://doc.rust-lang.org/reference/attributes/type_system.html)
        - or private [`PhantomData`](https://doc.rust-lang.org/std/marker/struct.PhantomData.html) field on intermediate state struct
    1. If you must manage lifecycle in a field, wrap field in an [`Rc`](https://doc.rust-lang.org/std/rc/struct.Rc.html)


# Other Resources

1. https://markoengelman.com/ddd-anemic-vs-rich-domain-model/
1. https://doc.rust-lang.org/std/option/
1. https://hugotunius.se/2020/05/16/making-invalid-state-unrepresentable.html
