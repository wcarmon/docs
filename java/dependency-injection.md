# Overview
- What is Dependency Injection? (DI)
- Why we should use Constructor Injection? 
    - (Not ~~Field injection~~ nor ~~Setter injection~~)


--------
# Table of Contents
- [Dependency Injection](#dependency-injection)
- [Three Approaches](#three-approaches)
  * [Constructor Injection](#constructor-injection)
  * [~~Setter Injection~~](#setter-injection)
    + [Problems](#problems)
  * [~~Field Injection~~](#field-injection)
    + [Problems](#problems)
- [More info](#more-info)


--------
# Dependency Injection
- A [Design pattern](https://en.wikipedia.org/wiki/Dependency_injection#:~:text=In%20software%20engineering%2C%20dependency%20injection,object%20is%20called%20a%20service.)
- Decouples `dependency creation/retrieval` from `dependency usage`
- Simplifies managing large code bases
- Simplifies testing
    - Particularly when combined with the [SOLID principles](https://www.digitalocean.com/community/conceptual_articles/s-o-l-i-d-the-first-five-principles-of-object-oriented-design)
- Simplifies refactoring
- Improves reuse
- Allows developers to work more concurrently
  - Bound by contracts, not implementations


# Three Approaches
- TL;DR; Use constructor injection

## Constructor Injection
- Promotes [Immutability](./jvm-immutability.md)
  - injected fields can be private and final
- Dependency issues are detected at startup
- [Spring docs on Constructor Injection](https://docs.spring.io/spring-framework/docs/current/reference/html/core.html#beans-constructor-injection)
- Spring team [recommends constructor injection](https://docs.spring.io/spring-framework/docs/current/reference/html/core.html#beans-setter-injection)
- Tests are library agnostic
  - Tests don't require a special runner
  - No [Vendor lock-in](https://en.wikipedia.org/wiki/Vendor_lock-in) for tests
- No reflection required
- Compatible with preconditions
- Container agnostic
  - not locked into one DI library
  - No [Vendor lock-in](https://en.wikipedia.org/wiki/Vendor_lock-in) for our classes


## ~~Setter Injection~~
- A.K.A. "Interface injection"
### Problems
- Hinders [Immutability](./jvm-immutability.md) (which hinders safe concurrency)
- No guarantees of dependencies being set
    - Potential for incomplete objects
    - Setter might not be called
- No guarantees dependencies are changed
    - Security flaw
- Dependency problems not detected until usage  


## ~~Field Injection~~
### Problems
- Hinders [Immutability](./jvm-immutability.md) (which hinders safe concurrency)
- Discouraged by [Spring](https://docs.spring.io/spring-framework/docs/current/reference/html/core.html#beans-setter-injection)
    - Recent versions don't even mention support for field injection
- Discouraged by Guice
- Requires reflection or a proxy 
- Requires special runner for tests
    - [Vendor lock-in](https://en.wikipedia.org/wiki/Vendor_lock-in)
    - Prevents you from using another [test runner](https://junit.org/junit4/javadoc/4.13/org/junit/runner/Runner.html)
- Breaks abstraction (cannot make properties `private`)
- Incompatible with [Preconditions](./preconditions.md)
- Classes cannot be final

# Examples
```java
public final class FooService {

    private final FooDao fooDao;            <--- NOTICE: this is final

    public FooService(
        FooDao fooDao) {                    <--- NOTICE: pass the dependency here

        // Preconditions go here -->
        Objects.requireNotNull(fooDao, "fooDao is required and null");

        // Assignments go here -->
        this.fooDao = fooDao;
    }

    // ... business logic where you use `this.fooDao`
}
```


--------
# More info
- https://stackify.com/dependency-injection/
- [Spring docs on DI](https://docs.spring.io/spring-framework/docs/current/reference/html/core.html#beans-factory-collaborators)
- [Guice docs on DI](https://github.com/google/guice/wiki/Motivation) 
- [reflectoring.io article](https://reflectoring.io/constructor-injection/)
- [C# docs on DI](https://docs.microsoft.com/en-us/aspnet/core/fundamentals/dependency-injection?view=aspnetcore-5.0)
- [Golang docs on DI](https://github.com/google/wire)
- [Rust docs on DI](https://docs.rs/inject/0.1.3/inject/)
- [Angular docs on DI](https://angular.io/guide/dependency-injection)
- [JEE docs on DI](https://docs.oracle.com/javaee/6/tutorial/doc/giwhl.html)
