# Overview
1. Why stored procedures are bad



# Not Portable
1. Stored procs only work in 1 type of database (Oracle Proc cannot run in [PostgreSQL](https://www.postgresql.org/) nor  [SQL server](https://www.microsoft.com/en-us/sql-server/sql-server-downloads) nor [DB2](https://www.ibm.com/docs/en/db2/11.5?topic=installing-db2-database-servers))
    1. This is vendor lock-in


# Not Scalable
1. Stored procs cannot be distributed across a computation cluster (eg. [AWS Lambdas](https://aws.amazon.com/lambda/features/) or [Google Cloud functions](https://cloud.google.com/functions))
1. Stored procs cannot be scaled independent of storage
1. Stored procs cannot scale up or down based on usage (compare to [Lambdas](https://aws.amazon.com/lambda/features/) or [Cloud functions](https://cloud.google.com/functions))
1. Stored procs cannot use multiple threads


# Not Reusable
1. Stored procs don't allow computation in popular languages ([Java](https://www.java.com/en/), [Python](https://www.python.org/), [Node](https://nodejs.org/en/), C/C++, [golang](https://go.dev/), [Kotlin](https://kotlinlang.org/), [Rust](https://www.rust-lang.org/), ...)
1. Stored procs cannot use popular libraries


# Not Testable
TODO: more detail


# Not Debuggable
1. Stored procs don't support [breakpoints](https://www.jetbrains.com/help/idea/using-breakpoints.html#manage-breakpoints)



# Not Observable
1. Stored procs don't work with [OpenTelemetry](https://opentelemetry.io/) or [OpenTracing](https://opentracing.io/)
1. Stored procs don't work with Logging tools
1. Stored procs don't work with Cloud observability tools (eg, [AWS XRay](https://aws.amazon.com/xray/), [Google Cloud Trace](https://cloud.google.com/trace), ...)



# More resources
1. https://wiki.c2.com/?StoredProceduresAreEvil
1. https://federico-razzoli.com/3-rgood-reasons-to-use-stored-procedures
1. https://kevinlawry.wordpress.com/2012/08/07/why-i-avoid-stored-procedures-and-you-should-too/
1. https://medium.com/swlh/i-said-goodbye-to-stored-procedures-539d56350486
1. http://eichler.byethost11.com/misc/AntiSP.htm?i=1
1. https://dusted.codes/drawbacks-of-stored-procedures




-----------------------------
# TODO: organize these
# Details
1. non-portable syntax
1. incompatible with cloud (certainly DB2)
1. cannot scale processing & data independently (hard coded)
   1. compare with KafkaStreams which run with the Consumer
1. relatively immature logging features
1. no multi-threading & concurrency features
1. no unit tests
1. no retry
1. no streaming
1. no circuit breakers
1. DB2 doesn't even have documentation on testing
1. cannot run locally (db2 & oracle)
1. cannot use breakpoints
1. no observability features (eg. OpenTracing)
1. Moves business logic into persistence tier
1. Cannot refactor them safely because of testing
1. No developer isolation in dev
1. Cannot measure code coverage

