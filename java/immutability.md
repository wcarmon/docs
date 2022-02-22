# Overview
1. How to achieve Immutability on the JVM
1. For a general overview of why Immutability is important, see [here](../general/immutability.md)


# POJO Checklist
1. Mark classes `final`
    1. Composition over Inheritance: [why?](https://en.wikipedia.org/wiki/Composition_over_inheritance), [why?](https://stackoverflow.com/questions/49002/prefer-composition-over-inheritance), [why?](https://medium.com/geekculture/composition-over-inheritance-7faed1628595)
1. Mark all properties `private final`
1. No Setters, just Getters
1. Use [Builder pattern](https://refactoring.guru/design-patterns/builder) (POJOs)
    1. For non-POJOs, Use [Constructor injection](./dependency-injection.md)
1. Use modern java APIs, like java.time
    1. Modern core API are immutable
1. Prefer primitive properties (when sensible)
1. Rely on jvm defaults for properties (when sensible)


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
