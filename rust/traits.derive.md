# Overview
1. [derive](TODO) macro


# Key Concepts
1. derive macro auto implements traits on a struct or macro


# Traits
|Trait|Purpose|Compiler usage|Requirements|
|---|---|---|---|
|[`Clone`](TODO)|Explicit copy using .clone(), make `T` from `&T`|--|TODO|
|[`Copy`](TODO)||Use [copy semantics](TODO) for the type|TODO|
|[`Debug`](TODO)|Enable formatting using {:?}|TODO|TODO|
|[`Default`](TODO)||||
|[`Error`](TODO)||||
|[`Hash`](TODO)|||[`PartialEq`](TODO) and [`Eq`](TODO)|
|[`Eq`](TODO)|||[`PartialEq`](TODO)|
|[`PartialEq`](TODO)||`==`||
|[`Ord`](TODO)|||[`Eq`](TODO)|
|[`PartialOrd`](TODO)|comparisons|`<`, `<=`, `>`, `>=`|[`PartialEq`](TODO)|
|[`Serialize`](https://serde.rs/derive.html)|convert struct or enum to string/bytes|--||
|[`Deserialize`](https://serde.rs/derive.html)|convert bytes/string to struct or enum|--||
|[``](TODO)||||



# Other resources
1. https://doc.rust-lang.org/rust-by-example/trait/derive.html
