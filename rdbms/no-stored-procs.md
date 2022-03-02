# Overview
1. Why stored procedures are bad
1. Why it's better to write Business logic in a programming language (eg. [Java](https://www.java.com/en/), [Python](https://www.python.org/), [Node](https://nodejs.org/en/), C/C++, [golang](https://go.dev/), [Kotlin](https://kotlinlang.org/), [Rust](https://www.rust-lang.org/), ...)


--------
# Table of Contents
- [Not Portable](#not-portable)
- [Not Scalable](#not-scalable)
- [Not Reusable](#not-reusable)
- [Not Testable](#not-testable)
- [Not Debuggable](#not-debuggable)
- [Not Observable](#not-observable)
- [No Developer happiness](#no-developer-happiness)
- [Other reasons](#other-reasons)
- [More resources](#more-resources)


# Not Portable
1. Stored procs only work in 1 type of database
    1. (Oracle Proc cannot run in [PostgreSQL](https://www.postgresql.org/) nor [SQL server](https://www.microsoft.com/en-us/sql-server/sql-server-downloads) nor [DB2](https://www.ibm.com/docs/en/db2/11.5?topic=installing-db2-database-servers))
    1. This is vendor lock-in
1. Every database vendor has their own syntax
    1. [PostgreSQL](https://www.postgresql.org/docs/13/sql-createprocedure.html), [MySQL](https://dev.mysql.com/doc/refman/8.0/en/create-procedure.html), [Oracle](https://docs.oracle.com/cd/B19306_01/server.102/b14200/statements_6009.htm), [DB2](https://www.ibm.com/docs/en/db2-for-zos/11?topic=statements-create-procedure-external), [SQLServer](https://docs.microsoft.com/en-us/sql/relational-databases/stored-procedures/create-a-stored-procedure?view=sql-server-ver15)
1. Stored procs are tech debt because some databases don't work in the cloud (eg. DB2)


# Not Scalable
4. Stored procs violate ["Separation of concerns"](https://en.wikipedia.org/wiki/Separation_of_concerns) Principle (Business logic in persistence tier)
1. Stored procs lock Business logic into 1 persistence store (vendor-lockin)
1. Stored procs cannot be scaled independent of storage (hard coded processing & persistence scaling)
1. Stored procs cannot scale up or down based on usage (Elasticity), (compare with [AWS Lambdas](https://aws.amazon.com/lambda/features/) or [Google Cloud functions](https://cloud.google.com/functions))
1. Stored procs cannot be distributed across a computation cluster (eg. [AWS Lambdas](https://aws.amazon.com/lambda/features/) or [Google Cloud functions](https://cloud.google.com/functions))
1. Stored procs cannot use multiple threads ([Parallelism](https://en.wikipedia.org/wiki/Parallel_computing))
1. Stored procs don't support [Non-blocking](https://en.wikipedia.org/wiki/Non-blocking_algorithm) coding nor [Async IO](https://en.wikipedia.org/wiki/Asynchronous_I/O)
1. Stored procs don't support [A/B code deployments](https://www.testenvironmentmanagement.com/deployment-styles-bluegreen-canary-and-ab/)
1. Stored procs don't support Concurrency patterns (eg. [Fork-join](https://en.wikipedia.org/wiki/Fork%E2%80%93join_model), [Circuit breakers](https://en.wikipedia.org/wiki/Circuit_breaker_design_pattern), [Retry & backoff](https://resilience4j.readme.io/docs/retry), ...)
1. Stored procs don't support [back pressure](https://medium.com/@jayphelps/backpressure-explained-the-flow-of-data-through-software-2350b3e77ce7)
1. Stored procs don't support [Message/Event-driven flows](https://developer.lightbend.com/docs/akka-platform-guide/concepts/message-driven-event-driven.html)
1. Stored procs don't support [Load balancing](https://en.wikipedia.org/wiki/Load_balancing_(computing))
    1. Most databases support Load balancing, but an overwhelmed proc & idle storage are treated as one unit
1. Stored procs don't support granular locks (eg. lock intermediate calculations for these 2 rows)
1. Stored procs don't support locks with timeouts
1. Stored procs don't support Streaming (eg. process incrementally with parallel pipelines)


# Not Reusable
1. Stored procs don't allow computation in popular languages (eg. [Java](https://www.java.com/en/), [Python](https://www.python.org/), [Node](https://nodejs.org/en/), C/C++, [golang](https://go.dev/), [Kotlin](https://kotlinlang.org/), [Rust](https://www.rust-lang.org/), ...)
1. Stored procs cannot use popular libraries
    1. [awesome-java](https://github.com/akullpp/awesome-java)
    1. [awesome-python](https://github.com/vinta/awesome-python)
    1. [awesome-node](https://github.com/sindresorhus/awesome-nodejs)
    1. [awesome-c](https://github.com/oz123/awesome-c)
    1. [awesome-golang](https://github.com/avelino/awesome-go)
    1. [awesome-rust](https://github.com/rust-unofficial/awesome-rust)


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
1. Stored procs don't support [Vulnerability scanning tools](https://www.coresecurity.com/blog/top-14-vulnerability-scanners-cybersecurity-professionals)


# Not Observable
1. Stored procs don't work with [OpenTelemetry](https://opentelemetry.io/) or [OpenTracing](https://opentracing.io/)
1. Stored procs don't work with popular Logging tools (eg. [ElasticSearch](https://www.elastic.co/), [Splunk](https://www.splunk.com/), ...)
1. Stored procs don't work with Cloud observability tools (eg, [AWS XRay](https://aws.amazon.com/xray/), [Google Cloud Trace](https://cloud.google.com/trace), ...)
1. Stored procs don't provide insight into [hot spots](https://www.yourkit.com/docs/java/help/cpu_hot_spots.jsp)


# No Developer happiness
1. Developers must share the common code runtime (cannot run in isolation for DB2, Oracle, ...)
    1. Some DBs support containers now, but still requires a prod-like setup and local container support
1. Engineers cannot recreate issues locally without affecting other Engineers
    1. Again, unless you have full container support


# Other Reasons
1. No Machine Learning support


# More resources
1. https://wiki.c2.com/?StoredProceduresAreEvil
1. https://federico-razzoli.com/3-rgood-reasons-to-use-stored-procedures
1. https://kevinlawry.wordpress.com/2012/08/07/why-i-avoid-stored-procedures-and-you-should-too/
1. https://medium.com/swlh/i-said-goodbye-to-stored-procedures-539d56350486
1. http://eichler.byethost11.com/misc/AntiSP.htm?i=1
1. https://dusted.codes/drawbacks-of-stored-procedures
