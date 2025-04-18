# Overview
1. Checklist for using [prost](https://crates.io/crates/prost) (for rust [Protocol buffers](https://protobuf.dev/))
1. See also [grpc doc](./io.grpc.server.md)

# One-time setup

## [Download protoc](https://github.com/protocolbuffers/protobuf/releases/)
1. eg. `protoc-29.3-linux-x86_64.zip`

1. Unpackage
```
mkdir -p $HOME/opt/protoc;
mv -nv $HOME/Downloads/protoc*x86_64.zip $HOME/opt/protoc/ ;
cd $HOME/opt/protoc;
unzip protoc*x86_64.zip;
rm -v ./protoc*x86_64.zip;

# -- verify
$HOME/opt/protoc/bin/protoc --version
```

## Install `protoc`
    1. (After downloading) Set `$PROTOC` env var (higher priority)
        1. maybe set to `PROTOC=$HOME/opt/protoc/bin/protoc`

### Alternative install Approach-A:
- `sudo apt-get install protobuf-compiler`

### Alternative install Approach-B:
1. put binary on `$PATH` (lower priority than `$PROTOC`)
1. eg.
```bash
chmod 755 $HOME/opt/protoc/bin/protoc
ln -sv $HOME/opt/protoc/bin/protoc $HOME/bin/protoc
```
1. eg. Add `$HOME/opt/protoc/bin` to `PATH`


## Setup `Cargo.toml`
```toml
[dependencies]
# ... other deps
prost = "..."
prost-types = "..."

[build-dependencies]
# -- gRPC (prost implied)
tonic-build = "..."

# -- only required without gRPC/tonic ...
#prost-build = "..."
```

## Sources (model)
1. Add `$PROJ_ROOT/src/foo.rs` for the each `struct`
    1. model the domain as you would normally
1. Add `$PROJ_ROOT/proto/foo.proto` for each corresponding [proto def](https://protobuf.dev/programming-guides/proto3/)
    1. Choose a [package](https://protobuf.dev/programming-guides/proto3/#packages) (you'll use it later)
    1. Or maybe the protos already exist
    1. Add `Proto` suffix to your `message`s to distinguish them in code


## Cargo Build code
1. In [`$PROJ_ROOT/build.rs`](https://docs.rs/prost-build/latest/prost_build/):
```rs
use std::io::Result;

fn main() -> Result<()> {
    // -- For gRPC (implies protobuf too)
    tonic_build::configure()
        // -- Generate a client
        .build_client(true)

        // -- Generate a server
        .build_server(true)
        .build_transport(true)

        // -- Add extra derive attribute to some message type
        // -- See https://docs.rs/prost-build-config/latest/prost_build_config/
        // -- See https://docs.rs/prost-build/latest/prost_build/struct.Config.html#method.message_attribute
        .message_attribute("MyMessageType","#[derive(Eq, Hash)]",)

        // -- For each externally defined proto
        // -- assuming you have `package foo.bar.baz;` in your proto
        // .extern_path(".foo.bar.baz", "::name_of_crate::foo::bar::baz")

        .compile_protos(
            &[
                "proto/http.proto",
                "proto/model.proto",
                // ... other protos
            ],
            &[
                "src/",     # for reference resolution??
                "proto/",
            ],
        )?;

    // -- ================================================
    // -- Protobuf only (no gRPC)
    // prost_build::compile_protos(
    //     &[
    //         "proto/foo.proto",
    //         // TODO: other proto files here
    //     ],
    //     &["src/", "proto/"],
    // )?;

    // -- ================================================
    // -- Protobuf only, with extra config (no gRPC)
    // let mut config = Config::new();
    // config.message_attribute("MyProto", "#[derive(Eq, Hash)]");
    //
    // config.compile_protos(
    //     &["proto/foo.proto", "proto/bar.proto"],
    //     &["src/", "proto/"],
    // )?;


    Ok(())
}
```

## Sources (entry point)
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


--------
# Usage: Type Conversion
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


# Usage: Write bytes (Encode)
```rust
    let obj = MyDomainType {
        // ... set fields here
    };

    let my_proto: my::pkg::Foo = obj.into();

    let raw_bytes: Vec<u8> = my_proto.encode_to_vec();
    // -- See also: my_proto.encode(buf)

    // TODO: send raw bytes somewhere (eg. Postgres, Redis, Kafka, gRPC, Hazelcast)
```

# Usage: Read bytes (Decode)
```rust
    use prost::Message;     // imports the `decode` method

    let raw_bytes: Vec<u8> = ... ; // TODO: read from somewhere

    // -- deref, coerce, then (re)reference raw_bytes
    let decoded = my::pkg::Foo::decode(&*raw_bytes)
        .context("failed to deserialize proto")?;

    let deserialized: MyDomainType = decoded
        .try_into()
        .context("failed to convert proto to domain object")?;
```


--------
# Gotcha
1. prost doesn't write directly to [`std::io::Write`](./io.file.md), so you must first write to `&[u8]` (or similar)
1. prost has their own Buf struct: `prost::bytes::Buf`
    1. Solution is to use deref coercion: `&*my_buffer`
1. `prost-build`: uses `optional` for all user defined types
    1. https://github.com/tokio-rs/prost/issues/521
    1. https://github.com/tokio-rs/prost/issues/945
1. [Enums can be a bit unintuitive](https://github.com/tokio-rs/prost?tab=readme-ov-file#enumerations), but there are enough features in place to make it work
    1. read/deserialize using `my_proto.my_enum_field()`, not `my_proto.my_enum_field` (`TryFrom` or pure `fn`)
    1. write/serialize by converting to `i32` (`From` or pure `fn`)
1. generated types are not convenient enough to represent the domain, so conversion required
1. package names must not have parent/child relationship
    1. Bad: use `com.foo.aa` in `com.foo.aa.bb`
    1. Good: use `com.foo.aa.common` in `com.foo.aa.bb`


# Other Resources
1. https://crates.io/crates/prost
1. https://docs.rs/prost-build/latest/prost_build/
1. https://docs.rs/prost/latest/prost/trait.Message.html#method.encode_to_vec
1. https://github.com/tokio-rs/prost
1. https://protobuf.dev/programming-guides/proto3/
