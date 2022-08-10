# Overview
1. Idioms for TOML parsing


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

# Other resources
1. https://github.com/pelletier/go-toml