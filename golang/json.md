# Overview
- How to read & write [json](https://www.json.org/json-en.html)


# Unmarshal (Parsing, Deserializing)
1. Concept: Build struct with zero value, [`json.Unmarshal`](https://pkg.go.dev/encoding/json) sets properties
1. Recall `[]byte` <-> `string` conversion is cheap


# Marshal (Writing, Serializing)
1. TODO


# Idioms
- Use null types to distinguish unset values from zero values
    1. Recommended: [kak-tus/nan](https://github.com/kak-tus/nan)
    1. Runner-up: [guregu/null](https://github.com/guregu/null)
    1. See [rdbms](./rdbms.md) doc


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
1. https://thedeveloperblog.com/go/json-go
1. https://yourbasic.org/golang/json-example/
