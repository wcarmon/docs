# Overview
1. TODO


# Install
```bash
cargo install --locked tokio-console
```

# Cargo.toml
```toml
[dependencies]
# ...
console-subscriber = "0.4"
tokio = { version = "1", features = ["full", "tracing"] }
tokio-console = "0.1"
```

# main.rs
```rust
fn main() {
    console_subscriber::init()

    // ...
}

```


# Run application
- Add env flag: `RUSTFLAGS="--cfg tokio_unstable"`


# Run viewer from Terminal
```bash 
tokio-console --lang en_US.UTF-8
```


# TODO: unorganized
- port 6669


# Other resources
1. https://docs.rs/tokio-console/latest/tokio_console/
