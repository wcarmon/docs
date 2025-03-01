# Overview

1. Idioms for success with JSON Deserialization
1. See also [structs doc](structs.md) (for Record/POJO/Data class, with and without Builder)

# Idioms

1. Keep it simple
1. Move complexity out of the serde process
1. Serialization is easy/mature/well-supported
1. Deserialization is hard
1. GOTCHA: [serde supports custom errors](https://serde.rs/error-handling.html), but `serde_json` does **NOT**
    1. you lose all structure if you follow the [Parse, Don't validate pattern](https://lexi-lambda.github.io/blog/2019/11/05/parse-don-t-validate/) using just serde
    1. [They convert your errors to strings](https://lexi-lambda.github.io/blog/2019/11/05/parse-don-t-validate/) (via `Display` trait)
    1. See https://github.com/serde-rs/json/issues/922
    1. [`serde_json::from_str`](https://github.com/serde-rs/json/blob/master/src/de.rs#L2678) is hard coded to use [their error struct](https://github.com/serde-rs/json/blob/master/src/error.rs#L25)
1. The real benefit of serde_json crate is [`serde_json::Value`](https://github.com/serde-rs/json/blob/master/src/value/mod.rs#L116)
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

# Field Aliases

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

1. `Concept`: let `serde` deserialize into generated `*Builder` struct, then [let Builder enforce validtaion](./structs.md#builder-enforce-validation)
1. `Idiom`: Pass-through `serde` attribute macros using [`builder_*_attr`](https://docs.rs/derive_builder/latest/derive_builder/#pass-through-attributes) attribute macros

## Annotate the Struct

```rust

#[derive(Builder, Debug, ...)]   // <-- NOTICE: no Deserialize here
#[builder(build_fn(error = "anyhow::Error", validate = "Self::validate"))]
// -- Pass thru Deserialize attribute macro to Builder struct
#[builder_struct_attr(derive(Deserialize))]
// -- Pass thru typical serde attributes
#[builder_struct_attr(serde(deny_unknown_fields, rename_all = "camelCase"))]
pub struct MyStruct {
    
    // ... fields ...
   
    #[builder(setter(skip))]
    #[builder(default)]
    #[builder_field_attr(serde(default))]  // <-- Pass thru serde default to Builder struct
    something_defaulted: i64,
}   

// -- Validation fn is the same as for normal Builder (see structs.md for details) 
impl MyStructBuilder {
    fn validate(&self) -> Result<(), anyhow::Error> {
        ...
    }
}
```

## Usage

```rust
let json_str = r#" { ... } "#;

// -- Deserialize into the generated Builder struct
let b: MyStructBuilder = serde_json::from_str(json_str)
    .context("failed to parse json for MyStruct")?;

// -- Validate on build
let instance = b.build()
    .context("invalid MyStruct")?;
```

# Struct Validation (Without Builder)

1. Generally Out-of-scope for a Deserialization library
    1. too complex, scope creep
    1. Do validation AFTER parsing
1. Deserialize to a simpler type, possibly using new-type pattern
    1. See https://rust-unofficial.github.io/patterns/patterns/behavioural/newtype.html
    1. See https://doc.rust-lang.org/rust-by-example/generics/new_types.html
1. Use `TryFrom`
    1. [See `TryFrom` trait](https://doc.rust-lang.org/std/convert/trait.TryFrom.html)
    1. [`#[serde(try_from = "SimpleSerdeFriendlyType")]`](https://serde.rs/container-attrs.html#try_from)
        1. Assuming `SimpleSerdeFriendlyType` is local to the deserializing crate
1. Avoid the ~~`HashMap<String, Value>`~~ route, it's a dead end, requires a lot of pattern matching
