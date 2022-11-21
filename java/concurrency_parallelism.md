# Overview
TODO

# Table of Contents
TODO


--------
# Definitions
1. Parallelism:
    1. Executing multiple tasks **simultaneously**
1. Concurrency:
    1. How you structure/organize code
    1. Avoiding the challenges below


# Challenges
1. [Deadlock](https://en.wikipedia.org/wiki/Deadlock)
    1. Mutual/Circular hold-and-wait
    1. No [preemption](https://en.wikipedia.org/wiki/Preemption_(computing))
1. Atomicity
    1. How to execute multiple statements without interruption (atomically)
1. Race conditions
    1. Outcome depends on task execution order
1. Blocking
    1. Unbounded waiting
1. Starvation
    1. a task can never a resoruce


# Tradeoffs
1. How much parallelism?
    1. Too much: performance degrades due to thread management overhead
    1. Not enough: performance degrades due to unused resources


# More info
TODO
