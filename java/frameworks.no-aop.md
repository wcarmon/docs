# Overview
- What is Aspect Oriented programming (AOP)
- 18 reasons we should avoid AOP


# Table of Contents
- [Definitions](#definitions)
- [Approaches](#approaches)
   * [Compile time weaving (static)](#compile-time-weaving--static-)
   * [Class-load time weaving (static)](#class-load-time-weaving--static-)
   * [Runtime weaving (Dynamic)](#runtime-weaving--dynamic-)
      + [Proxy based](#proxy-based)
- [Analogies](#analogies)
- [Disadvantages](#disadvantages)
   * [Item-01: Unforeseen side effects](#item-01--unforeseen-side-effects)
   * [Item-02: Comprehension overhead](#item-02--comprehension-overhead)
   * [Item-03: Security flaws](#item-03--security-flaws)
   * [Item-04: Code reviews more complex](#item-04--code-reviews-more-complex)
   * [Item-05: Harder to develop, IDE incompatibility](#item-05--harder-to-develop--ide-incompatibility)
   * [Item-06: Harder to test](#item-06--harder-to-test)
   * [Item-07: Weaving requires extra tooling](#item-07--weaving-requires-extra-tooling)
   * [Item-08: Runtime code bloat](#item-08--runtime-code-bloat)
   * [Item-09: Runtime aspects create increase latency](#item-09--runtime-aspects-create-increase-latency)
   * [Item-10: Fragile aspects create chaos/confusion](#item-10--fragile-aspects-create-chaos-confusion)
   * [Item-11: Incompatible with debuggers](#item-11--incompatible-with-debuggers)
   * [Item-12: Learning curve](#item-12--learning-curve)
   * [Item-13: Multi-aspect interaction issues](#item-13--multi-aspect-interaction-issues)
   * [Item-14: Incompatible with profilers](#item-14--incompatible-with-profilers)
   * [Item-15: Incompatible with Static analysis tools](#item-15--incompatible-with-static-analysis-tools)
   * [Item-16: Can create race conditions & deadlocks](#item-16--can-create-race-conditions---deadlocks)
   * [Item-17: Success usage requires rigorous discipline from all team members](#item-17--success-usage-requires-rigorous-discipline-from-all-team-members)
   * [Item-18: No modern books](#item-18--no-modern-books)
- [Alternatives](#alternatives)
   * [Refactor to design patterns](#refactor-to-design-patterns)
   * [Structural Search and replace (SSR)](#structural-search-and-replace--ssr-)
   * [Code generation](#code-generation)
   * [Request context propagation](#request-context-propagation)
- [More info](#more-info)


--------
# Definitions
- `Aspect`: Logical, cross-cutting concern
- `Advice`: code to execute
- `Join Point`: where `Advice` can execute (eg. method call, thrown exception, field modification, ...)
  - For Spring, [always a method execution](https://docs.spring.io/spring-framework/docs/current/reference/html/core.html#aop-introduction-defn)
- `Pointcut`: where to apply `Advice`, a predicate/pattern to match `Advice` with a `Join Point`
- `Weaving`: applying aspects to code (by mutating code or bytecode)


--------
# Approaches

## Compile time weaving (static)
1. Woven during compilation
1. **Requires a special compiler**
1. Compiler is slower (**EVERY** build is slower)
1. Compiler incompatible with Java compiler improvements over time
1. Compiler incompatible with [Kotlin](https://kotlinlang.org/) compiler
1. Incompatibilities with modern tools like [GraalVM](https://www.graalvm.org/)
1. Compiler requires more memory


## Class-load time weaving (static)
1. Woven during class loading (at runtime)
1. Slower runtime
1. **Requires special [ClassLoader](https://docs.oracle.com/en/java/javase/11/docs/api/java.base/java/lang/ClassLoader.html)**
1. Possible conflicts with other class loaders
1. Impact of aspects only known at runtime
    1. Increased complexity for reasoning about the code behavior from source


## Runtime weaving (Dynamic)
1. Woven during execution (at runtime, after class loading)
1. Impact of aspects only known at runtime

### Proxy based
- Spring uses this


--------
# Analogies
1. Adding AOP is like paying a loan off with a credit card
    1. If you are considering AOP, you have technical debt (eg. it's hard to add transactions or logging)
    1. AOP creates more debt (harder to reason about code, harder to maintain)
1. AOP is a glitter bomb in a white stirt factory (your code)
    1. If you own the factory, you don't want it there
    1. If you own the glitter bomp, you're not as concerned
    1. You'd rather contain & minimize the damage it can create
    1. It can ruin the day for people that are unaware of its presence
    1. You are forced to constantly think about it when making decisions
    1. The kinds of mistakes it creates are very expensive to fix
    1. Proper handling requires expertise and education for everyone involved



--------
# Disadvantages
## Item-01: Unforeseen side effects
1. Impact on 3rd party libraries
    1. Unpredictable behavior as you add/remove libraries
1. Refactoring leads to unpredictable behavior
    1. Method renames
    1. Package renames
1. Can create [infinite loops](https://www.google.com/search?q=infinite+loops+java&oq=infinite+loops+java&aqs=chrome..69i57j0j0i10i22i30j0i22i30l7.1366j0j7&sourceid=chrome&ie=UTF-8) (aspects that affect side effects of other aspects)
1. Can break [varargs](https://docs.oracle.com/javase/8/docs/technotes/guides/language/varargs.html) methods
1. Behavior depends on which aspects are on classpath


## Item-02: Comprehension overhead
1. EVERY aspect must be considered when writing EVERY method
    1. Code is MUCH harder to reason about
1. Cannot determine what code does by looking at it (obscured control flow)
    1. Breaks encapsulation


## Item-03: Security flaws
1. Attackers can rewrite & bypass your control flow
    1. Even worse for runtime weaving
1. Any behavior can change (or be bypassed) by a new aspect on classpath
1. Security Control flow & checks can be changed or bypassed by any aspect


## Item-04: Code reviews more complex
1. Harder to reason about correctness
1. Any behavior can change (or be bypassed)
1. Control flow can be changed by any aspect


## Item-05: Harder to develop, IDE incompatibility
1. If supported, IDEs generally require a plugin and much more memory to convey aspect info
1. At best, it's a performance drag (less productive developers)
1. EVERY aspect must be considered when writing EVERY method
    1. Code is MUCH harder to reason about


## Item-06: Harder to test
1. Requires more integration testing since unit tests can behave differently than at runtime
1. Aspects can create scenarios that only happen at runtime
    1. eg. stack overflow, Out of memory, edge cases ...
1. By definition, every method must be regression tested when ...
    1. an aspect changes
    1. a class/method is renamed
    1. a class/method is moved
    1. the arguments of a method are renamed
    1. the arguments of a method are reordered
    1. a subclass is added
    1. any class is added to any package


## Item-07: Weaving requires extra tooling
1. Compile-time weaving requires an extra Gradle/Maven plugin
   1. Which increases build times and memory usage
   1. Affects EVERY build
   1. Those plugins are frequently out of date
   1. These plugins can prevent you from using modern JVM, gradle/maven versions
   1. May or may not work with non-oracle JDKs
1. Runtime weaving requires special classloader or Proxies 
   1. increased memory footprint
   1. Possible conflicts with other classloaders


## Item-08: Runtime code bloat
1. Runtime bytecode can far exceed the size of the source
1. Runtime bytecode can spike from very small aspect changes


## Item-09: Runtime aspects create increase latency
1. Generally implemented with proxies (more memory)
1. Extra method invocations increase latency
1. Extra method invocations can lead to stack overflows
1. Runtime weaving takes time & memory at startup (Bad for cloud/container apps)
1. Can prevent inlining optimizations


## Item-10: Fragile aspects create chaos/confusion
1. Aspects based on method or package name break when you refactor
1. The cause for behavior change is not obvious to the person refactoring


## Item-11: Incompatible with debuggers
1. AOP will add extra methods (with obscure names) to the call stack
1. Control flow can jump unexpectedly based on runtime concerns (like variables in an aspect)


## Item-12: Learning curve
1. Obscure terminology (see above)
1. Requires deep understanding of control flow (and knowledge of where to look for influencers)


## Item-13: Multi-aspect interaction issues
1. Aspects can affect other aspects
1. Order of application matters
1. Further increases complexity


## Item-14: Incompatible with profilers
1. Instrumenting profilers (bytecode manipulation) can conflict with AOP (bytecode manipulation)
1. Creates unnecessary problems (making both the AOP and the profiler worse)


## Item-15: Incompatible with Static analysis tools
1. Static analysis tools assume standard control flow
1. AOP creates both false positives & false negatives


## Item-16: Can create race conditions & deadlocks
1. TODO: finish this section


## Item-17: Success usage requires rigorous discipline from all team members
1. One person's bad aspect can affect the whole team


## Item-18: No modern books
1. No books have been written on AOP in the last 5 years
   1. Compare to 2000-2009
1. This suggests the pattern is abandonware   
1. This makes it harder for new developers to familiarize with AOP
   1. perhaps this is good, since it decreases AOP adoption



--------
# Alternatives

## Refactor to design patterns
1. Most design patterns allow you to change one factor without changing another (separate concerns)
1. We should use design patterns anyway
1. Avoids all the disadvantages listed above


## Structural Search and replace (SSR)
1. Intellij lets you restructure your java/kotlin code in bulk ([SSR](https://www.jetbrains.com/help/idea/structural-search-and-replace.html))
1. Avoids all the disadvantages listed above   


## Code generation
1. Generate the code that would have been repeated
1. Maintenance is simpler than manually maintaining
1. Avoids all the disadvantages listed above


## Request context propagation
1. (Only when considering aspects for propagation)
1. For kotlin, replace with [CoroutineContext](https://kotlinlang.org/docs/coroutine-context-and-dispatchers.html)
1. Replace with manual propagation (see [SSR](#structural-search-and-replace-ssr) & [Code generation](#code-generation) above)
1. (For Java18+) Replace with [Project loom's](https://wiki.openjdk.java.net/display/loom/Main) "thread local"


--------
# More info
- [From Stack overflow](https://stackoverflow.com/questions/15447397/spring-aop-whats-the-difference-between-joinpoint-and-pointcut)
- [From Spring](https://docs.spring.io/spring-framework/docs/current/reference/html/core.html#aop)
- [From aspectj](https://www.eclipse.org/aspectj/)
