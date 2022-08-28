# Overview
1. Idioms for TOML parsing


# Ignoring fields
```go
type Foo struct {
    ...
    IgnoredForParsing `toml:"-"`
    ...
}
```


# Parse Error handling
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

# Burnt Sushi
- use Metadata.Undecoded for "extra" fields
- use Metadata.IsDefined for "missing" fields
- use Unmarshal interface to self unmarshal 


# P


# Unfiled
- TODO: schema?
- TODO: detect duplicate assignment (overwrite)?
- TODO: idiom: setDefaults before unmarshal, setDerived after

# Other resources
1. https://github.com/pelletier/go-toml
