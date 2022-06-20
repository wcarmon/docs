# Overview
- How to read & write [json](https://www.json.org/json-en.html)


# Unmarshal (Parsing, Deserializing)
1. Concept: Build struct with zero value, [`json.Unmarshal`](https://pkg.go.dev/encoding/json) sets properties
1. Recall `[]byte` <-> `string` conversion is cheap


# Marshal (Writing, Serializing)
1. TODO


# Custom Marshal
1. Like [`@JsonValue`](TODO) for jackson
```go
func (t *MyType) MarshalJSON() ([]byte, error) {

    // NOTE: alias MyType if you have recursive structure

    return json.Marshal(t.foo)
}
```

# Custom Unmarshal
1. Like [`@JsonCreator`](TODO) for jackson
1. GOTCHA: only works for Exported fields
```go
func (t *MyType) UnmarshalJSON(data []byte) error {

	var raw interface{}
	//var raw []interface{} <-- if you expect a list/array/slice
	if err := json.Unmarshal(data, &raw); err != nil {
		return err
	}

	//TODO: type assertion or switch on type

	t.Foo = ...

	return nil
}
```


# Idioms
- Use null types to distinguish unset values from zero values
    1. Recommended: [kak-tus/nan](https://github.com/kak-tus/nan)
    1. Runner-up: [guregu/null](https://github.com/guregu/null)
    1. See [rdbms](./rdbms.md) doc
1. [Goland can build structs from json](https://www.jetbrains.com/help/go/working-with-json.html)
1. GOTCHA: custom json Unmarshal method **not** called for Unexported fields (only Exported)
    1. Goland has an inspection for this


# TODO: organize
- TODO: handling for unrecognized properties (extras)
- TODO: handling for missing properties
- TODO: handling for $id and $schema
- TODO: omitempty
- TODO: how to serialize (Marshal) properties alphabetical


# Other resources
1. https://pkg.go.dev/encoding/json
1. https://gobyexample.com/json
1. https://linuxhint.com/marshal-unmarshal-golang/
1. http://choly.ca/post/go-json-marshalling/
1. https://thedeveloperblog.com/go/json-go
1. https://www.practical-go-lessons.com/chap-25-json-and-xml
1. https://yourbasic.org/golang/json-example/
