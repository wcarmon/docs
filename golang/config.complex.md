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


const defaultConfigFilename = "app.config.yaml"


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

// structure mirrors the config yaml file
type appConfig struct {

	// debug, info, warn, error
	LogLevel   string

	InputPath  string
	OutputPath string

	// TODO: Align with yaml config file structure
}


// os.Args
// Helps simplify dependency injection
type OSArgs []string


// Load reads from config file, env vars, ...
// Pass os.Args
func NewConfig(osArgs OSArgs) (*appConfig, error) {
	v := viper.New()

	// -- Set paths for config file
	err := setPathConfigForViper(
		v,
		osArgs,
		defaultConfigFilename,
		configSearchDirs)
	if err != nil {
		return nil, err
	}

	v.SetConfigType("yaml")

	// -- If you want to accept env vars
	// v.AutomaticEnv()
	// v.BindEnv("DB_USER", dbUser)
	// v.BindEnv("DB_PASS", dbPass)

	// -- Parse config
	err = v.ReadInConfig()
	if err != nil {
	    log.Error().
	        Err(err).
	        Msg("failed to read config using viper")
		return nil, err
	}

	// -- Store into config struct
	var c appConfig
	err = v.Unmarshal(&c)
	if err != nil {
	    log.Error().
	        Err(err).
	        Msg("failed to unmarshal config")
		return nil, err
	}

	// -- Set defaults
	// alternatively: https://github.com/spf13/viper#establishing-defaults
	c.setDefaults()

	// -- Validate
	err = c.Validate()
	if err != nil {
		log.Error().
			Err(err).
			Str("config", fmt.Sprintf("%#v", c)).
			Msg("Config is invalid")
		return nil, err
	}

	return &c, err
}

func (cfg appConfig) Validate() error {
	if strings.TrimSpace(cfg.InputPath) == "" {
		return errors.New("inputPath is required")
	}

	if strings.TrimSpace(cfg.OutputPath) == "" {
		return errors.New("outputPath is required")
	}

	// TODO: do other validation here

	return nil
}


// Pass os.Args
func setPathConfigForViper(
	v *viper.Viper,
	osArgs OSArgs,
	defaultConfigFilename string,
	searchDirs []string) error {

	if v == nil {
		return errors.New("viper instance is required")
	}

	if len(osArgs) > 1 {
		// -- Set config path to passed path
		cfgPath := osArgs[1]

		v.SetConfigName(filepath.Base(cfgPath))
		v.AddConfigPath(filepath.Dir(cfgPath))
		return nil
	}

	// -- Invariant: No config yaml passed
	if strings.TrimSpace(defaultConfigFilename) == "" {
		return errors.New("defaultConfigFilename is required")
	}

	v.SetConfigName(defaultConfigFilename)
	for _, dir := range searchDirs {
		v.AddConfigPath(dir)
	}

	return nil
}

func (c *appConfig) setDefaults() {
	if strings.TrimSpace(c.LogLevel) == "" {
		c.LogLevel = "debug"
	}

	//TODO: set other defaults here (for blank/nil field)
}
```

# Main func
1. Put this into `main.go` for each command
```go
func main() {

	// TODO: setup zerolog here

	cfg, err := NewConfig(os.Args)
	if err != nil {
		log.Error().
			Err(err).
			Str("cfg", fmt.Sprintf("%#v", cfg)).
			Msg("failed to parse config")
		os.Exit(1)
	}

	// TODO: use cfg here
}
```
