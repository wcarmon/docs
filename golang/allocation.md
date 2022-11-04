# Overview
- Summary of (heap) allocation mechanisms


# `make` function
1. Creates [slices](./collections.slices.md), [maps](./collections.maps.md), [channels](./concurrncy.channels.md)
1. returns initialized T
1. assignment creates a **new** variable which points to the same storage location
    1. Similar to a [reference](https://www.tutorialspoint.com/cplusplus/cpp_references.htm) in c++ ([but not the same](https://dave.cheney.net/2017/04/29/there-is-no-pass-by-reference-in-go))
1. [returns a pointer](https://dave.cheney.net/2017/04/30/if-a-map-isnt-a-reference-variable-what-is-it)
1. [Official docs](https://pkg.go.dev/builtin#make)


# `new` function
1. Allocates memory on heap (like [`calloc`](https://en.cppreference.com/w/c/memory/calloc) in c)
1. Does NOT initialize memory
1. [Official docs](https://pkg.go.dev/builtin#new)


# Idioms
1. Use `make` 90% of the time


# Other resources
1. https://go101.org/optimizations/0.3-memory-allocations.html
1. [make](https://pkg.go.dev/builtin#make)
1. [new](https://pkg.go.dev/builtin#new)
1. [Effective Go > make](https://go.dev/doc/effective_go#allocation_make)
1. [Effective Go > new](https://go.dev/doc/effective_go#allocation_new)
