# Overview
- What is Aspect Oriented programming is (AOP)
- Why should I avoid AOP


# [Definitions](#definitions)
- `Aspect`: Logical, cross cutting concern
- `Advice`: code to execute
- `Join Point`: where advice can execute (method call, exception throw, field modification, ...)
  - For Spring, [always a method execution](https://docs.spring.io/spring-framework/docs/current/reference/html/core.html#aop-introduction-defn)
- `Pointcut`: where to apply `Advice`, a predicate/pattern to match advice with join points
- `Weaving`: applying aspects to code (by mutating code)


--------
# [Approaches](#approaches)

## Compile time weaving (static)
1. Woven during compilation
1. **Requires a special compiler**
1. Compiler is slower (**EVERY** build is slower)
1. Compiler incompatible with java compiler improvements over time
1. Compiler incompatible with [Kotlin](https://kotlinlang.org/) compiler
1. Incompatibilities with modern tools like [GraalVM](https://www.graalvm.org/)


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
# [Analogies](#Analogies)
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
# [Disadvantages](#disadvantages)
## [Item-01: Unforeseen side effects](#item-01-unforeseen-side-effectsitem-01)
1. Impact on 3rd party libraries
    1. Unpredictable behavior as you add/remove libraries
1. Refactoring leads to unpredictable behavior
    1. Method renames
    1. Package renames
1. Can create [infinite loops](https://www.google.com/search?q=infinite+loops+java&oq=infinite+loops+java&aqs=chrome..69i57j0j0i10i22i30j0i22i30l7.1366j0j7&sourceid=chrome&ie=UTF-8) (aspects that affect side effects of other aspects)
1. Can break [varargs](https://docs.oracle.com/javase/8/docs/technotes/guides/language/varargs.html) methods
1. Behavior depends on which aspects are on classpath


## [Item-02: Comprehension overhead](#item-02-comprehension-overheaditem-02)
1. EVERY aspect must be considered when writing EVERY method
    1. Code is MUCH harder to reason about
1. Cannot determine what code does by looking at it (obscured control flow)
    1. Breaks encapsulation


## [Item-03: Security flaws]
1. Attackers can rewrite & bypass your control flow
    1. Even worse for runtime weaving
1. Any behavior can change (or be bypassed) by a new aspect on classpath
1. Security Control flow & checks can be changed or bypassed by any aspect


## [Item-04: Code reviews more complex]
1. Harder to reason about correctness
1. Any behavior can change (or be bypassed)
1. Control flow can be changed by any aspect

## [Item-05: Harder to develop, IDE incompatibility]
1. If supported, IDEs generally require a plugin and much more memory to convey aspect info
1. At best, it's a performance drag (less productive developers)
1. EVERY aspect must be considered when writing EVERY method
    1. Code is MUCH harder to reason about


## [Item-06: Harder to test]
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


## [Item-07](#item-07)
1.

## [Item-04](#item-04)
...

## [Item-04](#item-04)
...


## [Item-04](#item-04)
...


## [Item-04](#item-04)
...


- no AOP books published in the last 8 years

--------
# Advantages
TODO


--------
# [Alternatives](#alternatives)


# More info
- [From Stack overflow](https://stackoverflow.com/questions/15447397/spring-aop-whats-the-difference-between-joinpoint-and-pointcut)
- [From Spring](https://docs.spring.io/spring-framework/docs/current/reference/html/core.html#aop)
- [From aspectj](https://www.eclipse.org/aspectj/)
