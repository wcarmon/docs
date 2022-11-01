# Overview
1. How to use [maps](https://doc.rust-lang.org/std/iter/struct.Map.html)


# Key Concepts
1. Core implementations: [`HashMap`](https://doc.rust-lang.org/std/collections/struct.HashMap.html) (unsorted, faster) and [`BTreeMap`](https://doc.rust-lang.org/std/collections/struct.BTreeMap.html) (sorted, slower)


# Create
1. unlike [`vec!`](https://doc.rust-lang.org/std/macro.vec.html), There is no built-in construction macro
1. Via ctor
```rust
// map owns keys
// map borrows values
let mut m: HashMap<String, &str> = HashMap::with_capacity(64);
...
```


# Size
```rust
m.len()
```


# Insert/Update
```rust
let m: HashMap<String, &str> = ...
...
m.insert(String::from("k1"), "foo");
```


# Remove
```rust
m.remove()
```


# Retrieve
1. GOTCHA: valid lookups return `Some(&Value)`, not `Some(Value)`
```rust
let m: HashMap<String, &str> = ...
...
match m.get("k1") {
    Some(&v) => println!("value: {}", v),
    None => println!("no value"),
}
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
