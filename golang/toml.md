# Overview
1. Idioms for [toml](https://toml.io/en/) parsing
1. Best [2 Libraries](https://github.com/avelino/awesome-go#markup-languages) for [toml](https://toml.io/en/) parsing and generation


# Libraries
1. like [yaml](https://yaml.org/), [toml](https://toml.io/en/) is not in the [standard library](https://pkg.go.dev/std)


## [Pelletier](https://github.com/pelletier/go-toml)
1. Prefer this unless you have a strong reason not to
1. Use [`toml:"..."`](https://github.com/pelletier/go-toml#struct-tags-have-been-merged) to rename a field
1. Use [`encoding.TextUnmarshaler`](https://pkg.go.dev/encoding#TextUnmarshaler) interface (standard) to [self unmarshal](https://github.com/pelletier/go-toml/blob/v2/unmarshaler.go#L70)
1. Use [`Decoder.DisallowUnknownFields`](https://pkg.go.dev/github.com/pelletier/go-toml/v2#Decoder.DisallowUnknownFields) to prevent extra fields
    1. Aligned with [standard lib's json equivalent](https://pkg.go.dev/encoding/json#Decoder.DisallowUnknownFields)
1. TODO: add warnings for missing fields (strict mode)
1. **Pro**: Has utility to lint and format `toml` files: [`tomll`](https://github.com/pelletier/go-toml#tools)
1. **Con**: Uses [unsafe](https://github.com/pelletier/go-toml/blob/v2/internal/danger/danger.go#L12)
1. **Con**: cannot decode [Toml array](https://toml.io/en/v1.0.0#array) into Set (`map[string]struct{}` or `map[T]struct{}`)


## [BurntSushi](https://github.com/BurntSushi/toml)
1. Use [`toml:"..."`](https://github.com/BurntSushi/toml#examples) to rename a field
1. Use [`encoding.TextUnmarshaler`](https://pkg.go.dev/encoding#TextUnmarshaler) interface (standard) to self unmarshal
1. Use [`MetaData.Undecoded`](https://github.com/BurntSushi/toml/blob/master/meta.go#L82) for "extra" fields
    1. GOTCHA: not so useful since includes all primitives too
1. Use [`MetaData.IsDefined`](https://github.com/BurntSushi/toml/blob/master/meta.go#L28) for "missing" fields
1. **Con**: Doesn't handle cyclic types (infinite loop)
1. **Con**: API is less aligned with standard lib (eg. [`toml.Decode`](TODO) instead of `toml.Unmarshal`), arg is `string` instead of `[]byte`



# Example: Ignoring a field
```go
type Foo struct {
    ...
    IgnoredForParsing `toml:"-"`
    ...
}
```


# Pelletier Example: Error handling during parse
```go
...
err = toml.Unmarshal(data, &foo)
if err != nil {
    if de, ok := err.(*toml.DecodeError); ok {
        line, col := de.Position()

        log.Error().
            Caller().
            Err(err).
            Int("position.column", col).
            Int("position.line", line).
            Str("errMsg", de.Error()).
            Str("key", fmt.Sprintf("%v", de.Key())).
            Str("path", tomlInputPath).
            Msg("failed to parse toml data")

    } else {
        log.Error().
            Caller().
            Err(err).
            Str("path", tomlInputPath).
            Msg("failed to parse toml data")
    }

    return nil, err
}

...
```

# BurntSushi Example: Error handling during parse
```go
- TODO
```

# BurntSushi Example: print undecoded keys
```go
md, err := toml.Decode(data, &foo)
...
SprintfUndecodedKeys(md.Undecoded())
...

func SprintfUndecodedKeys(keys []toml.Key) string {
    out := make([]string, 0, len(keys))
    for _, k := range keys {
        out = append(out, strings.Join(k, "."))
    }

    return strings.Join(out, "\n")
}
```


# Gotchas
1. Unlike `json` & `yaml`, `toml` doesn't support schema
    1. *Counter*: Many of the json schema validators are buggy and abandonware (not current)
    1. yaml relies on json schema


# TODO:
- TODO: detect duplicate assignment (overwrite)?  <-- [spec says it's a parser failure](TODO)

# Other Resources
1. https://github.com/pelletier/go-toml
