# Overview
1. Installing grpc


# Setup
```bash
flutter pub add grpc
dart pub global activate protoc_plugin

ln -sv --force $HOME/.pub-cache/bin/protoc-gen-dart $HOME/bin/
```

## Verify
```bash
which protoc-gen-dart
```


# Other resources
1. https://grpc.io/docs/languages/dart/quickstart/
