# Overview

1. Idiomatic usage of a [`struct`](https://doc.rust-lang.org/book/ch05-01-defining-structs.html)
1. See [traits doc](./traits.md)
1. See [modeling doc](./modeling.md)

# Key Concepts

1. A `struct` let us group related, named fields into one data structure
    1. [Tuples](https://doc.rust-lang.org/rust-by-example/primitives/tuples.html) let us group *unnamed* fields into one data structure
1. A `struct` is either **fully** mutable or **fully** immutable
1. [Exterior mutability](https://doc.rust-lang.org/rust-by-example/scope/borrow/mut.html) is checked and enforced [at compile-time](https://doc.rust-lang.org/std/keyword.mut.html)
1. There are **no** [constructors](https://en.wikipedia.org/wiki/Constructor_(object-oriented_programming))
    1. Instantiation: [doc-1](https://doc.rust-lang.org/std/keyword.struct.html#instantiation), [doc-2](https://doc.rust-lang.org/nomicon/constructors.html)
    1. Optionally, you can add a `pub fn new(...) -> Self { ... }`

# Idioms

1. Use [`derive`](./traits.derive.md) attribute to auto-generate [common traits](./traits.derive.md)
1. `Ownership`: Prefer to own fields in a struct ([Why?](https://www.lurklurk.org/effective-rust/lifetimes.html#lifetimes-in-data-structures))
1. Don't implement `to_string()`, implement [`Display`](https://doc.rust-lang.org/std/fmt/trait.Display.html)
1. Enforce validation (invariant maintenance).  See two options below


# Builder Pattern

## Builder: Pros & Cons

1. `Pro`: [Implementation is trivial](https://docs.rs/derive_builder/latest/derive_builder/) (see below)
1. `Pro`: Builder has simpler validation pattern
1. `Pro`: Builder is simpler than making multiple constructor functions
1. `Pro`: Builder allows incremental construction (less local variables)
1. `Con`: For small structs, Builder doesn't help much because structs [are easily built by field name](https://doc.rust-lang.org/book/ch05-01-defining-structs.html#using-the-field-init-shorthand)
1. More tradeoffs: [doc-1](https://rust-unofficial.github.io/patterns/patterns/creational/builder.html), [doc-2](https://www.lurklurk.org/effective-rust/builders.html)

## Builder: Example

1. In `main.rs` or `lib.rs`

```rust
#[macro_use]
extern crate derive_builder;

...
```

1. In a struct

```rust
#[derive(Builder, Debug)]
#[builder(build_fn(error = "anyhow::Error", validate = "Self::validate"))]
pub struct MyStruct {
    pub age: u16,
    pub happy: bool,
    pub weight: f32,

    // -- Allow anything that can convert into String (eg. Vec<String>)
    #[builder(setter(into))]
    pub friends: Vec<String>,

    // -- Allow caller to skip setting this field
    #[builder(default)]
    // -- Avoid double wrapping Option
    #[builder(setter(into, strip_option))]
    pub id: Option<i32>,

    // -- Allow anything that can convert into String (eg. &str)
    #[builder(setter(into))]
    pub name: String,

    // -- Don't generate setter for private field
    #[builder(setter(skip))]
    #[builder(default = "17")]
    something_hidden: i64,
}
```

1. Usage
```rust
  let v1 = MyStructBuilder::default()
            .age(123)
            .friends(vec!["foo", "bar"].into_iter().map(String::from).collect_vec())
            .happy(true)
            .name("foo")
            .weight(3.14)
            .build()
            .context("failed to build MyStruct")?;
```

## Builder: Enforce [Validation](https://docs.rs/derive_builder/latest/derive_builder/#pre-build-validation)

```rust
impl MyStructBuilder {  // Notice the the fn is on the Builder struct

    fn validate(&self) -> Result<(), anyhow::Error> {

        // TODO: more validation here

        if let Some(v) = self.age {
            if v > 88 {
                bail!("too old: {v}");
            }
        }

        Ok(())
    }
}
```

# Enforce validation (without a builder)
1. Use [`non_exhaustive`](https://doc.rust-lang.org/reference/attributes/type_system.html) attribute
1. Only forces validation   Has no impact inside the crate, only affects other crates

```rust
#[derive(...)]
#[non_exhaustive]
pub struct MyStruct {

    pub foo: Foo,
    pub bar: Bar,
    // ... other fields ...
}

impl MyStruct {

    // ::new function is the "constructor" pattern
    pub fn new(
            foo: Foo,
            bar: Bar
            // ... other fields ...
        ) -> Result<Self, anyhow::Error> {

        let out = Self {
            ... assign here ...
        };

        out.validate()?;
        Ok(out)
    }

    pub fn validate(&self) -> Result<(), anyhow::Error> {
        // ... run validation here
    }
```


# Destructuring

1. TODO

# Anti-patterns

1. ~~[Getters](https://codehs.gitbooks.io/apjava/content/Classes-And-Object-Oriented-Programming/getter-and-setter-methods.html)~~
    1. `Con`: Doesn't help much because field-level [(exterior)](https://web.mit.edu/rust-lang_v1.25/arch/amd64_ubuntu1404/share/doc/rust/html/book/first-edition/mutability.html#interior-vs-exterior-mutability) mutability is already controlled by [references & ownership](https://web.mit.edu/rust-lang_v1.25/arch/amd64_ubuntu1404/share/doc/rust/html/book/first-edition/mutability.html#field-level-mutability)
    1. `Pro`: [Implementation is trivial](https://docs.rs/derive-getters/0.2.0/derive_getters/)

# TODO/Unorganized

- TODO: https://ricardomartins.cc/2016/06/08/interior-mutability

# Other Resources

1. https://web.mit.edu/rust-lang_v1.25/arch/amd64_ubuntu1404/share/doc/rust/html/book/first-edition/structs.html
1. https://doc.rust-lang.org/book/ch05-01-defining-structs.html
1. https://ricardomartins.cc/2016/06/08/interior-mutability
1. https://web.mit.edu/rust-lang_v1.25/arch/amd64_ubuntu1404/share/doc/rust/html/book/first-edition/mutability.html#field-level-mutability
1. https://www.kuniga.me/docs/rust/#struct
