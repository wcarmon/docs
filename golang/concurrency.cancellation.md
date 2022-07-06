# Overview
1. How to handle cancellation
1. See also [context](./context.md) doc


# Key Concepts
1. Use [`context`](./context.md) for cancellation
1. [Parent `context` cancels children](https://cs.opensource.google/go/go/+/refs/tags/go1.18.3:src/context/context.go;l=16) (Propagation)
    1. child `context` does **NOT** cancel parent `context`
    1. eg. `context.Background()` is never cancelled


# Idioms
1. TODO


# Other resources
1. TODO
