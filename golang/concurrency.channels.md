# Overview
1. Key features & usage idioms for a [channel](https://go.dev/tour/concurrency/2)


# Key Concepts
1. Type-safe
1. Thread-safe (goroutine safe)
1. FIFO queue
1. [Pass-by-address-value](https://www.educative.io/edpresso/pass-by-value-vs-pass-by-reference)
    1. All things pass by value
    1. maps, slices, channels, functions are passed by "address" value (like a pointer)
    1. If you pass a `channel` to a function/method, caller & callee are referencing the same `channel`
1. Optionally buffered
    1. Only affects Senders (Not receivers)
1. Go channels are designed for 1 writer, and multiple readers
1. [`range`](TODO) will **NOT** stop recieving util channel is closed


# Creation
1. allocated with [`make`](./allocation.md)
```go
// unbuffered channel of ints
c1 := make(chan int)

// unbuffered channel of empty struct (zero memory)
c2 := make(chan struct{})

// buffered channel of strings, capacity of 5
c3 := make(chan string, 5)
```


# Buffering: Unbuffered channel
- sender blocks for first receiver
- receiver blocks for sender


# Buffering: buffered channel
- Buffer size == how many values to accept without a receiver


# Sender
1. runtime will `panic` if you send on a **closed** channel
1. Blocks when ...
    1. (unbounded) Unbuffered and receiver hasn't received
    1. (unbounded) writing to a full buffer (until there's buffer capacity)
    1. (briefly) writing to the non-full buffer (just long enough to commit the value)
1. Send:
```go
responseCodeCh <- 200
```


# Receiver
1. Blocks when ...
    1. (unbounded) no messages available
    1. (unbounded) when buffer empty
1. Reading from closed channel yields zero value
1. Only receiver [can check](https://go.dev/ref/spec#Receive_operator) if channel is closed
1. Receive:
```go
//TODO
```
1. You can also use [`select`](https://go.dev/ref/spec#Select_statements) + [`default`](https://gobyexample.com/non-blocking-channel-operations) for non-blocking

- TODO: range



# Direction: Two-way
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

# `select` block
TODO
TODO: https://www.golang-book.com/books/intro/10


# Idioms
1. Use one-way channels as function args


- TODO: nil channel
- TODO: closed channel
- TODO: closing a channel
- TODO: channel with empty struct


# Other Resources
1. [Language spec](https://go.dev/ref/spec#Channel_types)
1. [go101](https://go101.org/article/channel.html)
1. [gobyexample](https://gobyexample.com/channels)
1. [Official tour](https://go.dev/tour/concurrency/2)
1. [yourbasic](https://yourbasic.org/golang/channels-explained/)
