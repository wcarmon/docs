# Overview

1. Things that are excellent about C++
1. Things that are terrible about C++

# Good news

1. Expressive
    1. If it can be done in another language, C++ can do it
1. Light on memory
1. Fast at runtime
1. Control over hardware
2. Heavily used in ...
    1. Video game development 
    2. Database development
    3. Low latency Trading systems
    4. Cloud infra
    5. low latency CDNs
    6. Desktop applications GUIs
    7. Embedded systems
1. Evolving quickly enough
1. [Algorithms](https://en.cppreference.com/w/cpp/algorithm)
    1. Better than [Java streams](https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/util/stream/Stream.html)
    1. Much better than [go slices](https://pkg.go.dev/slices)
    1. Rust is close via [std::iter](https://doc.rust-lang.org/std/iter/index.html) and [itertools](https://docs.rs/itertools/latest/itertools/)
1. Strong collections
    1. Same as Java, Rust, etc
    1. Also, Lock-free collections (Rust too)
    1. Much better options than Go, C, Javascript, etc
1. Huge community for specific domains
    1. Big in gaming, though C# is close
    1. Strong Machine learning libraries, though Python is close (deferring to c for performance)
    1. Strong GUI libraries (compared to all other languages)
    1. Strong Finance libraries (eigen, quantlib, boost)
1. Immutability (via `const`)
1. Idioms for safe memory management
    1. Compare to C which requires `malloc` and `free`
1. Easy to containerize
1. Concise error handling
1. Inheritance, which is useful for GUI code
1. (kinda) Safe pointers (References, Smart pointers)
    1. Unlike Go, C, ...
1. High quality, popular libraries
    2. Unreal engine
    3. Qt
1. One of few options for embedded systems
    2. rust support isn't there yet


# Bad news
1. Complexity everywhere
2. Programmer must do things the tools could easily do
1. Doing the idiomatic thing is more verbose than anti-patterns
    1. not that there are many agreements on how to do things
    2. compare to Go, Rust/clippy, java, etc
1. Versions
    1. C++ 11 is a different language from pre 11
    1. C++ 17/20/23 feel like a different language from C++ 11/14
    1. Many teams haven't upgraded for that reason
    2. Most c++ shops are stuck on an old version
    3. Most popular libraries don't target modern C++
1. Cross compilation is VERY complex
1. Modules are not well supported yet
    1. Which makes compilation slower
1. Slow compilation
1. Very unsafe at runtime if used incorrectly
    1. Static analysis, testing & sanitizers help
1. ~~No string templates~~
    1. std::format
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
1. No one is starting new projects in c++
    1. Unless they only have C++ dev
    2. Unless they are in gaming or military
    3. Mostly maintaining mission critical legacy systems that are too hard to update
1. Macros
1. Infinite backward compatibility
    1. too many ways to do things
    2. old ways never die
1. Templates
    1. also error messages are unhelpful
    2. sooo complex
1. Dumping ground for ideas
1. Operator overloading means you don't really know what anything does
1. safe concurrency is a nightmare
1. no consistency around naming things (Compared to Rust, Java, Go, etc)
1. Focus is on the language, not problem solving
1. Most jobs are about babysitting legacy systems.  Nothing new
1. Banned from the Linux kernel
1. Undefined behavior
1. Exceptions and how they interact with everything else
1. modules are poorly supported
3. Safety is opt-in
    4. compare to Rust, Java, Go, etc
