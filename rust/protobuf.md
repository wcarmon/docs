# Overview
1. Checklist for using [prost](TODO) (for rust [Protocol buffers](TODO))

# One-time setup
1. [Download protoc](https://github.com/protocolbuffers/protobuf/releases/)
    1. eg. `protoc-27.0-linux-x86_64.zip`
1. Install `protoc`
    1. Either set `$PROTOC` env var (higher priority) or put binary on `$PATH` (lower priority)
    1. eg. `chmod 755 $HOME/opt/protoc/bin/protoc; ln -sv $HOME/opt/protoc/bin/protoc $HOME/bin/protoc;`
    1. eg. Add `$HOME/opt/protoc/bin` to `PATH`
1. In crate's `Cargo.toml`
    ```toml
    [dependencies]
    prost = "..."
    prost-types = "..."
    ...

    [build-dependencies]
    prost-build = { version = "..." }
    ```
1. Add `$PROJ_ROOT/src/foo.rs` for the each `struct`
1. Add `$PROJ_ROOT/protos/foo.proto` for each corresponding protocol buffer definition
    1. Choose a package (you'll use it later)
1. In $PROJ_ROOT/build.rs
```rs
use std::io::Result;

use prost_build::compile_protos;

fn main() -> Result<()> {
    compile_protos(
        &[
            "protos/foo.proto",
            // TODO: other proto files here
        ],
        &["src/", "protos/"],
    )?;

    Ok(())
}
```
1. In `$PROJ_ROOT/libmain.rs` (or `$PROJ_ROOT/main.rs`)
```rs
    pub mod my {
        pub mod pkg {
            // -- final argument matches the package in *.proto
            include!(concat!(env!("OUT_DIR"), "/my.pkg.rs"));
        }
    }
```
1. Add `$PROJ_ROOT/src/foo_proto.rs` for the mapping
    1. See conversion examples below
1. cargo generates proto structs/enums
    1. Generated structs [`impl Message`](https://docs.rs/prost/latest/prost/trait.Message.html)
    1. See `$PROJ_ROOT/target/debug/build/${CRATE_NAME}-${SOME_HASH}/${PROTO_PACKAGE}.rs`


# Conversion
```rust
// From Domain to proto should be infallible

impl From<MyDomainType> for my::pkg::Foo {
    fn from(value: MyDomainType) -> Self {
        Self {
            // ... set fields
        }
    }
}

// -- Deserializing may fail
impl TryFrom<my::pkg::Foo> for MyDomainType {
    type Error = anyhow::Error;

    fn try_from(value: my::pkg::FooFill) -> Result<Self, Self::Error> {
        let ts = DateTime::from_timestamp_millis(value.ts_millis)
            .ok_or(anyhow!("failed to build DateTime"))?;

        // ... any other complex deserialization here

        Ok(Self {
            ts,
            // ... set fields
        })
    }
}
```


# Write & Read
```rust
    let obj = MyDomainType {
        // ... set fields
    };

    let proto: my::pkg::Foo = obj.into();

    let raw_bytes = my_proto.encode_to_vec();
    // See also: my_proto.encode(buf)

    // TODO: send raw bytes somewhere
```


# Read
```rust
    let raw_bytes: Vec<u8> = ... ; // TODO: Get from somewhere

    // -- deref, coerce, then reference
    let decoded = my::pkg::Foo::decode(&*raw_bytes)
        .context("failed to deserialize proto")?;

    let deserialized: MyDomainType = decoded
        .try_into()
        .context("failed to convert proto to domain object")?;
```


# Other Resources

