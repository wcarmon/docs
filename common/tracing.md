# Overview
- [OpenTelemetry](https://opentelemetry.io/)


# Definitions
- Span.Event: more commonly known as a Log.Event, occurs during the life of a Span


# Concepts

## Trace
- a distributed call stack
- a [DAG](https://en.wikipedia.org/wiki/Directed_acyclic_graph) of *Spans*
- [Official definition](https://opentelemetry.io/docs/concepts/signals/traces/)


## Span
- Part of a [trace](https://opentelemetry.io/docs/concepts/signals/traces/)
- [Official definition](https://opentelemetry.io/docs/concepts/signals/traces/#spans-in-opentelemetry)
- Generally has a significant duration between start and end time


## Log
- a "point-in-time" event
- See also [span.event](https://opentelemetry.io/docs/concepts/signals/traces/#span-events)


## Resource
- "Something" which produces logs, traces or metrics (like an application, server, lambda, etc)
- immutable key-value pairs related to the entity producing spans


## Collector
- Allows building pipelines
- Input side is called Receiver (listen on ports for thrift, grpc, http, etc)
- Output side is called Exporter (write to local file, send to jaeger, kafka, Prometheus, etc)


## Exporter
- local sink for spans
- Part of the Collector (Outbound side)


# Span & Log correlation
1. OpenTelemetry doesn't provide a log API (except `Span.AddEvent`)
1. OpenTelemetry is focused on correlating via `span_id` and `trace_id`


# Other resources
1. https://opentelemetry.io/docs/reference/specification/error-handling/
