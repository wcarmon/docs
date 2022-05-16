# Overview
- Example of rate-limiting (Bounded parallelism) pattern


# Example
```go
func main() {
    maxParallel := 3

    semaphoreChan := make(chan bool, maxParallel)
    defer func() {
        close(semaphoreChan)
    }()

    // -- Create n permits
    for i := 0; i < maxParallel; i++ {
        semaphoreChan <- true
    }

    // -- Spawn tasks
    for taskId := 0; taskId < 999; taskId++ {
        go simulateSlowTask(taskId, semaphoreChan)
    }

    // -- Wait for all the tasks to complete
    time.Sleep(3 * time.Minute)
}

func simulateSlowTask(
    taskId int,
    semaphoreChan chan bool) {

    // -- Wait for permit
    _ = <-semaphoreChan

    // -- Return permit when finished
    defer func() {
        semaphoreChan <- true
    }()

    // -- Do the slow task
    fmt.Printf("BEGIN: %v\n", taskId)
    time.Sleep(6 * time.Second) // simulate slow task
    fmt.Printf("END: %v\n", taskId)
}
```


# Other resources
1. https://pkg.go.dev/time#Sleep
1. [channels](./concurrency.channels.md) doc
