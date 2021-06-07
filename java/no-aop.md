# Overview

# [Definitions](#definitions)
- `Aspect`: Logical, cross cutting concern
- `Advice`: code to execute
- `Join Point`: where advice can execute (method call, exception throw, field modification, ...)
  - For Spring, [always a method execution](https://docs.spring.io/spring-framework/docs/current/reference/html/core.html#aop-introduction-defn)
- `Pointcut`: where to apply `Advice`, a predicate/pattern to match advice with join points
- `Weaving`: applying aspects to code (by mutating code)


--------
# [Approaches](#approaches)

## Compile time (static)
- Woven during compilation
- **Requires a special compiler**
- Compiler is slower (EVERY build is slower)
- Compiler incompatible with java compiler improvements over time
- Compiler incompatible with [Kotlin](https://kotlinlang.org/) compiler
- Incompatibilities with modern tools like [GraalVM](https://www.graalvm.org/)


## Classload time (static)

## Runtime (Dynamic)

### Proxy based
- Spring

### Runtime weaving


--------
# [Analogies](#Analogies)

--------
# Advantages

--------
# [Disadvantages](#disadvantages)

--------
# [Alternatives](#alternatives)


# More info
- [From Stack overflow](https://stackoverflow.com/questions/15447397/spring-aop-whats-the-difference-between-joinpoint-and-pointcut)
- [From Spring](https://docs.spring.io/spring-framework/docs/current/reference/html/core.html#aop)
- [From aspectj](https://www.eclipse.org/aspectj/)
