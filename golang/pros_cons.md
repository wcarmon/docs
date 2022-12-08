# Overview
1. Things that are excellent about Golang
1. Things that are terrible about Golang


# Good news
1. Simple concurrency (compare to java, Python, c, c++, js/ts, php)
1. Optimized for readers (compare to rust, c++, c, java, js, ts, ruby, php, Python, perl, etc)
1. [defer](https://go.dev/tour/flowcontrol/12)
1. Fast builds (compare to java, c++, rust, ...)
1. Implicit interface implementation
1. Light runtime memory usage (compare to java, Python, c#, vb, ruby, php, ...)
1. Multiple return values
1. Methods can declare mutable or read-only receiver
1. Tests only log when they fail


# Bad news
1. Verbose error handling (compare to Rust or Java)
1. Enums cannot have properties (but they can have methods)
1. Switch: compiler cannot enforce exhaustive enum cases
1. Immutability is hard
    1. Mitigate: struct copy is easy
1. Struct fields don't support default values
1. No Sets
    1. Mitigate: use map[T]bool)
1. functional/stream programming is hard (compare to java streams)
    1. though performance is better without streams
    1. java streams [require a special debugger](https://www.jetbrains.com/idea/guide/tips/debugging-streams/)
1. Sorting is unintuitive
1. max/min/abs functions don't work on all numeric types


# Other Resources
1. TODO