# Overview
1. Idioms for [toml](https://toml.io/en/) parsing
1. Best [2 Libraries](https://github.com/avelino/awesome-go#markup-languages) for [toml](https://toml.io/en/) parsing and generation


# Libraries
1. like [yaml](https://yaml.org/), [toml](https://toml.io/en/) is not in the [standard library](https://pkg.go.dev/std)

## [BurntSushi](https://github.com/BurntSushi/toml)
1. Prefer this unless you have a strong reason not to
1. Use [`toml:"..."`](https://github.com/BurntSushi/toml#examples) to rename a field
1. Use [`MetaData.Undecoded`](https://github.com/BurntSushi/toml/blob/master/meta.go#L82) for "extra" fields
    1. GOTCHA: not so useful since includes all primitives too
1. Use [`MetaData.IsDefined`](https://github.com/BurntSushi/toml/blob/master/meta.go#L28) for "missing" fields
1. Use [`encoding.TextUnmarshaler`](https://pkg.go.dev/encoding#TextUnmarshaler) interface (standard) to self unmarshal
1. **Con**: Doesn't handle cyclic types (infinite loop)


## [Pelletier](https://github.com/pelletier/go-toml)
1. Prefer [BurntSushi](https://github.com/BurntSushi/toml)
1. **Con**: Uses [unsafe](https://github.com/pelletier/go-toml/blob/v2/internal/danger/danger.go#L12)
1. **Pro**: Has utility to lint and format `toml` files: [`tomll`](https://github.com/pelletier/go-toml#tools)


# Example: Ignoring a field
```go
type Foo struct {
    ...
    IgnoredForParsing `toml:"-"`
    ...
}
```

# BurntSushi Example: Error handling during parse
```go
- TODO
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


# Gotchas
1. Unlike json & yaml, toml doesn't support schema
    1. Many of the json schema validators are buggy and abandonware (not current)
    1. yaml relies on json schema

# TODO:
- TODO: detect duplicate assignment (overwrite)?

# Other resources
1. https://github.com/pelletier/go-toml
