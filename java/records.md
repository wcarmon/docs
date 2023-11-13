# Overview
1. Info on Java [Records](https://docs.oracle.com/en/java/javase/14/language/records.html)
1. Java 17 and 21 (LTS) have mature records


# Features
1. Immutable (assuming fields are also immutable)
1. [Sealed Types](https://docs.oracle.com/en/java/javase/17/language/sealed-classes-and-interfaces.html) + Records are [algebraic types](https://en.wikipedia.org/wiki/Algebraic_data_type) (similar to rust)


# Similarities with Classes
1. Allows instance methods
1. Allows static fields
1. Allows static methods
1. Can implement interfaces
1. Instances live on [the heap](https://docs.oracle.com/cd/E13150_01/jrockit_jvm/jrockit/geninfo/diagnos/garbage_collect.html)
    1. Not the same as [valhalla's inline classes](https://cr.openjdk.org/~briangoetz/valhalla/sov/02-object-model.html)
1. Supports generics


# Differences from Classes
1. Implicitly `final` (classes are implicitly non-final)
1. Only has `public` instance members (and fields are implicitly public)
1. Compiler generates ctor, accessor methods, `::equals`, `::hashcode`, `::toString`
    1. accessor methods are like getters with out the `get` prefix
1. Has a compact constructor
1. All fields are defined in the "Record header"
1. Records work with [pattern matching](https://docs.oracle.com/en/java/javase/20/language/record-patterns.html#GUID-7623D3AD-4141-4914-A384-60C65BD0C010)


# Other resources
1. [JEP 359](https://openjdk.org/jeps/359) (Java 14)
1. [JEP 384](https://openjdk.org/jeps/384) (Java 15)
1. [JEP 395](https://openjdk.org/jeps/395) (Java 16)
1. [JEP 405](https://openjdk.org/jeps/405) (Java 19)
1. https://openjdk.org/projects/amber/design-notes/records-and-sealed-classes
