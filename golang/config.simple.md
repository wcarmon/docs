# Overview
1. A simple example of config parsing with [Viper](https://github.com/spf13/viper)
1. See [Complex example](./config.complex.md)


# Simple Example
```go
import (
	"errors"
	"github.com/spf13/viper"
	"path/filepath"
)

type appConfig struct {

	// debug, info, warn, error
	LogLevel string

	// TODO: other config properties here
	// Keep this aligned with the config file structure
}


// Load reads from config file, env vars, ...
// Pass os.Args
func (c *appConfig) Load(osArgs []string) error {
	v := viper.New()

	// -- Set paths for config file
	err := setPathConfigForViper(v, osArgs)
	if err != nil {
		return err
	}

	v.SetConfigType("yaml")

	// -- Parse config
	err = v.ReadInConfig()
	if err != nil {
		return err
	}

	// -- Store into this struct
	err = v.Unmarshal(&c)

	return err
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
