# Overview
1. TODO


# package.json
```bash
pnpm i @opentelemetry/api;
pnpm i @opentelemetry/core;
pnpm i @opentelemetry/otlp-exporter-base;
pnpm i @opentelemetry/resources;
pnpm i @opentelemetry/sdk-trace-base;
pnpm i @opentelemetry/sdk-trace-web;
pnpm i @opentelemetry/semantic-conventions;
```


# Init
- TODO


# Span
- [`tracer.startSpan(...)`](https://github.com/open-telemetry/opentelemetry-js/blob/main/api/src/trace/tracer.ts#L41)
    - [sources](https://github.com/open-telemetry/opentelemetry-js/blob/main/packages/opentelemetry-sdk-trace-base/src/Tracer.ts#L65)
    - No side effects (Pure function)
    - No context mutation (No impact on global [`ContextManager`](https://github.com/open-telemetry/opentelemetry-js/blob/main/api/src/context/types.ts#L49))
    - If you pass [`Context`](https://github.com/open-telemetry/opentelemetry-js/blob/main/api/src/context/types.ts#L20), your new span [will be a child span](https://github.com/open-telemetry/opentelemetry-js/blob/main/api/src/trace/tracer.ts#L34)
    - You are responsible for calling **`span.end()`** in `finally` block
    - [more official docs](https://open-telemetry.github.io/opentelemetry-js/interfaces/_opentelemetry_api.Tracer.html#startSpan)
- [`tracer.startActiveSpan(...)`](https://github.com/open-telemetry/opentelemetry-js/blob/main/api/src/trace/tracer.ts#L87)
    - Has side effects on global [`ContextManager`](https://github.com/open-telemetry/opentelemetry-js/blob/main/api/src/context/types.ts#L49)
    - You are responsible for calling **`span.end()`** in `finally` block
    - Mutates the context for the duration of the closure argument
    - [more official docs](https://open-telemetry.github.io/opentelemetry-js/interfaces/_opentelemetry_api.Tracer.html#startActiveSpan)


# `SpanContext` Propagation (within browser)
- see [the doc](./tracing.propagation.md)


# Exporter
- TODO:


# Traceparent
1. Helps propagate from browser to server
1. Convert from [`SpanContext`](https://github.com/open-telemetry/opentelemetry-js/blob/main/api/src/trace/span_context.ts#L25) to a [`traceparent`](https://www.w3.org/TR/trace-context/#traceparent-header) header string
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


# [fetch](TODO)
- TODO

```typescript
        span.setAttribute("http.request.header.traceparent", traceparentHeader);
        span.setAttribute(ATTR_HTTP_REQUEST_METHOD, "GET");
        span.setAttribute(ATTR_URL_FULL, url);
        span.setAttribute(ATTR_USER_AGENT_ORIGINAL, navigator.userAgent);
```

## Error handling

```typescript
        if (resp.status != 200) {
            const respBody = await resp.text();
            span.setStatus({
                code: SpanStatusCode.ERROR,
                message: respBody,
            });

            // maybe console.error(...) or throw new Error(...)
        }
```


# Other resources
1. TODO
