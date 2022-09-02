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
```


# Enable ("Install")
```bash
ln -sv $(go env GOPATH)/bin/protoc-gen-go-grpc $HOME/bin/
```



# Other resources
1. https://grpc.io/docs/languages/go/basics/
