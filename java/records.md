# Overview
1. Info on Java [Records](https://docs.oracle.com/en/java/javase/14/language/records.html)
1. Java 17 and 21 (LTS) have mature records


# Features
1. Immutable (assuming fields are also immutable)
1. [Sealed Types](https://docs.oracle.com/en/java/javase/17/language/sealed-classes-and-interfaces.html) + Records are [algebraic types](https://en.wikipedia.org/wiki/Algebraic_data_type) (similar to rust)
    1. See [https://openjdk.org/jeps/409](https://openjdk.org/jeps/409)


# Similarities with Classes
1. Allows instance methods
1. Allows `static` fields
1. Allows `static` methods
1. Can implement interfaces
1. Instances live on [the heap](https://docs.oracle.com/cd/E13150_01/jrockit_jvm/jrockit/geninfo/diagnos/garbage_collect.html)
    1. Different from [valhalla's inline classes](https://cr.openjdk.org/~briangoetz/valhalla/sov/02-object-model.html)
1. Supports [Generics](https://docs.oracle.com/javase/tutorial/java/generics/index.html)
1. Supports Validation in constructor (to maintain invariants)
    1. Syntax is noticeably different
1. Pattern matching works in `instanceof` checks with a implicit casting
    1. Same for Records, classes, primitives, etc


# Differences from Classes
1. Implicitly `final` (classes are implicitly non-`final`)
1. Only has `public` instance members (and fields are implicitly `public`)
1. Compiler generates constructor, accessor methods, [`::equals`](https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/lang/Object.html#equals(java.lang.Object)), [`::hashCode`](https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/lang/Object.html#hashCode()), [`::toString`](https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/lang/Object.html#toString())
    1. accessor methods are like getters with out the `get` prefix
1. Has a [compact constructor](https://blogs.oracle.com/javamagazine/post/java-record-canonical-constructor)
1. All fields are defined in the ["Record header"](https://docs.oracle.com/en/java/javase/17/language/records.html#GUID-6699E26F-4A9B-4393-A08B-1E47D4B2D263)
1. Records work with [pattern matching](https://docs.oracle.com/en/java/javase/20/language/record-patterns.html#GUID-7623D3AD-4141-4914-A384-60C65BD0C010)
    1. See [https://openjdk.org/jeps/427](https://openjdk.org/jeps/427)
    1. [destructuring](https://basarat.gitbook.io/typescript/future-javascript/destructuring) works ...
        1. with `instanceof` checks
        1. in `switch` cases
        1. in [`for` loops](https://openjdk.org/jeps/432) (Java 20)


# [Jackson](https://github.com/FasterXML/jackson) ([databind](https://github.com/FasterXML/jackson-databind)) integration
1. Version [2.12+](https://github.com/FasterXML/jackson/wiki/Jackson-Release-2.12#databind) of [databind](https://github.com/FasterXML/jackson-databind) support Records
1. Version [2.15+](https://github.com/FasterXML/jackson/wiki/Jackson-Release-2.15#changes-core) support records with [`@JsonCreator`](https://javadoc.io/doc/com.fasterxml.jackson.core/jackson-annotations/2.15.3/com/fasterxml/jackson/annotation/JsonCreator.html)


# Builder
1. TODO


# [Lombok](https://projectlombok.org/) integration
1. Use [1.18.30+](https://projectlombok.org/changelog) for mature records support
    1. v1.18.20 had basic/initial support
1. See [`@Builder`](https://projectlombok.org/features/Builder)


# Other resources
1. [JEP 359](https://openjdk.org/jeps/359) (Java 14)
1. [JEP 384](https://openjdk.org/jeps/384) (Java 15)
1. [JEP 395](https://openjdk.org/jeps/395) (Java 16)
1. [JEP 409](https://openjdk.org/jeps/409) (Java 17)
1. Records: [JEP 405](https://openjdk.org/jeps/405) (Java 19)
1. Pattern Matching: [JEP 427](https://openjdk.org/jeps/427) (Java 19)
1. Pattern Matching: [JEP 433](https://openjdk.org/jeps/433) (Java 20)
1. https://openjdk.org/projects/amber/design-notes/records-and-sealed-classes
