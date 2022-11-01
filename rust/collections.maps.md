# Overview
1. How to use [maps](https://doc.rust-lang.org/std/iter/struct.Map.html)


# Key Concepts
1. Core implementations: [`HashMap`](https://doc.rust-lang.org/std/collections/struct.HashMap.html) (unsorted, faster) and [`BTreeMap`](https://doc.rust-lang.org/std/collections/struct.BTreeMap.html) (sorted, slower)


# Create
1. Unlike [`vec!`](https://doc.rust-lang.org/std/macro.vec.html), There is no built-in construction macro
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
m.is_empty()
```


# [Insert/Update/Put/Upsert](https://doc.rust-lang.org/std/collections/struct.HashMap.html#method.insert)
```rust
let m: HashMap<String, &str> = ...
...
m.insert(String::from("k1"), "foo"); // put or upsert

let oldValue = m.insert(String::from("k2"), "bar");
```

# [Put all](https://doc.rust-lang.org/std/iter/trait.Extend.html#tymethod.extend)
```rust
m.extend(m2)
```


# [Remove](https://doc.rust-lang.org/std/collections/struct.HashMap.html#method.remove)
```rust
let oldValue = m.remove(key1);

let oldEntry = m.remove_entry(key1);
```


# [Retrieve](https://doc.rust-lang.org/std/collections/struct.HashMap.html#method.get)
1. GOTCHA: valid lookups return `Some(&Value)`, not `Some(Value)`
```rust
let m: HashMap<String, &str> = ...
...
match m.get("k1") {
    Some(&v) => println!("value: {}", v),
    None => println!("no value"),
}
```


## [Get & mutate in-place](https://doc.rust-lang.org/std/collections/struct.HashMap.html#method.get_mut)
```rust
// mutate in place
m.get_mut("k1")
 .map(|v| *v = "bar");
```


# [Check for key](https://doc.rust-lang.org/std/collections/struct.HashMap.html#method.contains_key)
```rust
// can query by reference or by owned key
m.contains_key(&key1)
```


# Iterate
```rust
for (key, value) in m {
    ...
}


// -- keys only (less efficient than entry iter)
for key in map.keys() {
    ...
}

// -- values only (less efficient than entry iter)
for val in map.values() {
    ...
}
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
let oldValue = m.entry(key1).or_insert(...);
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
