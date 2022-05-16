# Overview
- TODO ...


# Key features of Channels
1. Pass by ?
1. Thread-safe?


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
1. Always block until data available
TODO: range


# Senders
1. Blocks when ...
    1. Unbuffered and receiver hasn't received
    1. writing to the non-full buffer (just long enough to commit the value)
    1. writing to a full buffer (until there's buffer capacity)
TODO


# select block
TODO


# Idioms
TODO ...


TODO: nil channel
TODO: closed channel


# Other resources
1. TODO ...
