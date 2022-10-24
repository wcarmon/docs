# Overview
1. Things that are excellent about java 17+
1. Things that are terrible about java 17+


# Good news
1. Abstractions
1. Actively developed
1. Constants (compare to python)
1. Cross platform (at least for desktop)
1. Enums can have properties (compare to golang)
1. Generics support
1. Huge ecosystem
1. Interfaces (compare to c or python)
1. Multi-threaded (compare to python's GIL)
1. Native mature HTTP client
1. Sandboxed (more secure than many alternatives)
1. Strings are simple (compare to c, c++ or Rust)
1. Strong IDE support
1. Tons of books, articles, youtube videos, etc.
1. Tons of jobs in USA


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
1. Correct concurrent programming is hard (compare to [go](TODO))
    1. [Loom should help](https://cr.openjdk.java.net/~rpressler/loom/Loom-Proposal.html)
1. No value types
    1. [Project Valhalla](https://openjdk.org/projects/valhalla/) should help
1. Slow native compiler (Graal), (compare to [Go](TODO))
1. Native Cross-compilation is HARD (compare to rust, go, c, ...)
1. Slow build tools ([Gradle](TODO) and [Maven](TODO))
1. Heavy runtime memory usage (compare to Rust, Go, c, c++)
    1. Patrially mitigate with GraalVM
1. inconsistent naming on numberic types (compare to [Rust](TODO) or [go](TODO))
1. Verbose syntax (compare to python or go)
1. Complex [FFI](https://en.wikipedia.org/wiki/Foreign_function_interface), see [Project Panama](https://openjdk.org/projects/panama/)
1. Build system doesn't scale (the next lib adds significant build time and memory usage)
1. Records are half-baked (no builder, no inheritance, no private state) and getters are incompatible with javabean patterns
    1. Mitigate by avoiding records
1. Modules are complicated and not widely supported
    1. Mitigate by avoiding modules
1. Ecosystem full of bloated & overly complex libraries (J2EE, JBoss, Spring, Hibernate, xml parsers, etc)
    1. Mitigate by avoiding those libraries


## Bad news: Minor
1. Auto-formatting is non-core (See [spotless](TODO))
1. No pattern matching (compare to [Rust](https://doc.rust-lang.org/book/ch18-03-pattern-syntax.html))
    1. Scheduled for [Java 20](https://openjdk.org/jeps/433)
1. Required semicolons
    1. Mitigate using IDE
1. No context class (compare to [go](https://pkg.go.dev/context) or [rust](https://doc.rust-lang.org/stable/std/task/struct.Context.html))
1. Reflection is expensive, and some libs abuse it (eg. Spring)
    1. Mitigate by avoiding reflection & libs that abuse it


# Other resources
1. TODO
