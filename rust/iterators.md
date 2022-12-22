# Overview
1. [Iterators](https://doc.rust-lang.org/stable/std/iter/index.html), [`IntoIterator`](https://doc.rust-lang.org/std/iter/trait.IntoIterator.html), [`FromtIterator`](https://doc.rust-lang.org/std/iter/trait.FromIterator.html)


# Key Concepts
1. There are 3 forms of iteration
    - `iter()`, iterates over `&T` *(borrowed item ref)*
    - `iter_mut()`, iterates over `&mut T` *(borrowed mutable item ref)*
    - [`into_iter()`](https://doc.rust-lang.org/std/iter/trait.IntoIterator.html#tymethod.into_iter), iterates over `T` *(owned item)*
1. Implementers choose which forms to support
    - `iter()`: ... TODO ...
    - `iter_mut()`: [`Vec`](https://doc.rust-lang.org/std/vec/struct.Vec.html), [`BTreeMap`](https://doc.rust-lang.org/std/collections/struct.BTreeMap.html), [`LinkedList`](https://doc.rust-lang.org/std/collections/struct.LinkedList.html#), [`Option`](https://doc.rust-lang.org/std/option/enum.Option.html), [`Result`](https://doc.rust-lang.org/std/result/enum.Result.html), [`VecDeque`](https://doc.rust-lang.org/std/collections/struct.VecDeque.html),
    - `into_iter()`: [`Vec`](https://doc.rust-lang.org/std/vec/struct.Vec.html), [`VecDeque`](https://doc.rust-lang.org/std/collections/struct.VecDeque.html), [`BTreeSet`](https://doc.rust-lang.org/std/collections/struct.BTreeSet.html), [`HashMap`](https://doc.rust-lang.org/std/collections/struct.HashMap.html), [`Option`](https://doc.rust-lang.org/std/option/enum.Option.html), [`BinaryHeap`](https://doc.rust-lang.org/std/collections/struct.BinaryHeap.html), [`LinkedList`](https://doc.rust-lang.org/std/collections/struct.LinkedList.html), ...
1. [`for` loop](https://doc.rust-lang.org/reference/expressions/loop-expr.html#iterator-loops) is [syntactic sugar for Iterators](https://doc.rust-lang.org/std/iter/index.html#for-loops-and-intoiterator)
1. [Iterators](https://doc.rust-lang.org/stable/std/iter/trait.Iterator.html#) and [Adapters](https://doc.rust-lang.org/stable/std/iter/index.html#adapters) are lazy
    1. Nothing happens until call [`.next()`](https://doc.rust-lang.org/stable/std/iter/trait.Iterator.html#tymethod.next) (might be indirect, [see Terminators](#terminators))
    1. Compiler generally warns you
    1. implies iterators can be infinite


# Idioms
1. If [a loop](https://doc.rust-lang.org/reference/expressions/loop-expr.html) is simpler, use a loop
1. a `fn` should *accept* [`IntoIterator`](https://doc.rust-lang.org/std/iter/trait.IntoIterator.html)
    1. Allows passing [`Vec<T>`](https://doc.rust-lang.org/std/vec/struct.Vec.html#), [`HashSet<T>`](https://doc.rust-lang.org/std/collections/struct.HashSet.html), [`BTreeSet<T>`](https://doc.rust-lang.org/std/collections/struct.BTreeSet.html#),
1. a `fn` should *return* [`FromtIterator`](https://doc.rust-lang.org/std/iter/trait.FromIterator.html)


# [`Iterator`](https://doc.rust-lang.org/std/iter/trait.Iterator.html)
1. This is the most important [trait](./traits.md) related to iteration
1. Has 1 associated type for the `Item`
1. [`next`](https://doc.rust-lang.org/std/iter/trait.Iterator.html#tymethod.next) is the only required method, you get 75+ other methods for free (since based on `.next()`)
    1. Returns [`Option<Self::Item>`](https://doc.rust-lang.org/stable/std/iter/trait.Iterator.html#tymethod.next)
    1. Returning [`None`](https://doc.rust-lang.org/std/option/enum.Option.html#variant.None) is not necessarily a final state, depends on impl
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


# Flexible fn which accepting collection of any String
```rust
// works on ...
//
// - Vec<&'static str>
// - Vec<&str>
// - Vec<String>
// - Vec<Rc<String>>
// - Vec<Arc<String>>
//
// - HashSet<&'static str>
// - HashSet<&str>
// - HashSet<String>
// - HashSet<Rc<String>>
// - HashSet<Arc<String>>
//
// - BTreeSet<&'static str>
// - BTreeSet<&str>
// - BTreeSet<String>
// - BTreeSet<Rc<String>>
// - BTreeSet<Arc<String>>
fn my_string_collection_consumer<I, T>(values: I)
where
    I: IntoIterator<Item = T>,
    T: Borrow<String>,
{
    ...
}
```


# ~~TODO: Unorganized~~
1. [Iterator](https://doc.rust-lang.org/std/iter/trait.Iterator.html) borrows mutably
1. TODO: `.cloned()`

# Other Resources
1. TODO
