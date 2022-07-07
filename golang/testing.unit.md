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


# Fixtures & testdata
1. Use `testdata` directory in the package
1. Official examples (70+)
    - [archive/tar/testdata](https://go.dev/src/archive/tar/testdata)
    - [archive/zip/testdata](https://go.dev/src/archive/zip/testdata)
    - [compress/bzip2/testdata](https://go.dev/src/compress/bzip2/testdata)
    - [compress/flate/testdata](https://go.dev/src/compress/flate/testdata)
    - [compress/testdata](https://go.dev/src/compress/testdata)
    - [crypto/tls/testdata](https://go.dev/src/crypto/tls/testdata)
    - [crypto/x509/testdata](https://go.dev/src/crypto/x509/testdata)
    - [encoding/json/testdata](https://go.dev/src/encoding/json/testdata)
    - [html/template/testdata](https://go.dev/src/html/template/testdata)
    - [image/png/testdata](https://go.dev/src/image/png/testdata)
    - [image/testdata](https://go.dev/src/image/testdata)
    - [mime/multipart/testdata](https://go.dev/src/mime/multipart/testdata)
    - [mime/testdata](https://go.dev/src/mime/testdata)
    - [net/http/testdata](https://go.dev/src/net/http/testdata)
    - [net/testdata](https://go.dev/src/net/testdata)
    - [os/testdata](https://go.dev/src/os/testdata)
    - [regexp/testdata](https://go.dev/src/regexp/testdata)
    - [text/template/testdata](https://go.dev/src/text/template/testdata)
    - [time/testdata](https://go.dev/src/time/testdata)

# TODO/Organize these
- TODO: just link to  https://www.practical-go-lessons.com/chap-19-unit-tests
- TODO: explain t.log
- TODO: explain _test package suffix
- TODO: explain subtests
- TODO: explain table driven tests (show examples from sdk sources)
- TODO: explain t.Parallel
- TODO: test deadlines
- TODO: explain t.Errorf
- TODO: using reflect.DeepEqual to compare structs - https://pkg.go.dev/reflect#DeepEqual
- TODO: got & want  (not expected & actual)  <-- examples from official


# Other resources
1. [Official testing package](https://pkg.go.dev/testing)
1. https://www.practical-go-lessons.com/chap-19-unit-tests
1. https://go.dev/doc/tutorial/add-a-test
1. [digitalocean](https://www.digitalocean.com/community/tutorials/how-to-write-unit-tests-in-go-using-go-test-and-the-testing-package)
1. https://blog.alexellis.io/golang-writing-unit-tests/
1. [testify lib](https://github.com/stretchr/testify)