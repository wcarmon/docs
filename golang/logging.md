# Overview
- Best options for logging (and why)


# Idioms
1. Add enough context to solve problems
1. Only configure logging in the last mile (eg. main method)
    1. eg. `zerolog.SetGlobalLevel(zerolog.DebugLevel)`
1. Use Error/Warn logging generously since this helps resolve issues
1. Use Info/Debug logging sparingly, replace with tests
    1. Less spam in the code
    1. Code executes faster
    1. Tests should cover cases where this logging would be useful


# Best: [zap](https://github.com/uber-go/zap)
1. Use if zerolog doesn't meet your needs
1. More complex than zerolog, wider scope, more features
1. Compatible with [Opentelemetry](TODO)
1. Avoid the sugar api
    1. uses reflection
    1. no type safety
    1. keys and values have to be paired carefully (error prone)


# Next Best: [zerolog](https://github.com/rs/zerolog)
1. Simple
1. Fast
1. Comprehensive for typical cases
1. Con: incompatible with [OpenTelemetry](https://opentelemetry.io/)
1. Con: seems to be unmaintained


# Multiple loggers
```go
func initLoggers(level zerolog.Level) *os.File {

	today := time.Now().Format("2006-01-02")
	logFilePath := fmt.Sprintf("app.%v.log", today)

	logFile, err := os.OpenFile(logFilePath,
		os.O_WRONLY|os.O_CREATE|os.O_APPEND,
		0640)
	if err != nil {
		panic("failed to open log file")
	}

	zerolog.TimeFieldFormat = zerolog.TimeFormatUnix

	multi := zerolog.MultiLevelWriter(
		// pretty console logger
		zerolog.ConsoleWriter{Out: os.Stdout},

		// file logger
		logFile,
	)

	log.Logger = zerolog.
		New(multi).
		Level(level).
		With().
		Timestamp().
		Logger()

	return logFile
}

func main() {

	defer initLoggers(zerolog.DebugLevel).Close()

    ...
}
```


# Other resources
1. https://pkg.go.dev/github.com/rs/zerolog
1. https://github.com/rs/zerolog
1. https://medium.com/swlh/stop-using-prints-and-embrace-zerolog-2c4dd8e8816a
1. https://learning-cloud-native-go.github.io/docs/a6.adding_zerolog_logger/
1. https://godocs.io/github.com/rs/zerolog
