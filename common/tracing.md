# Overview
- [OpenTelemetry](https://opentelemetry.io/)



# Concepts

## Trace
1. a distributed call stack
1. a [DAG](https://en.wikipedia.org/wiki/Directed_acyclic_graph) of *Spans*
1. [Official docs](https://opentelemetry.io/docs/concepts/signals/traces/)


## Span
1. Part of a [trace](https://opentelemetry.io/docs/concepts/signals/traces/)
1. [Official docs](https://opentelemetry.io/docs/concepts/signals/traces/#spans-in-opentelemetry)
1. Generally has a significant duration between start and end time
1. Mutable until `span.end()`


## Log
1. a timestamped text record (ideally sturctured)
1. a "point-in-time" event
1. May or may not be associated with a [span](https://opentelemetry.io/docs/concepts/signals/traces/#spans-in-opentelemetry)
    1. See also [span.event](https://opentelemetry.io/docs/concepts/signals/traces/#span-events)
1. Uses `span_id` and `trace_id` to correlate with a span
1. [Official docs](https://opentelemetry.io/docs/concepts/signals/logs/)
1. OpenTelemetry considers these synonyms: Log Record, Log Event, Event, Span.Event


## Baggage
1. traced scoped key-value pairs
1. [Official docs](https://opentelemetry.io/docs/reference/specification/overview/#baggage-signal)


## Resource
1. "Something" which produces logs, traces or metrics (like an application, server, lambda, etc)
1. immutable key-value pairs related to the entity producing spans
1. [Official docs](https://opentelemetry.io/docs/reference/specification/overview/#resources)
1. The origin of the telemetry


## Context
1. minimal data required to propagate a trace across machines/servers
1. Includes things like [`trace_id`](https://opentelemetry.io/docs/reference/specification/logs/data-model/#field-traceid), [`span_id`](https://opentelemetry.io/docs/reference/specification/logs/data-model/#field-spanid), [trace flags]()https://opentelemetry.io/docs/reference/specification/logs/data-model/#field-traceflags, [baggage](https://opentelemetry.io/docs/reference/specification/baggage/api/), etc
1. [Official docs](https://opentelemetry.io/docs/reference/specification/context/)
1. Immutable


## Collector
1. Allows building pipelines
1. Input side is called Receiver (listen on ports for thrift, grpc, http, etc)
1. Output side is called Exporter (write to local file, send to jaeger, kafka, Prometheus, etc)
1. "Lives" with or in your process (the observed application)


## Exporter
1. local sink for spans
1. Part of the Collector (Outbound side)


## OTLP
1. TODO


# Span & Log correlation
1. OpenTelemetry doesn't provide a log API (except `Span.AddEvent`)
1. OpenTelemetry is focused on correlating via `span_id` and `trace_id`
1. [Official docs](https://opentelemetry.io/docs/reference/specification/logs/#log-correlation)



# Other resources
1. https://opentelemetry.io/docs/reference/specification/error-handling/
