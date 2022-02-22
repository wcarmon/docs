# Overview
1. Why is immutability important
1. Immutability isn't limited to one language


# Big picture
1. Don't mutate, build another one with the changes
1. "Save As" not "Save"
1. Makes things easier to reason about


# Benefits (Pros)
1. Predictability
1. Safety
1. Immutable data is threadsafe, safe to share
    1. Consumes less memory than defensive copies
    1. Avoids race conditions
    1. Avoids corruption by multi-thread related mutation
1. Simplifies multi-threaded & parallel code
1. Better control over data
1. Avoids unnecessary defensive copies
1. Simplifies undo/redo (update/rollback)
1. Simplifies debugging
1. Avoids reading data in an inconsistent state
1. [Atomicity of failure](http://jtechies.blogspot.com/2012/07/item-64-strive-for-failure-atomicity.html)
1. No hidden side-effects on data
1. Simplified caching
1. Avoids temporal coupling on methods
1. Validation only required on construction
1. Traceability & Audit trail


# Drawbacks (Cons)
1. Sometimes, extra instances can consume more memory
    1. However, immutable instances can be shared, which reduces memory


# Tools build around the Immutability Concept
1. [Git](https://git-scm.com/)
1. [Blockchain](https://medium.com/fluree/immutability-and-the-enterprise-an-immense-value-proposition-98cd3bf900b1)
1. [Kafka](https://kafka.apache.org/)


--------
# Other resources
1. https://www.tiny.cloud/blog/mutable-vs-immutable-javascript/
1. https://docs.oracle.com/javase/tutorial/essential/concurrency/immutable.html
1. https://debugged.it/blog/why-immutability-matters/
1. https://immutable-js.com/#the-case-for-immutability
1. https://www.ctl.io/developers/blog/post/immutability
1. https://itnext.io/why-concept-of-immutability-is-so-damn-important-for-a-beginner-front-end-developer-8da85b565c8e
1. https://en.wikipedia.org/wiki/Immutable_object
1. https://stackoverflow.com/questions/34385243/why-is-immutability-so-important-or-needed-in-javascript#:~:text=Besides%20reduced%20memory%20usage%2C%20immutability,change%20in%20a%20react%20component.
