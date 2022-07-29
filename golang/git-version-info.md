# Overview
1. How to get git commit hash version info into your binary


# Example

## Update Build script
```bash
readonly GIT_COMMIT=$(git rev-list -1 HEAD)
# alternative: readonly GIT_COMMIT=$(git rev-parse HEAD)
...

GOOS=linux \
  GOARCH=amd64 \
  go build \
  -o "$OUTPUT_DIR/$OUTPUT_BINARY_NAME.linux.amd64" \
  -ldflags="-X main.gitCommitHash=${GIT_COMMIT}" \
  $CMD_PACKAGE
...
```
1. See also [go/build.native.sh](../bash/examples/go/build.native.sh)

## Update main.go file
```go
// Set by build process
// go build ... -ldflags="-X main.gitCommitHash=..."
var gitCommitHash string

func main() {

    // zerolog setup ...

    log.Info().
        Str("gitCommitHash", gitCommitHash).
        Msg("version")

    ...
}
```