# Overview
1. Key features of Interfaces


# Key Concepts
1. Interfaces Define required **behavior**
1. Interface implementation is implicit
    1. This is huge!  loose couping between packages/modules
    1. Avoids unnecessary dependencies
    1. Compiler checks for implementation
1. Only interfaces can be embedded into interfaces (Union)
1. Interfaces Pass-by-address-value
    1. All things pass by value
    1. "feels like" Pass-by-reference
    1. behaves like passing a pointer

# Embedding
1. See https://www.practical-go-lessons.com/chap-16-interfaces#interface-embedding

# Implementing interface
1. Implementation is implicit
    1. Enforced by compiler
    1. Contrast with java, kotlin, c# or php where implementation is explicit
1. This helps create reuse with explicit dependencies
1. https://www.practical-go-lessons.com/chap-16-interfaces#implicit-implementation


TODO: runtime checks for interfaces like Marshaler


# Idioms
1. interfaces generally belong in the package that **uses** values of the interface type, not the package that implements those values
    1. https://github.com/golang/go/wiki/CodeReviewComments#interfaces
1. Prefer built-in/core interfaces
1. Prefer defining interfaces **where they are used**
1. Prefer accepting an interface over a concrete type
1. Interfaces with 1 or 2 methods are very common
    1. Compose!
    1. Keep interfaces short/small
1. Single method interfaces end with "-er"
    (eg. [`Writer`](https://pkg.go.dev/io#Writer), [`Reader`](https://pkg.go.dev/io#Reader), [`Closer`](https://pkg.go.dev/io#Closer))
1. Naming: Use MixedCaps or mixedCaps


# Other resources
1. https://www.practical-go-lessons.com/chap-16-interfaces
1. https://gobyexample.com/embedding
