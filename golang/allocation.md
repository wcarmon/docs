# Overview
- TODO ...


# make function
1. Creates [slices](./collections.slices.md), [maps](./collections.maps.md), [channels](./channels.md)
1. returns initialized T
1. assignment creates a **new** variable which points to the same storage location
    1. Similar to a [reference](https://www.tutorialspoint.com/cplusplus/cpp_references.htm) in c++ ([but not the same](https://dave.cheney.net/2017/04/29/there-is-no-pass-by-reference-in-go))
1. [returns a pointer](https://dave.cheney.net/2017/04/30/if-a-map-isnt-a-reference-variable-what-is-it)
1. [Official docs](https://pkg.go.dev/builtin#make)


# new
1. Allocates memory on heap (like [`calloc`](https://en.cppreference.com/w/c/memory/calloc) in c)
1. Does NOT initialize memory
1. [Official docs](https://pkg.go.dev/builtin#new)


# Idioms
TODO ...


# Other resources
1. TODO ...
