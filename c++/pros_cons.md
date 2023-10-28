# Overview

1. Things that are excellent about C++
1. Things that are terrible about C++

# Good news

1. Expressive
    1. If it can be done in another language, C++ can do it
1. Light on memory
1. Fast at runtime
1. Control over hardware
1. Evolving quickly enough
1. [Algorithms](https://en.cppreference.com/w/cpp/algorithm)
    1. Better than [Java streams](https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/util/stream/Stream.html)
    1. Much better than [go slices](https://pkg.go.dev/slices)
    1. Rust is close via [std::iter](https://doc.rust-lang.org/std/iter/index.html) and [itertools](https://docs.rs/itertools/latest/itertools/)
1. Strong collections
    1. Same as Java, Rust, etc
    1. Also, Lock-free collections (Rust too)
    1. Much better options than Go, C, Javascript, etc
1. Huge community
    1. Strong Machine learning libraries
    1. Strong GUI libraries
1. Immutability (via `const`)
1. Idioms for safe memory management
    1. Compare to C which requires `malloc` and `free`
1. Easy to containerize
1. Concise error handling
1. Inheritance, which is useful for GUI code
1. Safe pointers (References, Smart pointers)
    1. Unlike Go, C, ...


# Bad news
1. Complexity
1. Versions
    1. C++ 11 is a different language from pre 11
    1. C++ 17/20/23 feel like a different language from C++ 11/14
1. Cross compilation is VERY complex
1. Modules are not well supported yet
    1. Which makes compilation slower
1. Slow compilation
1. Very unsafe at runtime if used incorrectly
    1. Static analysis, testing & sanitizers help
1. No string templates
    1. Compare to [Java string templates](https://openjdk.org/jeps/459)
    1. Compare to [Kotlin interpolation](https://kotlinlang.org/docs/java-to-kotlin-idioms-strings.html)
    1. Compare to [Python fstrings](https://realpython.com/python-f-strings/)
    1. Compare to [Rust `format!` macro](https://doc.rust-lang.org/std/macro.format.html)
1. [Testing was added long after the ecosystem was established](https://github.com/catchorg/Catch2)
1. Building & distributing code is not as smooth as other popular languages ([CMake](https://cmake.org/))
    1. Go: Compare to [`go build`](https://pkg.go.dev/cmd/go#hdr-Compile_packages_and_dependencies) and [`go get`](https://pkg.go.dev/cmd/go/internal/get)
    1. Java: Compare to [gradle](https://gradle.org/) & [maven repos](https://mvnrepository.com/)
    1. Python: Compare to [pip](https://pypi.org/project/pip/)
    1. Rust: Compare to [cargo](https://doc.rust-lang.org/cargo/)
1. OpenMP is an afterthought
