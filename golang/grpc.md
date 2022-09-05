# Overview
1. What is [gRPC](https://grpc.io/docs/languages/go/basics/)


# Relation to other technologies
- TODO: more here


# Prereq: Protocol Buffers
1. See [protobuf doc](./protobuf.md)


# Install
```bash
go install google.golang.org/grpc/cmd/protoc-gen-go-grpc@latest

# Verify
ls -al $(go env GOPATH)/bin | grep grpc

which protoc-gen-go-grpc;
find $HOME -name protoc-gen-go-grpc;
```
- Ensure `protoc-gen-go-grpc` is on your `$PATH` (try to execute directly)
- May need to add `$GOPATH/bin` to `$PATH` (see `go env GOPATH`)
```bash
ln -sv $(go env GOPATH)/bin/protoc-gen-go-grpc $HOME/bin/
```

# Get dependencies
```bash
PROJ_ROOT=/dir/containing/go.mod/
cd $PROJ_ROOT

go get google.golang.org/grpc
go mod tidy
```


# Compile
- see [protobuf doc](./protobuf.md)
- TODO: more here
- TODO: protoc generates `*_grpc.pb.go`

# Server
- TODO: embed UnimplementedFoo
- TODO: implement methods on Foo interface


# Other resources
1. https://grpc.io/docs/languages/go/basics/
