# Overview
- Key features of functions
- See also [Methods](./methods.md) doc


# Key features of functions
1. An executable code block
1. Multiple arguments
    1. Passed by value (or pass an address by value)
    1. varargs supported
1. Multiple return types
    1. Passed by value (or pass an address by value)
1. All types pass by value & return by value
    1. Some types pass by address value (feels like pass-by-reference)
    1. eg. map, slice, channel, pointer, function args
    1. See [Language spec](https://go.dev/ref/spec#Method_values)
1. No [overloading](https://www.w3schools.com/java/java_methods_overloading.asp)
    1. Same as C, javascript, typescript, Python, ...
    1. Unlike Java, C++, ...


TODO: (higher order) accepting function as arg
TODO: (higher order) return a function
TODO: defer - https://go.dev/ref/spec#Defer_statements
TODO: named result param
TODO: init function (per file)
TODO: varargs
TODO: it's ok to return address of local var in constructor


# Idioms
1. Use pointer receiver only when mutating


# Other resources
1. https://www.practical-go-lessons.com/chap-40-design-recommendations#methods-and-functions
1. https://www.practical-go-lessons.com/chap-10-functions
1. https://www.golangprograms.com/go-language/functions.html
1. https://gobyexample.com/functions
