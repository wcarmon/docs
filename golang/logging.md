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
1. More complex than zerolog, wider scope, more features
1. More compatible with [Opentelemetry](https://opentelemetry.io/)
1. **Avoid** the sugar api
    1. Uses reflection
    1. No type safety (so no refactoring)
    1. Slower than the typesafe api
    1. Error prone: Developer must carefully pair `keys` and `values`
1. [zap setup examples](./logging.zap.md)
1. [OpenTelemetry & Zap integration](https://github.com/wcarmon/otzap)


# Next Best: [zerolog](https://github.com/rs/zerolog)
1. Use if zap doesn't meet your needs
1. Simple
1. Fast
1. Comprehensive for typical cases
1. `Con`: incompatible with [OpenTelemetry](https://opentelemetry.io/)
1. `Con`: seems to be unmaintained
1. [zerolog setup examples](./logging.zerolog.md)


# Other Resources
1. https://pkg.go.dev/github.com/rs/zerolog
1. https://github.com/rs/zerolog
1. https://medium.com/swlh/stop-using-prints-and-embrace-zerolog-2c4dd8e8816a
1. https://learning-cloud-native-go.github.io/docs/a6.adding_zerolog_logger/
1. https://godocs.io/github.com/rs/zerolog
