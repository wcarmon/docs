# Overview
1. Best tools for a mature development environment
1. Every [popular language](https://www.tiobe.com/tiobe-index/) has tools (Guard rails) to simplify writing mature code 
1. Guard rails, (when followed), prevent Developers from making common mistakes
1. Guard rails can teach Developers to follow language specific idioms


# Most important Guard rails
1. [Compiler](https://www.techtarget.com/whatis/definition/compiler#:~:text=A%20compiler%20is%20a%20special,as%20Java%20or%20C%2B%2B.), [another explainer](https://dev.to/arikaturika/code-compiling-explain-like-im-five-4mkj)
1. Static Analyzer (Lint)
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
|Compiler|[`rustc`](https://doc.rust-lang.org/rustc/what-is-rustc.html) (usually invoked via `cargo build` or thru IDE)|
|Static Analyzer|[Clippy](https://github.com/rust-lang/rust-clippy)|
|Automated Tester|[`cargo test`](https://doc.rust-lang.org/cargo/commands/cargo-test.html)|
|IDE|Most Jetbrains tools like [Goland, CLion or Intellij](https://www.jetbrains.com/rust/)|
|AI|[Tabnine](https://www.tabnine.com/), [Copilot](https://github.com/features/copilot)|
|Profiler|[TODO](https://nnethercote.github.io/perf-book/profiling.html)|
|Auto-Formatter|[`rustfmt`](https://github.com/rust-lang/rustfmt) (usually invoked via `cargo fmt`)|


# [Go](https://go.dev/)
|Category|Best Tools|
|---:|:---|
|Compiler|[`go build`](https://go.dev/doc/tutorial/compile-install)|
|Static Analyzer|[golangci-lint](https://github.com/golangci/golangci-lint)|
|Automated Tester|[`go test`](https://go.dev/doc/tutorial/add-a-test)|
|IDE|[Goland](https://www.jetbrains.com/go/) or [vsc](https://code.visualstudio.com/)|
|AI|[Tabnine](https://www.tabnine.com/), [Copilot](https://github.com/features/copilot)|
|Profiler|[Goland CPU Profiler](https://www.jetbrains.com/help/go/cpu-profiler.html), [Goland Memory profiler](https://www.jetbrains.com/help/go/memory-profiler.html), [Goland Mutex profiler](https://www.jetbrains.com/help/go/mutex-profiler.html#InterpretingTheResults)|
|Auto-Formatter|[`gofmt` or `go fmt`](https://pkg.go.dev/cmd/gofmt)|


# [Java](https://www.oracle.com/java/technologies/downloads/)
|Category|Best Tools|
|---:|:---|
|Compiler|[`javac`](https://docs.oracle.com/en/java/javase/17/docs/specs/man/javac.html) (usually invoked thru [gradle](https://gradle.org/) or [IDE](https://www.jetbrains.com/idea/))|
|Static Analyzer|[PMD](https://pmd.github.io/), [sonarqube](https://www.sonarqube.org/)|
|Automated Tester|[JUnit](https://junit.org/junit5/)|
|IDE|[Intellij](https://www.jetbrains.com/idea/), [Inspections](https://www.jetbrains.com/help/idea/list-of-java-inspections.html)|
|AI|[Tabnine](https://www.tabnine.com/), [Copilot](https://github.com/features/copilot)|
|Profiler|[VisualVM](https://visualvm.github.io/download.html), [Yourkit](https://www.yourkit.com/), [JProfiler](https://www.ej-technologies.com/products/jprofiler/overview.html)|
|Auto-Formatter|[Spotless](https://github.com/diffplug/spotless)|


# [Typescript](https://www.typescriptlang.org/)
|Category|Best Tools|
|---:|:---|
|Compiler (Transpiler)|[`tsc`](https://www.typescriptlang.org/docs/handbook/compiler-options.html)|
|Static Analyzer|[ESlint](https://eslint.org/), [standard](https://github.com/standard/standard#install)|
|Automated Tester|TODO (mocha, jasmine, karma, chai, ...)| 
|IDE|TODO, [WebStorm](https://www.jetbrains.com/help/webstorm/typescript-support.html)|
|AI|[Tabnine](https://www.tabnine.com/), [Copilot](https://github.com/features/copilot)|
|Profiler|TODO|
|Auto-Formatter|[Prettier](https://prettier.io/)|


# [Python](https://www.python.org/)
|Category|Best Tools|
|---:|:---|
|Compiler|TODO|
|Static Analyzer|[Pylint](https://pylint.org/), [Mypy](http://mypy-lang.org/), [flake8](https://flake8.pycqa.org/en/latest/) (wraps pyflakes and others), [bandit](https://bandit.readthedocs.io/en/latest/), |
|Automated Tester|[PyTest](https://docs.pytest.org/en/7.2.x/)|
|IDE|[PyCharm](https://www.jetbrains.com/pycharm/)|
|AI|[Tabnine](https://www.tabnine.com/), [Copilot](https://github.com/features/copilot)| 
|Profiler|TODO|
|Auto-Formatter|[Black](https://github.com/psf/black)|


# [C++](https://en.wikipedia.org/wiki/C%2B%2B)
|Category|Best Tools|
|---:|:---|
|Compiler|[clang](https://clang.llvm.org/), [gcc](https://gcc.gnu.org/).  Enable all warnings since different compilers catch different bugs|
|Static Analyzer|[AddressSanitizer](https://github.com/google/sanitizers/wiki/AddressSanitizer), [ThreadSanitizer](https://github.com/google/sanitizers/wiki/ThreadSanitizerCppManual), [MemorySanitizer](https://github.com/google/sanitizers/wiki/MemorySanitizer), [UndefinedBehaviorSanitizer](https://clang.llvm.org/docs/UndefinedBehaviorSanitizer.html), [LeakSanitizer](https://clang.llvm.org/docs/LeakSanitizer.html)| 
|Automated Tester|[Google test](http://google.github.io/googletest/)|
|IDE|[clion](https://www.jetbrains.com/clion/): [sanitizer support](https://www.jetbrains.com/help/clion/google-sanitizers.html), [inspections](https://www.jetbrains.com/help/clion/running-inspections.html), ...|
|AI|[Tabnine](https://www.tabnine.com/), [Copilot](https://github.com/features/copilot) 
|Profiler|[Google orbit](https://github.com/google/orbit), [Valgrind tools](https://valgrind.org/info/tools.html) |
|Auto-Formatter|[ClangFormat](https://clang.llvm.org/docs/ClangFormat.html), [astyle](https://astyle.sourceforge.net/)|


# [C](https://en.wikipedia.org/wiki/C_(programming_language))
|Category|Best Tools|
|---:|:---|
|Compiler|TODO|
|Static Analyzer|TODO|
|Automated Tester|TODO|
|IDE|TODO|
|AI|[Tabnine](https://www.tabnine.com/), [Copilot](https://github.com/features/copilot)| 
|Profiler|TODO|
|Auto-Formatter|TODO|


# [Kotlin](https://kotlinlang.org/)
|Category|Best Tools|
|---:|:---|
|Compiler|[kotlinc](https://kotlinlang.org/docs/command-line.html) (usually invoked thru [gradle](https://gradle.org/) or [IDE](https://www.jetbrains.com/idea/))|
|Static Analyzer|[Detekt](https://github.com/detekt/detekt), [ktlint](https://pinterest.github.io/ktlint/)|
|Automated Tester|(same as Java)|
|IDE|(same as Java)|
|AI|[Tabnine](https://www.tabnine.com/), [Copilot](https://github.com/features/copilot)| 
|Profiler|(same as Java)|
|Auto-Formatter|TODO [ktlint](https://pinterest.github.io/ktlint/)|


# [Swift](https://developer.apple.com/swift/)
|Category|Best Tools|
|---:|:---|
|Compiler|TODO|
|Static Analyzer|TODO|
|Automated Tester|TODO|
|IDE|TODO|
|AI|[Tabnine](https://www.tabnine.com/), [Copilot](https://github.com/features/copilot)| 
|Profiler|TODO|
|Auto-Formatter|TODO|


# [Dart](https://dart.dev/)
|Category|Best Tools|
|---:|:---|
|Compiler|TODO|
|Static Analyzer|TODO|
|Automated Tester|TODO|
|IDE|TODO|
|AI|[Tabnine](https://www.tabnine.com/), [Copilot](https://github.com/features/copilot)| 
|Profiler|TODO|
|Auto-Formatter|TODO|
