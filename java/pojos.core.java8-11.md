# Overview
1. How to build idiomatic POJOs on Java 8 thru 11
1. For [Lombok](https://projectlombok.org/) based POJOs, see [./pojos.lombok.java8-11.md](./pojos.lombok.java8-11.md)


# Before you start...
1. For Intellij, Install either [InnerBuilder plugin](https://plugins.jetbrains.com/plugin/7354-innerbuilder) or [InnerBuilder continued plugin](https://plugins.jetbrains.com/plugin/15818-innerbuilder-continued)
1. Both are equally sufficient although `InnerBuilder continued` has more features.
1. Restart after installing one plugin


# Big picture
1. We want Immutability.  [Why?](../general/immutability.md)
    1. No setters
    1. Immutable after construction
    1. Composition, not inheritance
1. We don't want to rely on argument positions (brittle/fragile coding anti-pattern)
1. We want compatibility with Jackson (JSON serialization & deserialization)
1. We want our POJOs to be compatible with java Collections (Map, Set, List, ...)
1. We want our POJOs to print helpful info when logged



TODO: hashcode & equals
TODO: toString