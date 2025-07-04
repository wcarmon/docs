# Overview

1. Things that are excellent about Rust
1. Things that are terrible about Rust

# Good news

1. Light runtime memory usage
    1. compare to java, go, python, c#, vb, ruby, php, ...
    1. On par with C & C++
1. Extremely **fast** at runtime
    1. compare to java, go, python, c#, vb, ruby, php, ...
    1. On par with C & C++
1. Evolves quickly
    1. compare to Java, Go, Python, C#, vb, ruby, php, ...
    1. Sometimes this is a con :-)
1. Safety
    1. Compare with C & C++
1. Many C++ idioms are the default
    1. Ownership model
    1. Mutability model
    1. Explicit lifetimes
    1. References, Smart pointers
1. Multiple return values (compared to Java, Python, C, ...)
1. "Sensible" Operator overloading
1. [Set](https://doc.rust-lang.org/std/collections/struct.HashSet.html) support
    1. compare to Go which lacks them
1. Methods must declare mutability requirements/assumptions
1. Struct fields support default values (compare to Go)
1. Good attribute macros tend to simplify what would be boilerplate in other languages
    - eg. [derive](), [serde](https://serde.rs/derive.html), [instrument](https://docs.rs/tracing/latest/tracing/attr.instrument.html)
1. [`format!()`](https://doc.rust-lang.org/std/macro.format.html) is excellent
1. [Cargo](https://doc.rust-lang.org/cargo/) is excellent
1. [Feature flags](https://doc.rust-lang.org/cargo/reference/features.html) are excellent
1. Rich enums (compare to Go)
1. (2025) Used by companies in: Crypto, Gaming, AI & Machine Learning, Zero-Knowledge Proofs (ZKP), Gambling, and High-Frequency Trading (HFT)/Finance, Embedded, Security
1. [Traits](https://doc.rust-lang.org/std/all.html#traits) help group & organize code around patterns (`Hash`, `Eq`, `PartialEq`, `Ord`, `PartialOrd`, `Default`, `Clone`, `From`, `TryFrom`, `AsRef`, `Display`, `Deref`, `Add`, ...)
    1. Compare to c++
    1. Java is similar but not as streamlined
        - `Comparable`, `Writer`, `Reader`, ... are interfaces
        - `::hash`, `::equals`, `::toString` are part of `Object`


# Bad news

1. Slow builds
    1. slow compared to Go, Java, TS, ...
    1. C++ is much worse
1. Syntax is dense, especially with lifetimes
1. "Sometimes" file-names and module-names are associated (eg `mod foo` must be in `foo.rs`)
1. JetBrains specific
    1. RustRover has broken fonts and they cannot recreate (compared to CLion, Intellij, Goland)
    1. RustRover is poorly supported (compared to other JetBrains products)
        1. They respond, they just don't fix anything
        1. They regularly introduce regressions
    1. CLion rust plugin is about as buggy (however CLion is stable)
    1. Auto-import fails when using macros (`macro_rules!`)
    1. Plugin makes editor unresponsive
        1. I believe they are doing analysis on the main/UI thread
        1. Happens even with a 32 core AMD Ryzen 9 with 63 GB of ram (allocating 6 gb to the IDE)
    1. Editing a macro is very painful
        1. They are doing work on the main/ui thread
        1. See lots of related tickets open
    1. Things just stop working after a while...
        1. feature: specify type explicitly
    1. In build panel, file links navigate to the wrong file when name is common (eg. Cargo.toml or main.rs, lib.rs)
1. Not many jobs (as of 2023), compared to Golang, C++, Java, Python
1. [Strings are overly complex](./strings.md) compared to Go, Python, Java, ...
    1. But rust strings are simple and safe compared to c & c++
1. Complexity (or "nuance")
    1. eg. Rust strings compared to Golang, Java, Python, ...
    1. eg. Generics and Associated Types
    1. eg. Iterators when you need [`.map`](https://doc.rust-lang.org/std/iter/struct.Map.html) returns a [`Result`](https://doc.rust-lang.org/std/result/)
        1. You end up using things like: `collect::<Result<Vec<_>, anyhow::Error>>()?`
        2. maybe [`try_collect`](https://doc.rust-lang.org/std/iter/trait.Iterator.html#method.try_collect) helps?
    1. eg. Error handling, particularly across libraries, and when using [serde](https://serde.rs/)
    1. eg. Traits with overlapping applicability like [`Deref`](https://doc.rust-lang.org/std/ops/trait.Deref.html) (Associated types), [Borrow](https://doc.rust-lang.org/std/borrow/trait.Borrow.html), and [AsRef](https://doc.rust-lang.org/std/convert/trait.AsRef.html) (Generics)
    1. eg. Error messages are generally helpful, but complex (more helpful than c, c++, java, python, php, ruby)
    1. Many popular libs don't value simplicity (Compare to Go & Python ecosystems)
        1. Increasingly, Java has this problem (eg. look at Spring Web & WebFlux)
        1. c++ has always had this problem
    1. Generalizing collection fn arguments is hard. eg. try to pass `Vec<PathBuf>` into a fn which accepts `&[&Path]`)
        1. root cause: statically sized vs dynamically sized
1. Too big to fit in your head all at once (Compared to Golang, Core Java, Core Python, ...)
    1. Better than c++ though :-)
    1. Constantly thinking about ownership & borrowing
        1. Generally two version of **everything** (Owned version, Borrowed version)
        1. `clone` can be an escape hatch
1. Must actively code in rust frequently to keep it in mind (compare to Java or Go)
1. No struct validation at initialization
    1. Compare to Java, C++
    1. Same problem in Go, C
    1. [`derive_builder`](https://docs.rs/derive_builder/latest/derive_builder/) can help mitigate
    1. The strong type system makes many (not all) validations unnecessary
1. Hard to keep code looking current, modern syntax evolves quickly (same as JavaScript)
    1. [Clippy](TODO) helps
1. HTTP is very hard if you want anything more than the basics
    1. The frameworks built on hyper are complex when you need to customize (axum, warp, rocket)
        1. eg. custom error on json body parse failure
    1. [Hyper](https://hyper.rs/) can be difficult to use directly due to ownership issues (eg. routing with database connection)
1. Non-blocking code is complex (compared to Golang)
    1. although [Tokio](https://tokio.rs/) and Rayon are simpler to use correctly than Java 18 or c++ concurrency
    1. Example: Read thru the docs for Future & Poll
1. Hard to abstract over Sets
    - Hard write a function which to accepts both `HashSet` and `BTreeSet`
    - Can partially mitigate by accepting iterator, but doesn't help if you need to use other set operations
    - Would need `dyn`
1. Hard to abstract over Maps
    - Hard write a function which to accepts both `HashMap` and `BTreeMap`
    - Can partially mitigate by accepting iterator, but doesn't help if you need to use other map operations
    - Would need `dyn`
1. [`match`](https://doc.rust-lang.org/rust-by-example/flow_control/match.html) creates excessive nesting
    1. Things like [if-let](https://doc.rust-lang.org/rust-by-example/flow_control/if_let.html) mitigate somewhat
1. Cross compiling is hard.  Eg. from Linux container with target of Mac M1 chips (compare to Go, Java, Python, ...)
    - Probably more of an issue with apple requiring xcode
    - See https://godot-rust.github.io/book/gdnative/export/macosx.html
    - See https://wapl.es/rust/2019/02/17/rust-cross-compile-linux-to-macos.html
1. (Serde) custom Deserializer [is REALLY hard](https://serde.rs/impl-deserialize.html)
    1. compare with Golang [`UnmarshalJSON`](https://pkg.go.dev/encoding/json#Unmarshaler)
    1. compare with Java with [Jackson's `@JsonCreator`](https://javadoc.io/static/com.fasterxml.jackson.core/jackson-annotations/2.14.2/com/fasterxml/jackson/annotation/JsonCreator.html)
1. [Path](https://doc.rust-lang.org/std/path/struct.Path.html) is surprisingly tedious to use in practice (see [`to_string_lossy()`](https://doc.rust-lang.org/std/ffi/struct.OsStr.html#method.to_os_string))
    1. compare with Golang [`path/filepath`](https://pkg.go.dev/path/filepath)
    1. compare with Java [`Path`](https://docs.oracle.com/en/java/javase/11/docs/api/java.base/java/nio/file/Path.html)
    1. CLion debugger cannot print `Path` nor `PathBuf`
1. [CLion](https://www.jetbrains.com/clion/) Editor
    1. Relatively slow error checker (compare to Intellij, Goland or WebStorm with eslint)
1. [CLion](https://www.jetbrains.com/clion/) Debugger
    1. Cannot help you debug `Trait` implementations
        1. Compare with debugging golang, java, ... interface implementations
    1. Cannot print strings sometimes (eg. alias a type to a string)
    1. Cannot pretty print `Path` and `PathBuf` variables
1. Popular url lib is non-standard
    1. https://github.com/servo/rust-url/issues/808
1. Idiomatic testing guidance bloats source files
    1. Move tests to separate root dir
1. `use`ing the wrong `Write`: see [`std::fmt::Write`](https://doc.rust-lang.org/std/fmt/trait.Write.html) and [`std::io::Write`](https://doc.rust-lang.org/std/io/trait.Write.html)
    1. Maybe a CLion issue
1. Tracing
    1. OpenTelemetry api is FAR TOO complex to use directly (compare to Go, Python, Java, ...)
    1. Tokio tracing lib helps a lot, but there are still gotchas (minefields)
        1. eg. must define all fields into `info_span!` before usage, else fails silently
    1. Tracing makes Rayon usage very complex
        1. eg. https://github.com/rayon-rs/rayon/issues/1018
        1. Root cause is probably ownership handling in opentelemetry/tokio-tracing
1. Module setup is unintuitive
    1. need an extra file and have to reference in parent directory
    1. Compare to Go or Java or Python or C++ or C or TS or Kotlin or ...
1. CLion: cannot exclude directories
1. Hard to abstract over Ranges
    - Hard write a function which to accepts both `std::ops::Range` and `RangeInclusive`
    - Eg. when you need `.start` & `.end`
    - [`RangeBounds`](https://doc.rust-lang.org/std/ops/trait.RangeBounds.html) trait kinda helps
        - Need `dyn`, but `RangeBounds` is NOT object safe, so ...
1. [match patterns can be excessively complex](https://doc.rust-lang.org/reference/patterns.html#identifier-patterns)
