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


# Null handling
1. Important interfaces to implement:
    - [`driver.Valuer`](https://pkg.go.dev/database/sql/driver#Valuer) (one method: `Value`)
    - [`json.Marshaler`](https://pkg.go.dev/encoding/json#Marshaler) (one method: `MarshalJSON`)
    - [`json.Unmarshaler`](https://pkg.go.dev/encoding/json#Unmarshaler) (one method: `UnmarshalJSON`)
    - [`sql.Scanner`](https://pkg.go.dev/database/sql#Scanner) (one method: `Scan`)


# Idioms
- Use null types to distinguish unset values from zero values
    1. Runner-up: [guregu/null](https://github.com/guregu/null)
    1. See [rdbms](./rdbms.md) doc
1. [Goland can build structs from json](https://www.jetbrains.com/help/go/working-with-json.html)
1. GOTCHA: custom json Unmarshal method **not** called for Unexported fields (only Exported)
    1. Goland has an inspection for this


## Rejected tools
1. [kak-tus/nan](https://github.com/kak-tus/nan)
    1. Far too many deps (gocql, [etc](https://github.com/kak-tus/nan/blob/master/go.mod))


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
