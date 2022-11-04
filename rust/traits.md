# Overview
1. What are [traits](https://doc.rust-lang.org/book/ch10-02-traits.html)?
1. How to use [traits](TODO)?
1. Popular core [traits](TODO)?


# Definitions
1. A trait is a collection of **methods** defined for an **unknown type**, called `Self`
1. Marker trait: agreement between user and implementer for something the compiler cannot represent


# Comparison

## Java
1. Similar to [java interfaces](https://docs.oracle.com/javase/tutorial/java/concepts/interface.html)
    1. Traits can "extend" other traits
    1. Traits *cannot* have fields, just methods
1. Differences
    1. implementation is decoupled from the type (`impl` block is separate from struct/enum/type)
    1. Trait implementation is outside the type’s definition
    1. Can choose between vtable/indirect dispatch (heap allocated) and static/direct dispatch


## Golang
1. Similar to [golang interfaces](https://go.dev/ref/spec#Interface_types)
    1. Traits can "extend" other traits
    1. Traits *cannot* have fields, just methods
1. Differences
    1. Traits are **explicitly** implemented on types
    1. No embedding


## C++
1. Similar to c++ [abstract classes](TODO)
    1. Traits can "extend" other traits
1. Differences
    1. TODO: no fields
    1. [Operator overloading](https://doc.rust-lang.org/rust-by-example/trait/ops.html) works via traits


- TODO: trait implementations must be in separate `impl` block from unrelated methods

- TODO: https://doc.rust-lang.org/book/ch10-02-traits.html
- TODO: https://doc.rust-lang.org/rust-by-example/trait.html
- TODO: https://web.mit.edu/rust-lang_v1.25/arch/amd64_ubuntu1404/share/doc/rust/html/book/first-edition/traits.html
- TODO: https://www.educative.io/answers/what-are-traits-in-rust
- TODO: https://blog.logrocket.com/rust-traits-a-deep-dive/
- TODO: https://www.chiark.greenend.org.uk/~ianmdlvl/rust-polyglot/traits.html
- TODO: https://oswalt.dev/2020/07/rust-traits-defining-behavior/
- TODO: https://stevedonovan.github.io/rustifications/2018/09/08/common-rust-traits.html
- TODO: https://vino.dev/blog/node-to-rust-day-10-traits/
- TODO: https://cheats.rs/#generics-constraints
- TODO: compiler needs to know how much space every function's return type requires
- TODO: when is `into` required (and when is it implicit?)

# Other Resources
1. https://doc.rust-lang.org/book/ch10-02-traits.html
1. https://doc.rust-lang.org/rust-by-example/trait.html