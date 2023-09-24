# Overview

1. [Ownership](https://doc.rust-lang.org/book/ch04-00-understanding-ownership.html) purpose, usage

# Purpose

1. To manage the [heap](./memory.md) without [a garbage collector](https://en.wikipedia.org/wiki/Garbage_collection_(computer_science))
1. For compile-time verification of memory safety

# Concepts & Rules

1. each value/resource is owned by exactly one [variable](https://doc.rust-lang.org/reference/variables.html)
1. [value] is dropped when owner (variable) goes out of scope (rust automatically calls [drop](https://doc.rust-lang.org/rust-by-example/trait/drop.html))
    1. Scope: tell the compiler when borrows are valid, when resources can be freed, and when variables are created or destroyed.
1. [variables](https://doc.rust-lang.org/reference/variables.html) are in charge of freeing their own resources/values
1. Ownership Begins with assignment

# Usage

1. **Optionally** use [drop](https://doc.rust-lang.org/rust-by-example/trait/drop.html) func to cleanup early

## Move semantics

1. `=` [moves](https://doc.rust-lang.org/rust-by-example/scope/move.html) ownership by default
1. function arguments move by default
1. function return types move by default
1. All types are movable

## fn arguments

1. Option-1: borrow, pass by read-only reference (generally preferred): `&T`
    1. Allows multiple readers
    1. Allows caller to send either owned or borrowed values
1. Option-2: borrow, pass by *mutable* reference: `&mut T`
1. Option-3: move, pass by value: `T`
    1. Only allows caller to send owned values
1. Option-4: [clone](https://doc.rust-lang.org/rust-by-example/trait/clone.html) (explicit)
1. Option-5: [copy](https://doc.rust-lang.org/std/marker/trait.Copy.html) (implicit)
    1. avoid unless you understand the full implications


- TODO: https://dev.to/cthutu/rust-2-lifetimes-owners-and-borrowers-oh-my-3fem
- TODO: https://vino.dev/blog/node-to-rust-day-5-ownership/
- TODO: https://cheats.rs/#memory-lifetimes

# Other Resources

1. https://doc.rust-lang.org/book/ch04-00-understanding-ownership.html
1. [Memory doc](./memory.md)
1. https://blog.logrocket.com/understanding-ownership-in-rust/
1. https://www.makeuseof.com/rust-ownership/
1. https://web.mit.edu/rust-lang_v1.25/arch/amd64_ubuntu1404/share/doc/rust/html/book/second-edition/ch04-01-what-is-ownership.html
1. https://dev.to/cthutu/rust-2-lifetimes-owners-and-borrowers-oh-my-3fem
