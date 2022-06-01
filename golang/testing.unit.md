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


# Failures

- TODO: use t.Errorf() + t.Fail() instead of t.Fatalf since it breaks some parallel things and goland output printing


- TODO: explain t.log
- TODO: explain _test package suffix
- TODO: explain subtests
- TODO: explain table driven tests (show examples from sdk sources)
- TODO: explain t.Parallel
- TODO: explain t.Errorf
- TODO: using reflect.DeepEqual to compare structs - https://pkg.go.dev/reflect#DeepEqual
- TODO: testdata dir (not fixtures)  <-- examples from official
- TODO: got & want  (not expected & actual)  <-- examples from official

# Idioms
- TODO ...


# Other resources
1. [Official testing package](https://pkg.go.dev/testing)
1. https://go.dev/doc/tutorial/add-a-test
1. [testify lib](https://github.com/stretchr/testify)
1. [digitalocean](https://www.digitalocean.com/community/tutorials/how-to-write-unit-tests-in-go-using-go-test-and-the-testing-package)
1. https://blog.alexellis.io/golang-writing-unit-tests/
