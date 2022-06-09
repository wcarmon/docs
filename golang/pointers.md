# Overview
1. Key points about Pointers in golang


# Key Concepts
1. Pointer is an address (of a variable)
1. `&` means **address-of**
1. `*` means two things:
    1. (part of a type) `*int` means a **pointer type** with an `int` base type
    1. (unary operator) `*myVar` means **value-at**, meaning dereference `myVar`
        1. `*nil` creates a `panic` (dereferencing a nil pointer)
1. all stack frames are independent/isolated (cannot access other stack frames)
1. C++ has both [References](https://isocpp.org/wiki/faq/references) and [Pointers](https://cplusplus.com/doc/tutorial/pointers/) (the [difference](https://isocpp.org/wiki/faq/references#pointers-and-references))
    1. C++ discourages pointers
1. Passing pointer is not always faster since golang needs to do [escape analysis](https://en.wikipedia.org/wiki/Escape_analysis) to decide where to allocate (stack or heap)


## Func parameters
1. function parameters **pass by value** (copy)
    1. compiler will **copy** arguments from caller stack frame to callee stack frame
    1. If the **value** is a pointer, callee can mutate value (at the address)
    1. Passing pointer trades immutability for less copying
1. If func accepts interface ...
    1. (convenience) Caller can pass value if no receivers accept pointer (because passing address makes no difference)
    1. Otherwise, caller **must** pass **address** of the implementation
    1. Compiler & IDE enforces all of this
1. Maps, slices, channels, pointers, functions pass "like" references
    1. They are passing address `by-value`

## Func return parameters
1. returned parameters **pass by value** (copy)
    1. compiler will **copy** return values from callee stack frame to caller stack frame
    1. If the return **value** is a pointer, compiler will allocate on [heap](TODO)


# Pointer func args
```go
func acceptValue(p int) {
	// changes have zero impact on caller
	p = 10
}

func acceptPointer(p *int) {
	// mutate value at p, affects caller
	*p = 10

	// CANNOT make caller's pointers point somewhere else
}
```


# Idioms
1. Accept pointer for mutation & REALLY large objects
1. Accept non-pointer for immutability


# Other resources
1. https://go.dev/ref/spec#Calls
1. https://go.dev/tour/moretypes/1
1. https://www.practical-go-lessons.com/chap-15-pointer-type
1. https://gobyexample.com/pointers
1. https://www.golang-book.com/books/intro/8
