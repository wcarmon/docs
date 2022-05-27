# Overview
- Example of rate-limiting (Bounded parallelism) pattern


# Example
```go
func main() {
    maxParallel := 3

    semaphoreChan := make(chan struct{}, maxParallel)
    defer func() {
        close(semaphoreChan)
    }()

    // -- Create n permits
    for i := 0; i < maxParallel; i++ {
        semaphoreChan <- struct{}
    }

    // -- Spawn tasks
    for taskId := 0; taskId < 999; taskId++ {
        go simulateSlowTask(taskId, semaphoreChan)
    }

    // -- Wait for all the tasks to complete
    // In practice, use WaitGroup or done chan
    time.Sleep(3 * time.Minute)
}

func simulateSlowTask(
    taskId int,
    semaphoreChan chan struct{}) {

    // -- Wait for permit
    <-semaphoreChan

    // -- Return permit when finished
    defer func() {
        semaphoreChan <- struct{}
    }()

    // -- Do the slow task
    fmt.Printf("BEGIN: %v\n", taskId)
    time.Sleep(6 * time.Second) // simulate slow task
    fmt.Printf("END: %v\n", taskId)
}
```


# Other resources
1. [time.Sleep](https://pkg.go.dev/time#Sleep)
1. [channels](./concurrency.channels.md) doc
1. https://gobyexample.com/rate-limiting
1. https://yourbasic.org/golang/wait-for-goroutines-waitgroup/
