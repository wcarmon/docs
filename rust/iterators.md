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
1. a `fn` should *return* [`FromIterator`](https://doc.rust-lang.org/std/iter/trait.FromIterator.html)


## Error handling idioms
1. Error handling for [`Result`](https://doc.rust-lang.org/std/result/)s in failable operations
    1. Other approaches: https://doc.rust-lang.org/rust-by-example/error/iter_result.html

### Error handling Approach #1:
1. in [`.map`](https://doc.rust-lang.org/std/iter/struct.Map.html) (or similar) return [`Result`](https://doc.rust-lang.org/std/result/)
1. Final step in `iter` chain is [`collect`](https://doc.rust-lang.org/std/result/#collecting-into-result) with [turbofish](https://techblog.tonsser.com/posts/what-is-rusts-turbofish):
    - eg. `.collect::<Result<Vec<_>, anyhow::Error>>()?`
    - eg. `.collect::<Result<Vec<_>, anyhow::Error>>()?.join("...")`
    - [`Result::collect`](https://doc.rust-lang.org/std/result/#collecting-into-result) will [auto fail-fast on first `Err`](https://doc.rust-lang.org/std/result/enum.Result.html#impl-FromIterator%3CResult%3CA%2C%20E%3E%3E-for-Result%3CV%2C%20E%3E)
```rust
let values = vec![1, 2, 3]
    .into_iter()
    .map(|x| something_failable(x))  // <-- return a Result
    .collect::<Vec<_>, anyhow::Error>()?;
```


### Error handling Approach #2:
1. in [`.map`](https://doc.rust-lang.org/std/iter/struct.Map.html) (or similar) return [`Result`](https://doc.rust-lang.org/std/result/)
1. Use [`.collect()`](https://doc.rust-lang.org/std/result/#collecting-into-result) as final step to produce `Result`
1. assign to variable with type `Result<Vec<_>, _>`
1. Use `?` operator after assigning result
```rust
let result: Result<Vec<_>, anyhow::Error> = vec![1, 2, 3]
    .into_iter()
    .map(|x| something_failable(x))
    .collect();

let values = result?;
...
```


# [`Iterator`](https://doc.rust-lang.org/std/iter/trait.Iterator.html) trait
1. The most important [trait](./traits.md) related to iteration
1. Has one associated type for the [`Item`](https://doc.rust-lang.org/stable/std/iter/trait.Iterator.html#associatedtype.Item)
1. [`next`](https://doc.rust-lang.org/std/iter/trait.Iterator.html#tymethod.next) is the only required method
1. You get 75+ other methods for free (since based on `.next()`), [See Adapters](#adapters)
    1. Returns [`Option<Self::Item>`](https://doc.rust-lang.org/stable/std/iter/trait.Iterator.html#tymethod.next)
    1. Returning [`None`](https://doc.rust-lang.org/std/option/enum.Option.html#variant.None) is not necessarily a final state, depends on the `impl`
1. Iterators are lazy
1. GOTCHA: Iterators/Adapters don't work when your closure/lambda uses [`?` operator](./errors.md)
    1. Must return [`Result<T, E>`]((https://doc.rust-lang.org/std/result/)), not `T`
1. GOTCHA: `.iter()` adds an extra level of indirection: like `&&v`
1. `.iter()` creates a new struct to iterate the collection
    1. [BTreeSet example](https://doc.rust-lang.org/stable/src/alloc/collections/btree/set.rs.html#1156)
    1. [HashSet example](https://doc.rust-lang.org/src/std/collections/hash/set.rs.html#198)
    1. [Vec example](https://doc.rust-lang.org/src/core/slice/mod.rs.html#735)


# [`IntoIterator`](https://doc.rust-lang.org/std/iter/trait.IntoIterator.html) trait
1. Trait for converting *something* into an [`Iterator`](https://doc.rust-lang.org/std/iter/trait.Iterator.html)
1. **Moves** the collection into an iterator
1. Has 1 method: [`into_iter()`](https://doc.rust-lang.org/std/iter/trait.IntoIterator.html#tymethod.into_iter)
    1. Consumes/takes ownership of iterator
1. Did I mention this takes ownership :-)
1. implementing [`IntoIterator`](https://doc.rust-lang.org/std/iter/trait.IntoIterator.html) allows your type to work with [for loops](https://doc.rust-lang.org/std/iter/index.html#for-loops-and-intoiterator)
    1. [For loop uses `into_iter()`](https://doc.rust-lang.org/std/iter/index.html#for-loops-and-intoiterator)
    1. you cannot iterate a collection twice because the first time moves
    1. Solution-A: you can borrow the collection multiple times: `for v in &my_collection {...}`
    1. Solution-B: you can use `.iter()`: [`for v in my_collection.iter() {`](https://doc.rust-lang.org/std/iter/index.html#iterating-by-reference)
1. Core collections tend to impl [`IntoIterator`](https://doc.rust-lang.org/std/iter/trait.IntoIterator.html) 3 times,
    1. once for owned (`T`)
    1. once for borrowed (`&T`)
    1. once for mutable borrow (`&mut T`)

## Example
```rust
// in practice you can just use the BTreeSet directly
#[derive(Clone, Debug, Default, Eq, Hash, PartialEq)]
pub struct MyFancyStuff(BTreeSet<String>);

// allow owned iteration
impl IntoIterator for MyFancyStuff {
    type Item = String;
    type IntoIter = <BTreeSet<Self::Item> as IntoIterator>::IntoIter;

    // into_iter takes ownership of the iterator
    fn into_iter(self) -> Self::IntoIter {
        self.0.into_iter()
    }
}

// allow borrowed iteration
impl<'a> IntoIterator for &'a MyFancyStuff {
    type Item = String;
    type IntoIter = <BTreeSet<Self::Item> as IntoIterator>::IntoIter;

    // into_iter takes ownership of the iterator
    fn into_iter(self) -> Self::IntoIter {
        // clone is cheap, give them their own
        self.0.clone().into_iter()
    }
}

```


# [`FromIterator`](https://doc.rust-lang.org/std/iter/trait.FromIterator.html) trait
1. TODO


# [Adapters](https://doc.rust-lang.org/std/iter/index.html#adapters)
1. Adapters are "chainable" functions
1. Adapters are Higher-order functions (functions that accept a function)
1. In other places, these are called [Combinators](https://doc.rust-lang.org/reference/glossary.html#combinator)
1. Don't panic, return a [`Result`](https://doc.rust-lang.org/std/result/)
1. Adapters are lazy
1. Similar to [RxJs](https://rxjs.dev/api/operators), [RxJava `Observable`](https://reactivex.io/RxJava/3.x/javadoc/io/reactivex/rxjava3/subjects/BehaviorSubject.html), [Reactor `Flux`](https://projectreactor.io/docs/core/release/api/reactor/core/publisher/Flux.html), [Java `Stream`](https://docs.oracle.com/en/java/javase/18/docs/api/java.base/java/util/stream/Stream.html), [lodash operators](https://lodash.com/docs/4.17.15#map) operators
    1. Visual guides: [js based](https://res.cloudinary.com/practicaldev/image/fetch/s--sYEjzdnw--/c_limit%2Cf_auto%2Cfl_progressive%2Cq_auto%2Cw_880/https://dev-to-uploads.s3.amazonaws.com/i/sr8koff729gxcvpnoty6.jpeg), [C# based](https://csharpcorner-mindcrackerinc.netdna-ssl.com/article/simplify-map-reduce-and-filter-in-typescript/Images/map_filter_reduce.png), ...
1. See more adapters in [itertools](https://docs.rs/itertools/latest/itertools)


|Adapter/fn|Purpose|Stream size after `fn`|Type after `fn`|
|--- |--- |---|---|
|[`map`](https://doc.rust-lang.org/stable/std/iter/trait.Iterator.html#method.map)              |Convert type or ownership               |*Same*         |Changed|
|[`filter`](https://doc.rust-lang.org/stable/std/iter/trait.Iterator.html#method.filter)        |Ignore/keep items                       |Generally less |*Same*|
|[`flat_map`](https://doc.rust-lang.org/stable/std/iter/trait.Iterator.html#method.flat_map)    |process nested`<T>` collection like `T` |Generally more |Changed|
|[`take`](https://doc.rust-lang.org/stable/std/iter/trait.Iterator.html#method.take)            |keep first *n*                          |Generally less |*Same*|
|[`skip`](https://doc.rust-lang.org/stable/std/iter/trait.Iterator.html#method.skip)            |ignore first *n*                        |Generally less |*Same*|
|[`cloned`](https://doc.rust-lang.org/stable/std/iter/trait.Iterator.html#method.cloned)        |clones items (converts to owned)        |*Same*         |Same, but owned|
|[`enumerate`](https://doc.rust-lang.org/stable/std/iter/trait.Iterator.html#method.enumerate)  |like `map`, but includes Item index     |*Same*         |Changed|
|[`inspect`](https://doc.rust-lang.org/stable/std/iter/trait.Iterator.html#method.inspect)      |debugging                               |*Same*         |*Same*


# Terminators
|Terminator|Purpose|
|---|---|
|[`collect`](https://doc.rust-lang.org/std/iter/trait.Iterator.html#method.collect)     |builds collection|
|[`for_each`](https://doc.rust-lang.org/std/iter/trait.Iterator.html#method.for_each)   |side effects (eg. printing, logging)|
|[`reduce`](https://doc.rust-lang.org/std/iter/trait.Iterator.html#method.reduce)       |*reduce* down to a single value|
|[`fold`](https://doc.rust-lang.org/std/iter/trait.Iterator.html#method.fold)           |like `reduce`, but takes starting value|
|[`all`](https://doc.rust-lang.org/stable/std/iter/trait.Iterator.html#method.all)      |true when all items match predicate|
|[`any`](https://doc.rust-lang.org/stable/std/iter/trait.Iterator.html#method.any)      |true only when at least one item matches predicate|
|[`last`](https://doc.rust-lang.org/stable/std/iter/trait.Iterator.html#method.last)    |get final Item|
|[`max`](https://doc.rust-lang.org/stable/std/iter/trait.Iterator.html#method.max)       |largest value|
|[`min`](https://doc.rust-lang.org/stable/std/iter/trait.Iterator.html#method.min)       |smallest value|


# [`TryIter`](TODO)
- TODO


# Example: A `fn` which accepts "collection" of any String-like
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
- https://doc.rust-lang.org/stable/std/iter/trait.Iterator.html#method.nth


# Other Resources
1. https://docs.rs/itertools/latest/itertools/
