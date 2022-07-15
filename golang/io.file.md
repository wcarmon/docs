# Overview
1. TODO

# Temp files
```go

// linux:   /tmp/prefix.<random-numbers>.suffix
// mac:     /var/folders/<random-numbers>/prefix.<random-numbers>.suffix
// windows: ? (see os.TempDir())
f, err := os.CreateTemp("", "prefix.*.suffix")
if err != nil { ... }

defer os.Remove(f.Name())
```


# Other resources
1. https://www.practical-go-lessons.com/chap-29-data-storage-files-and-databases
