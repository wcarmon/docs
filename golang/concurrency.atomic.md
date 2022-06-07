# Overview
- Patterns for atomic statements


- TODO: atomic increment
- TODO: atomic compare-and-swap


# sync.Mutex
1. Example
```go
type SafeWidget struct {
	mu             sync.Mutex // guards stateToProtect
	stateToProtect []string
}

// Return a defensive copy
func (w SafeWidget) StateToProtect() []string {
	shallowCopy := make([]string, len(w.stateToProtect))
	copy(shallowCopy, w.stateToProtect)

	return shallowCopy
}

func (w *SafeWidget) AppendToState(v string) {
	w.mu.Lock()
	defer w.mu.Unlock()

	w.stateToProtect = append(w.stateToProtect, v)
}
```


# sync.RWMutex
1. Performance optimization over `sync.Mutex`
1. Allows multiple readers
1. Example
```go
// TODO
```


# Idioms
1. Minimize scope (package/local variable)
1. Keep private (do NOT expose)
1. group with collection it protects (eg. map, slice, ...)
    1. See [variables](./variables.md) doc
- TODO ...



# Other resources
1. https://pkg.go.dev/sync#RWMutex
