# Overview

1. Candidate libs for light & modern REST server
1. Selection criteria
1. Best options for 2023

# Criteria

1. See [criteria for selecting libs](../common/libraries.md)

# Additional Criteria

1. Container friendly
    1. Light on memory
    1. [Library, not a framework](../common/libraries.md#library-vs-framework)
    1. [Graal](./graal.md) & [native-image](./graal.md) friendly
1. [Dependency injection](./di.md) friendly
1. Simple routing
1. Filters/Middleware
1. Simple parameter mapping
1. No scala (memory hungry, tomorrow's abandonware)
1. Minimal runtime magic (reflection)
1. Non-blocking IO (eg. netty based)
1. No ~~Reactor~~/~~RxJava~~ (memory hungry, complex, infectious)
    1. Mono and Flux take over all your function signatures
    1. JDBC is still blocking so there's no value in contaminating your API
    1. [Project loom](https://wiki.openjdk.org/display/loom/Getting+started) obsoletes reactive programming
1. HTTP/2 support
1. [OpenTelemetry](https://opentelemetry.io/) friendly

# Candidate libs

## [Jetty](https://www.eclipse.org/jetty/)

1. Best fit
1. Optional [Servlet 5.x](https://jakarta.ee/specifications/servlet/5.0/) support

## [Undertow](https://undertow.io/)

- TODO

## [Spark](https://sparkjava.com/)

1. `Con`: smaller community than jetty

## [Jersey](https://eclipse-ee4j.github.io/jersey/)

- TODO

## [Blade](https://github.com/lets-blade/blade)

1. `Pro`: minimal dependencies

# Rejected

## ~~Quarkus~~

1. Framework, not a library
    1. If it doesn't do exactly what you want, you are out of luck (same for most frameworks)
    1. You are locked into what they can provide (same for most frameworks)
1. CDI for injection (cannot replace with Guice nor spring-context)
1. vertx based (see below)
1. Tightly coupled to popular frameworks
    1. They manually build "adapters" (only) to popular frameworks
1. Reactive programming (see above)
1. Eclipse micro profile for metrics
1. Coroutines support isn't core

## ~~RestEasy~~

1. Abandonware (last updated 2018)

## ~~Restlet~~

1. Abandonware (last updatd 2014)

## ~~Spring Web~~

1. Overly complex
1. Heavy on reflection
1. Abandonware (They are pushing webflux instead)
1. Lots of magic
    1. Following stack traces is hard
    1. Reasoning about control flow is hard
1. Heavy memory footprint

## ~~Spring WebFlux~~

1. Reactive programming (see above)
1. Heavy on reflection
1. Most of the same problems as Spring Web
1. Not graal & native-image friendly
    1. lots of warning & error messages

## ~~TomEE~~

1. Too heavy
1. Overhead for supporting too many abandoned/legacy technologies

## ~~Vertx~~

1. Vertx doesn't help with non-blocking code
    1. [They tell YOU](https://vertx.io/docs/vertx-core/java/#golden_rule) not to write blocking code
    1. If you have to do the work, you don't need vertx
1. Callback hell
    1. Not even lambda friendly
    1. asynchronous is undesirable, because it doesn't compose, isn't traceable via source, ...
1. Immature EventBus
    1. SerDe performance overhead in both directions
    1. Loss of type safety at the EventBus (no refactoring, performance overhead)
    1. no bus retry
    1. no bus persistence
    1. no bus guarantees
1. Non-blocking "lie" breaks at the SQL layer since JDBC is a blocking API
1. No composition (verticles are not composable)
1. Debugging is hard
    1. Non-trivial flows require following things thru the bus
