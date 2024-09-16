# Overview


# Formatting with Thousands separator

```toml
[dependencies]
num-format = "0.4"
```

```rust
use num_format::{Locale, ToFormattedString};

// ...

    let n = 123_456_789;
    let s = n.to_formatted_string(&Locale::en);
    println!("{}", s);

```


# Other Resources
