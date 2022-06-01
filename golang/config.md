# Overview
1. How to use [Viper](https://github.com/spf13/viper) to parse config


# Parse Example
1. explicit config file or config file search
1. configurable search paths
```go
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
}

type appConfig struct {

	// debug, info, warn, error
	LogLevel string

	// TODO: other config properties here
}

// Load reads from config file, env vars, ...
// Pass os.Args
func (c *appConfig) Load(osArgs []string) error {
	v := viper.New()

	// -- Set paths for config file
	v.SetConfigType("yaml")
	err := setPathConfigForViper(
		v,
		osArgs,
		defaultConfigFilename,
		configSearchDirs)
	if err != nil {
		return err
	}

	// -- If you want to accept env vars
	// v.AutomaticEnv()
	// v.BindEnv("DB_USER", dbUser)
	// v.BindEnv("DB_PASS", dbPass)

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
func setPathConfigForViper(
	v *viper.Viper,
	osArgs []string,
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
```


# Other resources
