# Overview
- 20 Reasons we should avoid [Checked Exceptions](https://docs.oracle.com/javase/tutorial/essential/exceptions/runtime.html)

# Language facts
## Item-01: Languages created **before** Java never adopted Checked Exceptions
- These older languages adopted other features, but not Checked Exceptions

### No Checked Exceptions in these popular languages:
- [C](https://www.iso.org/standard/74528.html)
- [C++](https://www.cplusplus.com/)
- [Python](https://www.python.org/)
- [Visual Basic](https://docs.microsoft.com/en-us/office/vba/language/reference/user-interface-help/visual-basic-language-reference)
- [Perl](https://www.perl.org/)
- [Assembly language]()

## Item-02: Languages created **after** Java rejected Checked Exceptions
- These languages learned from the Checked Exception mistake

### No Checked Exceptions in these popular languages:
- [C#](https://docs.microsoft.com/en-us/dotnet/csharp/tour-of-csharp/) *(microsoft)*
- [Swift](https://swift.org/) *(Apple)*
- [Golang](https://golang.org/) *(Google)*
- [Kotlin](https://kotlinlang.org/) *(Jetbrains & Google)*
- [Javascript](https://www.javascript.com/) *(Mozilla)*
- [Typescript](https://www.typescriptlang.org/) *(microsoft)*
- [Rust](https://www.rust-lang.org/) *(Mozilla)*
- [VB.net](https://docs.microsoft.com/en-us/dotnet/visual-basic/) *(microsoft)*
- [PHP](https://www.php.net/manual/en/intro-whatis.php)
- [Ruby](https://www.ruby-lang.org/en/)
- [Groovy](https://groovy-lang.org/)
- [F#](https://fsharp.org/) *(microsoft)*
- [Dart](https://dart.dev/) *(Google)*
- [Objective-C](https://developer.apple.com/library/archive/documentation/Cocoa/Conceptual/ProgrammingWithObjectiveC/Introduction/Introduction.html#//apple_ref/doc/uid/TP40011210) *(Apple)*
- [OCaml](https://ocaml.org/)

## Item-03: All other **JVM** languages rejected Checked Exceptions
### [Kotlin](https://kotlinlang.org/)
- The most popular non-java jvm language, backed by Google & Jetbrains
- The preferred language for Android development

### [Scala](https://www.scala-lang.org/)
- The most popular functional language on jvm

### [Groovy](https://groovy-lang.org/)
- The most popular jvm scripting language

### [Clojure](https://clojure.org/)
- Another popular functional language for jvm


## Item-04: Java is the **only** [TIOBE Index](https://www.tiobe.com/tiobe-index/) language plagued with Checked Exceptions
- Exactly 1 out of the 20 most used programming languages has Checked Exceptions (java)
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
- Including, (but not limited to):
    - [Reactor](https://projectreactor.io/)
        - Backed by [Spring](https://spring.io/)
        - See their [recommended workaround](https://projectreactor.io/docs/core/release/reference/#_handling_exceptions_in_operators_or_functions) for the Checked Exception problem
    - [RxJava](https://github.com/ReactiveX/RxJava)
    - [Akka Reactive Streams](https://doc.akka.io/docs/akka/current/)


--------
# Dependencies
## Item-08: Exception propagation creates dependencies across contexts
1. Only a problem for Checked Exceptions (since they must be imported)
1. The import requirement creates a compile time reference
1. Typically, you are forced to add a `<dependency>` so method signatures compile


--------
# Contracts/Interfaces
## Item-09: Checked Exceptions leak implementation details
1. Encapsulation failure
1. Consider a CRUD abstraction over your data layer, throwing [SQLException](https://docs.oracle.com/en/java/javase/11/docs/api/java.sql/java/sql/SQLException.html)
    1. What if you want to swap out a [NoSQL store](https://en.wikipedia.org/wiki/NoSQL) or a cache?
    1. What if clients drive their logic based on thrown [SQLException](https://docs.oracle.com/en/java/javase/11/docs/api/java.sql/java/sql/SQLException.html)?
    

## Item-10: Checked Exceptions become part of your API, forever
1. Once you adopt Checked Exceptions, you're stuck with them
    1. Removing them can break client code that catches a Checked Exception
1. As a library author, inability to make (safe) changes is undesirable


## Item-11: Checked Exceptions make your library harder to use
1. Engineers must select from the terrible options below (see [Item-16](#item-16-java-compiler-forces-you-to-choose-among-terrible-options))
1. Engineers may opt for alternatives (or fork your lib to fix it)


--------
# Inconsistencies

## Item-12: Sun/Oracle wrap some Checked Exceptions in RuntimeExceptions
1. Even the authors of Java try to avoid CheckedExceptions
1. See java.net.URI::[create](https://docs.oracle.com/en/java/javase/11/docs/api/java.base/java/net/URI.html#create(java.lang.String))


## Item-13: Sun was inconsistent with usage of Checked Exceptions
1. See [their policy/guidance](https://docs.oracle.com/javase/tutorial/essential/exceptions/runtime.html)
    1. See Violation for [URISyntaxException](https://docs.oracle.com/en/java/javase/11/docs/api/java.base/java/net/URISyntaxException.html) 
    1. See Violation for [CloneNotSupportedException](https://docs.oracle.com/en/java/javase/11/docs/api/java.base/java/lang/CloneNotSupportedException.html) 
    1. See Violation for [NumberFormatException](https://docs.oracle.com/en/java/javase/11/docs/api/java.base/java/lang/NumberFormatException.html) 
1. See [Closeable](https://docs.oracle.com/en/java/javase/11/docs/api/java.base/java/io/Closeable.html#close()) vs [AutoCloseable](https://docs.oracle.com/en/java/javase/11/docs/api/java.base/java/lang/AutoCloseable.html#close())
    1. Even worse, Compare how [InterruptedException](https://docs.oracle.com/en/java/javase/11/docs/api/java.base/java/lang/InterruptedException.html) and [IOException](https://docs.oracle.com/en/java/javase/11/docs/api/java.base/java/io/IOException.html) are handled for both of these 

## Item-14: Checked Exceptions force you to acknowledge some Exceptions and not others
1. Try-catch blocks are biased toward only catching Checked Exceptions
    1. And ignoring possibly more important RuntimeExceptions
    

--------
# Tools
## Item-15: IDEs like Intellij, Eclipse and Netbeans all default to an anti-pattern

- By default:
```java
try {
    legacyMethod(); // throws Checked Exception

} catch ( TheCheckedException ex ) { 
	ex.printStackTrace(); // <--- this is the Error hiding anti-pattern
}
```


--------
# Code bloat

## Item-16: Java compiler forces you to choose among terrible options
1. Compiler forces you to acknowledge
    - It doesn't force you to handle cleanly
    - It doesn't force you to handle RuntimeExceptions

### Option-1: Ignore
1. This is the [Error Hiding anti-pattern](https://en.wikipedia.org/wiki/Error_hiding)
```java
try {
    legacyMethod(); // throws Checked Exception

} catch ( TheCheckedException ex ) { 
	// this is the error hiding anti-pattern
}
```

### Option-2: Propagate
1. Propagation spreads the problem to ALL of your callers
1. Propagation forces you to change your method signatures in ways **unrelated** to your code


### Option-3: Wrap
1. Wrapper code is worthless 
1. Wrapper code hinders both comprehension & performance
1. Wrapper code increases the indentation of your methods (which reduces comprehension & maintenance)
1. If you control both caller & caller, the simpler solution is to use RuntimeException in the callee
```java
try {
    legacyMethod(); // throws Checked Exception

    } catch ( SomeCheckedException ex ) { 
 	throw new RuntimeException(ex); // wrap
}
```

### Option-4: Handle
1. In practice, the caller is RARELY in a position to deal with the exception
    - eg. What to do when [IOException](https://docs.oracle.com/en/java/javase/11/docs/api/java.base/java/io/IOException.html) thrown while **closing** a Connection?
1. Exceptions are propagated up to a Component that CAN handle it.
    - This means you're using options above until you get to the real handler


--------
# Modern libraries
## Item-17: Spring framework has zero Checked Exceptions

## Item-18: SLF4j has zero Checked Exceptions

## Item-19: Google Guava
1. Has 7 [**unchecked** exceptions](https://javadoc.io/doc/com.google.guava/guava/latest/index.html)
1. Has 2 Checked Exceptions, both extend [IOException](https://docs.oracle.com/en/java/javase/11/docs/api/java.base/java/io/IOException.html) (to align with existing libs)
    - [BaseEncoding.DecodingException](https://guava.dev/releases/19.0/api/docs/com/google/common/io/BaseEncoding.DecodingException.html)
    - [InsecureRecursiveDeleteException](https://guava.dev/releases/22.0/api/docs/com/google/common/io/InsecureRecursiveDeleteException.html)
1. Has [Throwables](https://github.com/google/guava/wiki/ThrowablesExplained) utilities to fix Checked Exceptions


## Item-20: Apache Commons Lang
1. lang3 has a utility to fix [Checked Exceptions](https://commons.apache.org/proper/commons-lang/apidocs/org/apache/commons/lang3/exception/ExceptionUtils.html)


    
--------
# More info
- https://phauer.com/2015/checked-exceptions-are-evil/
- [More debate on stack overflow](https://stackoverflow.com/questions/613954/the-case-against-checked-exceptions)
