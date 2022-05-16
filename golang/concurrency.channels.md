# Overview
- Key features & usage idioms for a channel


# Key features of Channels
1. Type-safe
1. Pass-by-reference
1. Thread-safe
1. Optionally buffered
    1. Only affects Senders (Not receivers)

# Creation
1. allocated with `make`
```go
TODO
```

# Buffering
TODO


# Two-way
TODO

# Receive only channel
TODO

# Send only channel
TODO


# Receivers
1. Always block until a message is available
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
TODO ...


- TODO: nil channel
- TODO: closed channel


# Other resources
1. TODO ...
