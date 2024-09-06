# Overview

1. How to use [maps](https://doc.rust-lang.org/std/iter/struct.Map.html)

# Key Concepts

1. Core implementations: [`HashMap`](https://doc.rust-lang.org/std/collections/struct.HashMap.html) (unsorted, faster) and [`BTreeMap`](https://doc.rust-lang.org/std/collections/struct.BTreeMap.html) (sorted, slower)

# [Create](https://doc.rust-lang.org/std/collections/struct.HashMap.html#examples)

1. Unlike [`vec!`](https://doc.rust-lang.org/std/macro.vec.html), There is no built-in construction macro
1. Via ctor

```rust
// map owns keys
// map borrows values
let mut m: HashMap<String, &str> = HashMap::with_capacity(64);
...
```

1. Via entries

```rust
let m = HashMap::from([
    ("a".to_owned(), "one"),
    ("b".to_owned(), "two")]);
```

# [Size](https://doc.rust-lang.org/std/collections/struct.HashMap.html#method.len)

```rust
    m.len()
    m.is_empty()
```

# [Insert/Update/Put/Upsert](https://doc.rust-lang.org/std/collections/struct.HashMap.html#method.insert)

```rust
    let m: HashMap<String, &str> = ...
    ...
    m.insert(String::from("k1"), "foo"); // put or upsert

    let old_value = m.insert(String::from("k2"), "bar");
```
- Similar to [`.put(...)`](https://docs.oracle.com/en%2Fjava%2Fjavase%2F21%2Fdocs%2Fapi%2F%2F/java.base/java/util/Map.html#put(K,V)) in `java.util.Map`
- See also: [`HashMap::get_mut`](https://doc.rust-lang.org/std/collections/struct.HashMap.html#method.get_mut)


# [Put all](https://doc.rust-lang.org/std/iter/trait.Extend.html#tymethod.extend)

```rust
    m.extend(m2)
```

# [Remove](https://doc.rust-lang.org/std/collections/struct.HashMap.html#method.remove)

```rust
    let old_value = m.remove(key1);

    let old_entry = m.remove_entry(key1);

    m.clear();
```

# [Get/Retrieve](https://doc.rust-lang.org/std/collections/struct.HashMap.html#method.get)

1. GOTCHA: valid lookups return [`Some(&Value)`](https://doc.rust-lang.org/std/option/enum.Option.html#variant.Some), not [`Some(Value)`](https://doc.rust-lang.org/std/option/enum.Option.html#variant.Some)
1. Avoid `m[key1]` because failed lookup [panics](https://www.lurklurk.org/effective-rust/panic.html)

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
    if m.contains_key(&key1) {
        ...
    }
```

# [Iterate](https://doc.rust-lang.org/std/collections/struct.HashMap.html#method.iter)

```rust
    // -- Iterate entries
    for (key, value) in m {
        ...
    }

    // or .into_iter()

    // -- keys only (less efficient than entry iter)
    for key in m.keys() {
        ...
    }

    // -- values only (less efficient than entry iter)
    for v in m.values() {
        ...
    }
```

# [Get Keys](https://doc.rust-lang.org/std/collections/struct.HashMap.html#method.keys)

```rust
m.keys()
```

# Shallow copy

```rust
TODO: try m.extend(...)
TODO: try m.clone()
```

# [Put-if-absent](https://doc.rust-lang.org/stable/std/collections/hash_map/enum.Entry.html#method.or_insert)

```rust
    let old_value = m.entry(key1).or_insert(my_dflt_val);
```

# [Put-if-present (replace)](https://doc.rust-lang.org/std/collections/hash_map/enum.Entry.html)
```rust
    if let Occupied(mut entry) = m.entry(key) {
        // -- Replace value
        let _old_entity = entry.insert(new_value);

    } else {
        // -- TODO: handle not found here
    }
```
- [Java equivalent](https://docs.oracle.com/en/java/javase/22/docs/api/java.base/java/util/Map.html#replace(K,V))


# [Filter/Retain](https://doc.rust-lang.org/std/collections/struct.HashMap.html#method.retain)

```rust
    m.retain(|k, v| k.len() > 3);
```

# [Sort](https://doc.rust-lang.org/std/collections/struct.BTreeMap.html#impl-FromIterator%3C(K%2C%20V)%3E-for-BTreeMap%3CK%2C%20V%2C%20Global%3E)

```rust
    let sorted = BTreeMap::from_iter(m);
```

# [Print](https://doc.rust-lang.org/std/collections/struct.HashMap.html#method.fmt)

```rust
use std::fmt::Write;
...

    let mut s = String::new();

    write!(&mut s, "m={:?}", m)?

    print!("{:?}", m);
```

1. For writing to [file](https://doc.rust-lang.org/std/fs/struct.File.html), use [`std::io::Write`](https://doc.rust-lang.org/std/io/trait.Write.html)

# Custom keys

1. Add to key struct/enum: [`#[derive(PartialEq, Eq, Hash)]`](./traits.derive.md)

# Idioms

1. TODO


# Java comparison
|Rust|Java|
|---|---|
|`for (k, v) in &m {...}`|`for (var entry : m.entrySet()) {...}`|
|`HashMap::new()`|`new HashMap<>()`|
|`HashMap::with_capacity(n)`|`new HashMap<>(n)`|
|`if let Some(v) = m.get(&k) {...}`|`if (m.containsValue(v)) {...}`|
|`let old = m.remove(&k)`|`var old = m.remove(k)`|
|`m.clear()`|`m.clear()`|
|`m.contains_key(&k)`|`m.containsKey(k)`|
|`m.entry(&k).or_insert(v)`|`m.putIfAbsent(k, v)`|
|`m.entry(&k).or_insert_with(\|\| some_value)`|`m.computeIfAbsent(k, (ignored) -> some_value)`|
|`m.extend(m2)`|`m.putAll(m2)`|
|`m.get(&k).copied().unwrap_or(v)`|`m.getOrDefault(k, v)`|
|`m.insert(k, v)`|`m.put(k, v)`|
|`m.into_iter()`|N/A|
|`m.iter()`|`m.entrySet().stream()`|
|`m.iter()`|`m.entrySet()`|
|`m.keys()`|`m.keySet()`|
|`m.len()`|`m.size()`|
|`m.values()`|`m.values()`|
|`m.values_mut()`|N/A|


# Other Resources

1. https://doc.rust-lang.org/stable/std/collections/struct.HashMap.html
1. https://doc.rust-lang.org/book/ch08-03-hash-maps.html
1. https://phaiax.github.io/rust-cheatsheet/
1. https://doc.rust-lang.org/std/iter/struct.Map.html
1. https://doc.rust-lang.org/rust-by-example/std/hash.html
1. https://cheats.rs/#other-collections
