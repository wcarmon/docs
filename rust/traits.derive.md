# Overview
1. [derive](TODO) macro


# Key Concepts
1. derive macro auto implements traits on a struct or macro


# Traits
|Trait|Purpose|Compiler usage|Requirements|
|---|---|---|---|
|[`Clone`](https://doc.rust-lang.org/std/clone/trait.Clone.html)|Explicit copy using .clone(), make `T` from `&T`|N/A|TODO|
|[`Copy`](https://doc.rust-lang.org/std/marker/trait.Copy.html)||Use [copy semantics](TODO) for the type|TODO|
|[`Debug`](https://doc.rust-lang.org/std/fmt/trait.Debug.html)|Enable formatting using {:?}|TODO|TODO|
|[`Default`](https://doc.rust-lang.org/std/default/trait.Default.html)||||
|[`Eq`](https://doc.rust-lang.org/std/cmp/trait.Eq.html)|||[`PartialEq`](TODO)|
|[`Error`](https://doc.rust-lang.org/std/error/index.html)|||TODO|
|[`Hash`](https://doc.rust-lang.org/std/hash/trait.Hash.html)|||[`PartialEq`](TODO) and [`Eq`](TODO)|
|[`Ord`](https://doc.rust-lang.org/std/cmp/trait.Ord.html)|||[`Eq`](TODO)|
|[`PartialEq`](https://doc.rust-lang.org/std/cmp/trait.PartialEq.html)||`==`||
|[`PartialOrd`](https://doc.rust-lang.org/std/cmp/trait.PartialOrd.html)|comparisons|`<`, `<=`, `>`, `>=`|[`PartialEq`](TODO)|
|[`Serialize`](https://serde.rs/derive.html)|convert struct or enum to string/bytes|N/A||
|[`Deserialize`](https://serde.rs/derive.html)|convert bytes/string to struct or enum|N/A||
|[``](TODO)||||



# Other resources
1. https://doc.rust-lang.org/rust-by-example/trait/derive.html
