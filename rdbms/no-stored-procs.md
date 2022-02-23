# Overview
1. Why stored procedures are bad
1. Why it's better to write logic in a programming language (eg. [Java](https://www.java.com/en/), [Python](https://www.python.org/), [Node](https://nodejs.org/en/), C/C++, [golang](https://go.dev/), [Kotlin](https://kotlinlang.org/), [Rust](https://www.rust-lang.org/), ...)


# Not Portable
1. Stored procs only work in 1 type of database (Oracle Proc cannot run in [PostgreSQL](https://www.postgresql.org/) nor  [SQL server](https://www.microsoft.com/en-us/sql-server/sql-server-downloads) nor [DB2](https://www.ibm.com/docs/en/db2/11.5?topic=installing-db2-database-servers))
    1. This is vendor lock-in
1. Every database vendor has their own (often obscure) syntax
    1. [PostgreSQL](https://www.postgresql.org/docs/13/sql-createprocedure.html), [MySQL](https://dev.mysql.com/doc/refman/8.0/en/create-procedure.html), [Oracle](https://docs.oracle.com/cd/B19306_01/server.102/b14200/statements_6009.htm), [DB2](https://www.ibm.com/docs/en/db2-for-zos/11?topic=statements-create-procedure-external), [SQLServer] (https://docs.microsoft.com/en-us/sql/relational-databases/stored-procedures/create-a-stored-procedure?view=sql-server-ver15)
1. Stored procs are tech debt because some databases don't work in the cloud (eg. DB2)


# Not Scalable
1. Stored procs violate ["Separation of concerns"](https://en.wikipedia.org/wiki/Separation_of_concerns) Principle (Business logic in persistence tier)
1. Stored procs lock business logic into 1 persistence store (vendor-lockin)
1. Stored procs cannot be scaled independent of storage
1. Stored procs cannot scale up or down based on usage (Elasticity), (compare with [Lambdas](https://aws.amazon.com/lambda/features/) or [Cloud functions](https://cloud.google.com/functions))
1. Stored procs cannot be distributed across a computation cluster (eg. [AWS Lambdas](https://aws.amazon.com/lambda/features/) or [Google Cloud functions](https://cloud.google.com/functions))
1. Stored procs cannot use multiple threads (Parallelism)
1. Stored procs don't support [Non-blocking](https://en.wikipedia.org/wiki/Non-blocking_algorithm) coding nor [Async IO](https://en.wikipedia.org/wiki/Asynchronous_I/O)
1. Stored procs don't support [A/B code deployments](https://www.testenvironmentmanagement.com/deployment-styles-bluegreen-canary-and-ab/)
1. Stored procs don't support load balancing & [back pressure](https://medium.com/@jayphelps/backpressure-explained-the-flow-of-data-through-software-2350b3e77ce7)
1. Stored procs don't support Message/Event-driven flows
1. Stored procs don't support Concurrency patterns (eg. [Fork-join](https://en.wikipedia.org/wiki/Fork%E2%80%93join_model), [Circuit breakers](https://en.wikipedia.org/wiki/Circuit_breaker_design_pattern), [Retry & backoff](https://resilience4j.readme.io/docs/retry) ...)


# Not Reusable
1. Stored procs don't allow computation in popular languages (eg. [Java](https://www.java.com/en/), [Python](https://www.python.org/), [Node](https://nodejs.org/en/), C/C++, [golang](https://go.dev/), [Kotlin](https://kotlinlang.org/), [Rust](https://www.rust-lang.org/), ...)
1. Stored procs cannot use popular libraries


# Not Testable
1. Stored procs are incompatible with [Unit testing](https://en.wikipedia.org/wiki/Unit_testing) and the [XUnit](https://xunit.net/) movement
1. Stored procs don't support code coverage
1. Stored procs cannot be tested in parallel (requires n-independent database instances)
1. Stored procs cannot be tested as part of an automated build process (eg. [Gradle](https://gradle.org/), [Jenkins](https://www.jenkins.io/), [CircleCI](https://circleci.com/), TravisCI, ...)
1. Some vendors don't even provide documentation on how to test (eg. DB2)
1. Stored procs don't support [mock testing](https://en.wikipedia.org/wiki/Mock_object)
1. Testing Stored procs requires a "near-production" environment (any permission, schema, sharing, ... discrepancies invalidate test results)
1. Stored procs cannot be safely refactored because there's no automated testing


# Not Debuggable
1. Stored procs don't support [breakpoints](https://www.jetbrains.com/help/idea/using-breakpoints.html#manage-breakpoints)
1. Stored procs don't support [stepping thru code](https://www.jetbrains.com/help/idea/stepping-through-the-program.html)
1. Stored procs don't support static analysis tools (eg. [sonar](https://www.sonarqube.org/), [pmd](https://pmd.github.io/), [eslint](https://eslint.org/), [flake8](https://flake8.pycqa.org/en/latest/), ...)


# Not Observable
1. Stored procs don't work with [OpenTelemetry](https://opentelemetry.io/) or [OpenTracing](https://opentracing.io/)
1. Stored procs don't work with Logging tools (eg. [ElasticSearch](https://www.elastic.co/), [Splunk](https://www.splunk.com/), ...)
1. Stored procs don't work with Cloud observability tools (eg, [AWS XRay](https://aws.amazon.com/xray/), [Google Cloud Trace](https://cloud.google.com/trace), ...)
1. Stored procs don't provide insight into [hot spots](https://www.yourkit.com/docs/java/help/cpu_hot_spots.jsp)


# Not Developer happiness
1. Developers must share the common code runtime (cannot run in isolation for DB2, Oracle, ...)
    1. Some DBs support containers now, but still requires a prod-like setup and local container support
1. Engineers cannot recreate issues locally without affecting other Engineers
    1. Again, unless you have full container support


# More resources
1. https://wiki.c2.com/?StoredProceduresAreEvil
1. https://federico-razzoli.com/3-rgood-reasons-to-use-stored-procedures
1. https://kevinlawry.wordpress.com/2012/08/07/why-i-avoid-stored-procedures-and-you-should-too/
1. https://medium.com/swlh/i-said-goodbye-to-stored-procedures-539d56350486
1. http://eichler.byethost11.com/misc/AntiSP.htm?i=1
1. https://dusted.codes/drawbacks-of-stored-procedures




-----------------------------
# TODO: organize these
1. cannot scale processing & data independently (hard coded)
   1. compare with KafkaStreams which run with the Consumer
1. no code reviews
1. no security scanning tools
1. no streaming
1. relatively immature logging features
1. no granular lock support