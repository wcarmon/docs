# Overview
1. Pros with cloud providers (for small projects)

--------
# AWS
## Pros
1. Inexpensive
1. Android app for console

## Cons
1. complex
    1. See [vpc doc](./vpc.aws.md)
1. Support?


--------
# Google cloud
## Pros
1. Inexpensive
1. Generally excellent documentation
1. Android app for console
1. CLI
1. Nice UI
1. SSL Certificate management


## Cons
1. Tech support is expensive
    1. eg. `$29 per month + 3% of net spend`
1. If you do get support, it seems like the first response comes from a robot/AI
1. Cloud Run logs are significantly worse than their Log Explorer
    1. no json payload
    1. entries in reverse order (newest on bottom)
    1. no query support
1. `gRPC` is very hard
    1. when it doesn't work immediately, you will waste a lot of time
    1. HTTP 502 errors ... http/2
1. Only older versions of golang are supported on Cloud Functions
    1. Which is strange since they also make golang


--------
# Linode
## Pros

## Cons


--------
# Digital Ocean
## Pros

## Cons

