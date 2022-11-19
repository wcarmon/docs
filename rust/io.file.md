# Overview
1. TODO



# [Temp files](https://docs.rs/tempfile/latest/tempfile/)
```rust
use tempfile::NamedTempFile;
...

let mut file = NamedTempFile::new().unwrap();
file.write_all("...".as_bytes()).unwrap();

// file is auto-deleted when it goes out of scope
```


# Other Resources
1. https://rust-lang-nursery.github.io/rust-cookbook/
