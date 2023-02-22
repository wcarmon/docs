# Overview
- Example of Fan-in, Fan-out pattern


# Idioms
1. Build the tasks first (into a map or slice)



# Example
```go
func main() {

    tasks := make([]Task, 0, 10) // define the work

    results, err := ProcessTasksInParallel(context.Background(), tasks)
    ...
}

func ProcessTasksInParallel(ctx context.Context, tasks []Task) ([]MyResult, error) {

    resultsCh := make(chan MyResult, len(tasks))
    errCh := make(chan error, len(tasks))

    defer func() {
        close(errCh)
        close(resultCh)
    }()

    // -----------------------------------------
    // -- Fan-out section
    // -----------------------------------------
    for _, task := range tasks {
        // -- Spawn a goroutine for each task
        go processOneTask(ctx, resultsCh, errCh, task)
    }

    // -----------------------------------------
    // -- Fan-in section
    // -----------------------------------------
    output := make([]MyResult, 0, len(tasks))
    for i := 0; i < len(tasks); i++ {
        select {
        // -- wait for next result

        case result := <-resultsCh:
            // -- collect the successful results
            output = append(output, result)
        case err := <-errCh:
            // -- return early on first error
            return nil, err
        }
    }

    return output, nil
}

func processOneTask(
    ctx context.Context,
    resultCh chan<- MyResult,
    errCh chan<- error,
    task Task) {

    childCtx, span := otel.Tracer("").Start(ctx, "doSomething.parallel")
    defer span.End()

    data, err := doSomething(childCtx, task)
    if err != nil {
        errCh <- err
        return
    }

    resultCh <- data
}
```


# Notes
1. [`WaitGroup`](https://pkg.go.dev/sync) is useful when you don't know how many goroutines you will spawn


# Other Resources
1. [GoByExample](https://gobyexample.com/waitgroups)
1. [Official docs](https://pkg.go.dev/sync#WaitGroup)
