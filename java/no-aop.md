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
1. Compiler is slower (EVERY build is slower)
1. Compiler incompatible with java compiler improvements over time
1. Compiler incompatible with [Kotlin](https://kotlinlang.org/) compiler
1. Incompatibilities with modern tools like [GraalVM](https://www.graalvm.org/)


## Class-load time weaving (static)
1. Woven during class loading
1. Slower runtime
1. **Requires special [ClassLoader](https://docs.oracle.com/en/java/javase/11/docs/api/java.base/java/lang/ClassLoader.html)**
1. Possible conflicts with other class loaders
1. Impact of aspects only known at runtime
  1. Increased complexity for reasoning about the code behavior from source


## Runtime weaving (Dynamic)
1. Woven during execution
1. Impact of aspects only known at runtime

### Proxy based
- Spring uses this

### Runtime weaving


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
##[Item-01](#item-01)
##[Item-02](#item-02)
##[Item-03](#item-03)
##[Item-04](#item-04)


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
