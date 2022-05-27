# Overview
- Bounded waiting (timeout)


# Idioms
1. Avoid unbounded waiting


# Example
```go
func main() {

    timeout := 5 * time.Second

    done := make(chan struct{}, 1)

    go doSlowTask(done)

    // -- Wait for first of ...
    select {
    case <-done:
        // -- wait for task to finish
        fmt.Println("Finished task")

    case <-time.After(timeout):
        // -- wait for timer
        fmt.Println("Timeout")
    }
}

func doSlowTask(done chan<- struct{}) {
    defer func() { done <-struct{} }()

    time.Sleep(3 * time.Second)
}
```


# Other resources
1. [go by example](https://gobyexample.com/timeouts)
1. [golangr](https://golangr.com/timeout)
1. [golangbyexample](https://golangbyexample.com/select-statement-with-timeout-go)
1. https://faun.pub/implmenting-timeout-in-golang-ee2bc4aa6ae4
