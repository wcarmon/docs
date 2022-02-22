# Overview
1. How to build idiomatic POJOs on Java 8 thru 11
1. For [Lombok](https://projectlombok.org/) based POJOs, see [./pojos.lombok.java8-11.md](./pojos.lombok.java8-11.md)
1. See also [JVM Immutability](jvm-immutability.md)


# Before you start...
1. For Intellij, Install either [InnerBuilder plugin](https://plugins.jetbrains.com/plugin/7354-innerbuilder) or [InnerBuilder continued plugin](https://plugins.jetbrains.com/plugin/15818-innerbuilder-continued)
1. Both are equally sufficient although [`InnerBuilder continued`](https://plugins.jetbrains.com/plugin/15818-innerbuilder-continued) has more features.
1. Restart after [installing one plugin](https://www.jetbrains.com/help/idea/managing-plugins.html)


# Big picture
1. We want Immutability.  [Why?](../general/immutability.md)
    1. No setters
    1. Immutable after construction
    1. Composition, not inheritance (`final` classes)
    1. `final` properties
1. We don't want to rely on argument positions (brittle/fragile coding anti-pattern)
1. We want compatibility with [Jackson](https://github.com/FasterXML/jackson) (JSON serialization & deserialization)
1. We want our POJOs to be compatible with java Collections ([Map](https://docs.oracle.com/en/java/javase/11/docs/api/java.base/java/util/Map.html), [Set](https://docs.oracle.com/en/java/javase/11/docs/api/java.base/java/util/Set.html), [List](https://docs.oracle.com/en/java/javase/11/docs/api/java.base/java/util/List.html), ...)
1. We want our POJOs to print helpful info when logged


# POJO Checklist
1. Mark classes `final`
    1. Composition over Inheritance: [why?](https://en.wikipedia.org/wiki/Composition_over_inheritance), [why?](https://stackoverflow.com/questions/49002/prefer-composition-over-inheritance), [why?](https://medium.com/geekculture/composition-over-inheritance-7faed1628595)
1. Mark all properties `private final`
1. No Setters, just Getters
1. Use [Builder pattern](https://refactoring.guru/design-patterns/builder) (POJOs)
    1. For non-POJOs, Use [Constructor injection](./dependency-injection.md)
    1. `private` constructor
    1. copy constructor for making more instances
1. Use modern java APIs, like [java.time](https://docs.oracle.com/javase/8/docs/api/java/time/package-summary.html)
    1. Modern core APIs are immutable
1. Prefer [primitive](https://docs.oracle.com/javase/tutorial/java/nutsandbolts/datatypes.html) properties (when sensible)
1. Rely on [jvm defaults](https://docs.oracle.com/javase/tutorial/java/nutsandbolts/datatypes.html) for properties (when sensible)
1. Generate `hashcode()` & `equals(...)`
    1. [Why?](https://www.baeldung.com/java-equals-hashcode-contracts)
    1. [Why?](https://www.geeksforgeeks.org/equals-hashcode-methods-java/)
    1. [Why?](https://howtodoinjava.com/java/basics/java-hashcode-equals-methods/)
    1. [How? via Intellij](https://www.jetbrains.com/help/idea/generate-equals-and-hashcode-wizard.html)
    1. [How? via apache commons](https://commons.apache.org/proper/commons-lang/apidocs/org/apache/commons/lang3/builder/EqualsBuilder.html)
1. Generate [`toString()`](https://docs.oracle.com/javase/8/docs/api/java/lang/Object.html#toString--)



TODO: hashcode & equals
TODO: toString