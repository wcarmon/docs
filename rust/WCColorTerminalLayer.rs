use chrono::Local;
use colored::{Color, Colorize};
use std::error::Error;
use std::fmt::Debug;
use std::thread;
use tracing::field::{Field, Visit};
use tracing::Metadata;
use tracing::{Event, Level, Subscriber};
use tracing_subscriber::layer::Context;
use tracing_subscriber::registry::LookupSpan;
use tracing_subscriber::Layer;

// A Layer, which prints logs/events to terminal in color.
// See https://docs.rs/tracing-subscriber/latest/tracing_subscriber/layer/index.html
pub struct WCColorTerminalLayer {
    // -- See https://docs.rs/chrono/latest/chrono/struct.DateTime.html#method.format
    ts_format: String,
}

impl WCColorTerminalLayer {}

impl Default for WCColorTerminalLayer {
    fn default() -> Self {
        Self {
            ts_format: "%Y-%m-%d %H:%M:%S".to_string(),
        }
    }
}

impl<S> Layer<S> for WCColorTerminalLayer
where
    S: Subscriber + for<'lookup> LookupSpan<'lookup>,
{
    // Compatible with ...
    //   - log::debug!(...);
    //   - log::info!(...);
    //   - log::warn!(...);
    //   - log::error!(...);
    //   - tracing::debug!(...);
    //   - tracing::info!(...);
    //   - tracing::warn!(...);
    //   - tracing::error!(...);
    //
    // log::Log api record is converted to Event: https://docs.rs/tracing-log/latest/src/tracing_log/lib.rs.html#186
    // record attributes become Event::field::message
    fn on_event(&self, event: &Event<'_>, _ctx: Context<'_, S>) {
        let metadata = event.metadata();

        // TODO: Filtering happens at a higher level
        // if event.metadata().target() != "log" && !event.metadata().is_event() {
        //     return;
        // }

        // -- Capture "interesting" fields from Event record
        let mut message_visitor = MessageVisitor::default();
        event.record(&mut message_visitor);

        let prefix = self.build_prefix(&metadata, &message_visitor);

        // -- Color the prefix
        let color = get_color(*metadata.level());
        let prefix_with_color = prefix.color(color);

        // -- Message
        let body = if let Some(message) = message_visitor.message {
            format!(" - {message}")
        } else {
            String::new()
        };

        // -- Write to console/terminal
        println!("{prefix_with_color}{body}");
    }
}

impl WCColorTerminalLayer {
    fn build_prefix(&self, metadata: &Metadata, visitor: &MessageVisitor) -> String {
        let prefix_capacity = 72;
        let mut prefix = String::with_capacity(prefix_capacity);

        // -- Timestamp
        // let ts = Local::now().to_rfc3339();
        let ts = Local::now().format(&self.ts_format).to_string();
        prefix.push_str(&format!("{} ", ts));

        // -- Thread
        let thread_id = thread::current().id().as_u64();
        prefix.push_str(&format!("[#{:0>2?}] ", thread_id));

        // -- Level
        let level = *metadata.level();
        prefix.push_str(&format!("{:>5} ", level.to_string().to_uppercase()));

        // -- Target
        // let target = event.metadata().target();
        // msg.push_str(&format!("{} - ", target));

        // -- Module path
        if let Some(module_path) = &visitor.log_module_path {
            prefix.push_str(&format!("{}", module_path));
        }

        prefix
    }
}

fn get_color(level: Level) -> Color {
    match level {
        Level::ERROR => Color::Red,
        Level::WARN => Color::Yellow,
        Level::INFO => Color::Green,
        Level::DEBUG => Color::Blue,
        Level::TRACE => Color::Magenta,
    }
}

#[derive(Debug, Default)]
struct MessageVisitor {
    log_file: Option<String>,
    log_line: Option<u64>,
    log_module_path: Option<String>,
    log_target: Option<String>,
    message: Option<String>,
}

#[allow(dead_code)]
impl Visit for MessageVisitor {
    fn record_f64(&mut self, field: &Field, value: f64) {
        println!("TODO: handle visiting a f64")
    }

    fn record_i64(&mut self, field: &Field, value: i64) {
        println!("TODO: handle visiting a i64")
    }

    fn record_u64(&mut self, field: &Field, value: u64) {
        match field.name() {
            "log.line" => {
                self.log_line = Some(value);
            }
            _ => {
                println!(
                    "TODO: handle string field in event visitor: field.name={}",
                    field.name()
                );
            }
        }
    }

    fn record_i128(&mut self, field: &Field, value: i128) {
        println!("TODO: handle visiting a i128")
    }

    fn record_u128(&mut self, field: &Field, value: u128) {
        println!("TODO: handle visiting a u128")
    }

    fn record_bool(&mut self, field: &Field, value: bool) {
        println!("TODO: handle visiting a bool")
    }

    fn record_str(&mut self, field: &Field, value: &str) {
        match field.name() {
            "log.file" => {
                self.log_file = Some(value.to_string());
            }
            "log.module_path" => {
                self.log_module_path = Some(value.to_string());
            }
            "log.target" => {
                self.log_target = Some(value.to_string());
            }
            _ => {
                println!(
                    "TODO: handle string field in event visitor: field.name={}",
                    field.name()
                );
            }
        }
    }

    fn record_error(&mut self, field: &Field, value: &(dyn Error + 'static)) {
        println!(
            "TODO: handle visiting error in event visitor: field.name={}, error={:?}",
            field, value
        )
    }

    // -- For some reason message string comes here instead of ::record_str(...)
    fn record_debug(&mut self, field: &Field, value: &dyn Debug) {
        match field.name() {
            "message" => {
                self.message = Some(format!("{:?}", value));
            }
            _ => {
                println!(
                    "TODO: handle debug field in event visitor: field.name={}",
                    field.name()
                );
            }
        }
    }
}
