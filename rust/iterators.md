# Overview
1. Iterators, [`IntoIterator`](https://doc.rust-lang.org/std/iter/trait.IntoIterator.html), [`FromtIterator`](https://doc.rust-lang.org/std/iter/trait.FromIterator.html)


# Key Concepts
1. There are 3 forms of iteration
    - [`iter()`](TODO), iterates over `&T` (borrowed item ref)
    - [`iter_mut()`](TODO), iterates over `&mut T` (borrowed mutable item ref)
    - [`into_iter()`](TODO), iterates over `T` (owned item)
1. Implementers choose which forms to support
    - `iter()`: Hashset keys,
    - `iter_mut()`: TODO: examples
    - `into_iter()`: TODO: examples
1. [`for` loop](https://doc.rust-lang.org/reference/expressions/loop-expr.html#iterator-loops) is [syntactic sugar for Iterators](https://doc.rust-lang.org/std/iter/index.html#for-loops-and-intoiterator)
1. [`Iterators`](TODO) and [Adapters](TODO) are lazy
    1. Nothing happens until call [`.next()`](TODO)
    1. Compiler generally warns you


# Idioms
1. If [a loop](https://doc.rust-lang.org/reference/expressions/loop-expr.html) is simpler, use a loop
1. fn should accept [`IntoIterator`](https://doc.rust-lang.org/std/iter/trait.IntoIterator.html)
1. fn should return [`FromtIterator`](https://doc.rust-lang.org/std/iter/trait.FromIterator.html)


# [`Iterator`](https://doc.rust-lang.org/std/iter/trait.Iterator.html)
1. This is the most important [trait](./traits.md) related to iteration
1. Has 1 associated type for the `Item`
1. [`next`](https://doc.rust-lang.org/std/iter/trait.Iterator.html#tymethod.next) is the only required method, you get 75+ other methods for free (since based on `.next()`)
    1. Returns [`Option<Self::Item>`](https://doc.rust-lang.org/stable/std/iter/trait.Iterator.html#tymethod.next)
    1. Returning [`None`](TODO) is not necessarily a final state, depends on impl
1. These are lazy
1. Con: Don't work when your closure/lambda uses `?` operator
    1. Must return `Result<T, E>`, not `T`
1. Con: Often adds an extra level of indirection `&&v`



# [`IntoIterator`](https://doc.rust-lang.org/std/iter/trait.IntoIterator.html)
1. For converting something into an [`Iterator`](https://doc.rust-lang.org/std/iter/trait.Iterator.html)
1. Has 1 method: [`into_iter()`](https://doc.rust-lang.org/std/iter/trait.IntoIterator.html#tymethod.into_iter)
    1. Consumes/takes ownership of iterator
1. implementing [`IntoIterator`](https://doc.rust-lang.org/std/iter/trait.IntoIterator.html) allows your type to work with [for loops](https://doc.rust-lang.org/std/iter/index.html#for-loops-and-intoiterator)
1. Core collections tend to impl [`IntoIterator`](https://doc.rust-lang.org/std/iter/trait.IntoIterator.html) 3 times,
    1. once for owned (`T`)
    1. once for borrowed (`&T`)
    1. once for mutable borrow (`&mut T`)


# [`FromIterator`](https://doc.rust-lang.org/std/iter/trait.FromIterator.html)


# [Adapters](https://doc.rust-lang.org/std/iter/index.html#adapters)
1. Chaining functions
1. eg. [`map`](TODO), [`filter`](TODO), [`take`](TODO), [`flat_map`](TODO),
1. Don't panic, return a [`Result`](TODO)
1. These are lazy


# Terminators
1. [`collect`](https://doc.rust-lang.org/std/iter/trait.Iterator.html#method.collect), [`reduce`](https://doc.rust-lang.org/std/iter/trait.Iterator.html#method.reduce), [`for_each`](https://doc.rust-lang.org/std/iter/trait.Iterator.html#method.for_each), [`fold`](https://doc.rust-lang.org/std/iter/trait.Iterator.html#method.fold), [`redu`]


# [`TryIter`](TODO)


# ~~TODO: Unorganized~~
1. [Iterator](https://doc.rust-lang.org/std/iter/trait.Iterator.html) borrows mutably
- TODO: `.iter()` (borrow), `.into_iter()` (owned)


# Other Resources
1. TODO
