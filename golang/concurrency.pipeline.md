# Overview
1. Idioms for go channel pipelines 
    1. including context, error handling, timeouts, OpenTelemetry, etc.


# Idioms
1. One Source `func`
1. One Sink `func`
1. Multiple processor `func`s

# Source `func`

# Sink `func`

# Processor `func`s
1. Only use buffering on the output channel, (to avoid exhausting memory)
1. Return `error` only when channel setup fails
    1. Errors during processing go to the output channel    
    
    
## merge `func`



# Other resources
1. https://go.dev/blog/pipelines
