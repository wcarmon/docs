# Overview

1. Frequently used commands for [cargo](https://doc.rust-lang.org/cargo/)

# New versions of Dependencies (fix outdated/old deps)

1. one time

```bash
cargo install --locked cargo-outdated
```

1. periodically

```sh
cargo update --workspace --dry-run;
cargo update --workspace --verbose;

cargo outdated;
cargo tree;
```

1. Also, [clion has an inspection for this](https://www.jetbrains.com/help/clion/running-inspections.html) called `New crate version available`

# Dependency version conflicts

```bash
cargo tree -d;
```

# Unused dependencies

1. one time

```bash
cargo install cargo-machete;
```

1. periodically

```bash
# -- May have false positives
cargo machete;

cargo +nightly udeps
# or
cargo +nightly udeps --all-targets
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
