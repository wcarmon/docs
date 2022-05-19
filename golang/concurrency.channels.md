# Overview
- Key features & usage idioms for a channel


# Key features of Channels
1. Type-safe
1. Pass-by-reference
1. Thread-safe
1. Optionally buffered
    1. Only affects Senders (Not receivers)

# Creation
1. allocated with [`make`](./allocation.md)
```go
TODO
```

# Buffering
TODO


# Two-way
TODO


# Receive only channel
1. Example
```go
func myReceiver(source <-chan bool) {
	current := <-source
	fmt.Println("I read this: %v", current)
}
```
TODO: more here


# Send only channel
1. Writing to closed channel causes `panic`
1. Example
```go
func mySender(sink chan<- bool) {
    sink <- true
}
```
TODO: more here


# Receivers
1. Always block until a message is available
1. Reading from closed channel yields zero value
TODO: range


# Senders
1. Blocks when ...
    1. Unbuffered and receiver hasn't received
    1. writing to the non-full buffer (just long enough to commit the value)
    1. writing to a full buffer (until there's buffer capacity)
TODO


# `select` block
TODO
TODO: https://www.golang-book.com/books/intro/10


# Idioms
1. Use one-way channels as function args


- TODO: nil channel
- TODO: closed channel
- TODO: closing a channel


# Other resources
1. [Language spec](https://go.dev/ref/spec#Channel_types)
