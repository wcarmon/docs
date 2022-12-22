# Overview
1. Iterators, [`IntoIterator`](https://doc.rust-lang.org/std/iter/trait.IntoIterator.html), [`FromtIterator`](https://doc.rust-lang.org/std/iter/trait.FromIterator.html)


# Idioms
1. If [a loop](https://doc.rust-lang.org/reference/expressions/loop-expr.html) is simpler, use a loop
1. fn should accept [`IntoIterator`](https://doc.rust-lang.org/std/iter/trait.IntoIterator.html)
1. fn should return [`FromtIterator`](https://doc.rust-lang.org/std/iter/trait.FromIterator.html)


# [`Iterator`](https://doc.rust-lang.org/std/iter/trait.Iterator.html)
1. This is the most important [trait](./traits.md) related to iteration
1. Has 1 associated type for the `Item`
1. [`next`](https://doc.rust-lang.org/std/iter/trait.Iterator.html#tymethod.next) is the only required method, you get 75+ other methods for free
    1. Returns [`Option<Self::Item>`](https://doc.rust-lang.org/stable/std/iter/trait.Iterator.html#tymethod.next)
    1. Returning [`None`](TODO) is not necessarily a final state, depends on impl
1. Con: Don't work when your closure/lambda uses `?` operator
    1. Must return `Result<T, E>`, not `T`
1. Con: Often adds an extra level of indirection `&&v`


# [`FromtIterator`](https://doc.rust-lang.org/std/iter/trait.FromIterator.html)


# [`IntoIterator`](https://doc.rust-lang.org/std/iter/trait.IntoIterator.html)
1. implementing [`IntoIterator`](https://doc.rust-lang.org/std/iter/trait.IntoIterator.html) allows your type to work with [for loops](https://doc.rust-lang.org/std/iter/index.html#for-loops-and-intoiterator)




# ~~TODO: Unorganized~~
1. [Iterator](https://doc.rust-lang.org/std/iter/trait.Iterator.html) borrows mutably
- [`iter()`](TODO), iterates over `&T`
- [`into_iter()`](TODO), iterates over `T` (owned)
- [`iter_mut()`](TODO), iterates over `&mut T`
- TODO: `.iter()` (borrow), `.into_iter()` (owned)


# Other Resources
1. TODO
