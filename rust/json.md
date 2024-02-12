# Overview
1. Idioms for success with JSON Deserialization


# Idioms
1. Keep it simple
1. Move complexity out of the serde process
1. Deserialize to **simple** types, then convert using core Rust
    1. [See `TryFrom` trait](https://doc.rust-lang.org/std/convert/trait.TryFrom.html)
    1. [`#[serde(try_from = "SimpleSerdeFriendlyType")]`](https://serde.rs/container-attrs.html#try_from)
        1. Assuming `SimpleSerdeFriendlyType` is local to the deserializing crate
1. [`#[serde(rename_all = "camelCase")]`](https://serde.rs/container-attrs.html#rename_all): auto converts snake_case in struct fields to camelCase in json
1. `#[derive(Clone, Debug, Deserialize, Serialize, ...)]`
    1. assuming you have the [`derive` feature flag](https://serde.rs/feature-flags.html) in `Cargo.toml`


--------
# @Missing fields

## Solve via Defaults
1. [`#[serde(default)]`](https://serde.rs/field-attrs.html#default): calls `Default::default()` (so [`impl Default`](https://doc.rust-lang.org/std/default/trait.Default.html#how-can-i-implement-default))
1. [`#[serde(default = "path")]`](https://serde.rs/field-attrs.html#default--path) invokes a function
1. See also: https://doc.rust-lang.org/std/default/trait.Default.html

## Solve via Ignoring
1. `#[serde(skip)]`: both serialization and deserialization
1. `#[serde(skip_serializing)]`: only serialization
1. `#[serde(skip_deserializing)]`: only deserialization


--------
# @Extra fields
```rust
#[serde(deny_unknown_fields)]
pub struct MyStruct {
    ... fields ...
}
```


# Validation
1. Out of scope for Deserialization (too complex, scope creep)
1. Deserialize to a simpler type, possibly using new-type pattern
1. Use `TryFrom`
    1. [See `TryFrom` trait](https://doc.rust-lang.org/std/convert/trait.TryFrom.html)
    1. [`#[serde(try_from = "SimpleSerdeFriendlyType")]`](https://serde.rs/container-attrs.html#try_from)
        1. Assuming `SimpleSerdeFriendlyType` is local to the deserializing crate


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