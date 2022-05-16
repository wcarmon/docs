# Overview
- Key features & operations on structs

# Structs
1. [Pass-by-value](TODO)
    1. functions you invoke receive a copy of the struct
1. No inheritance ;-)


- TODO: adding methods - methods.md
- TODO: := copy/assign?
- TODO: json
- TODO: Embedding


# Idioms
1. Getters & Setters are neither required nor idiomatic
1. If you have getters, use `Owner`, not ~~`GetOwner`~~
1. If you have setters, use `SetOwner`
1. Method which converts to string is `String()` not `ToString()`

# Other resources
1. https://gobyexample.com/embedding
