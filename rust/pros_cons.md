# Overview
1. Things that are excellent about Rust
1. Things that are terrible about Rust


# Good news
1. Light runtime memory usage (compare to java, go, python, c#, vb, ruby, php, ...)
1. Extremely **fast** at runtime (compare to java, go, python, c#, vb, ruby, php, ...)
1. Evolves quickly (compare to java, go, python, c#, vb, ruby, php, ...)
1. Multiple return values (compared to Java, Python, C, ...)
1. "Sensible" Operator overloading
1. [Set](https://doc.rust-lang.org/std/collections/struct.HashSet.html) support (compare to Go)
1. Methods must declare mutability requirements/assumptions
1. Struct fields support default values (compare to Go)
1. Good attribute macros tend to simplify what would be boilerplate in other languages
    - eg. [derive](), [serde](https://serde.rs/derive.html), [instrument](https://docs.rs/tracing/latest/tracing/attr.instrument.html)
1. [`format!()`](https://doc.rust-lang.org/std/macro.format.html) is excellent
1. [Cargo](https://doc.rust-lang.org/cargo/) is excellent
1. [Feature flags](https://doc.rust-lang.org/cargo/reference/features.html) are excellent
1. Rich enums (compare to Go)


# Bad news
1. Slow builds
1. Syntax is dense
1. "Sometimes" file-names and module-names are associated (eg `mod foo` must be in `foo.rs`)
1. Not many jobs (as ov 2023), compared to Golang, Java, Python
1. Complexity (or "nuance")
    1. eg. Compare Rust strings to Golang, Java, Python, ...
    1. eg. Generics and Associated Types
    1. eg. Iterators when you need [`.map`](https://doc.rust-lang.org/std/iter/struct.Map.html) returns an [`Result`](https://doc.rust-lang.org/std/result/)
    1. eg. Error handling, particularly across libraries, and when using [serde](https://serde.rs/)
1. Too big to fit in your head all at once (Compared to Golang, Core Java, Core Python, ...)
    1. Better than c++ though :-)
1. HTTP is very hard if you want anything more than the basics
    1. The frameworks built on hyper are complex when you need to customize (axum, warp, rocket)
    1. [Hyper](https://hyper.rs/) can be difficult to use directly due to ownership issues (eg. routing with app state)
1. Non-blocking code is complex (compared to Golang)
    1. although [Tokio](https://tokio.rs/) and Rayon are simpler to use correctly than Java 18 or c++ concurrency
    1. Example: Read thru the docs for Future & Poll
1. [`match`](https://doc.rust-lang.org/rust-by-example/flow_control/match.html) creates excessive nesting
    1. Things like [if-let](https://doc.rust-lang.org/rust-by-example/flow_control/if_let.html) mitigate somewhat


# Other Resources
1. TODO
