# Overview
1. Functions and closures
1. For methods, [see doc](./methods.md)


# Closures
1. Closure: A function pointer and a **context**
    - A function which captures its Environment
1. *For contrast*: pure functions (`fn`) are just a [function pointer](https://doc.rust-lang.org/std/primitive.fn.html) (no context)
1. Closures can steal
    - TODO: more here (`move`)
1. Closures can borrow
    - TODO: more here

## Closure Types
1. uses `|foo| { ... }` syntax
1. Every closure has a unique type, (even if the types of its input and output are the same.)
    1. [`Fn`](https://doc.rust-lang.org/std/ops/trait.Fn.html): immutable/shared **borrowed** context
    1. [`FnMut`](https://doc.rust-lang.org/std/ops/trait.FnMut.html): mutable/exclusive **borrowed** context
    1. [`FnOnce`](https://doc.rust-lang.org/std/ops/trait.FnOnce.html): **owned** context


# TODO/Unorganized
- TODO: https://cheats.rs/#functions-behavior
- TODO: https://www.kuniga.me/docs/rust/#functions


# Other Resources
1. https://medium.com/swlh/understanding-closures-in-rust-21f286ed1759
1. https://doc.rust-lang.org/nomicon/hrtb.html
1. https://teh-cmc.github.io/rust-async/html/chapter_1/closures.html
1. https://huonw.github.io/blog/2015/05/finding-closure-in-rust/
1. https://doc.rust-lang.org/book/ch13-01-closures.html
