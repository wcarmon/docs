# Overview
1. TODO ...


# Key Concepts


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
// Calls REST endpoint with HTTP GET
// Service returns slice of entities
func ListFoos(
	ctx context.Context,
	baseURI string) ([]Foo, error) {

	// -- Build req
	req, err := http.NewRequestWithContext(
		ctx,
		http.MethodGet,
		baseURI+"/foo",
		nil)
	if err != nil {
		// TODO: log extra details here
		return nil, err
	}

	// -- Req headers
	// TODO: set Auth header here

	// -- Call
	resp, err := client.Do(req) // Auto handles context cancellation
	if err != nil {
		// TODO: log extra details here
		return nil, err
	}
	defer resp.Body.Close()

	// -- Parse resp
	if resp.StatusCode != http.StatusOK {
		// ...
	}

	b, err := io.ReadAll(resp.Body)
	if err != nil {
		// TODO: log extra details here
		return nil, err
	}

	items := make([]Foo, 0, 64)
	err = json.Unmarshal(b, &items)
	if err != nil {
		// TODO: log extra details here
		return nil, err
	}

	return items, nil
}
```


# Example: HTTP POST
```go
// Calls REST endpoint with HTTP POST
// Service returns ID for persisted entity
func CreateFoo(
	ctx context.Context,
	foo Foo,
	baseURI string) (FooId, error) {

	// -- Serialize body
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
	// TODO: set Auth header here

	// -- Call
	resp, err := client.Do(req) // Auto handles context cancellation
	if err != nil {
		// TODO: log extra details here
		return "", err
	}
	defer resp.Body.Close()

	// -- Parse resp
	if resp.StatusCode != http.StatusOK {
		// ...
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

- TODO: opentelemetry


# Other resources
1. https://www.practical-go-lessons.com/chap-35-build-an-http-client

