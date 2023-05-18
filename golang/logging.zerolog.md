# Overview
1. See [logging doc](./logging.md)
1. Config Examples


# Example: Multiple loggers
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
