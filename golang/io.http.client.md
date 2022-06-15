# Overview
1. HTTP Client examples


# Key Concepts
1. builtin http client is robust & feature rich
1. builtin http client handles cancellation, timeout, deadline expiration
1. chi [Timeout middleware](https://pkg.go.dev/github.com/go-chi/chi/middleware#Timeout) sets deadline on [requests idiomatically](https://github.com/go-chi/chi/blob/master/middleware/timeout.go#L36)


# Examples
1. Assuming things like this are defined:
```go
type FooId string

type Foo struct {
	Id FooId
}

// Previously initialized
// Threadsafe & reusable
var client http.Client
```


# Example: HTTP GET
```go
// ListFoos makes HTTP GET call to REST endpoint
// Service returns slice of entities (possibly nil)
func ListFoos(
	ctx context.Context,
	baseURI string) ([]Foo, error) {

	// -- Build req
	req, err := http.NewRequestWithContext(
		ctx,
		http.MethodGet,
		// NOTE: Append any other url params here
		baseURI+"/foo",
		nil)
	if err != nil {
		// TODO: log extra details here
		return nil, err
	}

	// -- Req headers
	// TODO: set Auth/Bearer header here

	// -- Call
	resp, err := client.Do(req) // Auto-handles context cancellation
	if err != nil {
		// TODO: log extra details here
		// NOTE: timeouts come here
		return nil, err
	}
	defer resp.Body.Close()

	// -- Parse resp
	if resp.StatusCode != http.StatusOK {
		// TODO: log extra details here
		return nil, fmt.Errorf("unexpected statusCode=%v", resp.StatusCode)
	}

	b, err := io.ReadAll(resp.Body)
	if err != nil {
		// TODO: log extra details here
		return nil, err
	}

	output := make([]Foo, 0, 64)
	err = json.Unmarshal(b, &output)
	if err != nil {
		// TODO: log extra details here
		return nil, err
	}

	return output, nil
}
```


# Example: HTTP POST
```go
// CreateFoo makes HTTP POST call to REST endpoint
// Service persists and returns generated ID for new entity
func CreateFoo(
	ctx context.Context,
	foo Foo,
	baseURI string) (FooId, error) {

	// -- Build req body
	reqBody, err := json.Marshal(foo)
	if err != nil {
		// TODO: log extra details here
		return "", err
	}

	// -- Build req
	req, err := http.NewRequestWithContext(
		ctx,
		http.MethodPost,
		baseURI+"/foo",
		bytes.NewBuffer(reqBody))
	if err != nil {
		// TODO: log extra details here
		return "", err
	}

	// -- Req headers
	req.Header.Set("Content-Type", "application/json")
	// TODO: set Auth/Bearer header here

	// -- Call
	resp, err := client.Do(req) // Auto-handles context cancellation
	if err != nil {
		// TODO: log extra details here
		// NOTE: timeouts come here
		return "", err
	}
	defer resp.Body.Close()

	// -- Parse resp
	if resp.StatusCode != http.StatusOK {
		// TODO: log extra details here
		return nil, fmt.Errorf("unexpected statusCode=%v", resp.StatusCode)
	}

	b, err := io.ReadAll(resp.Body)
	if err != nil {
		// TODO: log extra details here
		return "", err
	}

	return FooId(b), nil
}
```


# Idioms
1. Reuse `http.Client`

- TODO: opentelemetry B3 header propagation


# Debugging
1. use [`httputil.DumpRequest(...)`](https://pkg.go.dev/net/http/httputil#DumpRequest)


# Other resources
1. https://www.practical-go-lessons.com/chap-35-build-an-http-client
1. https://pkg.go.dev/net/http
1. https://gobyexample.com/http-clients
1. https://zetcode.com/golang/http-client/
1. https://blog.logrocket.com/configuring-the-go-http-client/
