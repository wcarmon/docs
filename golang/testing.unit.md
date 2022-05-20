# Overview
- Patterns for [Unit testing](https://en.wikipedia.org/wiki/Unit_testing)
- See [e2e testing](./testing.e2e.md) doc


# Setup & Teardown
```go
func TestMain(m *testing.M) {
	setup()
	code := m.Run()
	teardown()
	os.Exit(code)
}

func setup() {
    // more here
}

func teardown() {
    // more here
}
```

- TODO: explain t.log
- TODO: explain _test package suffix
- TODO: explain subtests
- TODO: explain table driven tests (show examples from sdk sources)
- TODO: explain t.Parallel
- TODO: explain t.Errorf
- TODO: explain t.Fatalf
- TODO: testdata dir (not fixtures)  <-- examples from official
- TODO: got & want  (not expected & actual)  <-- examples from official

# Idioms
- TODO ...


# Other resources
1. TODO ...
