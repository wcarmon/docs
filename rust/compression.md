# Overview
1. Examples of how to use [flate2](https://crates.io/crates/flate2)


# Compress
- `Cargo.toml`
```toml
[dependencies]
flate2 = "1.0"
```
- Code:
```rust
    let bytes_to_write: Vec<u8> = ... ;

    let mut compressor = flate2::write::GzEncoder::new(Vec::new(), Compression::fast());

    compressor.write_all(&bytes_to_write)
        .context("failed to GzEncoder bytes")?;

    let compressed: Vec<u8> = compressor.finish()
        .context("failed to finalize Gz bytes")?;
```


# Decompress
```rust
```


# TODO
- TODO: zlib vs gzip
- TODO: brotli example


# Other Resources
