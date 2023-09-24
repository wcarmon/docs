# Overview
1. Things that are excellent about Golang
1. Things that are terrible about Golang


# Good news
1. Simple concurrency (compare to java, Python, c, c++, js/ts, php)
1. Optimized for readers (compare to rust, c++, c, java, js, ts, ruby, php, Python, perl, etc)
1. [defer](https://go.dev/tour/flowcontrol/12)
1. Fast builds (compare to java, c++, rust, ...)
1. Implicit interface implementation
   1. Impossible in Java without reflection or hacks
   2. Rust can get close using "Orphan rule" and default impl
1. Light runtime memory usage (compare to java, Python, c#, vb, ruby, php, ...)
1. Multiple return values
1. Methods can declare mutable or read-only receiver
1. Tests only log when they fail


# Bad news
1. Verbose error handling & error propagation
    1. Compare to [Rust](https://doc.rust-lang.org/rust-by-example/std/result/question_mark.html), [Python](https://docs.python.org/3/library/exceptions.html), [C++](https://cplusplus.com/doc/tutorial/exceptions/) or [Java](https://docs.oracle.com/javase/tutorial/essential/exceptions/index.html)
1. Immutability is hard
    1. Mitigate: `struct` copy is easy
    1. But struct copy "fails" when structs has pointer/reference field
    1. eg. `struct` often use `*big.Float` in finance
    1. Also `*big.Float` API favors memory reuse over immutability
    1. Requires extra manual coding discipline
    1. Compare to Java [`record`](https://docs.oracle.com/en/java/javase/17/language/records.html#GUID-6699E26F-4A9B-4393-A08B-1E47D4B2D263)s or `final` class props or lombok [`@Value`](https://projectlombok.org/features/Value)
    1. Compare to Rust [`mut`](https://doc.rust-lang.org/std/keyword.mut.html)
    1. Compare to Python [`@dataclass(frozen=True, kw_only=True, slots=True)`](https://docs.python.org/3/library/dataclasses.html)
    1. Compare to C++ (class with `private fields` and `const` getter member functions) 
1. `struct` provides no way to enforce invariants 
    1. compare to Java, C++, or any language with constructors
    1. Rust has same problem, but compiler can generate builder [via macro](https://docs.rs/derive_builder/latest/derive_builder/)
    1. Requires extra manual coding discipline
1. `struct` fields don't support default values (compare to [Rust](https://doc.rust-lang.org/std/default/trait.Default.html), Java, C++)
    1. normally, you'd mitigate with a constructor, but Golang lacks those
1. `switch` statement: compiler cannot enforce exhaustive enum cases
    1. compare to Java, Rust, etc
    1. Requires extra manual coding discipline
1. [atomics lack encapsulation, since you must pass raw pointer](https://pkg.go.dev/sync/atomic#AddInt64)
    1. Compare to [Java atomics](https://docs.oracle.com/en/java/javase/20/docs/api/java.base/java/util/concurrent/atomic/package-summary.html) or [Rust atomics](https://doc.rust-lang.org/std/sync/atomic/) or [c++ atomics](https://en.cppreference.com/w/cpp/atomic/atomic)
    1. Requires extra manual coding discipline
1. structured concurrency is hard to use correctly
    1. eg. when to close channels for fan-in fan-out pattern
    1. Mitigate: https://pkg.go.dev/golang.org/x/sync/errgroup
    1. [Learn more](https://vorpus.org/blog/notes-on-structured-concurrency-or-go-statement-considered-harmful/)
    1. Requires extra manual coding discipline
1. `big.Float` is hard to use correctly
    1. [setter methods tend to mutate in the interest of saving memory](https://pkg.go.dev/math/big)
    1. API is VERY different from most of golang
    1. Requires extra manual coding discipline
1. Enums cannot have properties
    1. But they can have methods
    1. Compare to [Rust enums](https://doc.rust-lang.org/book/ch06-01-defining-an-enum.html) or [Java enums](https://docs.oracle.com/javase/tutorial/java/javaOO/enum.html) or Java [sealed classes](https://docs.oracle.com/en/java/javase/20/language/sealed-classes-and-interfaces.html)
    1. See your options: https://threedots.tech/post/safer-enums-in-go/
1. No [Sets](https://en.wikipedia.org/wiki/Set_(abstract_data_type))
    1. Mitigate: use `map[T]bool` for "HashSet"
    1. Compare to [Rust](https://doc.rust-lang.org/std/collections/struct.HashSet.html) or [Java](https://docs.oracle.com/en/java/javase/20/docs/api/java.base/java/util/Set.html) or [c++](https://cplusplus.com/reference/unordered_set/unordered_set/)
    1. Also, no `SortedSet` either, Compare to [Java](https://docs.oracle.com/en/java/javase/20/docs/api/java.base/java/util/SortedSet.html) or [Rust](https://doc.rust-lang.org/stable/std/collections/struct.BTreeSet.html) or [C++](https://en.cppreference.com/w/cpp/container/set)
1. functional/stream programming is hard
    1. compare to [Java streams](https://docs.oracle.com/en/java/javase/20/docs/api/java.base/java/util/stream/Stream.html) or [rust Iterator](https://doc.rust-lang.org/std/iter/trait.Iterator.html) or JS array or [C++ algorithms](https://en.cppreference.com/w/cpp/algorithm)
    1. although performance is sometimes often better without streams
    1. java streams [require a special debugger](https://www.jetbrains.com/idea/guide/tips/debugging-streams/)
    1. [go 1.21 improved this](https://pkg.go.dev/slices)
1. ~~`max`/`min`/`abs` functions don't work on all numeric types~~
    1. Fixed in 1.21 - https://tip.golang.org/ref/spec#Min_and_max
1. ~~Sorting is unintuitive~~
    1. Fixed in 1.21 - https://pkg.go.dev/slices#Sort


# Other Resources
1. TODO
