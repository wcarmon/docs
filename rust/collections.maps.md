# Overview
1. How to use [maps](https://doc.rust-lang.org/std/iter/struct.Map.html)


# Key Concepts
1. Core implementations: [`HashMap`](https://doc.rust-lang.org/std/collections/struct.HashMap.html) (unsorted, faster) and [`BTreeMap`](https://doc.rust-lang.org/std/collections/struct.BTreeMap.html) (sorted, slower)


# Create
1. Via literal
```rust
TODO
```

1. Via ctor
```rust
let mut m: HashMap<String, String> = HashMap::with_capacity(64);
...
```


# Size
```rust
TODO
```


# Insert/Update
```rust
TODO
```


# Remove
```rust
m.remove()
```

# Retrieve
```rust
TODO
```


# Check for key
```rust
TODO

// can query by reference even when owned stored
.contains_key()

```


# Iterate
```rust
TODO

// -- keys only
TODO

// -- values only
TODO
```


# Get Keys
```rust
TODO
```


# Shallow copy
```rust
TODO
```


# Put-if-absent
```rust
TODO
```


# Sorting
```rust
TODO
```


# Printing
```rust
TODO
```


# Custom keys
1. Add to key struct/enum: `#[derive(PartialEq, Eq, Hash)]`


# Idioms
1. TODO


# Gotcha
- lookups return &Value, not Value


- TODO: https://doc.rust-lang.org/book/ch08-03-hash-maps.html
- TODO: https://doc.rust-lang.org/stable/std/collections/struct.HashMap.html
- TODO: https://web.mit.edu/rust-lang_v1.25/arch/amd64_ubuntu1404/share/doc/rust/html/book/second-edition/ch08-03-hash-maps.html
- TODO: https://phaiax.github.io/rust-cheatsheet/
- TODO: https://cheats.rs/#data-structures
- TODO: https://www.kuniga.me/docs/rust/#hashmap


# Other resources
1. https://doc.rust-lang.org/std/iter/struct.Map.html
1. https://doc.rust-lang.org/rust-by-example/std/hash.html
1. https://cheats.rs/#other-collections
