# Overview
1. Idioms for success with JSON Deserialization


# Idioms
1. Keep it simple
1. Move complexity out of the serde process
1. Deserialize to **simple** types, then convert using core Rust
    1. [See `TryFrom` trait](https://doc.rust-lang.org/std/convert/trait.TryFrom.html)
    1. [`#[serde(try_from = "SimpleSerdeFriendlyType")]`](https://serde.rs/container-attrs.html#try_from)
        1. Assuming `SimpleSerdeFriendlyType` is local to the deserializing crate
1. `#[serde(rename_all = "camelCase")]`: auto converts snake_case in struct fields to camelCase in json
1. `#[derive(Clone, Debug, Deserialize, Serialize, ...)]`


--------
# @Missing Properties

## Solve via Defaults
1. [`#[serde(default)]`](https://serde.rs/field-attrs.html#default): calls `Default::default()` (so [`impl Default`](https://doc.rust-lang.org/std/default/trait.Default.html#how-can-i-implement-default))
1. [`#[serde(default = "path")]`](https://serde.rs/field-attrs.html#default--path) invokes a function
1. See also: https://doc.rust-lang.org/std/default/trait.Default.html

## Solve via Ignoring
1. `#[serde(skip)]`: both serialization and deserialization
1. `#[serde(skip_serializing)]`: only serialization
1. `#[serde(skip_deserializing)]`: only deserialization


--------
# @Extra properties
```rust
#[serde(deny_unknown_fields)]
...
```


# Validation
```rust
// TODO
```


# Field aliases
```rust
#[serde(alias = "foo")]
#[serde(alias = "fooBar")]
pub my_field: String
```


# Auto-deduce Enum variant
```rust
// TODO
```


# TODO: parse these
- TODO: https://docs.rs/jsonschema/latest/jsonschema/
- TODO: https://docs.rs/schemars/0.8.10/schemars/
- TODO: https://vino.dev/blog/node-to-rust-day-22-using-json/


# Other Resources
1. TODO