# Overview
1. Setup environment for mature development
1. Every [popular language](https://www.tiobe.com/tiobe-index/) has a set of development tools (Guard rails) to simplify writing mature code 
1. Guard rails, (when followed), prevent developers from making common mistakes
1. Guard rails can teach you language specific idioms


# Most important Guard rails
1. Compiler
1. Static analysis (Lint)
1. Auto-Tester
  1. Unit test, E2E test
1. IDE
  1. Inspections, Auto-completion, Navigation 
1. AI coding helper (eg. [Tabnine](https://www.tabnine.com) & [Copilot](https://github.com/features/copilot))
1. Profiler
1. Auto-Formatter
1. Other humans (Code reviewers)


# Rust
1. Compiler: [rustc](https://doc.rust-lang.org/rustc/what-is-rustc.html) (usually invoked via `cargo build` or thru IDE)
1. Static analysis: [clippy](https://github.com/rust-lang/rust-clippy)
1. Automated Tester: [cargo test](https://doc.rust-lang.org/cargo/commands/cargo-test.html)
1. IDE: Most Jetbrains tools like [Goland, CLion or Intellij](https://www.jetbrains.com/rust/)
1. AI: [tabnine](https://www.tabnine.com/), [copilot](https://github.com/features/copilot)
1. Profiler: TODO
1. Auto-Formatter: [rustfmt](https://github.com/rust-lang/rustfmt) (usually invoked via `cargo fmt`)


# Go
1. Compiler: [`go build`](https://go.dev/doc/tutorial/compile-install)
1. Static analysis: TODO
1. Automated Tester: [`go test`](https://go.dev/doc/tutorial/add-a-test)
1. IDE: [Goland](https://www.jetbrains.com/go/) or [vsc](https://code.visualstudio.com/)
1. AI: [tabnine](https://www.tabnine.com/), [copilot](https://github.com/features/copilot)
1. Profiler: [Goland CPU Profiler](https://www.jetbrains.com/help/go/cpu-profiler.html), [Goland Memory profiler](https://www.jetbrains.com/help/go/memory-profiler.html), [Goland Mutex profiler](https://www.jetbrains.com/help/go/mutex-profiler.html#InterpretingTheResults)
1. Auto-Formatter: [`gofmt` or `go fmt`](https://pkg.go.dev/cmd/gofmt)


# Java
1. Compiler: [javac](https://docs.oracle.com/en/java/javase/17/docs/specs/man/javac.html) (usually invoked indirectly thru gradle or IDE)
1. Static analysis: [PMD](https://pmd.github.io/)
1. Automated Tester: [Junit](https://junit.org/junit5/)
1. IDE: [Intellij](https://www.jetbrains.com/idea/)
  1. [Inspections](https://www.jetbrains.com/help/idea/list-of-java-inspections.html)
1. AI: [tabnine](https://www.tabnine.com/), [copilot](https://github.com/features/copilot)
1. Profiler: [VisualVM](https://visualvm.github.io/download.html), [yourkit](https://www.yourkit.com/), [jprofiler](https://www.ej-technologies.com/products/jprofiler/overview.html)
1. Auto-Formatter: [spotless] (https://github.com/diffplug/spotless)


# Typescript
1. Compiler: TODO
1. Static analysis: TODO
1. Automated Tester: TODO 
1. IDE: TODO
1. AI: [tabnine](https://www.tabnine.com/), [copilot](https://github.com/features/copilot)
1. Profiler: TODO
1. Auto-Formatter: [Prettier](https://prettier.io/)


# Python
1. Compiler: TODO
1. Static analysis: TODO
1. Automated Tester: TODO
1. IDE: TODO
1. AI: [tabnine](https://www.tabnine.com/), [copilot](https://github.com/features/copilot) 
1. Profiler: TODO
1. Auto-Formatter: TODO


# C++
1. Compiler: [clang](https://clang.llvm.org/), [gcc](https://gcc.gnu.org/)
  1. Enable all warnings, different compilers catch different bugs
1. Static analysis: [AddressSanitizer](https://github.com/google/sanitizers/wiki/AddressSanitizer), [ThreadSanitizer](https://github.com/google/sanitizers/wiki/ThreadSanitizerCppManual), [MemorySanitizer](https://github.com/google/sanitizers/wiki/MemorySanitizer), [UndefinedBehaviorSanitizer](https://clang.llvm.org/docs/UndefinedBehaviorSanitizer.html), [LeakSanitizer](https://clang.llvm.org/docs/LeakSanitizer.html) 
1. Automated Tester: [Google test](http://google.github.io/googletest/)
1. IDE: 
  1. [clion](https://www.jetbrains.com/clion/): [sanitizer support](https://www.jetbrains.com/help/clion/google-sanitizers.html), [inspections](https://www.jetbrains.com/help/clion/running-inspections.html), ...
1. AI: [tabnine](https://www.tabnine.com/), [copilot](https://github.com/features/copilot) 
1. Profiler: TODO
1. Auto-Formatter: TODO


# C
- TODO


# Kotlin
- TODO


# Swift
- TODO


# Dart
- TODO
