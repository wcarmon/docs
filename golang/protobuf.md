# Overview
1. What are [Protocol bufferes](https://developers.google.com/protocol-buffers/docs/gotutorial)?
1. How to generate go code from `*.proto` file


# Tool Setup
1. See [Official docs](https://developers.google.com/protocol-buffers/docs/gotutorial#compiling-your-protocol-buffers)

## Protoc
1. [Download `protoc`](https://github.com/protocolbuffers/protobuf/releases)
    1. eg. `protoc-21.5-linux-x86_64.zip`
```
DOWNLOADED_ARCHIVE=$HOME/Downloads/protoc-21.5*.zip;
INSTALL_DIR=$HOME/opt/protobuf;

mkdir -pv $INSTALL_DIR;
unzip -d $INSTALL_DIR $DOWNLOADED_ARCHIVE;

ln -sv $INSTALL_DIR/bin/protoc $HOME/bin/protoc;
```
- TODO: verify include path for well known types like Duration and Timestamp


## protoc-gen-go
1. Install `protoc-gen-go` (used by `protoc`)
```
go install google.golang.org/protobuf/cmd/protoc-gen-go@latest;
```

## Verify install
```
which protoc-gen-go;
find $HOME -name protoc-gen-go
```

- Ensure `protoc-gen-go` is on your `$PATH`



# Proto file
- TODO:



# Compile
1. See protoc [command line options](https://manpages.ubuntu.com/manpages/trusty/man1/protoc.1.html)
    1. or use `protoc --help`
```
PROTO_INPUT_DIR=$HOME/my-project/proto;
PROTO_OUTPUT_DIR=$HOME/my-project/go/src;

protoc \
...

```

/*

*/



TODO: point to shell script with example build
TODO: point to grpc.md file


TODO: https://grpc.io/docs/languages/go/quickstart/

# Other resources
