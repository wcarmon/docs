# Overview
- Example of Fan-in, Fan-out pattern


# Idioms
1. Build the tasks first (into a map or slice)



# Example
```go
func main() {
    tasks := make([]Task, 0, 10) // define the work

    results, err := ProcessTasksInParallel(context.Background(), tasks)
}

func ProcessTasksInParallel(ctx context.Context, tasks []Task) ([]MyResult, error) {

    // -- To determine when to close channels
    wg := &sync.WaitGroup{}

    // -- For sending results & errors from processor goroutines
    resultsCh := make(chan MyResult, len(tasks))
    errCh := make(chan error, len(tasks))

    // -- Ensure channels are eventually closed
	defer func() {
		// blocking, wait for all spawned goroutines to finish
		// spawned goroutines are the senders of channels below
		wg.Wait()

		close(errCh)
		close(resultCh)
	}()

    // -- Helps cancel goroutines if we stop early
	parallelCtx, cancel := context.WithCancel(ctx)
	defer cancel()

    // -----------------------------------------
    // -- Fan-out section
    // -----------------------------------------
    for _, task := range tasks {
        wg.Add(1)
        task := task // don't share reference with other goroutines

        // -- Spawn a goroutine for each task
		go func() {
			defer wg.Done()

			result, err := processOneTask(parallelCtx, task)
			if err == context.Canceled {
				otzap.AddDebugEvent(span, "cancelled parallel goroutine")
				return
			}

			if err != nil {
				otzap.AddErrorEvent(span, "failed to do the thing", err)
				errCh <- err
				return
			}

			resultCh <- result
		}()
    }

//TODO: rewrite from here down

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
