# Overview
1. How to setup/configure tokio based [tracing](https://docs.rs/tracing/latest/tracing/)

# `Cargo.toml` for libraries (`lib.rs`)

```toml
[dependencies]
# ...
tracing = "0.1"
tracing-attributes = "0.1"
```


# `Cargo.toml` for application (`main.rs`)

```toml
[dependencies]
# ...
opentelemetry = "0.24"
tracing = "0.1"
tracing-attributes = "0.1"
```


# `Cargo.toml` wherever the `init_tracing` function is defined
```toml
anyhow = "1.0"
derive_builder = "0.20"
log = "0.4"

# -- Alternative to env_logger, writes to terminal and to tokio-console
console-subscriber = "0.4"

# -- Provides: TracerProvider,
opentelemetry = "0.24"

# -- Exports spans/logs/metrics via OTLP,
# -- has SpanExporter struct
# -- has exporter::tonic::trace::TonicTracesClient (as SpanExporter)
opentelemetry-otlp = { version = "0.17", features = ["grpc-tonic"] }

# -- Provides constants for resource and span attribute keys
opentelemetry-semantic-conventions = "0.16"

# -- Provides: Resource, SpanExporter trait
opentelemetry_sdk = { version = "0.24", features = ["rt-tokio"] }

# -- Collect traces, provides Layers, Registry, ...
tracing-subscriber = "0.3"

# -- Adapter: connects tracer & OpenTelemetry
tracing-opentelemetry = "0.25"
```


# TracingConfig `struct` for configuration
```rust
use anyhow::ensure;
use chrono::TimeDelta;
use derive_builder::Builder;

#[derive(Builder, Clone, Debug)]
#[builder(build_fn(error = "anyhow::Error", validate = "Self::validate"))]
pub struct TracingConfig {
    // eg. "http://localhost:4317";
    // See https://www.jaegertracing.io/docs/next-release/deployment/#collector
    pub endpoint: String,

    // Application name
    // Appears in Jaeger UI in many places
    // Keep as short & distinct as possible
    pub service_name: String,

    // Tag: otel.library.name
    // Empty string is fine
    pub tracer_name: String,

    pub flush_frequency: TimeDelta,
}

impl TracingConfigBuilder {
    fn validate(&self) -> Result<(), anyhow::Error> {
        ensure!(
            self.endpoint.is_some(),
            "endpoint must not be empty"
        );
        ensure!(
            self.service_name.is_some(),
            "service_name must not be empty"
        );

        let endpoint = self.endpoint.as_ref().unwrap();
        let service_name = self.service_name.as_ref().unwrap();

        ensure!(!endpoint.trim().is_empty(), "endpoint required");
        ensure!(!service_name.trim().is_empty(), "service_name required");

        Ok(())
    }
}
```


# `fn` to initialize tracing
```rust
use console_subscriber::ConsoleLayer;

use opentelemetry::trace::TracerProvider;
use opentelemetry::{global, KeyValue};
use opentelemetry_otlp::Protocol::Grpc;
use opentelemetry_otlp::WithExportConfig;
use opentelemetry_sdk::{trace, Resource};
use opentelemetry_semantic_conventions::resource::SERVICE_NAME;

use tracing_subscriber::layer::SubscriberExt; // enables Registry::default().with
use tracing_subscriber::util::SubscriberInitExt;
use tracing_subscriber::{filter, Layer, Registry};


// WARNING: only invoke from an application (main.rs), not a library
pub fn init_tracing(
    conf: &TracingConfig,
) -> Result<(), anyhow::Error> {

    // -- See https://opentelemetry.io/docs/concepts/resources/
    // -- Jaeger maps this to Span.Process.ServiceName
    let resources = Resource::new(
        vec![KeyValue::new(SERVICE_NAME, conf.service_name.clone())]);

    // -- Uses opentelemetry_otlp::exporter::tonic::trace::TonicTracesClient as SpanExporter
    // -- This factory can build SpanExporter, MetricsExporter and LogExporter
    let otlp_exporter_factory = opentelemetry_otlp::new_exporter()
        .tonic() // requires tokio
        .with_endpoint(&conf.endpoint)
        .with_protocol(Grpc)
        .with_timeout(conf.flush_frequency.to_std()?);

    let pipeline = opentelemetry_otlp::new_pipeline()
        .tracing()
        .with_exporter(otlp_exporter_factory)
        .with_trace_config(
            trace::Config::default()
                // TODO: reasonable defaults here
                // .with_id_generator(RandomIdGenerator::default())
                // .with_max_attributes_per_span(32)
                // .with_max_events_per_span(64)
                // .with_sampler(AlwaysOn)
                // .with_sampler(AlwaysOff)
                .with_resource(resources),
        );

    let tracer_provider = pipeline
        .install_batch(opentelemetry_sdk::runtime::Tokio)
        .context("failed to setup OTLP exporter")?;

    let tracer = tracer_provider.tracer(conf.tracer_name.clone());

    // -- Build OpenTelemetry Layers for tracing lib
    let otlp_layer = tracing_opentelemetry::layer().with_tracer(tracer);
    let filtered_otlp_layer = otlp_layer.with_filter(build_anti_spam_filter());

    // -- Exposes to tokio-console on port 6669
    // let tokio_console_layer = ConsoleLayer::builder()
    //     .with_default_env()
    //     .spawn();

    // -- Reads RUST_LOG env variable
    let env_filter = build_fmt_filter().context("failed to build env_filter for to format logs")?;

    // -- Pretty prints to console, no spans on console
    let color_term_layer = WCColorTerminalLayer::default()
        .with_filter(env_filter)
        .with_filter(build_anti_spam_filter());

    // -- Add Layers to Subscriber (tracing lib concept)
    let subscriber = Registry::default()
        .with(color_term_layer)
        .with(filtered_otlp_layer)
        //.with(tokio_console_layer)
        .init(); // invokes set_global_default(...) to set global

    // -- Apply globally (OpenTelemetry concept)
    // -- only in main.rs, never for a library
    global::set_tracer_provider(tracer_provider);

    Ok(())
}

// -- Don't send tokio internal events to Jaeger
fn build_anti_spam_filter() -> FilterFn {
    filter_fn(|meta| {
        let target = meta.target().to_string();
        if target.starts_with("console_subscriber::")
            || target.starts_with("h2::client")
            || target.starts_with("h2::codec::")
            || target.starts_with("h2::frame::")
            || target.starts_with("h2::hpack::")
            || target.starts_with("h2::proto::")
            || target.starts_with("hyper_util::client::")
            || target.starts_with("runtime::resource::")
            || target.starts_with("tokio::sync::")
            || target.starts_with("tokio::task")
            || target.starts_with("tokio::time::")
            || target.starts_with("tokio::util::")
            || target.starts_with("tonic::transport::")
            || target.starts_with("tower::buffer::")
        {
            return false;
        }

        true
    })
}

// Pretty prints logs
// Level is based on env variable: RUST_LOG
// (see env_logger or tracing crate for details on RUST_LOG)
fn build_fmt_filter() -> Result<filter::EnvFilter, anyhow::Error> {
    // -- See: ConsoleLayer::builder().with_default_env().init();

    let env_var = std::env::var("RUST_LOG").context("missing required env var: RUST_LOG")?;

    env_var
        .parse::<filter::EnvFilter>()
        .context("failed to parse env var: RUST_LOG")
}
```
- See [`WCColorTerminalLayer`](./WCColorTerminalLayer.rs)


# `fn` to shutdown
```rust
use chrono::TimeDelta;
use opentelemetry::global;
use tracing::warn;

// NOTE: sleep_time must be as long as the flush frequency on otlp_exporter
pub fn shutdown_tracing(sleep_time: TimeDelta) {
    warn!("Giving OTLP Exporter time to flush spans");

    global::shutdown_tracer_provider();

    let sleep_time = sleep_time.to_std()
        .expect("failed to convert sleep_time to std::time::Duration");
    sleep(sleep_time);
}
```


# main.rs
- GOTCHA: remove `env_logger::init()` if present (env_logger conflicts with tracing)
```rust
// -- Env vars:
// RUST_LOG=debug
// RUSTFLAGS=--cfg tokio_unstable
// ...
fn main() {
    // ...

    let tracing_conf = TracingConfigBuilder::default()
        .endpoint("http://localhost:4317".to_string())
        .flush_frequency(TimeDelta::milliseconds(500))
        .service_name("my-app-name".to_string())
        .tracer_name(String::new())
        .build()
        .expect("failed to build tracing config");

    // -- Send spans in background thread
    let rt = tokio::runtime::Builder::new_multi_thread()
        .worker_threads(4) // or std::thread::available_parallelism()
        .enable_all()
        .build()
        .expect("failed to build tokio runtime");

    // -- OTLP exporter requies a runtime
    let _ = rt.block_on(async {
        init_tracing(&tracing_conf).context("failed to init tracing")
    });

    // ... run the normal logic here

    shutdown_tracing(TimeDelta::seconds(5));
    // rt.shutdown_timeout(TimeDelta::seconds(1));
}
```
