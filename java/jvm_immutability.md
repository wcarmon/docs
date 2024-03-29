# Overview

1. How to achieve Immutability on the JVM
1. For a general overview of why Immutability is important, [see here](../common/immutability.md)

# Immutable POJO Checklist

## Java

1. See How to build [Core Java based POJOs](./pojos.core.java8_17.md)
1. See How to build [Lombok based POJOs](./pojos.lombok.java8_17.md)

## [Kotlin](https://kotlinlang.org/)

1. Use [`data class`](https://kotlinlang.org/docs/data-classes.html) with [`val`](https://kotlinlang.org/docs/basic-syntax.html#variables)

# Non-POJO Checklist (Services, Helpers, Components, DAOs, ...)

1. Use [Constructor injection](./dependency_injection.md)
1. Mark **all** class `final`
    1. Composition over Inheritance: [why?](https://en.wikipedia.org/wiki/Composition_over_inheritance), [why?](https://stackoverflow.com/questions/49002/prefer-composition-over-inheritance), [why?](https://medium.com/geekculture/composition-over-inheritance-7faed1628595)
    1. **EXCEPTION**: Spring [`@Configuration`](https://docs.spring.io/spring-framework/docs/current/javadoc-api/org/springframework/context/annotation/Configuration.html) classes cannot be final
1. Mark **all** properties `private`
    1. Minimize exposure
    1. Use Getters to expose state
    1. Use immutable collections or defensive copies when exposing collections
1. Mark **all** properties `final`
    1. **EXCEPTION**: `private`, internal-only state can be non-final
1. Do validation (preconditions) in constructor
    1. See [preconditions doc](./preconditions.md)

# Utility class Checklist

1. See [idioms](./classes.utility.md)

# More resources

1. https://docs.oracle.com/javase/tutorial/essential/concurrency/imstrat.html
1. https://medium.com/@rufuszh90/effective-java-item-15-minimise-mutability-2526108ac7f1
1. https://docs.oracle.com/javase/tutorial/essential/concurrency/immutable.html
1. http://www.javapractices.com/topic/TopicAction.do?Id=29
1. https://debugged.it/blog/why-immutability-matters/
1. https://dev.to/kylec32/effective-java-tuesday-minimize-mutability-55db
1. https://www.baeldung.com/java-immutable-object
1. https://www.ctl.io/developers/blog/post/immutability
1. https://www.javatpoint.com/mutable-and-immutable-in-java
1. https://www.leadingagile.com/2018/03/immutable-in-java/
1. https://www.tiny.cloud/blog/mutable-vs-immutable-javascript/
