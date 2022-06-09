# Overview
1. TODO ...


# Key Concepts


# Example: HTTP POST
1. Assuming things like this exist:
```go
type FooId string

type Foo struct {
	Id FooId
}

// Previously initialized
// Threadsafe & reusable
var client http.Client
```
1. Call:
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

	// -- If response contains entities ...
	/*
		var f Foo
		err = json.Unmarshal(b, &f)
		if err != nil {
			return 0, err
		}

		return f, nil
	*/
}

```


# Idioms
1. Reuse `http.Client`


- TODO: context for cancellation
- TODO: opentelemetry


# Other resources
1. https://www.practical-go-lessons.com/chap-35-build-an-http-client

