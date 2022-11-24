# Overview
1. How to setup and use static analysis tools


# Clippy
1. Install: `rustup update; rustup component add clippy;`
1. Find issues: `cargo clippy --all`
1. Auto-fix: `cargo fix --allow-dirty --allow-staged`
1. Configure in your `main.rs` or command line (not in `Cargo.toml`)
1. Levels
    - `allow`: exit code 0, no message
    - `warn`: exit code 0, warning message
    - `deny`: non-zero exit code (failure) with message


## Example
```bash
# -- Typical warnings
cargo clippy --all

# -- More than you wanted to know :-)
cargo clippy --all -- -W clippy::pedantic -W clippy::nursery -W clippy::cargo
```


# Miri
- TODO: https://github.com/rust-lang/miri


# Cargo Check
- TODO: https://doc.rust-lang.org/cargo/commands/cargo-check.html


# Storage profiler for Artifact
- TODO: cargo bloat  - https://github.com/RazrFalcon/cargo-bloat


# Other Resources
1. https://doc.rust-lang.org/cargo/commands/cargo-check.html
1. https://github.com/rust-lang/miri
1. https://github.com/rust-lang/rust-clippy
1. https://github.com/rust-lang/rust-clippy
1. https://rust-lang.github.io/rust-clippy/master/
1. https://zhauniarovich.com/post/2021/2021-09-pedantic-clippy/
