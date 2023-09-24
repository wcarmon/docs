# Overview

1. Things that are excellent about Golang
1. Things that are terrible about Golang

# Good news

1. Optimized for readers
    1. Expressive, but more concise than rust, C++, C, Java, Typescript
    1. Less ways to do things than other languages (eg. loops)
    1. Roughly as concise, but easier to refactor & comprehend than unfamiliar Python, js, ruby, php, perl, etc
1. [defer](https://go.dev/tour/flowcontrol/12) statement
    1. Rust is about as good using [implicit `drop`](https://doc.rust-lang.org/std/ops/trait.Drop.html) at the end of scope
    1. Java has [try-with-resources](https://docs.oracle.com/javase/tutorial/essential/exceptions/tryResourceClose.html), which is almost as good, but increases [code nesting](https://miro.medium.com/v2/resize:fit:720/1*g4NuK2wpgB5hn_46bvzPmQ.png)
    1. C++ has [RAII](https://en.cppreference.com/w/cpp/language/raii), with destruction at end of scope
1. Very fast builds
    1. Compare to Java (even worse with Kotlin alone or hybrid Java+Kotlin)
    1. Compare to C++, Rust (macro complexity, optimization complexity). Both move "overhead" from runtime to compile-type
1. Cross compilation is very easy
    1. Same is true for Java (except maybe GraalVM) and dynamic languages like python
    1. Partly because they built [their own linker](https://github.com/golang/go/blob/master/src/cmd/link/internal/ld/macho.go) for mac
        1. That decision has [pros & cons](https://www.uber.com/blog/fixing-gos-linker/) too
    1. This is mostly difficult in other languages because of xcode (part of apple's "vendor lock-in" strategy)
        1. [Learn more](https://en.wikipedia.org/wiki/Mach-O)
    1. Compare to C++ [via clang](https://clang.llvm.org/docs/CrossCompilation.html), [Zig might help](https://andrewkelley.me/post/zig-cc-powerful-drop-in-replacement-gcc-clang.html)
    1. Compare to [Rust](https://wapl.es/rust/2019/02/17/rust-cross-compile-linux-to-macos.html/)
1. Light runtime memory usage
    1. Compare to Java, Python, c#, vb, ruby, php, etc
    1. Same benefit in Rust, C++, C
1. Implicit interface implementation (reduces dependencies)
    1. Impossible in Java without reflection or hacks
    1. Rust can get close using "Orphan rule" and default impl
1. Multiple return values
    1. Compare to Java (you must make extra `record`), or C++ (must make extra struct or class), etc
    1. Same benefit in Rust (due to implicit [tuples](https://doc.rust-lang.org/rust-by-example/primitives/tuples.html))
1. Methods can declare mutable (pointer) or read-only (copy) receiver
    1. Same benefit in Rust
1. Tests can only log when they fail

# Bad news

1. Verbose error handling & error propagation
    1. Compare to [Rust](https://doc.rust-lang.org/rust-by-example/std/result/question_mark.html), [Python](https://docs.python.org/3/library/exceptions.html), [C++](https://cplusplus.com/doc/tutorial/exceptions/) or [Java](https://docs.oracle.com/javase/tutorial/essential/exceptions/index.html)
1. [Immutability](../general/immutability.md) is hard
    1. Mitigate: `struct` shallow copy is trivial
        1. But `struct` shallow copy "fails" when structs has pointer/reference field
        1. eg. `struct`s often use `*big.Float` in finance
    1. Also `*big.Float` API favors memory reuse over immutability
    1. Compare to Java [`record`](https://docs.oracle.com/en/java/javase/17/language/records.html#GUID-6699E26F-4A9B-4393-A08B-1E47D4B2D263)s or `final` class props or lombok [`@Value`](https://projectlombok.org/features/Value)
    1. Compare to Rust [`mut`](https://doc.rust-lang.org/std/keyword.mut.html)
    1. Compare to Python [`@dataclass(frozen=True, kw_only=True, slots=True)`](https://docs.python.org/3/library/dataclasses.html)
    1. Compare to C++ (class with `private fields` and `const` getter member functions)
    1. Requires extra **manual** coding discipline (eg. getters for copy-types, manual deep copy for pointer types, ...)
1. `struct` provides no way to enforce invariants
    1. compare to Java, C++, or any language with constructors
    1. Rust has same problem, but compiler can generate builder [via macro](https://docs.rs/derive_builder/latest/derive_builder/)
    1. Requires extra **manual** coding discipline (eg. manually invoke a struct validation `func`)
1. `struct` fields don't support default values (compare to [Rust](https://doc.rust-lang.org/std/default/trait.Default.html), Java, C++)
    1. normally, you'd mitigate with a constructor, but Golang lacks those
    1. Requires extra **manual** coding discipline (eg. manually invoke a field defaulter, checking if not already set)
1. [atomics lack encapsulation, since you must pass raw pointer](https://pkg.go.dev/sync/atomic#AddInt64)
    1. Compare to [Java atomics](https://docs.oracle.com/en/java/javase/20/docs/api/java.base/java/util/concurrent/atomic/package-summary.html) or [Rust atomics](https://doc.rust-lang.org/std/sync/atomic/) or [C++ atomics](https://en.cppreference.com/w/cpp/atomic/atomic)
    1. Requires extra **manual** coding discipline (eg. manually verify all usages go thru the atomic api and not directly)
1. [structured concurrency](https://en.wikipedia.org/wiki/Structured_concurrency) is hard to use correctly
    1. eg. [when to close channels](https://udhos.github.io/golang-concurrency-tricks/) for fan-in fan-out pattern, error handling, cancellation, timeouts, etc.
    1. Mitigate: https://pkg.go.dev/golang.org/x/sync/errgroup
    1. [Learn more](https://vorpus.org/blog/notes-on-structured-concurrency-or-go-statement-considered-harmful/)
    1. Compare to [Kotlin](https://kotlinlang.org/docs/coroutines-basics.html#scope-builder-and-concurrency)
    1. Compare to [Java](https://openjdk.org/jeps/453)
    1. Compare to [Python's Trio](https://github.com/python-trio/trio)
    1. Compare to [Rust](https://rust-lang.github.io/async-book/03_async_await/01_chapter.html) or [Rayon Scope](https://docs.rs/rayon/latest/rayon/fn.scope.html), although it's still pretty hard in "core" Rust
    1. Requires extra **manual** coding discipline
1. `big.Float` is hard to use correctly
    1. [setter methods tend to mutate in the interest of saving memory](https://pkg.go.dev/math/big)
    1. The API is VERY different from most of golang types
    1. Compare to [Java BigDecimal](https://docs.oracle.com/en/java/javase/20/docs/api/java.base/java/math/BigDecimal.html#%3Cinit%3E(java.math.BigInteger)), which is sometimes verbose, but easier to use correctly
    1. TODO: Rust
    1. Mitigate: Learn from [this abandoned library](https://github.com/sdcoffey/big)   
    1. Requires extra **manual** coding discipline (eg. always create a new big.Float or be careful about reuse)
1. Enums cannot have properties
    1. But they can have methods
    1. Compare to [Rust enums](https://doc.rust-lang.org/book/ch06-01-defining-an-enum.html) or [Java enums](https://docs.oracle.com/javase/tutorial/java/javaOO/enum.html) or Java [sealed classes](https://docs.oracle.com/en/java/javase/20/language/sealed-classes-and-interfaces.html)
    1. See your options: https://threedots.tech/post/safer-enums-in-go/
    1. Mitigate: add getter methods to the "enum" then use `switch` statements in each method
1. No [Sets](https://en.wikipedia.org/wiki/Set_(abstract_data_type))    
    1. Compare to [Rust](https://doc.rust-lang.org/std/collections/struct.HashSet.html) or [Java](https://docs.oracle.com/en/java/javase/20/docs/api/java.base/java/util/Set.html) or [C++](https://cplusplus.com/reference/unordered_set/unordered_set/)
    1. Also, no `SortedSet`, Compare to [Java](https://docs.oracle.com/en/java/javase/20/docs/api/java.base/java/util/SortedSet.html) or [Rust](https://doc.rust-lang.org/stable/std/collections/struct.BTreeSet.html) or [C++](https://en.cppreference.com/w/cpp/container/set)
    1. Mitigate: use `map[T]bool` for "HashSet", use 3rd party lib for sorted set
1. `switch` statement: compiler cannot enforce **exhaustive** `enum` cases
    1. compare to [Java](https://docs.oracle.com/en/java/javase/17/language/switch-expressions.html), [Rust](https://rustc-dev-guide.rust-lang.org/pat-exhaustive-checking.html), [C++](https://abseil.io/tips/147),  etc
    1. Requires extra **manual** coding discipline (eg. remember to add missing statements, add a default case)
1. `switch` is not an expression
    1. Compare to [Java 17+](https://docs.oracle.com/en/java/javase/17/language/switch-expressions.html)
    1. Compare to [Rust match expression](https://doc.rust-lang.org/reference/expressions/match-expr.html)
    1. Same problem in C, C++, ...
    1. Mitigate: use a map, hashmap, etc
1. functional/stream programming is hard
    1. compare to [Java streams](https://docs.oracle.com/en/java/javase/20/docs/api/java.base/java/util/stream/Stream.html) or [Rust Iterator](https://doc.rust-lang.org/std/iter/trait.Iterator.html) or JS array or [C++ algorithms](https://en.cppreference.com/w/cpp/algorithm)
    1. although performance is sometimes often better without streams
    1. Java streams [require a special debugger](https://www.jetbrains.com/idea/guide/tips/debugging-streams/)
    1. [Golang 1.21 improved this](https://pkg.go.dev/slices)
1. `max`/`min`/`abs` ~~functions don't work on all numeric types~~
    1. Fixed in 1.21 - https://tip.golang.org/ref/spec#Min_and_max
1. ~~Sorting is unintuitive~~
    1. Fixed in 1.21 - https://pkg.go.dev/slices#Sort
