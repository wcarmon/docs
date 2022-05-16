# Overview
- Example of Fan-in, Fan-out pattern


# Example
```go
func main() {

	taskCount := 5

	var wg sync.WaitGroup

	// -- Decide how many to wait for
	wg.Add(taskCount)

	for taskId := 0; taskId < taskCount; taskId++ {

		// -- pass args since they change each loop iter
		go func(
			wg *sync.WaitGroup,
			taskId int) {
			defer wg.Done()

			doSomeWork(taskId)
		}(&wg, taskId) // pass wg struct by ref
	}

	// -- Wait for n calls to wg.Done
	wg.Wait()
}

func doSomeWork(taskId int) {
    fmt.Printf("Finished %d\n", taskId)
}
```


# Notes
1. This would be difficult with channels since you'd need to know when to `close(...)`


# Other resources
1. [GoByExample](https://gobyexample.com/waitgroups)
1. [Official docs](https://pkg.go.dev/sync#WaitGroup)
