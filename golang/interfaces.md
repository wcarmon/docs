# Overview
- TODO ...


TODO: embedding
TODO: implicit implementation


# Idioms
1. Prefer defining interfaces where they are used
1. Prefer accepting an interface over a concrete type
1. Interfaces with 1 or 2 methods are very common
    1. Compose!
1. Single method interfaces end with "-er"
    (eg. [`Writer`](https://pkg.go.dev/io#Writer), [`Reader`](https://pkg.go.dev/io#Reader), [`Closer`](https://pkg.go.dev/io#Closer))
1. Naming: Use MixedCaps or mixedCaps


# Other resources
1. https://gobyexample.com/embedding

