# Overview
1. Key points about web sockets


# Key points
1. WebSockets are well supported in modern browsers
1. WebSockets are probably the best way (2024) to push unsolicited data to browser from a server
1. WebSockets are only useful when one side is the browser
    - otherwise, just use gRPC
1. WebSockets can be CPU/IO taxing and therefore drain a phone's battery
1. Intellij [*.http files support websockets](https://www.jetbrains.com/help/idea/http-client-in-product-code-editor.html#websocket)
1. WebSockets work over HTTP
1. After connecting, WebSocket message don't have headers (unless you add your own)
    1. OpenTelemetry Context propagation requires you to send your own [traceparent](https://www.w3.org/TR/trace-context/#traceparent-header) as part of a message (and inject and extract)
1. json as [string/text](https://developer.mozilla.org/en-US/docs/Web/API/WebSocket/send#string) is fine since the browser natively supports
    1. ArrayBuffer, Blob, ... don't make as much sense unless you have really strict IO constraints
1. Each message should have ...
    1. a `type` property at the root of the message object
        1. [in Jackson](https://www.javadoc.io/doc/com.fasterxml.jackson.core/jackson-annotations/2.17.2/com/fasterxml/jackson/annotation/JsonTypeInfo.html)
        1. in rust `serde` crate, [use `Internally tagged`](https://serde.rs/enum-representations.html)


# Other Resources
1. https://developer.mozilla.org/en-US/docs/Web/API/WebSocket
1. https://developer.mozilla.org/en-US/docs/Web/API/WebSockets_API
1. https://www.jetbrains.com/help/idea/http-client-in-product-code-editor.html#websocket
1. [in Javalin](https://javalin.io/documentation#websockets)
1. [in actix](https://actix.rs/docs/websockets/)
1. [in Java 11+](https://docs.oracle.com/en%2Fjava%2Fjavase%2F21%2Fdocs%2Fapi%2F%2F/java.net.http/java/net/http/WebSocket.html)
1. [in golang](https://pkg.go.dev/golang.org/x/net/websocket)
