# Overview
1. TODO


# Gotcha: 
- `::push()` (not `.add()`, not `append`)


# IntoIterator
1. implementing [`IntoIterator`](https://doc.rust-lang.org/std/iter/trait.IntoIterator.html) allows your type to work with [for loops](https://doc.rust-lang.org/std/iter/index.html#for-loops-and-intoiterator) 

# [Iterator](https://doc.rust-lang.org/std/iter/index.html#iterator)
1. [Iterator](https://doc.rust-lang.org/std/iter/trait.Iterator.html) borrows mutably
1. [`next`](https://doc.rust-lang.org/std/iter/trait.Iterator.html#tymethod.next) is the only required method, you get 75+ other methods for free





# ~~TODO: Unorganized~~
- TODO: https://doc.rust-lang.org/book/ch08-01-vectors.html
- TODO: https://learning-rust.github.io/docs/b1.vectors.html
- TODO: https://doc.rust-lang.org/std/vec/struct.Vec.html
- TODO: https://doc.rust-lang.org/rust-by-example/std/vec.html
- TODO: https://vino.dev/blog/node-to-rust-day-17-arrays-loops-and-iterators/
- TODO: https://cheats.rs/#data-structures
- TODO: https://www.programming-idioms.org/cheatsheet/Rust
- TODO: https://www.kuniga.me/docs/rust/#data-structures
- TODO: `.iter()` (borrow), `.into_iter()` (owned)


    - [`iter()`](TODO), iterates over `&T`
    - [`into_iter()`](TODO), iterates over `T` (owned)
    - [`iter_mut()`](TODO), iterates over `&mut T`

# Other Resources
1. https://phaiax.github.io/rust-cheatsheet/
1. TODO
