# Overview
1. A simple example of config parsing with [Viper](https://github.com/spf13/viper)
1. See [Complex example](./config.complex.md)


# Simple Example
1. Put this into `config.go` for each command (eg. `/foo/cmd/mycmd1/config.go`)
```go
import (
	"errors"
	"github.com/spf13/viper"
	"path/filepath"
)

type appConfig struct {

	// debug, info, warn, error
	LogLevel   string

	InputPath  string `json:"inputPath"`
	OutputPath string `json:"outputPath"`

	// TODO: Aligned with yaml config file structure
}


// Load reads from config file, env vars, ...
// Pass os.Args
func BuildConfig(osArgs []string) (*appConfig, error) {
	v := viper.New()

	// -- Set paths for config file
	err := setPathConfigForViper(v, osArgs)
	if err != nil {
		return nil, err
	}

	v.SetConfigType("yaml")

	// -- Parse config
	err = v.ReadInConfig()
	if err != nil {
		return nil, err
	}

	// -- Store into config struct
	var c appConfig
	err = v.Unmarshal(&c)
	if err != nil {
		return nil, err
	}

	// -- Validation
	err = validateConfig(&c)
	if err != nil {
		return nil, err
	}

	return &c, err
}


func validateConfig(cfg *appConfig) error {
	// TODO: do any validation here

	return nil
}


// Pass os.Args
func setPathConfigForViper(v *viper.Viper, osArgs []string) error {

	if v == nil {
		return errors.New("viper instance is required")
	}

	if len(osArgs) <= 1 {
		return errors.New("pass config file path as command line argument")
	}

	// -- Set config path to passed path
	cfgPath := osArgs[1]

	v.SetConfigName(filepath.Base(cfgPath))
	v.AddConfigPath(filepath.Dir(cfgPath))
	return nil
}
```

# Main func
1. Put this into `main.go` for each command
```go
func main() {

    // TODO: setup zerolog here

	cfg, err := BuildConfig(os.Args)
	if err != nil {
		log.Error().
			Err(err).
			Str("cfg", fmt.Sprintf("%#v", cfg)).
			Msg("Failed to parse config")
		os.Exit(1)
	}

    // TODO: use cfg here

}
```
