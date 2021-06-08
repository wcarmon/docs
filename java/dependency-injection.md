# Overview
- What is Dependency Injection (DI)
- Why we should use Constructor Injection 
    - (Not ~~Field injection~~ nor ~~Setter injection~~)


--------
# Table of Contents
TODO


--------
# Dependency Injection
- A design pattern
- Decouples a class from its dependencies
- Separates `dependency retrieval` from `dependency usage`
- Simplifies managing large code bases
- Simplifies testing
    - Particularly when combined with the [SOLID principles](https://www.digitalocean.com/community/conceptual_articles/s-o-l-i-d-the-first-five-principles-of-object-oriented-design)
- Simplifies refactoring
- Improves reuse


# Three Approaches
- TL;DR; Use constructor injection

## Constructor Injection
- Promotes immutability
- Dependency issues are detected at startup
- [Spring docs on Constructor Injection](https://docs.spring.io/spring-framework/docs/current/reference/html/core.html#beans-constructor-injection)
- Spring team [recommends constructor injection](https://docs.spring.io/spring-framework/docs/current/reference/html/core.html#beans-setter-injection)
- Tests are library agnostic
  - Tests don't require a special runner
  - No vendor lock in for tests
- No reflection required
- Compatible with preconditions
- Container agnostic
  - not locked into one DI library
  - No vendor lockin for our classes


## ~~Setter Injection~~
### Problems
- Hinders immutability (which hinders safe concurrency)
- No guarantees of dependencies being set
    - Potential for incomplete objects
    - Setter might not be called
- No guarantees dependencies are changed
    - Security flaw


## ~~Field Injection~~
### Problems
- Hinders immutability (which hinders safe concurrency)
- Discouraged by Spring
- Discouraged by Guice
- Discouraged by Angular
- Requires reflection or a proxy 
- Requires special runner for tests
- Breaks abstraction (cannot make private)
- Incompatible with preconditions


--------
# More info
- [Spring docs on DI](https://docs.spring.io/spring-framework/docs/current/reference/html/core.html#beans-factory-collaborators)
- [Guice docs on DI](https://github.com/google/guice/wiki/Motivation) 
- https://stackify.com/dependency-injection/
- https://docs.microsoft.com/en-us/aspnet/core/fundamentals/dependency-injection?view=aspnetcore-5.0
