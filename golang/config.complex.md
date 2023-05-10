# Overview
1. A rich example of config parsing with [Viper](https://github.com/spf13/viper)
1. See [Simpler example](./config.simple.md)


# Complex Example
1. Put this into `config.go` for each command (eg. `/foo/cmd/mycmd/config.go`)
1. Handles explicit config file or can search for config file
1. Configurable search paths
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


// Determines where to search for config file
// Only used when no explicit config file passed
//
// Syntax allows
// - absolute path
// - path relative to working dir
// - path prefixed with $HOME
// - path with env variable (handled via os.ExpandEnv)
//
// TODO: replace foo with your app name
var configSearchDirs = []string{
    "/etc/foo",
    "$HOME/.foo",
    ".",
    "..",
}

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
    err := setPathConfigForViper(
        v,
        osArgs,
        configSearchDirs)
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

    // -- Set defaults
    // alternatively: https://github.com/spf13/viper#establishing-defaults
    c.setDefaults()

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
func setPathConfigForViper(
	v *viper.Viper,
	osArgs OSArgs,
	searchDirs []string) error {

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
	for _, dir := range searchDirs {
		v.AddConfigPath(dir)
	}

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

	// TODO: setup zap here

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
