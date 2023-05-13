# Overview
1. Frequently used commands for [cargo](https://doc.rust-lang.org/cargo/)


# Dependencies
1. one time
```bash
cargo install --locked cargo-outdated
```

1. periodically
```sh
# -- Bump version on outdated/old deps
cargo update;

cargo outdated;
cargo tree;
```

# Lock file cleanup
1. one time
```bash
cargo install cargo-unlock
```
1. periodically
```bash
cargo clean;
cargo unlock;
```
