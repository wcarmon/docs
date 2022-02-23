# Overview
1. Why stored procedures are bad



# Testability
TODO: more detail

# Debuggability
TODO: more detail

# Observability
TODO: more detail

# Portability
TODO: more detail

# Reusability
TODO: more detail

# Scalability
TODO: more detail


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
1. vendor lock-in
1. non-portable syntax
1. incompatible with cloud (certainly DB2)
1. cannot scale processing & data independently (hard coded)
   1. compare with KafkaStreams which run with the Consumer
1. relatively immature logging features
1. no multi-threading & concurrency features
1. no unit tests
1. DB2 doesn't even have documentation on testing
1. cannot run locally (db2 & oracle)
1. cannot use breakpoints
1. no observability features (eg. OpenTracing)
1. Moves business logic into persistence tier
1. Cannot refactor them safely because of testing
1. No developer isolation in dev
1. Cannot measure code coverage

