# Overview
- How to read & write [json](https://www.json.org/json-en.html)


# Unmarshal (Parse, Deserialize, Decode)
1. Concept: Build struct with zero value, [`json.Unmarshal`](https://pkg.go.dev/encoding/json) sets properties
1. Recall `[]byte` <-> `string` conversion is cheap


# Marshal (Write, Serialize, Encode)
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
1. Use null types to distinguish unset values from zero values
    1. Runner-up: [guregu/null](https://github.com/guregu/null)
    1. See [rdbms](./rdbms.md) doc
1. [Goland can build structs from json](https://www.jetbrains.com/help/go/working-with-json.html)
1. GOTCHA: custom json Unmarshal method **not** called for **Unexported** fields (only Exported)
    1. Goland has an inspection for this
1. Use `DisallowUnknownFields` for strict unmarshal 
1. TODO: verify idiom: setDefaults before unmarshal, set derived after
1. Standard lib lacks support for [json5](https://json5.org/)


# Preferred tools
1. Just use nilable type (eg. `*int32`)
1. [guregu/null.v4](https://github.com/guregu/null/tree/v4.0.0)
1. [emvi/null](https://github.com/emvi/null)
    1. light & simple implementation
    1. tests
    1. zero external deps
    1. Con: doesn't support custom MarshalText/UnmarshalText (important for toml & yaml)


## Rejected tools
1. ~~[kak-tus/nan](https://github.com/kak-tus/nan)~~
    1. Far too many deps (gocql, [etc](https://github.com/kak-tus/nan/blob/master/go.mod))


# TODO: organize
- TODO: handling for missing properties
- TODO: handling for `$id` and `$schema`
- TODO: omitempty
- TODO: how to serialize (Marshal) properties alphabetical


# Alternatives
1. [mapstructure](https://github.com/mitchellh/mapstructure)
    1. Supports multiple serialization types
    1. Captures "remainder" or "extra" fields while unmarshaling
    1. Supports [Embedded Structs and Squashing](https://pkg.go.dev/github.com/mitchellh/mapstructure#hdr-Embedded_Structs_and_Squashing)
1. [jsoniter](http://jsoniter.com/go-tips.html)
    1. Supports private fields (unlike standard json serde)
    1. Supports field type encoders/decoders




# Other Resources
1. https://pkg.go.dev/encoding/json
1. https://gobyexample.com/json
1. https://linuxhint.com/marshal-unmarshal-golang/
1. http://choly.ca/post/go-json-marshalling/
1. https://thedeveloperblog.com/go/json-go
1. https://www.practical-go-lessons.com/chap-25-json-and-xml
1. https://yourbasic.org/golang/json-example/
