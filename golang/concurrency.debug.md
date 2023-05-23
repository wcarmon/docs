# Overview
1. Debugging goroutines
1. Debugging concurrent & parallel go programs


# Symptoms
1. Hanging goroutines (your program should end but some goroutines are stuck)
1. Unexpected variable values (Race conditions)


# Anti-patterns
1. ~~littering your code with log statements~~
1. ~~Adding extra complexity~~
1. ~~Adding locks/mutexes~~


# Solution-1: Run locally 
1. Set env var: [`GOTRACEBACK="all"`](https://pkg.go.dev/runtime#pkg-overview)
1. Run the program
1. Get your [process id](https://pkg.go.dev/os#Getpid)
1. Wait for it to reach a point of non-responsiveness
1. Run [`kill -3 <pid>`](https://man7.org/linux/man-pages/man1/kill.1.html)
1. See the live goroutines in the console
1. [ag](https://github.com/ggreer/the_silver_searcher)/[ripgrep](https://github.com/BurntSushi/ripgrep)/[grep](https://man7.org/linux/man-pages/man1/grep.1.html) for your source directory
1. Use the file and line numbers to see where goroutines are stuck  


# Solution-2: Add observability (works locally and on servers)
1. See [tracing doc](./tracing.md)


# Solution-3: Run locally and Use a debugger
1. See https://www.jetbrains.com/help/go/debugging-code.html


# Solution-4: Use the race detector
1. https://go.dev/blog/race-detector
1. https://go.dev/doc/articles/race_detector
1. https://yourbasic.org/golang/detect-data-races/


# Solution-5: Add tests
1. Writing test friendly code forces you to write modular code
1. Modular code is simple to reason about
1. Tests can help you pin-point issues
1. see [unit test doc](./testing.unit.md) and [e2e doc](./testing.e2e.md)


# Solution-6: Follow best practices
1. Use a static analyzer (like golangci-lint or goland's inspections or sonarqube)
1. static analyzers can help you find and fix anti-patterns
1. Some anti-patterns cause concurrency issues, others make it harder to solve them



# Other resources
