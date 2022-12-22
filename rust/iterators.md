# Overview
1. Iterators, IntoIterator, FromIterator


# Idioms
1. If a loop is simpler, use a loop
1. fn should accept TODO
1. fn should return TODO


# Iterators
1. Con: Don't work when your closure/lambda uses `?` operator
    1. Must return `Result<T, E>`, not `T`
1. Con: Often adds an extra level of indirection `&&v`


# [`FromtIterator`](TODO)


# [`IntoIterator`](TODO)
1. implementing [`IntoIterator`](https://doc.rust-lang.org/std/iter/trait.IntoIterator.html) allows your type to work with [for loops](https://doc.rust-lang.org/std/iter/index.html#for-loops-and-intoiterator)

# [Iterator](https://doc.rust-lang.org/std/iter/index.html#iterator)
1. [Iterator](https://doc.rust-lang.org/std/iter/trait.Iterator.html) borrows mutably
1. [`next`](https://doc.rust-lang.org/std/iter/trait.Iterator.html#tymethod.next) is the only required method, you get 75+ other methods for free


# ~~TODO: Unorganized~~
- [`iter()`](TODO), iterates over `&T`
- [`into_iter()`](TODO), iterates over `T` (owned)
- [`iter_mut()`](TODO), iterates over `&mut T`
- TODO: `.iter()` (borrow), `.into_iter()` (owned)


# Other Resources
1. TODO
