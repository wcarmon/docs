# Overview
1. Key points about web sockets


# Key points
1. WebSockets start the [handshake](https://developer.mozilla.org/en-US/docs/Web/API/WebSockets_API/Writing_WebSocket_servers#the_websocket_handshake) via HTTP, then use TCP thereafter.
1. WebSockets are [well supported](https://caniuse.com/websockets) in modern browsers and server technologies
1. WebSockets are probably the best way (2025) to push unsolicited data to browser from a server
1. WebSockets are only useful when one side is the browser
    - otherwise, just use [gRPC](https://grpc.io/)
1. WebSockets can be CPU/IO taxing and therefore drain a mobile device's battery
1. Intellij [`*.http` files support websockets](https://www.jetbrains.com/help/idea/http-client-in-product-code-editor.html#websocket)
1. After connecting, WebSocket message don't have headers (unless you add your own)
    1. OpenTelemetry Context propagation requires you to send your own [traceparent](https://www.w3.org/TR/trace-context/#traceparent-header) as part of a message (and inject and extract)
1. json as [string/text](https://developer.mozilla.org/en-US/docs/Web/API/WebSocket/send#string) is fine since the browser natively supports
    1. ArrayBuffer, Blob, ... don't make as much sense unless you have really strict IO constraints
    1. [in actix, `Session::text(...)`](https://docs.rs/actix-ws/latest/actix_ws/struct.Session.html#method.text)
    1. [in Javalin](https://javalin.io/documentation#wscontext)
    1. [in core Java 11+](https://docs.oracle.com/en%2Fjava%2Fjavase%2F21%2Fdocs%2Fapi%2F%2F/java.net.http/java/net/http/WebSocket.html#sendText(java.lang.CharSequence,boolean))
1. Each message should have ...
    1. a `type` property at the root of the message object
        1. [in Jackson](https://www.javadoc.io/doc/com.fasterxml.jackson.core/jackson-annotations/2.17.2/com/fasterxml/jackson/annotation/JsonTypeInfo.html)
        1. in rust `serde` crate, [use `Internally tagged`](https://serde.rs/enum-representations.html) (eg. `#[serde(tag = "type")]` on the enum)
    1. a [`traceparent`](https://www.w3.org/TR/trace-context/#traceparent-header) field for OpenTelemetry tracing


## Events
1. [`onConnect` or `onOpen`](https://developer.mozilla.org/en-US/docs/Web/API/WebSocket/message_event)
    1. handle auth here
    1. establish sub-protocol (if you support multiple)
2. [`onMessage`](https://developer.mozilla.org/en-US/docs/Web/API/WebSocket/message_event)
    1. receive messages here
    1. most of the time spent here
    1. [in actix](https://docs.rs/actix-ws/latest/actix_ws/struct.MessageStream.html)
    1. [in Javalin](https://javalin.io/documentation#websockets)
    1. [in core Java 11+](https://docs.oracle.com/en%2Fjava%2Fjavase%2F21%2Fdocs%2Fapi%2F%2F/java.net.http/java/net/http/WebSocket.Listener.html#onText(java.net.http.WebSocket,java.lang.CharSequence,boolean))
3. [`onError`](https://developer.mozilla.org/en-US/docs/Web/API/WebSocket/error_event)
    1. Terminal
    1. client might choose to reconnect here
4. [`onClose`](https://developer.mozilla.org/en-US/docs/Web/API/WebSocket/close_event)
    1. Terminal
    1. client might choose to reconnect here


# Liveness
- TODO: ping pong
1. ping pong can happen at any time
1. Let the tools manage this if possible


# Other Resources
1. https://developer.mozilla.org/en-US/docs/Web/API/WebSocket
1. https://developer.mozilla.org/en-US/docs/Web/API/WebSockets_API
1. https://www.jetbrains.com/help/idea/http-client-in-product-code-editor.html#websocket
1. [in Javalin](https://javalin.io/documentation#websockets)
1. [in actix](https://actix.rs/docs/websockets/)
1. [in Java 11+](https://docs.oracle.com/en%2Fjava%2Fjavase%2F21%2Fdocs%2Fapi%2F%2F/java.net.http/java/net/http/WebSocket.html)
1. [in core golang](https://pkg.go.dev/golang.org/x/net/websocket) or via [gorilla](https://pkg.go.dev/github.com/gorilla/websocket)
1. https://www.w3.org/2012/10/Qualcomm-paper.pdf

