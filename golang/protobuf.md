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

### MacOS: Extra steps
1. Allow `protoc` binary to run
    1. Try to run `protoc`
    1. Apple menu > System Preferences > Security & Privacy > General
    1. On the bottom, find the failed `protoc` execution
    1. [Click `Allow Anyway` button](https://www.alphr.com/cannot-be-opened-because-the-developer-cannot-be-verified/)


## Setup: [protoc-gen-go](https://pkg.go.dev/google.golang.org/protobuf)
1. Install [`protoc-gen-go`](https://pkg.go.dev/google.golang.org/protobuf) (used by `protoc` to generate go)
```
go install google.golang.org/protobuf/cmd/protoc-gen-go@latest;
```

## Verify install
1. See `$HOME/go/bin/protoc-gen-go` (or use `go env | grep -i path` to find your `$GOPATH` path)
```
which protoc-gen-go;
find $HOME -name protoc-gen-go;
```
- Ensure `protoc-gen-go` is on your `$PATH` (try to execute directly)
- May need to add `$GOPATH/bin` to `$PATH` (see `go env GOPATH`)


# Build a `*.proto` file
1. See [Official docs](https://developers.google.com/protocol-buffers/docs/proto3)
1. Be careful with the [`option go_package`](https://developers.google.com/protocol-buffers/docs/reference/go-generated#package) path.  It is related to [`--go_out`](https://developers.google.com/protocol-buffers/docs/reference/go-generated#invocation) flag for `protoc`
    1. use a slash in `go_package` like "serde/pb"
1. See [Official style guide](https://developers.google.com/protocol-buffers/docs/style)
1. Do **NOT** use `proto` as a package name because it conflicts with generated code
1. Conversions
    1. Duration: [protobuf duration](https://pkg.go.dev/google.golang.org/protobuf/types/known/durationpb): [convert from](https://pkg.go.dev/google.golang.org/protobuf@v1.28.1/types/known/durationpb#hdr-Conversion_to_a_Go_Duration) using [`.AsDuration()`](https://pkg.go.dev/google.golang.org/protobuf/types/known/durationpb#Duration.AsDuration), [convert to](https://pkg.go.dev/google.golang.org/protobuf@v1.28.1/types/known/durationpb#hdr-Conversion_from_a_Go_Duration) using [`New`](https://pkg.go.dev/google.golang.org/protobuf@v1.28.1/types/known/durationpb#New)
    1. Time: [protobuf timestamp](https://pkg.go.dev/google.golang.org/protobuf@v1.28.1/types/known/timestamppb): [convert from](https://pkg.go.dev/google.golang.org/protobuf/types/known/timestamppb#hdr-Conversion_to_a_Go_Time) using [`.AsTime()`](https://pkg.go.dev/google.golang.org/protobuf/types/known/timestamppb#Timestamp.AsTime), [convert to](https://pkg.go.dev/google.golang.org/protobuf/types/known/timestamppb#hdr-Conversion_from_a_Go_Time) using [`New`](https://pkg.go.dev/google.golang.org/protobuf/types/known/timestamppb#New)


# Add dep to `go.mod`
```
# directory with go.mod file
cd $PROJ_ROOT;
go get google.golang.org/protobuf;
```
- or just add a [`require`](https://go.dev/ref/mod#go-mod-file-require) directive to [`go.mod`](https://go.dev/ref/mod#go-mod-file) and then run [`go mod tidy`](https://go.dev/ref/mod#go-mod-tidy).
- For example:
```
# Use the latest version
require google.golang.org/protobuf v1.28.1
```


# Compile
1. The compiler ([`protoc`](https://github.com/protocolbuffers/protobuf/releases)) generates `*.pb.go` from `*.proto` files
1. See `protoc` [command line options](https://manpages.ubuntu.com/manpages/trusty/man1/protoc.1.html) or use `protoc --help`
    1. Use relative paths for `protoc` flags
1. See [example shell script](../bash/examples/go/build.protobuf.sh)


# Reading & Writing
1. [Marshal/Write](https://developers.google.com/protocol-buffers/docs/gotutorial#writing_a_message)
1. [Unmarshal/Read](https://developers.google.com/protocol-buffers/docs/gotutorial#reading_a_message)
1. For comparing [timestamps](https://pkg.go.dev/google.golang.org/protobuf/types/known/timestamppb), use [`proto.Equal(ts1, ts2)`](https://pkg.go.dev/google.golang.org/protobuf/proto#Equal) or convert first using [`.AsTime()`](https://pkg.go.dev/google.golang.org/protobuf/types/known/timestamppb#Timestamp.AsTime)
    1. Similar for [Durations](https://pkg.go.dev/google.golang.org/protobuf/types/known/durationpb#pkg-overview)


# gRPC
1. See [gRPC doc](./grpc.md)


# Packages, Imports, Namespaces
1. [proto package](https://developers.google.com/protocol-buffers/docs/proto3#packages) names provide a namespace
    1. provides name isolation from other proto packages
    1. Helps prevent naming conflicts
1. [proto packages](https://developers.google.com/protocol-buffers/docs/proto3#packages) reference [messages](https://developers.google.com/protocol-buffers/docs/proto3#simple) in other `*.proto` files
1. [proto package](https://developers.google.com/protocol-buffers/docs/proto3#packages) names are independent of golang packages
    1. golang, python, java, ... packages are **independent** of proto packages
    1. python: package determined [by directory structure](https://developers.google.com/protocol-buffers/docs/pythontutorial#defining-your-protocol-format)
    1. c++: proto packages are only connected/related to [c++ namespaces](https://developers.google.com/protocol-buffers/docs/cpptutorial#defining-your-protocol-format)
1. In `*.proto`, `package` uses dot, `import` uses slashes
    1. eg. `package a.b;` -> `import "a/b/foo.proto";`
1. [Imports](https://developers.google.com/protocol-buffers/docs/proto3#importing_definitions):
    1. `import` paths uses slashes
    1. `import` paths end with `.proto";`
    1. `import` imports a `*.proto` file (not a message type)
    1. For name resolution, `protoc` appends each `import` path to a [`--proto_path`](https://developers.google.com/protocol-buffers/docs/proto3#generating) flag (in order)
    1. Using an imported `message` requires **proto package** qualification
    1. `import` paths do **NOT** use proto package
    1. `import` paths to **NOT** support wildcard import
    1. `import` paths are sensitive to directory hierarchy
1. [`protoc`](https://github.com/protocolbuffers/protobuf/releases):
    1. `mkdir -p` on the output directory first (protoc will **NOT** create output directory)
    1. Run `protoc` from any ancestor directory of the `*.proto` files
    1. Add one [`--proto_path`](https://developers.google.com/protocol-buffers/docs/proto3#generating) (or [`-I`](https://developers.google.com/protocol-buffers/docs/proto3#generating)) for importing messages
        1. $CWD/`--proto_path`/<import-path>
    1. `protoc` writes to: [`$CWD`](https://en.wikipedia.org/wiki/Working_directory)/[`--go_out`](https://developers.google.com/protocol-buffers/docs/reference/go-generated#invocation)/[`go_package`](https://developers.google.com/protocol-buffers/docs/reference/go-generated#package)/`filename`.pb.go
    1. Each `*.proto` file must reside at [`--proto_path`](https://developers.google.com/protocol-buffers/docs/proto3#generating)/*import-path*
    1. Directory of `*.proto` does **NOT** affect output path
    1. proto package does **NOT** affect output path
1. Example
    1. *Input*:
        - `--go_out=baz/gen`
        - `go_package = "serde/bar";`
        - filename: `foo.proto`
        - `package cheese.quuz;`  <-- proto package, **NOT** used for output
    1. *Output*: `$CWD/baz/gen/serde/bar/foo.pb.go`


# Other resources
1. https://grpc.io/docs/languages/go/quickstart/
1. https://developers.google.com/protocol-buffers/docs/gotutorial
1. https://github.com/golang/protobuf
1. https://pkg.go.dev/google.golang.org/protobuf/proto
1. https://developers.google.com/protocol-buffers/docs/reference/go/faq
1. https://go.dev/blog/protobuf-apiv2