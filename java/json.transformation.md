# Overview

1. Evaluation of tools for json -> json transformation

# Requirements

1. [All the general library requirements](../general/libraries.md)
1. Works well in java
1. "Fast enough"
1. Query + (basic) Transformations
1. Clear error messages
1. Not "too verbose"

## Nice to have

1. Works well in go
1. Works well in rust
1. Works well in a browser
1. At least as good as SQL
1. At least as good as XPath

# Leading Candidates

# [JsonPath](https://github.com/json-path/JsonPath)

- `Pro`: Actively maintained
- `Pro`: good docs
- `Pro`: good license
- `Pro`: rich transformation features
- `Pro`: used by [Google BigQuery](https://cloud.google.com/bigquery/docs/reference/standard-sql/json_functions#JSONPath_format)

# Rejected Candidates

## ~~GraphQL~~

- `Con`: too complex when reducing json to single value
- `Pro`: [implemented in go](https://graphql.org/code/#go)
- `Pro`: [implemented in java](https://github.com/graphql-java/graphql-java)
- `Pro`: [implemented in rust](https://graphql.org/code/#rust)
- `Pro`: books written
- `Pro`: good [transformation features](https://graphql.org/learn/queries/)
- `Pro`: popular (read: stack overflow support)
- `Pro`: well documented

## ~~jq~~

- `Con`: hard to execute from go (need cgo or process api)
- `Con`: hard to execute from java (need FFI or process api)
- `Pro`: good [transformation features](https://stedolan.github.io/jq/manual/#Builtinoperatorsandfunctions)

## ~~sawmill~~

- `Con`: light on documentation

## ~~silencio~~

- `Con`: not very JSON friendly
- `Con`: have to write your own transformers (non-standard language)

## ~~SPEL~~

- `Con`: not very JSON friendly
- `Con`: very jvm specific
- `Pro`: mature
- `Pro`: powerful transformation features
- `Pro`: well documented

# TODO: evaluate

- DollarQ
- JaQL
- jinq
- JMESPath
- [Jolt](https://github.com/bazaarvoice/jolt)
- JSON Surfer
- JSONiq
- JsonQuery
- OGNL
- MVEL
- MongoDB Query Language
- ObjectPath
- PostgreSQL JSON Query language
- SpahQL
- https://github.com/octomix/josson
- UnQL
- unquery

# Other resources
