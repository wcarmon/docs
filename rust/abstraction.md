# Overview
1. How to structure reusable code files in larger projects
1. See [modules doc](./modules.md)
1. See [modeling doc](./modeling.md)


# Key Concepts
1. a [Workspace](https://doc.rust-lang.org/cargo/reference/workspaces.html) contains Packages
    1. Packages share [`Cargo.lock`](https://doc.rust-lang.org/cargo/guide/cargo-toml-vs-cargo-lock.html)
    1. Packages share output dir (called [target](https://doc.rust-lang.org/cargo/reference/cargo-targets.html))
1. a [Package](https://doc.rust-lang.org/book/ch07-01-packages-and-crates.html#packages-and-crates) contains Crates
    1. a Package owns [`Cargo.toml`](https://doc.rust-lang.org/cargo/guide/cargo-toml-vs-cargo-lock.html)
1. a [Crate](https://doc.rust-lang.org/rust-by-example/crates.html) contains Modules
    1. a Crate corresponds to one artifact (lib or one executable/binary)
    1. a Crate is a [compilation unit](https://doc.rust-lang.org/rust-by-example/crates.html)
1. a [Module](./modules.md) contains `fn`, structs, [enums](https://doc.rust-lang.org/book/ch06-01-defining-an-enum.html), [traits](./traits.md), [methods](https://doc.rust-lang.org/reference/expressions/method-call-expr.html), sub-modules, ...
    1. a Module contains 1 or more `*.rs` files
    1. a Module is a visibility barrier (think [`pub`](https://doc.rust-lang.org/std/keyword.pub.html), private, ...)
1. You can "spread" [Methods](https://doc.rust-lang.org/reference/expressions/method-call-expr.html) across `*.rs` files, across modules, across crates, or across packages


# Idioms
1. Let a `*.rs` file be the **default** level of abstraction for one task/concept
    1. Golang equivalent: one package
    1. Java equivalent: one class
1. Define a method in exactly one of these two files:
    1. Where the type ([enum](https://doc.rust-lang.org/book/ch06-01-defining-an-enum.html), [struct](https://doc.rust-lang.org/book/ch05-01-defining-structs.html)) is defined
    1. Where the [trait](./traits.md) is defined


1. [Compare to golang](../golang/abstraction.md)


# Other Resources
1. https://doc.rust-lang.org/book/ch07-00-managing-growing-projects-with-packages-crates-and-modules.html
1. https://doc.rust-lang.org/rust-by-example/mod.html
1. https://doc.rust-lang.org/book/ch14-03-cargo-workspaces.html

