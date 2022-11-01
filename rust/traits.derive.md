# Overview
1. [derive](https://doc.rust-lang.org/reference/procedural-macros.html#derive-macros) macro


# Key Concepts
1. [`derive`](https://doc.rust-lang.org/reference/procedural-macros.html#derive-macros) attribute macro auto implements traits on a [struct](https://doc.rust-lang.org/book/ch05-01-defining-structs.html) or [enum](https://doc.rust-lang.org/book/ch06-01-defining-an-enum.html)
1. [`derive`](https://doc.rust-lang.org/reference/procedural-macros.html#derive-macros) attribute macro generates code
1. To override the behavior, implement the [trait](./traits.md) manually [expand the macro, if needed](https://github.com/dtolnay/cargo-expand)


# Traits
|Trait|Purpose|Compiler usage|Requirements|
|---|---|---|---|
|[`Clone`](https://doc.rust-lang.org/std/clone/trait.Clone.html)|Explicit copy using .clone(), make `T` from `&T`|N/A|TODO|
|[`Copy`](https://doc.rust-lang.org/std/marker/trait.Copy.html)||Use [copy semantics](https://dev.to/werner/move-semantics-vs-copy-semantics-pkb) for the type|TODO|
|[`Debug`](https://doc.rust-lang.org/std/fmt/trait.Debug.html)|Enable formatting using {:?}|TODO|TODO|
|[`Default`](https://doc.rust-lang.org/std/default/trait.Default.html)||||
|[`Eq`](https://doc.rust-lang.org/std/cmp/trait.Eq.html)|||[`PartialEq`](https://doc.rust-lang.org/std/cmp/trait.PartialEq.html)|
|[`Error`](https://doc.rust-lang.org/std/error/index.html)|||TODO|
|[`Hash`](https://doc.rust-lang.org/std/hash/trait.Hash.html)|||[`PartialEq`](https://doc.rust-lang.org/std/cmp/trait.PartialEq.html) and [`Eq`](https://doc.rust-lang.org/std/cmp/trait.Eq.html)|
|[`Ord`](https://doc.rust-lang.org/std/cmp/trait.Ord.html)|||[`Eq`](https://doc.rust-lang.org/std/cmp/trait.Eq.html)|
|[`PartialEq`](https://doc.rust-lang.org/std/cmp/trait.PartialEq.html)|compare any `x` and `y`, but [`x != x`](https://en.wikipedia.org/wiki/Partial_equivalence_relation) for some values, like `f64` |`==`||
|[`PartialOrd`](https://doc.rust-lang.org/std/cmp/trait.PartialOrd.html)|comparisons|`<`, `<=`, `>`, `>=`|[`PartialEq`](https://doc.rust-lang.org/std/cmp/trait.PartialEq.html)|
|[`Serialize`](https://serde.rs/derive.html)|convert struct or enum to string/bytes|N/A||
|[`Deserialize`](https://serde.rs/derive.html)|convert bytes/string to struct or enum|N/A||
|[``](TODO)||||



# Other resources
1. https://doc.rust-lang.org/rust-by-example/trait/derive.html
1. https://www.lurklurk.org/effective-rust/std-traits.html
1. https://dev.to/werner/move-semantics-vs-copy-semantics-pkb