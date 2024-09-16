# Overview
1. TODO


# Exporter
- TODO:


# Traceparent
1. Convert from [`SpanContext`](TODO) to a [`traceparent`](TODO) header string
1. `traceparent` is basically a serialized `SpanContext`
```typescript
import {SpanContext, TraceFlags} from "@opentelemetry/api";

// Default version in the specification is 0
const supportedVersion = 0;

/**
 * See https://www.w3.org/TR/trace-context/#traceparent-header
 * Java equivalent: https://github.com/open-telemetry/opentelemetry-java/blob/main/api/all/src/main/java/io/opentelemetry/api/trace/SpanContext.java#L27
 * Rust equivalent: https://github.com/open-telemetry/opentelemetry-rust/blob/main/opentelemetry/src/trace/span_context.rs#L462
 *
 * @param ctx
 * @return {string} defined https://www.w3.org/TR/trace-context/#traceparent-header
 */
export function buildTraceParentHeader(ctx: SpanContext): string {
    if (!ctx) {
        throw new Error("Missing SpanContext");
    }

    const spanId = ctx.spanId; // 16 hex chars
    const traceId = ctx.traceId; // 32 hex chars
    const ver = supportedVersion.toString(16).padStart(2, '0');

    const traceFlags = ctx.traceFlags & TraceFlags.SAMPLED;
    const flagsStr = traceFlags.toString(16).padStart(2, '0');

    return `${ver}-${traceId}-${spanId}-${flagsStr}`;
}
```


# Other resources
1. TODO
