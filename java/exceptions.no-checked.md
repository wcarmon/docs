# Overview
- Why I should avoid [Checked Exceptions](https://docs.oracle.com/javase/tutorial/essential/exceptions/runtime.html)

# Language facts
## Item-01: Languages created **before** Java never adopted Checked Exceptions
- These older languages adopted other features, but not Checked Exceptions

### No Checked Exceptions in these:
- C
- C++
- Python
- Visual Basic
- Perl
- Assembly language

## Item-02: Languages created **after** Java rejected Checked Exceptions
- These languages learned from this mistake

### No Checked Exceptions in these:
- C# *(microsoft)*
- Objective-C *(Apple)*
- Swift *(Apple)*
- Golang *(Google)*
- Kotlin *(Jetbrains & Google)*
- Javascript *(Mozilla)*
- Typescript *(microsoft)*
- Rust *(Mozilla)*
- VB.net *(microsoft)*
- PHP
- Ruby
- Groovy
- F# *(microsoft)*
- Dart *(Google)*

## Item-03: All other **JVM** languages rejected Checked Exceptions
### Kotlin
- The most popular non-java jvm language, backed by Google & Jetbrains
- The preferred language for Android development

### Scala
- The most popular functional language on jvm

### Groovy
- The most popular jvm scripting language

### Clojure
- Another popular functional language for jvm


## Item-04: Java is the **only** language on the [TIOBE Index](https://www.tiobe.com/tiobe-index/) plagued with Checked Exceptions
- exactly 1 out of the most used 20 programming languages has Checked Exceptions 
- For backward compatibility, they cannot be removed from Java
- Other JVM languages are free to avoid Checked Exceptions


--------
# Trending backwards
## Item-05: Checked Exceptions are incompatible with Java 8+ functional interfaces
- Checked Exceptions are incompatible with modern Java
- Incompatible interfaces include:
    - [Supplier](https://docs.oracle.com/javase/8/docs/api/java/util/function/Supplier.html)
        - Which replaces Legacy [Callable](https://docs.oracle.com/en/java/javase/11/docs/api/java.base/java/util/concurrent/Callable.html)
    - [Runnable](https://docs.oracle.com/en/java/javase/11/docs/api/java.base/java/lang/Runnable.html)
    - [Consumer](https://docs.oracle.com/en/java/javase/11/docs/api/java.base/java/util/function/Consumer.html)
    - [Function](https://docs.oracle.com/en/java/javase/11/docs/api/java.base/java/util/function/Function.html)
    - [UnaryOperator](https://docs.oracle.com/en/java/javase/11/docs/api/java.base/java/util/function/UnaryOperator.html)
    - [Predicate](https://docs.oracle.com/en/java/javase/11/docs/api/java.base/java/util/function/Predicate.html)


## Item-06: Checked Exceptions are incompatible with Java 8+ Streams
- [Typical ugly workarounds](https://www.oreilly.com/content/handling-checked-exceptions-in-java-streams/)


## Item-07: Checked Exceptions are incompatible with Reactive programming
- Including (but not limited to)
    - [Reactor](https://projectreactor.io/)
        - Backed by Spring
        - See their [recommended workaround](https://projectreactor.io/docs/core/release/reference/#_handling_exceptions_in_operators_or_functions)
    - [RxJava](https://github.com/ReactiveX/RxJava)
    - [Akka Reactive Streams](https://doc.akka.io/docs/akka/current/)


--------
# Dependencies
## Item-08: Exception Propagation creates dependencies across contexts
1. Only a problem for Checked Exceptions (since they must be imported)
1. Requires an import (compile time reference)
1. Typically, you'll be forced to add a <dependency> so your method signatures will compile


--------
# Contracts/Interfaces
## Item-09: Checked Exceptions leak implementation details
1. Encapsulation failure
1. Consider a CRUD abstraction over your data layer, throwing [SQLException](https://docs.oracle.com/en/java/javase/11/docs/api/java.sql/java/sql/SQLException.html)
    1. What if you're swapping out a nosql store or a cache
    1. What if clients drive their logic based on thrown SQLException?
    

## Item-10: Checked Exceptions become part of your API, forever
1. Once you adopt checked exceptions, you're stuck with them
    1. Removing them can break client code that catches the checked exception
1. As a library author, inability to make (safe) changes is undesirable


## Item-11: Checked Exceptions make your library harder to use
1. Engineers may opt for alternatives or fork & fix your lib


--------
# Inconsistencies

## Item-12: Even Sun/Oracle wrap some checked exceptions in RuntimeExceptions
1. See java.net.URI::[create](https://docs.oracle.com/en/java/javase/11/docs/api/java.base/java/net/URI.html#create(java.lang.String))


## Item-13: Sun was inconsistent with usage of checked exceptions
1. See [their policy/guidance](https://docs.oracle.com/javase/tutorial/essential/exceptions/runtime.html)
   1. See Violation for [URISyntaxException](https://docs.oracle.com/en/java/javase/11/docs/api/java.base/java/net/URISyntaxException.html) 
   1. See Violation for [CloneNotSupportedException](https://docs.oracle.com/en/java/javase/11/docs/api/java.base/java/lang/CloneNotSupportedException.html) 
   1. See Violation for [NumberFormatException](https://docs.oracle.com/en/java/javase/11/docs/api/java.base/java/lang/NumberFormatException.html) 
1. See [Closeable](https://docs.oracle.com/en/java/javase/11/docs/api/java.base/java/io/Closeable.html#close()) vs [AutoCloseable](https://docs.oracle.com/en/java/javase/11/docs/api/java.base/java/lang/AutoCloseable.html#close())


## Item-14: Checked Exceptions force you to acknowledge some Exceptions and not others
1. Try-catch blocks are biased toward only catching Checked Exceptions
    1. And ignoring possibly more important RuntimeExceptions
    

--------
# Modern libraries


--------
# Tools


--------
# Code bloat

--------
# More info
- https://phauer.com/2015/checked-exceptions-are-evil/
- [More debate on stack overflow](https://stackoverflow.com/questions/613954/the-case-against-checked-exceptions)
