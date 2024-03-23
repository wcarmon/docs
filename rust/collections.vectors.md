# Overview
1. Vectors, Slices, Arrays, Iterators
1. See [Generics doc](./generics.md)
1. See [Iterators doc](./iterators.md)


# Idioms
1. `fn` should accept `&[T]` (not ~~`Vec<T>`~~)
1. `fn` should return `Vec<T>` (not ~~`&[T]`~~)


# [Vector](TODO)
1. contiguous growable
1. Always heap allocated
1. Owned (just like [`String`](TODO))
    1. Slice is the borrowed version
1. Comparison
    1. Similar to [slice](../golang/collections.slices.md) in golang
    1. Similar to [ArrayList](https://docs.oracle.com/en/java/javase/19/docs/api/java.base/java/util/ArrayList.html) in java
    1. Similar to [Array](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array) in javascript
    1. Similar to [List](https://docs.python.org/3/tutorial/datastructures.html#more-on-lists) in python
1. `vec![...]` macro
1. TODO: Ranges


# [Slice](TODO)
1. A view into part of an array
1. Borrowed (just like [`&str`](TODO)
    1. Vector is the owned version
1. allows provably safe, efficient access to sub-array (without a copy)
1. Can be mutable or immutable (depends if variable is `mut`) 
1. TODO: Vec to slice via [..] - https://doc.rust-lang.org/std/vec/struct.Vec.html#slicing
1. TODO: Vec to slice via implicit Deref coercion ..


# Array
1. Fixed size
1. Size is part of the type



# Gotcha: 
- `::push()` (not `.add()`, not `append`)


- TODO: https://doc.rust-lang.org/book/ch08-01-vectors.html
- TODO: https://learning-rust.github.io/docs/b1.vectors.html
- TODO: https://doc.rust-lang.org/std/vec/struct.Vec.html
- TODO: https://doc.rust-lang.org/rust-by-example/std/vec.html
- TODO: https://vino.dev/blog/node-to-rust-day-17-arrays-loops-and-iterators/
- TODO: https://cheats.rs/#data-structures
- TODO: https://www.programming-idioms.org/cheatsheet/Rust
- TODO: https://www.kuniga.me/docs/rust/#data-structures


# Other Resources
1. https://phaiax.github.io/rust-cheatsheet/
1. https://www.cs.brandeis.edu/~cs146a/rust/doc-02-21-2015/book/arrays-vectors-and-slices.html
