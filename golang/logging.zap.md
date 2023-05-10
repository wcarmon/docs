# Overview
1. See [logging doc](./logging.md)
1. Config Examples


# Example init
```go
func initZap(minLevel zapcore.Level) (*zap.Logger, error) {
    cores, err := otzap.BuildNormalZapCores(minLevel)
    if err != nil {
        return nil, err
    }

    rootLogger := zap.New(zapcore.NewTee(cores...))

    rootLogger = rootLogger.WithOptions(
        zap.AddCaller(),      // TODO: only for warn, error
        zap.AddCallerSkip(1), // TODO: verify 1 is good
        zap.AddStacktrace(zapcore.ErrorLevel),
    )

    zap.RedirectStdLog(rootLogger)
    zap.ReplaceGlobals(rootLogger)
    return rootLogger, nil
}
```


# Example: Rolling log file with [lumberjack](https://github.com/natefinch/lumberjack/tree/v2.1)
```go
func NewRollingFileCore(
       minLevel zapcore.Level,
   ) zapcore.Core {

       cfg := zap.NewProductionEncoderConfig()
       cfg.MessageKey = "message"
       cfg.TimeKey = "time"

       rollingWriter := &lumberjack.Logger{
           Compress:   true,
           Filename:   "app.log",
           MaxAge:     2,
           MaxBackups: 2,
           MaxSize:    200,
       }

       return zapcore.NewCore(
           zapcore.NewJSONEncoder(cfg),
           zapcore.AddSync(rollingWriter),
           minLevel)
}
```
