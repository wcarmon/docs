# Overview
1. See [logging doc](./logging.md)
1. Config Examples


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
   		Filename:   "app.zap.log",
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