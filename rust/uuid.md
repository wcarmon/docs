# Overview
1. Tools for generating [uuids](https://en.wikipedia.org/wiki/Universally_unique_identifier)


# Best lib: [uuid](https://docs.rs/uuid/latest/uuid/) crate
1. `Pro`: serde friendly
1. `Pro`: modular (see crate features)
1. `Pro`: Some official support from the rust team
1. `Pro`: Actively developed
1. `Pro`: Popular


## Setup
1. Add to your [`Cargo.toml`](https://docs.rs/uuid/latest/uuid/#getting-started)
1. [`fast-rng` feature](https://docs.rs/uuid/latest/uuid/#other-features) is faster, but uses more external crates (dependencies)

## Usage
```rust
// -- Generate random
let value = Uuid::new_v4();

// -- Parse at runtime
let value = Uuid::parse_str("c4c4075f-c17f-49ea-aec9-b45d697aa431")?;

// -- Parse at compile time (constant)
const MY_VALUE: Uuid = uuid!("92153ec4-b5e9-46e4-9935-df36b2cd4f4b");
```

# Java comparison
|Rust|Java|
|---|---|
|[`Uuid::new_v4()`](https://docs.rs/uuid/latest/uuid/struct.Uuid.html#method.new_v4)|[`UUID.randomUUID()`](https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/util/UUID.html#randomUUID())|
|[`Uuid::parse_str(...)`](https://docs.rs/uuid/latest/uuid/struct.Uuid.html#method.parse_str)|[`UUID.fromString(...)`](https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/util/UUID.html#fromString(java.lang.String))|
