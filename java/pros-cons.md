# Overview
1. Things that are excellent about java 17+
1. Things that are terrible about java 17+


# Good news
1. [Actively Developed & Improving](https://en.wikipedia.org/wiki/Java_version_history)
1. Cross platform (at least for linux, mac & windows desktops & servers)
1. Constants (compare to [python](https://www.pythontutorial.net/python-basics/python-constants/))
1. Abstractions (compare to c)
1. [Enums](https://docs.oracle.com/javase/tutorial/java/javaOO/enum.html) can have properties (compare to golang)
1. Generics support
1. Huge ecosystem (compare to rust)
1. Interfaces (compare to c or [python](https://docs.python.org/3/library/abc.html) or [c++](https://www.tutorialspoint.com/cplusplus/cpp_interfaces.htm))
1. Built-in [Multi-threading](https://docs.oracle.com/en/java/javase/17/docs/api/java.base/java/util/concurrent/ExecutorService.html) (compare to [python's GIL](https://wiki.python.org/moin/GlobalInterpreterLock) or c)
1. Mature [HTTP/2 client](https://docs.oracle.com/en/java/javase/17/docs/api/java.net.http/java/net/http/HttpClient.html)
1. [Strings](https://docs.oracle.com/en/java/javase/17/docs/api/java.base/java/lang/String.html) are simple (compare to c, c++ or rust)
1. Strong IDE support (compare to dart, haskel, ...)
1. Tons of [books](https://www.amazon.com/s?k=java&rh=n%3A283155%2Cn%3A3608&dc&ds=v1%3A1wGhkb%2BL0nPGJ%2F14qdAAXL6%2BRsQeidlMcjvVtND26Zo), articles, youtube videos, etc.
1. Tons of jobs in USA (compare to rust, c)
1. [Set](https://docs.oracle.com/en/java/javase/17/docs/api/java.base/java/util/Set.html) support (compare to go)
1. Rich [collections](https://docs.oracle.com/en/java/javase/17/docs/api/java.base/java/util/Collection.html)


# Bad news
1. [Checked exceptions](./exceptions.no-checked.md), (compare to go, rust, c, c++, c#, js, ts, kotlin, python, ...)
    1. Mitigate with [Lombok](https://projectlombok.org/features/SneakyThrows)
1. Immutability is hard and not the default (compare to [Kotlin](TODO) or [Rust](TODO))
    1. Mitigate with [Lombok](https://projectlombok.org/features/Value)
1. No coroutines (see [Project loom](https://cr.openjdk.java.net/~rpressler/loom/Loom-Proposal.html))
    1. [Maybe soon](https://openjdk.org/jeps/425)
1. Behavior and state must be combined (compare to Go, Rust, C, Python, JS/TS, ...)
    1. Lambdas partially mitigate this
    1. No pure functions (compare to rust, go, c, c++, js, ts, python, kotlin, ...)
    1. Cannot spread implementaiton across multiple files (compare to rust, go, js, c#)
1. Inheritance is the only simple way to reuse (as opposed to [mixins](https://en.wikipedia.org/wiki/Mixin), [type-embedding](https://go101.org/article/type-embedding.html), ...)
1. Correct concurrent & parallel programming is hard (compare to [go](TODO))
    1. [Loom should help](https://cr.openjdk.java.net/~rpressler/loom/Loom-Proposal.html)
1. No [value types](https://cr.openjdk.java.net/~jrose/values/values-0.html#:~:text=The%20Java%20VM%20type%20system,double%20%2C%20char%20%2C%20and%20boolean%20.)
    1. [Project Valhalla](https://openjdk.org/projects/valhalla/) should help
1. Primitives vs Reference types (compare to rust, go, c, python, kotlin, etc)
    1. Generics don't work on primitive types (so boxing/unboxing required)
    1. [JEP 402](https://openjdk.org/jeps/402) should fix
1. Heavy runtime memory usage (compare to Rust, Go, c, c++)
    1. Patrially mitigate with GraalVM
1. Slow native compiler (Graal), (compare to [Go](TODO))
1. Native Cross-compilation is HARD (compare to rust, go, c, ...)
1. Slow build tools ([Gradle](TODO) and [Maven](TODO))
    1. Build system doesn't scale (the next lib adds significant build time and memory usage)
1. Complex [FFI](https://en.wikipedia.org/wiki/Foreign_function_interface), see [Project Panama](https://openjdk.org/projects/panama/)
1. [Records](https://docs.oracle.com/en/java/javase/17/docs/api/java.base/java/lang/Record.html) are half-baked (no builder, no inheritance, no private state) and getters are incompatible with javabean patterns
    1. Mitigate by avoiding records
1. Modules are complicated and not widely supported
    1. Mitigate by avoiding modules
    1. eg. check support in google libs like guava & guice
1. Ecosystem full of bloated & overly complex libraries (J2EE, JBoss, Spring, Hibernate, xml parsers, etc)
    1. Mitigate by avoiding those libraries
1. [JDBC](https://docs.oracle.com/en/java/javase/17/docs/api/java.sql/java/sql/package-summary.html) only supports blocking/synchronous
    1. Use non-relational databases?
    1. JDBC alternatives are not well adopted eg. [rdbc](https://rdbc.io/), [R2DBC](https://r2dbc.io/), [ADBA](https://blogs.oracle.com/java/post/asynchronous-database-access-api-adba) (abandonware)
    1. Project Loom might help?
1. [Licensing complexities since Oracle purchased Sun](https://redresscompliance.com/oracle-java-licensing-changes-explaned-free/)
1. Single return value (compare to go, rust, python)
1. No context class (compare to [go](https://pkg.go.dev/context) or [rust](https://doc.rust-lang.org/stable/std/task/struct.Context.html))
    1. So everyone has their own (eg. `io.opentelemetry.context.Context`, `javax.servlet.http.HttpServletRequest`, `io.vertx.core.Context`, ` kotlin.coroutines.CoroutineContext`)
1. No [defer](https://gobyexample.com/defer) (compare to go)
    1. forces `try-finally` with deeper nesting
1. Effectively useless in the browser (compare to js, ts, rust)


## Bad news: Minor
1. Auto-formatting is non-core (compare to [go](https://go.dev/blog/gofmt) or [rust](https://github.com/rust-lang/rustfmt))
    1. See [spotless](https://github.com/diffplug/spotless)
1. No pattern matching (compare to [Rust](https://doc.rust-lang.org/book/ch18-03-pattern-syntax.html))
    1. Scheduled for [Java 20](https://openjdk.org/jeps/433)
1. Reflection is expensive, and some libs abuse it (eg. Spring)
    1. Mitigate by avoiding reflection & libs that abuse it
1. No trailing comma (compare to go, rust, python, ts, js, kotlin)
1. No unsigned ints (compare to rust, go, c++, c#, kotlin, ...)
1. Inconsistent naming on numeric types (compare to [Rust](https://doc.rust-lang.org/reference/types/numeric.html) or [go](https://go.dev/ref/spec#Numeric_types))
1. Required semicolons
    1. Mitigate using IDE
1. Verbose syntax (compare to python or go)
    1. Project [Amber](https://openjdk.org/projects/amber/) aims to fix
1. Methods cannot accept read-only receiver


# Other resources
1. TODO
