# Overview
1. Info on `SpanContext` propagation within the browser (Parent/Child Spans)


# Without magic
1. No impact on global state
1. Explicit/manual propagation

## Parent via [`SpanContext`](https://github.com/open-telemetry/opentelemetry-js/blob/main/api/src/trace/span_context.ts#L25)
```ts
import {context, SpanContext, SpanKind, SpanStatusCode, trace} from "@opentelemetry/api";


    const span = tracer.startSpan(...);
    // ...

    try {
        // -- Pass parent SpanContext
        await this.myService.doSomeStuff(span.spanContext());

        // ... optionally set other span attributes here

    } catch (error) {
        span.setStatus({
            code: SpanStatusCode.ERROR,
            message: `${error}`,
        })

        // ... optionally set other error span attributes here

        throw error;

    } finally {
        span.end();  // <-- VERY IMPORTANT
    }
```

## Child via [`SpanContext`](https://github.com/open-telemetry/opentelemetry-js/blob/main/api/src/trace/span_context.ts#L25)
```ts
export async function doSomeStuff(parentSpanContext: SpanContext) {

    const cx = trace.setSpanContext(context.active(), parentSpanContext);

    const span = tracer.startSpan(
        "do-some-stuff",
        {
            kind: SpanKind.CLIENT,
            root: false,
        },
        cx,  // <-- Span constructor reads then sets parent traceId and spanId
    );

    try {
        // ... do some stuff

    } catch (error) {
        span.setStatus({
            code: SpanStatusCode.ERROR,
            message: `${error}`,
        })

        throw error;

    } finally {
        span.end();  // <-- VERY IMPORTANT
    }
}
```


## Parent via [`Context`](https://github.com/open-telemetry/opentelemetry-js/blob/main/api/src/api/context.ts#L34)
```ts
import {context, SpanStatusCode, trace} from "@opentelemetry/api";

    const span = tracer.startSpan(...);
    // ...

    const cx = trace.setSpanContext(context.active(), span.spanContext());
    try {
        // -- Pass parent Context
        await this.myService.doSomeStuff(cx);

    } catch (error) {
        span.setStatus({
            code: SpanStatusCode.ERROR,
            message: `${error}`,
        })

        // ... optionally set other error span attributes here

        throw error;

    } finally {
        span.end();  // <-- VERY IMPORTANT
    }

```


## Child from [`Context`](TODO)
```ts
// TODO
```


# With magic
- TODO: zone.js



# Other resources
1. TODO
