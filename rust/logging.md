# Overview

1. Idioms for logging
1. See also [tracing doc](./tracing.md)

# Summary of key ideas

1. Prefer [`tracer`](TODO) or [`opentelemetry`](TODO)
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
pub fn setup_logger() -> Result<(), anyhow::Error> {
    // Parse levels using: LevelFilter::from_str("info")?

    // TODO: allow override levels from env var

    let out_file = FileRotate::new(
        "app.log",
        AppendCount::new(2),
        ContentLimit::Time(TimeFrequency::Daily),
        Compression::OnRotate(2),
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
setup_logger().expect("failed to setup logger");
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
