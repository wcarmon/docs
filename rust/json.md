# Overview

1. Idioms for success with JSON Deserialization
1. See also [structs doc](structs.md) (for Record/POJO/Data class, with and without Builder)

# Idioms

1. Keep it simple
1. Move complexity out of the serde process
1. Deserialize to **simple** types, then convert using core Rust
    1. [See `TryFrom` trait](https://doc.rust-lang.org/std/convert/trait.TryFrom.html)
    1. [`#[serde(try_from = "SimpleSerdeFriendlyType")]`](https://serde.rs/container-attrs.html#try_from)
        1. Assuming `SimpleSerdeFriendlyType` is local to the deserializing crate
1. [`#[serde(rename_all = "camelCase")]`](https://serde.rs/container-attrs.html#rename_all): auto converts between a `snake_case` struct field and a `camelCase` json property
1. `#[derive(Clone, Debug, Deserialize, Serialize, ...)]`
    1. assuming you have the [`derive` feature flag](https://serde.rs/feature-flags.html) in `Cargo.toml`

--------

# Handle Missing fields

## Solve via Defaults

1. [`#[serde(default)]`](https://serde.rs/field-attrs.html#default): calls `Default::default()` (assuming you [`impl Default`](https://doc.rust-lang.org/std/default/trait.Default.html#how-can-i-implement-default))
1. [`#[serde(default = "path-to-function")]`](https://serde.rs/field-attrs.html#default--path) invokes a function to provide default value
    1. GOTCHA: This feature doesn't seem to work with derive_builder
1. See also: [`Default` trait](https://doc.rust-lang.org/std/default/trait.Default.html)

```rust
#[derive(Deserialize, ...)]
pub struct MyStruct {
   
    // -- Uses Default on Foo type 
    #[serde(default)]
    foo: Foo
   
    #[serde(default = "MyStruct::default_for_quux")]
    quux: i64,
    
    // ... other fields ...
}


impl MyStruct {
    fn default_for_quux() -> i64 {
        18
    }
}
```

## [Solve by Ignoring](https://serde.rs/attr-skip-serializing.html)

1. `#[serde(skip)]`: for both serialization and deserialization
1. `#[serde(skip_serializing)]`: only for serialization
1. `#[serde(skip_deserializing)]`: only for deserialization

--------

# Handle Extra/Unknown fields

```rust
#[serde(deny_unknown_fields)]
pub struct MyStruct {
    // ... fields ...
}
```

# Field aliases

```rust
#[serde(alias = "foo")]
#[serde(alias = "fooBar")]
pub my_field: String
```

# Auto-deduce Enum variant

1. Use `#[serde(untagged)]` on the `enum`
1. [Example](https://serde.rs/enum-representations.html#untagged)

--------

# Example: Builder Deserialization with Validation

1. Concept: deserialize into generated builder, then [use normal builder validtaion](./structs.md#builder-enforce-validation)
1. Idiom: Pass-through `serde` attribute macros into [`builder_*_attr`](https://docs.rs/derive_builder/latest/derive_builder/#pass-through-attributes)

## Annotate the Struct

```rust

#[derive(Builder, Debug)]
#[builder(build_fn(error = "anyhow::Error", validate = "Self::validate"))]
#[builder_struct_attr(derive(Deserialize))]
// -- Pass thru serde attributes
#[builder_struct_attr(serde(deny_unknown_fields, rename_all = "camelCase"))]
pub struct MyStruct {
   ... fields ...
   
    #[builder(setter(skip))]
    #[builder(default)]
    #[builder_field_attr(serde(default))]  // <-- NOTICE: serde attribute passed thru to Builder struct
    something_defaulted: i64,
}   

// Validation fn is the same as for normal Builder 
impl MyStructBuilder {
    fn validate(&self) -> Result<(), anyhow::Error> {
        ...
    }
}
```

## Usage

```rust
let json_str = ...

let b: MyStructBuilder = serde_json::from_str(json_str)
    .context("failed to parse json for MyStruct")?;

let instance = b.build()
    .context("failed to build MyStruct")?;
```

# Validation (Without builder)

1. Out of scope for Deserialization library (too complex, scope creep)
1. Deserialize to a simpler type, possibly using new-type pattern
    1. See https://rust-unofficial.github.io/patterns/patterns/behavioural/newtype.html
    1. See https://doc.rust-lang.org/rust-by-example/generics/new_types.html
1. Use `TryFrom`
    1. [See `TryFrom` trait](https://doc.rust-lang.org/std/convert/trait.TryFrom.html)
    1. [`#[serde(try_from = "SimpleSerdeFriendlyType")]`](https://serde.rs/container-attrs.html#try_from)
        1. Assuming `SimpleSerdeFriendlyType` is local to the deserializing crate
1. Avoid the ~~Map<String, Value>~~ route, it's a dead end, requires a lot of pattern matching
