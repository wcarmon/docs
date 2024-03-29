# Overview
- [OpenTelemetry](https://opentelemetry.io/)



# Concepts

## Trace
1. a distributed call stack
1. one "flow" thru the system (possibly across nodes/machines)
1. a [DAG](https://en.wikipedia.org/wiki/Directed_acyclic_graph) of *Spans*
1. [Official docs](https://opentelemetry.io/docs/concepts/signals/traces/)


## Span
1. A unit of work
1. Has a name, start time, duration, and attributes
1. Related to other Spans (Parent/Child, Siblings, ...)
1. Part of a [trace](https://opentelemetry.io/docs/concepts/signals/traces/)
1. Generally has a significant duration between start and end time
1. Mutable until `span.end()`
1. [Data model](https://opentelemetry.io/docs/reference/specification/trace/api/#span) and [protobuf](https://github.com/open-telemetry/opentelemetry-proto/blob/main/opentelemetry/proto/trace/v1/trace.proto)
1. [Official docs](https://opentelemetry.io/docs/concepts/signals/traces/#spans-in-opentelemetry)


## Log
1. a timestamped text record (ideally sturctured)
1. a "point-in-time" event
1. May or may not be associated with a [span](https://opentelemetry.io/docs/concepts/signals/traces/#spans-in-opentelemetry)
    1. See also [span.event](https://opentelemetry.io/docs/concepts/signals/traces/#span-events)
    1. See [span.AddEvent](https://opentelemetry.io/docs/reference/specification/trace/api/#add-events)
1. Uses `span_id` and `trace_id` to correlate with a span
1. OpenTelemetry considers these synonyms: Log Record, Log Event, Event, Span.Event
1. [Data model](https://opentelemetry.io/docs/reference/specification/logs/data-model/) and [protobuf](https://github.com/open-telemetry/opentelemetry-proto/blob/main/opentelemetry/proto/logs/v1/logs.proto)
1. [Official docs](https://opentelemetry.io/docs/concepts/signals/logs/)


## Baggage
1. traced scoped key-value pairs
1. [Official docs](https://opentelemetry.io/docs/reference/specification/overview/#baggage-signal)


## Resource
1. "Something" which produces logs, traces or metrics (like an application, server, lambda, etc)
1. immutable key-value pairs related to the entity producing spans
1. The origin of the telemetry
1. [Official docs](https://opentelemetry.io/docs/reference/specification/overview/#resources)


## Context
1. minimal data required to propagate a trace across machines/servers
1. Includes things like [`trace_id`](https://opentelemetry.io/docs/reference/specification/logs/data-model/#field-traceid), [`span_id`](https://opentelemetry.io/docs/reference/specification/logs/data-model/#field-spanid), [trace flags]()https://opentelemetry.io/docs/reference/specification/logs/data-model/#field-traceflags, [baggage](https://opentelemetry.io/docs/reference/specification/baggage/api/), etc
1. Immutable
1. [Official docs](https://opentelemetry.io/docs/reference/specification/context/)


## Collector
1. Optional
    1. alternatives include writing to stdout ([Console Exporter](https://opentelemetry.io/docs/instrumentation/go/getting-started/#creating-a-console-exporter)), local file system, kafka, etc
1. Exposed Server
    1. [Jaeger Collector](https://www.jaegertracing.io/docs/1.38/architecture/#collector) listens on [many ports](https://www.jaegertracing.io/docs/1.38/deployment/#collector)
1. Allows building pipelines
1. Input side is called [Receiver](https://opentelemetry.io/docs/collector/configuration/#receivers) (listen on ports for thrift, grpc, http, etc)
1. Output side is called [Exporter](https://opentelemetry.io/docs/collector/configuration/#exporters) (write to local file, send to jaeger, kafka, Prometheus, etc)
1. "Lives" with or in your process (the observed application)
1. Writes to local storage (eg. [ES](https://www.elastic.co/), [Kafka](https://kafka.apache.org/), [Cassandra](https://cassandra.apache.org/_/index.html), [Badger](https://github.com/dgraph-io/badger) ...
1. [Official docs](https://opentelemetry.io/docs/collector/)


## Processor
1. Called at the start & end of a **Span**'s lifecycle
1. called in the order they are registered
1. Think middleware?
1. Apps generally have (at least) one which builds export-friendly span data representation


## Exporter
1. local sink for spans
1. Writes to file system or some server
1. Exporters decouple instrumentation from the backend
1. Part of the Collector (on the outbound side) or part of your app
    1. Can also write to another Collector
1. The final component in the trace export pipeline
1. [go](https://opentelemetry.io/docs/instrumentation/go/exporting_data/), [java](https://github.com/open-telemetry/opentelemetry-java/tree/main/exporters), [js](https://opentelemetry.io/docs/instrumentation/js/exporters/), [python](https://opentelemetry.io/docs/instrumentation/python/exporters/), [c++](https://opentelemetry.io/docs/instrumentation/cpp/exporters/), [.net](https://opentelemetry.io/docs/instrumentation/net/exporters/)
1. Examples:
    - jaeger
    - prometheus
    - zipkin


## Tracer Provider
1. Stateful
1. Stores [Tracer](https://opentelemetry.io/docs/reference/specification/trace/api/#tracer) instances
    1. Register & Lookup by string key
1. Set the global tracer provider after building

## Agent
1. Forwards from Resource to Collector
1. Generally lives on the same machine as the Resource
1. Sometimes agents enrich spans with metadata
1. eg. [Jaeger Agent](https://www.jaegertracing.io/docs/1.38/deployment/#agent)


## Pipeline
1. TODO


## OTLP
1. TODO


# Span & Log correlation
1. OpenTelemetry doesn't provide a log API (except `Span.AddEvent`)
1. OpenTelemetry is focused on correlating via `span_id` and `trace_id`
1. [Official docs](https://opentelemetry.io/docs/reference/specification/logs/#log-correlation)
1. Existing Log lib should add `span_id` and `trace_id` to each log record (when available)
1. Existing Log lib should send records/events to ?TODO?


# Other Resources
1. https://opentelemetry.io/docs/reference/specification/error-handling/
