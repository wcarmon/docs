# Overview
1. How to install and update rust toolchain
1. See [clippy doc too](./static_analysis.md)


# Install
1. https://www.rust-lang.org/tools/install


# Update version
```bash
rustup update
```


# Check version
```bash
rustc --version
```


# Switch between nightly and stable
```rust
rustup override set nightly;

# -- or

rustup override set stable;
```


# Example Root Cargo.toml
1. Each crate must have one `Cargo.toml`
1. The root `$PROJECT_ROOT/Cargo.toml` file might look like this:
```toml
[workspace]
members = [
    "my-binary-crate-1",
    "my-binary-crate-2",
    "my-library-crate-1",
    ... other crates ...
]

resolver = "1"


[profile.dev]
codegen-units = 3
opt-level = 0

[profile.release]
codegen-units = 1
debug = 1
lto = true
opt-level = 3
panic = "abort"
```
