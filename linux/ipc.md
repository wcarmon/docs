# Overview
1. Mechanisms for communicating across Linux processes
1. TL;DR;
    1. Same machine?
        1. [POSIX Message queues](TODO) or [Domain sockets](TODO)
    1. Different machines?
        1. [gRPC](TODO) or REST over HTTP/2
    1. Ignore all the "System V" options
    1. Ignore all pipes


--------
# Shared memory
1. Impl: Kernel places page-table entries in in each process point to same RAM pages
1. Read: Reads are non-destructive (i.e. can be read multiple times)
1. Speed: Fastest IPC mechanism (for 2+ processes on same host system)
1. Speed: might not be the bottleneck for your application
1. Speed: No extra kernel-space copy required
1. Sync: reader/writer require synchronization
1. Sync: synchronization requirement can offset speed advantage over other IPC mechanisms
1. Sync: Use a semaphore to synchronize access to shared memory


## POSIX Shared memory
1. Reference: IPC pathname? TODO
1. Reference: file descriptor (TODO: more here)
1. Lifetime: lives until explicitly deleted or system shutdown


## System V Shared memory (legacy)


## Memory Mapped file
1. Reference: pathname or file descriptor
1. Lifetime: lives in file system, across system reboots
1. Lifetime: must be explicitly deleted
1. IO: any store to the mapped file segment results in implicit I/O


## Fileless Memory Mapping



--------
# Data transfer
1. Direction: Can only communicate in one direction
1. Read: Readers block until data available
1. Speed: Requires copying data twice between user-space and kernel-space
1. Sync: reader/writer synchronization is not required (automatic, by kernel)


## FIFO == Named Pipe
1. Concept: data queues with file names
1. Access: determined by file permissions
1. Compatible with epoll (simultaneous monitoring of multiple file descriptors)
1. Delim: Undelimited byte stream
1. Delim: use delim chars, message headers containing length or fixed-length messages
1. Lifetime: FIFO is dropped when no process has it open
1. Lifetime: name/identifier lives in file system
1. Read: reads are destructive
1. Reference: named in a directory
1. Reference: Use pathname or file descriptor
1. Priority: roll your own


## Pipe (Anonymous)
1. Con: framing challenges, messages can be intermingled
1. Con: Processes must share common ancestor
1. anonymous data queues
1. Delim: Undelimited byte stream
1. Protocol: must roll your own protocol
1. Read: reads are destructive
1. Reference: Use file descriptor to reference


## POSIX Message Queues
1. Messages are passed as blocks of arbitrary size, not as byte streams
1. Delimited messages
1. must read message fully (no partial)
1. Read: reads are destructive
1. Reference: IPC pathname? TODO
1. Reference: [`mqd_t`](TODO)
1. Priority: allows message prioritization
1. Lifetime: lives until explicitly deleted or system shutdown


## ~~System V Message Queues (legacy)~~
1. Similar to newer POSIX message queues


--------
# Net (Sockets)
1. Access: determined by file permissions
1. Lifetime: name/identifier lives in file system
1. Lifetime: Socket is dropped when no process has it open
1. Scope: Sockets are the ONLY option for IPC across host machines


## Sockets / Datagram
1. Delim: Delimited messages
1. Read: must read message fully (no partial)


## Socket / Unix Domain Socket (non-networked)
1. Scope: communication on same host machine
1. Reference: pathname or file desriptor


--------
# Synchronization

## POSIX semaphores (named)
1. [`semaphore.h`](https://man7.org/linux/man-pages/man0/semaphore.h.0p.html)
1. Useful for coordinating access to shared memory
1. Kernel maintained uint
1. Reference: [`sem_t`](TODO
1. Reference: IPC pathname? TODO
1. Lifetime: lives until explicitly deleted or system shutdown


## ~~System V semaphores (legacy)~~
1. similar to above

## File lock
1. Coordinates access to a single file
1. 2-types:
    1. Read lock (shared, multiple readers)
    1. Write lock (exclusive)
1. Locks can work on whole file or regions of a file
1. see [`fcntl`](TODO)
1. Access: access to lock requires read access to file



--------
# Small notifications

## Signals
1. TODO


---------------------------------
# Unfiled
## Shared File system

## System V IPC

## POSIX IPC

## Net / Socket / IP Socket
1. Reference: IP address + port

## Net / IP / TCP / gRPC

## Net / IP / TCP / HTTP / REST


# Other resources
1. https://docs.oracle.com/cd/E19504-01/802-5882/6i9k22elq/index.html
1. https://www.softprayog.in/programming/interprocess-communication-using-posix-shared-memory-in-linux
