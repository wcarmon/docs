# Overview
- Idioms for managing xml


# Struct idioms
1. Set name of current `struct` via XMLName
    - eg. `XMLName xml.Name `xml:"the-root-element-name"`

## Parent/Child
1. Parent MUST specify child tag name on attribute
1. Child can optionally include `XMLName xml.Name`


# Unmarshal (Parsing, Deserializing)
1. TODO


# Marshal (Writing, Serializing)
1. TODO


# Sort
1. TODO


# Idioms
1. TODO ...
1. There is no support for unknown attributes (silently ignored)
    1. https://github.com/golang/go/issues/30301


- TODO: empty tag with />

# Other resources
1. https://gobyexample.com/xml
1. https://pkg.go.dev/encoding/xml
