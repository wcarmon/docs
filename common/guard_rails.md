# Overview
1. Best tools for a mature development environment
1. Every [popular language](https://www.tiobe.com/tiobe-index/) has tools (Guard rails) to simplify writing mature code 
1. Guard rails, (when followed), prevent Developers from making common mistakes
1. Guard rails can teach Developers to follow language specific idioms


# Most important Guard rails
1. [Compiler](https://www.techtarget.com/whatis/definition/compiler#:~:text=A%20compiler%20is%20a%20special,as%20Java%20or%20C%2B%2B.), [another explainer](https://dev.to/arikaturika/code-compiling-explain-like-im-five-4mkj)
1. Static analysis (Lint)
1. Auto-Tester
  1. Unit test, E2E test
1. IDE
  1. Inspections, Auto-completion, Navigation 
1. AI coding helper (eg. [Tabnine](https://www.tabnine.com) & [Copilot](https://github.com/features/copilot))
1. Profiler (CPU, Memory, etc)
1. Auto-Formatter
1. Other humans (Code reviewers)


# [Rust](https://www.rust-lang.org/)
|Category|Best Tools|
|---:|:---|
|Compiler|[rustc](https://doc.rust-lang.org/rustc/what-is-rustc.html) (usually invoked via `cargo build` or thru IDE)|
|Static analysis|[clippy](https://github.com/rust-lang/rust-clippy)|
|Automated Tester|[`cargo test`](https://doc.rust-lang.org/cargo/commands/cargo-test.html)|
|IDE|Most Jetbrains tools like [Goland, CLion or Intellij](https://www.jetbrains.com/rust/)|
|AI|[tabnine](https://www.tabnine.com/), [copilot](https://github.com/features/copilot)|
|Profiler|TODO|
|Auto-Formatter|[rustfmt](https://github.com/rust-lang/rustfmt) (usually invoked via `cargo fmt`)|


# [Go](https://go.dev/)
1. Compiler: [`go build`](https://go.dev/doc/tutorial/compile-install)
1. Static analysis: TODO
1. Automated Tester: [`go test`](https://go.dev/doc/tutorial/add-a-test)
1. IDE: [Goland](https://www.jetbrains.com/go/) or [vsc](https://code.visualstudio.com/)
1. AI: [tabnine](https://www.tabnine.com/), [copilot](https://github.com/features/copilot)
1. Profiler: [Goland CPU Profiler](https://www.jetbrains.com/help/go/cpu-profiler.html), [Goland Memory profiler](https://www.jetbrains.com/help/go/memory-profiler.html), [Goland Mutex profiler](https://www.jetbrains.com/help/go/mutex-profiler.html#InterpretingTheResults)
1. Auto-Formatter: [`gofmt` or `go fmt`](https://pkg.go.dev/cmd/gofmt)


# [Java](https://www.oracle.com/java/technologies/downloads/)
1. Compiler: [javac](https://docs.oracle.com/en/java/javase/17/docs/specs/man/javac.html) (usually invoked thru [gradle](https://gradle.org/) or [IDE](https://www.jetbrains.com/idea/))
1. Static analysis: [PMD](https://pmd.github.io/)
1. Automated Tester: [Junit](https://junit.org/junit5/)
1. IDE: [Intellij](https://www.jetbrains.com/idea/)
  1. [Inspections](https://www.jetbrains.com/help/idea/list-of-java-inspections.html)
1. AI: [tabnine](https://www.tabnine.com/), [copilot](https://github.com/features/copilot)
1. Profiler: [VisualVM](https://visualvm.github.io/download.html), [yourkit](https://www.yourkit.com/), [jprofiler](https://www.ej-technologies.com/products/jprofiler/overview.html)
1. Auto-Formatter: [spotless] (https://github.com/diffplug/spotless)


# [Typescript](https://www.typescriptlang.org/)
1. Compiler (Transpiler): TODO
1. Static analysis: TODO
1. Automated Tester: TODO 
1. IDE: TODO
1. AI: [tabnine](https://www.tabnine.com/), [copilot](https://github.com/features/copilot)
1. Profiler: TODO
1. Auto-Formatter: [Prettier](https://prettier.io/)


# [Python](https://www.python.org/)
1. Compiler: TODO
1. Static analysis: TODO
1. Automated Tester: TODO
1. IDE: TODO
1. AI: [tabnine](https://www.tabnine.com/), [copilot](https://github.com/features/copilot) 
1. Profiler: TODO
1. Auto-Formatter: [Black](https://github.com/psf/black)


# [C++](https://en.wikipedia.org/wiki/C%2B%2B)
1. Compiler: [clang](https://clang.llvm.org/), [gcc](https://gcc.gnu.org/)
  1. Enable all warnings, different compilers catch different bugs
1. Static analysis: [AddressSanitizer](https://github.com/google/sanitizers/wiki/AddressSanitizer), [ThreadSanitizer](https://github.com/google/sanitizers/wiki/ThreadSanitizerCppManual), [MemorySanitizer](https://github.com/google/sanitizers/wiki/MemorySanitizer), [UndefinedBehaviorSanitizer](https://clang.llvm.org/docs/UndefinedBehaviorSanitizer.html), [LeakSanitizer](https://clang.llvm.org/docs/LeakSanitizer.html) 
1. Automated Tester: [Google test](http://google.github.io/googletest/)
1. IDE: 
  1. [clion](https://www.jetbrains.com/clion/): [sanitizer support](https://www.jetbrains.com/help/clion/google-sanitizers.html), [inspections](https://www.jetbrains.com/help/clion/running-inspections.html), ...
1. AI: [tabnine](https://www.tabnine.com/), [copilot](https://github.com/features/copilot) 
1. Profiler: TODO
1. Auto-Formatter: TODO


# [C](https://en.wikipedia.org/wiki/C_(programming_language))
1. Compiler: TODO
1. Static analysis: TODO
1. Automated Tester: TODO
1. IDE: TODO
1. AI: [tabnine](https://www.tabnine.com/), [copilot](https://github.com/features/copilot) 
1. Profiler: TODO
1. Auto-Formatter: TODO


# [Kotlin](https://kotlinlang.org/)
1. Compiler: TODO
1. Static analysis: TODO
1. Automated Tester: TODO
1. IDE: TODO
1. AI: [tabnine](https://www.tabnine.com/), [copilot](https://github.com/features/copilot) 
1. Profiler: TODO
1. Auto-Formatter: TODO


# [Swift](https://developer.apple.com/swift/)
1. Compiler: TODO
1. Static analysis: TODO
1. Automated Tester: TODO
1. IDE: TODO
1. AI: [tabnine](https://www.tabnine.com/), [copilot](https://github.com/features/copilot) 
1. Profiler: TODO
1. Auto-Formatter: TODO


# [Dart](https://dart.dev/)
1. Compiler: TODO
1. Static analysis: TODO
1. Automated Tester: TODO
1. IDE: TODO
1. AI: [tabnine](https://www.tabnine.com/), [copilot](https://github.com/features/copilot) 
1. Profiler: TODO
1. Auto-Formatter: TODO
