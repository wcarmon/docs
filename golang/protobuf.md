# Overview
1. What are [Protocol buffers](https://developers.google.com/protocol-buffers/docs/gotutorial)?
1. How to generate go code from `*.proto` file


# Tool Setup
1. See [Official docs](https://developers.google.com/protocol-buffers/docs/gotutorial#compiling-your-protocol-buffers)

## Setup: Protoc
1. Download [`protoc` from the releases page](https://github.com/protocolbuffers/protobuf/releases)
    1. eg. download `protoc-<version>-<platform>-<arch>.zip`
1. Install:
```
# -- TODO: Set these two vars
DOWNLOADED_ARCHIVE=$HOME/Downloads/protoc-21.5*.zip;
INSTALL_DIR=$HOME/opt/protobuf;

# -- NOTE: this unzips
mkdir -pv $INSTALL_DIR;
unzip -d $INSTALL_DIR $DOWNLOADED_ARCHIVE;

# -- NOTE: this adds to $PATH
ln -sv $INSTALL_DIR/bin/protoc $HOME/bin/protoc;
```


## Setup: [protoc-gen-go](https://pkg.go.dev/google.golang.org/protobuf)
1. Install [`protoc-gen-go`](https://pkg.go.dev/google.golang.org/protobuf) (used by `protoc` to generate go)
```
go install google.golang.org/protobuf/cmd/protoc-gen-go@latest;
```

## Verify install
```
which protoc-gen-go;
find $HOME -name protoc-gen-go;
```
- Ensure `protoc-gen-go` is on your `$PATH` (try to execute directly)



# Build a *.proto file
- See [Official docs](https://developers.google.com/protocol-buffers/docs/proto3)
- Be careful with the [`option go_package`](https://developers.google.com/protocol-buffers/docs/reference/go-generated#package) path.  It is related to [`--go_out`](https://developers.google.com/protocol-buffers/docs/reference/go-generated#invocation) flag for `protoc`


# Add dep to `go.mod`
```
# dir with go.mod file
cd $PROJ_ROOT;
go get google.golang.org/protobuf;
```
- or just add a [`require`](https://go.dev/ref/mod#go-mod-file-require) directive to [`go.mod`](https://go.dev/ref/mod#go-mod-file) and then run [`go mod tidy`](https://go.dev/ref/mod#go-mod-tidy).  eg.
```
require google.golang.org/protobuf v1.28.1
```


# Compile
1. Meaning: Generate `*.pb.go` from `*.proto`
1. See `protoc` [command line options](https://manpages.ubuntu.com/manpages/trusty/man1/protoc.1.html) or use `protoc --help`
1. See [example shell script](../bash/examples/go/build.protobuf.sh)


# gRPC
1. See [gRPC doc](./grpc.md)


# Other resources
1. https://grpc.io/docs/languages/go/quickstart/
1. https://developers.google.com/protocol-buffers/docs/gotutorial
1. https://github.com/golang/protobuf
1. https://pkg.go.dev/google.golang.org/protobuf/proto
1. https://developers.google.com/protocol-buffers/docs/reference/go/faq
1. https://go.dev/blog/protobuf-apiv2