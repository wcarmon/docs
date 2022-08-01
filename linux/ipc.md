# Overview
1. Mechanisms for communicating across Linux processes


--------
# Shared memory
1. Fastest IPC mechanism (for 2+ processes on same host system)
1. No extra kernel-space copy required
1. Con: reader/writer require synchronization
1. Con: synchronization requirement can offset speed advantage over other IPC mechanisms
1. Use a semaphore to synchronize access to shared memory
1. Kernel places page-table entries in in each process point to same RAM pages
1. Reads are non-destructive (i.e. can be read multiple times)


## POSIX Shared memory (newer)


## System V Shared memory (legacy)

## Memory Mapped file


--------
# Data transfer
1. Requires copying data twice between user-space and kernel-space
1. Pro: reader/writer synchronization is not required (automatic)
1. Readers block until data available


## Pipe (Anonymous)
1. Con: framing challenges, messages can be intermingled
1. Con: Processes must share common ancestor
1. anonymous data queues
1. Undelimited byte stream
1. reads are destructive
1. Use file descriptor to reference


## FIFO ==  Named Pipe
1. Concept: data queues with file names
1. Delim: Undelimited byte stream
1. Reading: reads are destructive
1. Reference: named in a directory
1. Reference: Use pathname or file descriptor to


## POSIX Message Queues (newer)
1. Messages are passed as blocks of arbitrary size, not as byte streams
1. Delimited messages
1. must read message fully (no partial)
1. reads are destructive


## ~~System V Message Queues (legacy)~~
1. Similar to newer POSIX message queues


--------
# Net

## Datagram sockets
1. Delimited messages
1. must read message fully (no partial)


--------
# Syncronization

## POSIX semaphores
1. Useful for coordinating access to shared memory
1. Kernel maintained uint


## ~~System V semaphores (legacy)~~
1. similar to above

## File lock
1. Coordinates access to a single file
1. 2-types:
    1. Read lock (shared, multiple readers)
    1. Write lock (exclusive)
1. Locks can work on whole file or regions of a file
1. see [`fcntl`](TODO)


--------
# Small notifications
## Signals


---------------------------------
# Unfiled
## Shared File system

## System V IPC

## POSIX IPC

## Net / Socket / Unix Domain Socket
1. Reference: pathname or file desriptor

## Net / Socket / IP Socket
1. Reference: IP address + port

## Net / IP / TCP / gRPC

## Net / IP / TCP / HTTP / REST


# Other resources
1. https://docs.oracle.com/cd/E19504-01/802-5882/6i9k22elq/index.html
1. https://www.softprayog.in/programming/interprocess-communication-using-posix-shared-memory-in-linux
