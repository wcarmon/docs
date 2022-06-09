# Overview
- Goroutines, concurrency, parallelism, ...


# Key concepts
1. Concurrency and Parallelism are different
    1. Concurrency: structuring code for independent execution
    1. Parallelism: **simultaneous** execution, a runtime concept
    1. [Concurrency vs Parallelism](https://medium.com/technofunnel/understanding-golang-and-goroutines-72ac3c9a014d)
    1. TODO: more here
1. Go runtime spawns enough threads to ensure [`GOMAXPROCS`](https://pkg.go.dev/runtime#GOMAXPROCS) threads are running
    1. [GOMAXPROCS](https://pkg.go.dev/runtime#:~:text=The%20GOMAXPROCS%20variable%20limits%20the,count) env variable
    1. defaults to number of logical cores available
1. Get available thread count
```go
fmt.Println("%d", runtime.GOMAXPROCS(0))
```


# Goroutine concepts
1. Goroutines are non-preemptive (cancellation is cooperative)
1. Everything in go is executed as a goroutine
    1. main function (goroutine) is created automatically
1. Goroutines are much lighter than threads
    1. Threads are lighter than processes
    1. python and node are limited to processes (threads & green-threads aren't available or performant)
1. go scheduler runs as a goroutine
1. TODO: continuations
1. `main` function will NOT wait for spawned goroutines, so you must **explicitly** wait
1. Debugging goroutine programs is harder, bugs have more places to hide
1. Goroutines have multiple places for suspension & reentry (managed by the runtime)
    1. [`time.Sleep`](https://pkg.go.dev/time)
    1. Before/After a function invocation
1. TODO: `runtime.NumGoroutine()`

# Idioms
1. Do most "sharing" via channels (90%)
1. Minimize use of mutex (10%)
    1. Use to guard internal state variable
1. Don't make assumptions about goroutine scheduling order
1. goroutines must not return a value directly, share thru [channels](./concurrency.channels.md) (or shared/protected variable)


- TODO race detector


TODO: http://golang.org/doc/articles/concurrency_patterns.html


# Other resources
1. https://gobyexample.com/goroutines
1. https://go.dev/tour/concurrency/1
1. https://golangbot.com/goroutines/
1. https://www.golangprograms.com/goroutines.html
1. https://www.golang-book.com/books/intro/10
1. https://unexpected-go.com/goroutines-on-loops.html
