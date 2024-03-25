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
    1. Similar to [`ArrayList`](https://docs.oracle.com/en/java/javase/19/docs/api/java.base/java/util/ArrayList.html) in java
    1. Similar to [`Array`](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array) in javascript
    1. Similar to [`std::vector`](https://cplusplus.com/reference/vector/vector/) in C++
    1. Similar to [`List`](https://docs.python.org/3/tutorial/datastructures.html#more-on-lists) in python
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


# Comparison to Java
|Rust|Java|
|---|---|
|[`v.binary_search(...)`](https://doc.rust-lang.org/std/vec/struct.Vec.html#method.binary_search)|[`Arrays.binarySearch(...)`](https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/util/Arrays.html#binarySearch(byte[],byte))|
|[`v.clear()`](https://doc.rust-lang.org/std/vec/struct.Vec.html#method.clear)|[`v.clear()`](https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/util/ArrayList.html#clear())|
|[`v.extend(iter)`](https://doc.rust-lang.org/std/iter/trait.Extend.html#tymethod.extend)|[`v.addAll(collection)`](https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/util/ArrayList.html#addAll(java.util.Collection))|
|[`v.first()`](https://doc.rust-lang.org/std/vec/struct.Vec.html#method.first),<br>[`v.get(0)`](TODO)|[`v.getFirst()`](https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/util/ArrayList.html#getFirst())|
|[`v.get(i)`](https://doc.rust-lang.org/std/vec/struct.Vec.html#method.get)|[`v.get(i)`](https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/util/ArrayList.html#get(int))|
|[`v.insert(...)`](https://doc.rust-lang.org/std/vec/struct.Vec.html#method.insert)|[`v.add(...)`](https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/util/ArrayList.html#add(E))|
|[`v.insert(0, item)`](https://doc.rust-lang.org/std/vec/struct.Vec.html#method.insert), <br>[`VecDeque::push_front(item)`](https://doc.rust-lang.org/std/collections/struct.VecDeque.html#method.push_front)|[`v.addFirst(item)`](https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/util/ArrayList.html#addFirst(java.lang.Object))|
|[`v.is_empty()`](https://doc.rust-lang.org/std/vec/struct.Vec.html#method.is_empty)|[`v.isEmpty()`](https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/util/ArrayList.html#isEmpty())|
|[`v.iter().min()`](https://doc.rust-lang.org/std/iter/trait.Iterator.html#method.min)|[`Collections.min(v)`](TODO)|
|[`v.iter().position(...)`](https://doc.rust-lang.org/std/iter/trait.Iterator.html#method.position),<br>[`v.iter().rposition(...)`](https://doc.rust-lang.org/std/iter/trait.Iterator.html#method.rposition)|[`v.indexOf(value)`](TODO)|
|[`v.iter()`](https://doc.rust-lang.org/std/vec/struct.Vec.html#method.iter), [`v.into_iter()`](TODO)|[`v.stream()`](TODO)<br>[`v.iterator()`](https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/util/ArrayList.html#iterator())|
|[`v.last()`](https://doc.rust-lang.org/std/vec/struct.Vec.html#method.last)|[`v.getLast()`](https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/util/ArrayList.html#getLast())|
|[`v.len()`](https://doc.rust-lang.org/std/vec/struct.Vec.html#method.len)|[`v.size()`](https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/util/ArrayList.html#size())|
|[`v.pop()`](https://doc.rust-lang.org/std/vec/struct.Vec.html#method.pop)|[`v.removeLast()`](https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/util/ArrayList.html#removeLast())|
|[`v.push(...)`](https://doc.rust-lang.org/std/vec/struct.Vec.html#method.push)|[`v.add(...)`](TODO), [`v.addLast(...)`](TODO)|
|[`v.remove(0)`](https://doc.rust-lang.org/std/vec/struct.Vec.html#method.remove),<br>[`VecDeque::pop_front()`](TODO)|[`v.removeFirst()`](https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/util/ArrayList.html#removeFirst())|
|[`v.remove(i)`](https://doc.rust-lang.org/std/vec/struct.Vec.html#method.remove)|[`v.remove(i)`](https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/util/ArrayList.html#remove(int))|
|[`v.reverse()`](https://doc.rust-lang.org/std/vec/struct.Vec.html#method.reverse)|[`Collections.reverse(v)`](TODO)|
|[`v.sort()`](https://doc.rust-lang.org/std/vec/struct.Vec.html#method.sort) (stable sort)|[`Collections.sort(v)`](TODO)|
|[`v.sort_unstable()`](https://doc.rust-lang.org/std/vec/struct.Vec.html#method.sort_unstable)|N/A|
|[`v0 == v1`](https://doc.rust-lang.org/std/vec/struct.Vec.html#impl-Eq-for-Vec%3CT,+A%3E)|[`v0.equals(v1)`](TODO)|
|[`vec![1, 2, 3]`](https://doc.rust-lang.org/std/macro.vec.html)|[`List.of(1, 2, 3)`](TODO)|
|[`Vec::from(iter)`](https://doc.rust-lang.org/std/vec/struct.Vec.html#method.from-2)|[`new ArrayList<>(otherCollection)`](TODO)|
|[`Vec::with_capacity(cap)`](https://doc.rust-lang.org/std/vec/struct.Vec.html#method.with_capacity)|[`new ArrayList<>(cap)`](TODO)|


# TODO
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
