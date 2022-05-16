# Overview
- Bounded waiting (timeout)


# Idioms
1. Avoid unbounded waiting


# Example
```go
func main() {

    timeout := 5 * time.Second

    done := make(chan struct{}, 1)

    go doExpensiveTask(done)

    // -- Wait for first of ...
    select {
    case _ = <-done:
        // -- wait for task to finish
        fmt.Printf("Finished task\n")

    case <-time.After(timeout):
        // -- wait for timer
        fmt.Printf("Timeout\n")
    }
}

func doExpensiveTask(done chan<- bool) {
    defer func() { done <- true }()

    time.Sleep(3 * time.Second)
}
```


# Other resources
1. [gobyexample](https://gobyexample.com/timeouts)
1. [golangr](https://golangr.com/timeout)
1. [golangbyexample](https://golangbyexample.com/select-statement-with-timeout-go)
1. https://faun.pub/implmenting-timeout-in-golang-ee2bc4aa6ae4