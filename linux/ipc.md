# Overview
1. Mechanisms for communicating across Linux processes



# TL;DR;
|Scenario|Best option|
|---|---|
|Same host, Same process, Same language|`import`/`use`/`include` library|
|Same host, Same process|[FFI](https://en.wikipedia.org/wiki/Foreign_function_interface)|
|Same host, Different process|gRPC [over UDS](https://en.wikipedia.org/wiki/Unix_domain_socket) or REST [over UDS](https://en.wikipedia.org/wiki/Unix_domain_socket) or shared local [File System](https://en.wikipedia.org/wiki/File_system)|
|Different host (implies different process)|[gRPC over HTTP/2](https://grpc.io/) or [REST over HTTP/2](https://en.wikipedia.org/wiki/Representational_state_transfer)|


1. Same machine?
    1. Small/medium sized data
        1. [non-blocking, TCP-based, Unix Domain sockets](TODO)
            1. [c++](TODO)
            1. [c](TODO)
            1. [go](TODO)
            1. [Java](TODO)
            1. [c#](https://docs.microsoft.com/en-us/aspnet/core/grpc/interprocess?view=aspnetcore-6.0)
            1. [Python](https://github.com/grpc/grpc/blob/master/examples/python/uds/README.md)
            1. [Dart](TODO)
            1. [Rust](TODO)
        1. [`gRPC`](TODO) over `localhost` (which, for most languages, is as fast as Unix domain socket)
        1. memory mapped file?
    1. Large data
        1. Shared file system
        1. file locks
        1. memory mapped file?
1. Ignore all pipes


--------
# Shared memory
1. Domain: same host machine
1. Impl: Kernel places page-table entries in in each process point to same RAM pages
1. Read: Reads are non-destructive (i.e. can be read multiple times)
1. Speed: Fastest IPC mechanism (for 2+ processes on same host system)
1. Speed: might not be the bottleneck for your application
1. Speed: No extra kernel-space copy required
1. Sync: reader/writer require synchronization
1. Sync: synchronization requirement can offset speed advantage over other IPC mechanisms
1. Sync: Use a semaphore to synchronize access to shared memory


## POSIX Shared memory
1. Header: [`sys/mman.h`](TODO)
1. Reference: IPC pathname? TODO
1. Reference: file descriptor (TODO: more here)
1. Lifetime: lives until explicitly deleted or system shutdown
1. Name: 255 chars max
1. Linking: requires [`librt`](TODO)


## ~~System V Shared memory~~ (legacy)
1. Similar to above

## Memory Mapped file
1. Reference: pathname or file descriptor
1. Lifetime: lives in file system, across system reboots
1. Lifetime: must be explicitly deleted
1. IO: any store to the mapped file segment results in implicit I/O


## Fileless Memory Mapping
1. TODO



--------
# Net (Sockets)
1. Access: determined by file permissions
1. Domain: Sockets are the ONLY option for IPC across host machines
1. Lifetime: Both sender and receiver need a Socket (Server binds to known address/name)
1. Lifetime: name/identifier lives in file system
1. Lifetime: Socket is dropped when no process has it open
1. Connection: Operate in pairs
1. Def: AF == Address Family == Domain


## ~~Datagram~~
1. eg. [UDP](TODO) - OSI Layer 4
1. Delim: Delimited messages
1. Delim: Message boundaries preserved
1. Order: out-of-order
1. Read: must read message fully (no partial)
1. Reliability:  duplicated, or no-delivery possible
1. Reliability: delivery NOT guaranteed/reliable


## Unix Domain Socket (non-networked)
1. Domain: communication on same host machine
1. Languages: C: [`sockaddr_un`](https://man7.org/linux/man-pages/man7/unix.7.html#DESCRIPTION)
1. Languages: C#: [`UnixDomainSocketEndPoint`](https://docs.microsoft.com/en-us/dotnet/api/system.net.sockets.unixdomainsocketendpoint?view=net-6.0)
1. Languages: Dart: [`Internet Address`](https://api.flutter.dev/flutter/dart-io/InternetAddress-class.html)
1. Languages: Go: [`UnixAddr`](https://pkg.go.dev/net#UnixAddr)
1. Languages: Java/JVM: [`UnixDomainSocketAddress`](https://docs.oracle.com/en/java/javase/17/docs/api/java.base/java/net/UnixDomainSocketAddress.html)
1. Languages: Python: [`socket`](https://docs.python.org/3/library/socket.html)
1. Languages: Rust: [`std::os::unix::net::UnixListener`](https://doc.rust-lang.org/std/os/unix/net/struct.UnixListener.html) and [`std::os::unix::net::UnixStream`](https://doc.rust-lang.org/std/os/unix/net/struct.UnixStream.html)
1. Lifetime: lives in file system, must be deleted explicitly
1. Name: [`AF_UNIX`](https://man7.org/linux/man-pages/man7/unix.7.html#DESCRIPTION)
1. Reference: (absolute) pathname or file descriptor
1. Reference: socket bound one-to-one with file path
1. Security: don't use /tmp since you have less control over permissions
1. Security: permissions determined by (socket) file permissions
1. Speed: communication happens in kernel-space
1. Speed: faster than Internet domain sockets


## Internet Domain Socket / TCP (networked)
1. Concept: IP layer adds IP address header (connectionless, unreliable)
1. Concept: TCP layer adds ports, sequence #, ack, checksums, flow-control, congestion-control, ... headers
1. Domain: same or different host machines
1. Lifetime: TODO
1. Reference:
1. Security: handled in higher-level protocol
1. Speed: TCP ([OSI Layer 4](https://en.wikipedia.org/wiki/Transport_layer)) and IP ([OSI Layer 3](https://en.wikipedia.org/wiki/Network_layer)) are in kernel space


## WebSockets
1. Languages: C [`TODO`](TODO)
1. Languages: Dart [`TODO`](TODO)
1. Languages: Go [`TODO`](TODO)
1. Languages: Java/JVM [`TODO`](TODO)
1. Languages: Python [`TODO`](TODO)
1. Languages: Rust [`websocket`](https://docs.rs/websocket/latest/websocket/) crate


--------
# Local Data transfer
1. Direction: Can only communicate in one direction
1. Read: Readers block until data available
1. Speed: Requires copying data twice between user-space and kernel-space
1. Sync: reader/writer synchronization is not required (automatic, by kernel)


## FIFO == Named Pipe
1. Access: determined by file permissions
1. Compatible with epoll (simultaneous monitoring of multiple file descriptors)
1. Concept: data queues with file names
1. Delim: Undelimited byte stream
1. Delim: use delim chars, message headers containing length or fixed-length messages
1. Domain: same host machine  TODO: even more restrictive than this
1. Lifetime: FIFO is dropped when no process has it open
1. Lifetime: name/identifier lives in file system
1. Priority: roll your own
1. Read: reads are destructive
1. Reference: named in a directory
1. Reference: Use pathname or file descriptor


## Pipe (Anonymous)
1. Concept: anonymous data queues
1. Delim: framing challenges, messages can be intermingled
1. Delim: Undelimited byte stream
1. Domain: Processes must share common ancestor
1. Protocol: must roll your own protocol
1. Read: reads are destructive
1. Reference: Use file descriptor to reference


## POSIX Message Queues
1. API: [`mq_open`](TODO), [`mq_close`](TODO), [`mq_send`](TODO), [`mq_receive`](TODO)
1. Async: allows async notification
1. Delim: Delimited messages
1. Delim: Messages are passed as blocks of arbitrary size, not as byte streams
1. Domain: same host machine
1. Header: [`mqueue.h`](TODO)
1. Language: 3rd party lib for golang, rust, java (jvm), python
1. Language: native to c
1. Lifetime: lives until explicitly deleted or system shutdown (reference counted by kernel)
1. Linking: requires [`librt`](TODO)
1. Name: 255 chars max
1. Priority: allows message prioritization (assign an `int`)
1. Read: must read message fully (no partial)
1. Read: reads are destructive
1. Reference: [`mqd_t`](TODO)
1. Reference: IPC pathname? TODO
1. Reference: message queue descriptor is per-process (same as file-descriptors)


## ~~System V Message Queues~~ (legacy)
1. Similar to newer POSIX message queues


--------
# Synchronization
1. Required for shared memory coordination


## POSIX semaphores (named)
1. Header: [`sys/mman.h`](https://man7.org/linux/man-pages/man0/semaphore.h.0p.html)
1. Header: [`semaphore.h`](TODO)
1. Useful for coordinating access to shared memory
1. Kernel maintained uint
1. Reference: [`sem_t`](TODO
1. Reference: IPC pathname? TODO
1. Lifetime: lives until explicitly deleted or system shutdown
1. API: [`sem_open`](TODO), [`sem_close`](TODO), [`sem_post`](TODO), [`sem_wait`](TODO)
1. Linking: requires [`librt`](TODO)


## ~~System V semaphores~~ (legacy)
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

## Net / Socket / IP Socket
1. Reference: IP address + port

## Net / IP / TCP / gRPC

## Net / IP / TCP / HTTP / REST


# Other resources
1. https://docs.oracle.com/cd/E19504-01/802-5882/6i9k22elq/index.html
1. https://www.softprayog.in/programming/interprocess-communication-using-posix-shared-memory-in-linux
1. https://opensource.com/article/19/4/interprocess-communication-linux-storage
