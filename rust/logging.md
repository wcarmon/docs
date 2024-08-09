# Overview

1. Idioms for logging
1. See also [tracing doc](./tracing.md)

# Summary of key ideas

1. For just logging, Prefer [`env_logger`](https://docs.rs/env_logger/latest/env_logger/)
    - GOTCHA: `env_logger` conflicts with `tokio-console` and with `tracing`
    - Env var: `RUST_LOG=debug|info|warn|trace`
1. For Tracing, Prefer [`tracer`]([TODO](https://docs.rs/tracing/latest/tracing/)) or [`opentelemetry`](TODO)
1. If you must use logging directly, prefer the [log crate](https://docs.rs/log/latest/log/)
1. Add logs where you **handle** an [`Error`](https://docs.rs/anyhow/latest/anyhow/struct.Error.html), not where you propagate (`?`)


# [Simplelog](https://docs.rs/simplelog/latest/simplelog/)

## Cargo.toml
```toml
[dependencies]
anyhow = "..."
file-rotate = "..."
log = "..."
simplelog = "..."
```

## Runtime Configuration
```rs
pub fn setup_simple_logger(log_file_name: &str) -> Result<(), anyhow::Error> {
    // Parse levels using: LevelFilter::from_str("info")?

    // TODO: allow override levels from env var

    // -- Daily rolling log file, compress old files
    let out_file = FileRotate::new(
        log_file_name,
        AppendCount::new(2),
        ContentLimit::Time(TimeFrequency::Daily),
        Compression::OnRotate(0),
        #[cfg(unix)]
            None,
    );

    CombinedLogger::init(vec![
        // -- Terminal appender
        TermLogger::new(
            LevelFilter::Info,
            Config::default(),
            TerminalMode::Mixed,
            ColorChoice::Auto,
        ),

        // -- (Rolling) file appender
        WriteLogger::new(
            LevelFilter::Debug,
            Config::default(),
            out_file,
        ),
    ])?;

    Ok(())
}
```

## Runtime init
1. in `main.rs`
```rs
...
setup_simple_logger("app.log").expect("failed to setup logger");
...
```


## Usage
1. Same pattern as print! and println! macros
```rs
debug!("...", ...);
info!("...", ...);
warn!("...", ...);
error!("...", ...);
```

## GOTCHAS
1. In Jetbrains products on on windows, **Disable** `Enable terminal emulation in output console`
    1. See https://www.jetbrains.com/help/clion/terminal-in-the-output-console.html#enable

# Other Resources
1. https://docs.rs/simplelog/latest/simplelog/
1. https://docs.rs/log/latest/log/
