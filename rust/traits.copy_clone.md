# Overview
1. Differentiating between [`Clone`](https://doc.rust-lang.org/std/clone/trait.Clone.html) and [`Copy`](https://doc.rust-lang.org/std/marker/trait.Copy.html) Traits in Rust.


||[`Clone`](https://doc.rust-lang.org/std/clone/trait.Clone.html)|[`Copy`](https://doc.rust-lang.org/std/marker/trait.Copy.html)|
| ---|---|---|
|Syntax|Explicit duplication|Implicit|
|Runtime cost|cheap or expensive|must be cheap|
|Depth|Deep or shallow|deep|
|Extra behavior?|Add arbitrary extra behavior|no|
|Move semantics<br>(assignments, fn invocations, etc)|no change|Replaces move with copy semantics|


# `Clone`
1. Compiler never invokes automatically
1. Supports extra behavior
    1. eg. [`Arc::clone()`](https://doc.rust-lang.org/std/sync/struct.Arc.html#method.clone) creates a new reference and increments a counter
    1. eg. [`String::clone()`](https://doc.rust-lang.org/std/string/struct.String.html#method.clone) allocates new independent memory on the heap
    1. eg. [`Vec::clone()`](https://doc.rust-lang.org/std/vec/struct.Vec.html#method.clone) creates an independent (deep) copy of vector
        1. (compiler requires elements `impl Clone`)
1. Super-Trait of `Copy`
1. implement when...
    1. Some part of your type won't be captured by a (recursive) field-by-field copy
    1. Your type needs extra steps to copy correctly


# `Copy`
1. Sub-Trait of `Clone`
1. Forbidden for heap-allocated data
1. Forbidden on types that [`impl Drop`](https://doc.rust-lang.org/std/ops/trait.Drop.html)


# Other Resources
1. https://hashrust.com/blog/moves-copies-and-clones-in-rust/
