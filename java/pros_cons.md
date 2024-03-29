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
1. Tons of jobs in USA (compare to Rust, c)
1. [Set](https://docs.oracle.com/en/java/javase/17/docs/api/java.base/java/util/Set.html) support (compare to go)
1. Rich [collections](https://docs.oracle.com/en/java/javase/17/docs/api/java.base/java/util/Collection.html)
1. Method overloading (compare to Go, Rust, c, js, python)
    1. Maybe it's not a good thing :-)
    1. Rust has alternative thru traits
1. Class properties support default values (compare to Go)
1. Java 14 fixed ambiguity or null pointer exceptions (https://openjdk.org/jeps/358)
    1. Null pointer precondition checks are unnecessary since error messages are equally clear
    1. `requireNonNull` is still useful in constructors to catch NPE early
    1. `requireNonNull` is still useful to prevent null pointers from drifting thru the code
    1. [lombok `@NonNull`](https://projectlombok.org/features/NonNull) also helps


# Bad news

1. [Checked exceptions](./exceptions.no_checked.md), (compare to Go, Rust, c, c++, c#, js, ts, Kotlin, Python, ...)
    1. Mitigate with [Lombok](https://projectlombok.org/features/SneakyThrows)
    1. Still very painful on streams (eg. [`map()`](https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/util/stream/Stream.html#map(java.util.function.Function)) with a lambda that throws an exception
1. Immutability is hard and not the default (compare to [Kotlin](TODO) or [Rust](TODO))
    1. Mitigate with [Lombok](https://projectlombok.org/features/Value)
1. No coroutines (see [Project loom](https://cr.openjdk.java.net/~rpressler/loom/Loom-Proposal.html))
    1. [Maybe soon](https://openjdk.org/jeps/425)
1. Behavior and state must be combined (compare to Go, Rust, C, Python, JS/TS, ...)
    1. Lambdas partially mitigate this
    1. No pure functions (compare to Rust, Go, c, c++, js, ts, Python, Kotlin, ...)
    1. Cannot spread implementaiton across multiple files (compare to Rust, Go, js, c#)
1. Inheritance is the only simple way to reuse (as opposed to [mixins](https://en.wikipedia.org/wiki/Mixin), [type-embedding](https://go101.org/article/type-embedding.html), ...)
1. Correct concurrent & parallel programming is hard (compare to [go](TODO))
    1. [Loom should help](https://cr.openjdk.java.net/~rpressler/loom/Loom-Proposal.html)
1. No [value types](https://cr.openjdk.java.net/~jrose/values/values-0.html#:~:text=The%20Java%20VM%20type%20system,double%20%2C%20char%20%2C%20and%20boolean%20.)
    1. [Project Valhalla](https://openjdk.org/projects/valhalla/) should help
1. Primitives vs Reference types (compare to Rust, Go, c, Python, Kotlin, etc)
    1. Generics don't work on primitive types (so boxing/unboxing required)
    1. [JEP 402](https://openjdk.org/jeps/402) should fix
1. Heavy runtime memory usage (compare to Rust, Go, c, c++)
    1. Patrially mitigate with GraalVM
1. Slow native compiler (Graal), (compare to [Go](TODO))
1. Native Cross-compilation is HARD (compare to Rust, Go, c, ...)
1. Slow build tools ([Gradle](TODO) and [Maven](TODO))
    1. Build system doesn't scale (the next lib adds significant build time and memory usage)
1. There's a limit on how fast your code can be because of GC and the JVM (compare to Rust)
1. There's a limit on how little memory you use because of GC and the JVM (compare to Rust, go)
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
1. Single return value (compare to Go, Rust, python)
1. No context class (compare to [go](https://pkg.go.dev/context) or [rust](https://doc.rust-lang.org/stable/std/task/struct.Context.html))
    1. So everyone has their own (eg. `io.opentelemetry.context.Context`, `javax.servlet.http.HttpServletRequest`, `io.vertx.core.Context`, ` kotlin.coroutines.CoroutineContext`)
1. No [defer](https://gobyexample.com/defer) (compare to go)
    1. forces `try-finally` with deeper nesting
1. Effectively useless in the browser (compare to js, ts, rust)
1. Hashing is hard (compare to Go, python)
    1. Mitigate with [apache commons codec](https://commons.apache.org/proper/commons-codec/apidocs/org/apache/commons/codec/digest/DigestUtils.html)
1. No type aliases
1. `java.nio.file.attribute.FileAttribute` permissions are complex (compare to Go)
1. Array equality tests are unlike other comparisons (compare to go, rust, ...)
1. primitive comparisons are different from reference comparisons (compare to go, rust, ...)
1. oracle keeps making java more expensive
    1. See [here](https://www.azul.com/java-alternative-vendors/?utm_content=&utm_term=oracle%20java&utm_campaign=GS_NB_Core-Oracle_OC_NAM_EN&utm_source=google&utm_medium=paid-search&_bt=662556186424&_bm=p&_bn=g&gad_source=1&gclid=CjwKCAiA3aeqBhBzEiwAxFiOBhLcjLlx9tewRy_My5Ah-degDI0ItxO2puOWhFgE1NVw1P0ONEcdtxoCe5gQAvD_BwE) or [here](https://redresscompliance.com/decoding-oracle-java-licensing-java-licensing-changes-2023/) or [here](https://www.reddit.com/r/java/comments/10l2we6/oracle_changing_java_licensing_to_per_user_vs_per/)

## Bad news: minor

1. Auto-formatting is non-core (compare to [go](https://go.dev/blog/gofmt) or [rust](https://github.com/rust-lang/rustfmt))
    1. See [spotless](https://github.com/diffplug/spotless)
1. No pattern matching (compare to [Rust](https://doc.rust-lang.org/book/ch18-03-pattern-syntax.html))
    1. Scheduled for [Java 20](https://openjdk.org/jeps/433)
1. Reflection is expensive, and some libs abuse it (eg. Spring)
    1. Mitigate by avoiding reflection & libs that abuse it
1. No trailing comma (compare to Go, Rust, Python, ts, js, kotlin)
1. No unsigned ints (compare to Rust, Go, c++, c#, Kotlin, ...)
1. Inconsistent naming on numeric types (compare to [Rust](https://doc.rust-lang.org/reference/types/numeric.html) or [go](https://go.dev/ref/spec#Numeric_types))
1. Required semicolons
    1. Mitigate using IDE
1. Verbose syntax (compare to python or go)
    1. Project [Amber](https://openjdk.org/projects/amber/) aims to fix
1. Methods cannot accept read-only receiver
1. Explicit interface implementation (compare to go)
    1. Forces tighter coupling than implicit interface implementation
1. Recursive file delete is hard (compare to Go, Python, ...)
    1. Mitigate with [Guava](https://guava.dev/releases/31.0-jre/api/docs/com/google/common/io/MoreFiles.html#deleteDirectoryContents(java.nio.file.Path,com.google.common.io.RecursiveDeleteOption...)) or [apache commons io](https://commons.apache.org/proper/commons-io/apidocs/org/apache/commons/io/FileUtils.html#deleteDirectory-java.io.File-)
1. `Paths.get` doesn't accept `Path` argument (so you must convert to `String` first)

## Jackson
1. While Deserializing, objectMapper doesn't usually tell you which Class/field caused the error
    1. eg. `NoSuchFieldError`
    1. Use debugger to step thru their source with a breakpoint
1. You have to wrap `objectMapper.readValue(...)` calls with try-catch-rethrow to get USEFUL exceptions


# Other Resources

1. TODO
