# Overview
1. Lessons learned from using gRPC
1. See also [protobuf doc](./protobuf.md)


# Request/Response (not streaming)
```rust

// TODO

    Ok(Response::new(DoSomethingResponse { some_data }))
```


# Streaming responses
1. Usually use an [Associated Type](TODO) to make the types more readable

```proto
message FooResponseChunk {
  repeated string something = 1;
}
```

- Example server
```rust
    // Pin: don't move in memory
    // Box: use heap
    // dyn: type only known at runtime
    // Stream: tokio_stream (think Rx Observable or Reactor Flux)
    // FooResponseChunk: part of domain model, defined in the proto
    // Status: gRPC response status: https://grpc.io/docs/guides/status-codes
    // Send: can move (ownership) across threads
    type DoSomethingStream = Pin<Box<dyn Stream<Item=Result<SpansResponseChunk, Status>> + Send>>;

    async fn do_something(
        &self,
        request: Request<DoSomethingRequest>,  // DoSomethingRequest is defined in a proto

        // Result: std rust, Ok & Err
        // Response: a tonic thing, has metadata, message, extensions (arbitrary kv pairs)
    ) -> Result<Response<Self::DoSomethingStream>, Status> {

        // ... do validation here ...

        // ... do business logic here ...

        // -- Build the stream
        let stream = async_stream::try_stream! {
            for current in some_provider.next() {
                yield FooResponseChunk {
                    something: current,
                }
            }
        };

        // -- return the stream
        Ok(Response::new(Box::pin(stream) as Self::DoSomethingStream))
    }
```

## Without Associated types
```rust
    async fn do_something(
        &self,
        request: Request<DoSomethingRequest>,  // DoSomethingRequest is defined in a proto
    ) -> Result<
            Response<
                Pin<
                    Box<
                        dyn Stream<
                            Item=Result<SpansResponseChunk, Status>> + Send>>>,
            Status> {

            ...
     }
```



# Other Resources
