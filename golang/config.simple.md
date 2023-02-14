# Overview
1. A simple example of config parsing with [Viper](https://github.com/spf13/viper)
1. See [Complex example](./config.complex.md)


# Simple Example
1. Put this into `conf.go` for each command (eg. `$PROJ_ROOT/src/cmd/run-server/conf.go`)
```go
import (
	"errors"
	"github.com/spf13/viper"
	"path/filepath"
)

const (
	configFileType        = "toml"
	defaultConfigFilePath = "app.conf.toml"
)

// maybe move to conf_model.go
// keep structure aligned with app.conf.toml
type appConf struct {

	// GOTCHA: unexported fields are ignored by viper/mapstructure

	// debug, info, warn, error
	LogLevel string `toml:"logLevel"`

	InputPath  string `toml:"inputPath"`
	OutputPath string `toml:"outputPath"`

	JWT struct {
		Issuer          string `toml:"issuer"`
		MaxAgeInMinutes int    `toml:"maxAgeInMinutes"`
		SharedKey       string `toml:"sharedKey"`
	} `toml:"jwt"`

	// TODO: Align with toml config file structure
}

// maybe move to conf_model.go
func (c appConf) Validate() error {
	if strings.TrimSpace(c.InputPath) == "" {
		return errors.New("inputPath is required")
	}

	if strings.TrimSpace(c.OutputPath) == "" {
		return errors.New("outputPath is required")
	}

	// TODO: do other validation here

	return nil
}

// Use os.Args
// Simplifies dependency injection
type OSArgs []string


// Load reads from config file, env vars, ...
// Pass os.Args
func NewConfig(osArgs OSArgs) (*appConf, error) {
	v := viper.New()

	// -- Set paths for config file
	err := setPathConfigForViper(v, osArgs)
	if err != nil {
		zap.L().Error("failed to init viper", zap.Error(err))

		return nil, err
	}

	v.SetConfigType(configFileType)

	// -- Allow env vars to override config file
	// -- NOTE: use v.AllKeys() to print all available keys (for 1st arg below)
	// v.BindEnv("db.user", "DB_USER")
	// v.BindEnv("db.pass", "DB_PASS")

	// -- Parse config
	err = v.ReadInConfig()
	if err != nil {
		zap.L().Error("failed to read config using viper", zap.Error(err))

		return nil, err
	}

	var c appConf

	// -- Set defaults
	// alternatively: https://github.com/spf13/viper#establishing-defaults
	c.setDefaults()

	extraViperConfig := func(config *mapstructure.DecoderConfig) {
		// extras/unused
		config.ErrorUnused = true

		// missing/implicit
		config.ErrorUnset = false
	}

	// -- Store into config struct
	err = v.Unmarshal(&c, extraViperConfig)
	if err != nil {
		zap.L().Error("failed to unmarshal config", zap.Error(err))

		return nil, err
	}

	// -- Validate
	err = c.Validate()
	if err != nil {
		zap.L().Error("invalid config",
			zap.Error(err),
			zap.String("config", fmt.Sprintf("%#v", c)),
		)

		return nil, err
	}

	return &c, err
}


// Pass os.Args
func setPathConfigForViper(v *viper.Viper, osArgs OSArgs) error {

	if v == nil {
		return errors.New("viper instance is required")
	}

	var cfgPath string
	if len(osArgs) <= 1 {
		p, err := filepath.Abs(filepath.Clean(defaultConfigFilePath))
		if err != nil {
			panic("coding error: invalid defaultConfigFilePath: " + defaultConfigFilePath)
		}

		cfgPath = p
		fmt.Printf("defaulting conf to: path=%v\n", cfgPath)
		fmt.Printf("to override conf path, pass it as a cli argument")

	} else {
		cfgPath = osArgs[1]
	}

	v.SetConfigName(filepath.Base(cfgPath))
	v.AddConfigPath(filepath.Dir(cfgPath))
	return nil
}

// maybe move to conf.defaults.go
func (c *appConf) setDefaults() {
	if strings.TrimSpace(c.LogLevel) == "" {
		c.LogLevel = "debug"
	}

	//TODO: set other defaults here (for blank/nil field)
}
```

# Main func
1. Put this into `main.go` for each command
```go
// Entry point
// Command line Args:
// 1. path to app.conf.toml file
func main() {

	// TODO: setup zerolog here

	// TODO: if using wire, make this a provider instead
	// and add wire.Value(OSArgs(os.Args))
	cfg, err := NewConfig(os.Args)
	if err != nil {
	    zap.L().Error("failed to parse config",
	        zap.Error(err),
	        zap.String("cfg", fmt.Sprintf("%#v", cfg)),
        )

		os.Exit(1)
	}

	// TODO: use cfg here
}
```
