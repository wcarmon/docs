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
    1. Allows passing [`Vec<T>`](https://doc.rust-lang.org/std/vec/struct.Vec.html#), [`HashSet<T>`](https://doc.rust-lang.org/std/collections/struct.HashSet.html), [`BTreeSet<T>`](https://doc.rust-lang.org/std/collections/struct.BTreeSet.html#), ...
1. a `fn` should *return* [`FromtIterator`](https://doc.rust-lang.org/std/iter/trait.FromIterator.html)


# [`Iterator`](https://doc.rust-lang.org/std/iter/trait.Iterator.html)
1. The most important [trait](./traits.md) related to iteration
1. Has one associated type for the [`Item`](https://doc.rust-lang.org/stable/std/iter/trait.Iterator.html#associatedtype.Item)
1. [`next`](https://doc.rust-lang.org/std/iter/trait.Iterator.html#tymethod.next) is the only required method
1. You get 75+ other methods for free (since based on `.next()`), [See Adapters](#adapters)
    1. Returns [`Option<Self::Item>`](https://doc.rust-lang.org/stable/std/iter/trait.Iterator.html#tymethod.next)
    1. Returning [`None`](https://doc.rust-lang.org/std/option/enum.Option.html#variant.None) is not necessarily a final state, depends on the `impl`
1. Iterators are lazy
1. GOTCHA: Iterators/Adapters don't work when your closure/lambda uses [`?` operator](./errors.md)
    1. Must return [`Result<T, E>`]((https://doc.rust-lang.org/std/result/)), not `T`
1. GOTCHA: `.iter()` Often adds an extra level of indirection: like `&&v`



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
1. TODO


# [Adapters](https://doc.rust-lang.org/std/iter/index.html#adapters)
1. Adapters are "chainable" functions
    1. [`map`](https://doc.rust-lang.org/stable/std/iter/trait.Iterator.html#method.map): TODO
    1. [`filter`](https://doc.rust-lang.org/stable/std/iter/trait.Iterator.html#method.filter): TODO
    1. [`flat_map`](https://doc.rust-lang.org/stable/std/iter/trait.Iterator.html#method.flat_map): TODO
    1. [`take`](https://doc.rust-lang.org/stable/std/iter/trait.Iterator.html#method.take): TODO
    1. [`skip`](https://doc.rust-lang.org/stable/std/iter/trait.Iterator.html#method.skip): TODO
1. Don't panic, return a [`Result`](https://doc.rust-lang.org/std/result/)
1. Adapters are lazy
1. Similar to [RxJs](https://rxjs.dev/api/operators), [RxJava `Observable`](https://reactivex.io/RxJava/3.x/javadoc/io/reactivex/rxjava3/subjects/BehaviorSubject.html), [Reactor `Flux`](https://projectreactor.io/docs/core/release/api/reactor/core/publisher/Flux.html), [Java `Stream`](https://docs.oracle.com/en/java/javase/18/docs/api/java.base/java/util/stream/Stream.html), [lodash operators](https://lodash.com/docs/4.17.15#map) operators
    1. Visual guides: [js based](https://res.cloudinary.com/practicaldev/image/fetch/s--sYEjzdnw--/c_limit%2Cf_auto%2Cfl_progressive%2Cq_auto%2Cw_880/https://dev-to-uploads.s3.amazonaws.com/i/sr8koff729gxcvpnoty6.jpeg), [C# based](https://csharpcorner-mindcrackerinc.netdna-ssl.com/article/simplify-map-reduce-and-filter-in-typescript/Images/map_filter_reduce.png), []


# Terminators
1. [`collect`](https://doc.rust-lang.org/std/iter/trait.Iterator.html#method.collect): builds collection
1. [`for_each`](https://doc.rust-lang.org/std/iter/trait.Iterator.html#method.for_each): side effects (eg. printing, logging)
1. [`reduce`](https://doc.rust-lang.org/std/iter/trait.Iterator.html#method.reduce): *reduce* down to a single value
1. [`fold`](https://doc.rust-lang.org/std/iter/trait.Iterator.html#method.fold): like `reduce`, but takes starting value


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
// ...
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
