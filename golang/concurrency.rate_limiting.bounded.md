# Overview
- Example of rate-limiting (Bounded parallelism) pattern


# Example
```go
func main() {
    maxParallel := 3

    semaphoreCh := make(chan struct{}, maxParallel)
    defer close(semaphoreCh)

    // -- Spawn tasks
    for taskId := 0; taskId < 50; taskId++ {
        semaphoreCh <- struct{}{} // reserve a slot (blocking)

        go func(taskId int) {
            simulateSlowTask(taskId)
            <-semaphoreCh // free the slot
        }(taskId)
    }

    // -- Wait for all the tasks to complete
    // In practice, use a WaitGroup or done chan
    time.Sleep(3 * time.Minute)
}

func simulateSlowTask(taskId int) {
    // -- Do the slow task
    fmt.Printf("BEGIN: %v\n", taskId)
    time.Sleep(6 * time.Second) // simulate slow task
    fmt.Printf("END: %v\n", taskId)
}
```


# Other Resources
1. [time.Sleep](https://pkg.go.dev/time#Sleep)
1. [channels](./concurrency.channels.md) doc
1. https://gobyexample.com/rate-limiting
1. https://yourbasic.org/golang/wait-for-goroutines-waitgroup/
