# Overview
1. Checklist for using [prost](https://crates.io/crates/prost) (for rust [Protocol buffers](https://protobuf.dev/))


# One-time setup
1. [Download protoc](https://github.com/protocolbuffers/protobuf/releases/)
    1. eg. `protoc-27.0-linux-x86_64.zip`
1. Install `protoc`
    1. Approach-1: Set `$PROTOC` env var (higher priority)
    1. Approach-2: put binary on `$PATH` (lower priority)
    1. eg.
    ```bash
    chmod 755 $HOME/opt/protoc/bin/protoc
    ln -sv $HOME/opt/protoc/bin/protoc $HOME/bin/protoc
    ```
    1. eg. Add `$HOME/opt/protoc/bin` to `PATH`
1. In crate's `Cargo.toml`
    ```toml
    [dependencies]
    # ... other deps
    prost = "..."
    prost-types = "..."

    [build-dependencies]
    prost-build = { version = "..." }
    ```
1. Add `$PROJ_ROOT/src/foo.rs` for the each `struct` (model the domain as you would normally)
1. Add `$PROJ_ROOT/protos/foo.proto` for each corresponding [proto def](https://protobuf.dev/programming-guides/proto3/)
    1. Choose a [package](https://protobuf.dev/programming-guides/proto3/#packages) (you'll use it later)
    1. Or maybe the protos already exit
1. In [`$PROJ_ROOT/build.rs`](https://docs.rs/prost-build/latest/prost_build/):
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
1. In `$PROJ_ROOT/lib.rs` (or `$PROJ_ROOT/main.rs`)
```rs
// -- replace "my" and "pkg" with your proto package segments
pub mod my {
    pub mod pkg {
        // -- final argument matches the package in *.proto
        include!(concat!(env!("OUT_DIR"), "/my.pkg.rs"));
    }
}
```
1. Add `$PROJ_ROOT/src/foo_proto.rs` for the conversion mappings
    1. [See examples below](https://github.com/wcarmon/docs/blob/main/rust/protobuf.md#conversion)
1. cargo generates proto structs/enums
    1. Generated structs [`impl Message`](https://docs.rs/prost/latest/prost/trait.Message.html)
    1. See `$PROJ_ROOT/target/debug/build/${CRATE_NAME}-${SOME_HASH}/${PROTO_PACKAGE}.rs`


# Conversion
```rust
// -- Domain -> Proto should be infallible
// -- (if not, impl TryFrom<MyDomainType>)

impl From<MyDomainType> for my::pkg::Foo {
    fn from(value: MyDomainType) -> Self {
        Self {
            // ... set fields here
        }
    }
}

// -- Deserializing may fail since rust has stronger types than proto
impl TryFrom<my::pkg::Foo> for MyDomainType {
    type Error = anyhow::Error;

    fn try_from(value: my::pkg::Foo) -> Result<Self, Self::Error> {

        // -- eg. Maybe you have a int64 timestmamp field
        let ts = DateTime::from_timestamp_millis(value.ts_millis)
            .ok_or(anyhow!("failed to build DateTime"))?;

        // ... any other complex deserialization here

        Ok(Self {
            ts,
            // ... set fields here
        })
    }
}
```


# Write bytes (Encode)
```rust
    let obj = MyDomainType {
        // ... set fields here
    };

    let my_proto: my::pkg::Foo = obj.into();

    let raw_bytes: Vec<u8> = my_proto.encode_to_vec();
    // -- See also: my_proto.encode(buf)

    // TODO: send raw bytes somewhere (eg. Postgres, Redis, Kafka, gRPC, Hazelcast)
```

# Read bytes (Decode)
```rust
    let raw_bytes: Vec<u8> = ... ; // TODO: read from somewhere

    // -- deref, coerce, then reference raw_bytes
    let decoded = my::pkg::Foo::decode(&*raw_bytes)
        .context("failed to deserialize proto")?;

    let deserialized: MyDomainType = decoded
        .try_into()
        .context("failed to convert proto to domain object")?;
```


# Other Resources
1. https://crates.io/crates/prost
1. https://docs.rs/prost-build/latest/prost_build/
1. https://docs.rs/prost/latest/prost/trait.Message.html#method.encode_to_vec
1. https://github.com/tokio-rs/prost
1. https://protobuf.dev/programming-guides/proto3/
