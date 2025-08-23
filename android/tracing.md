# Overview
1. TODO


# Concepts
1. `Slice`: 
    1. a rectangle around the execution of code
    1. Like a Span in OpenTelemetry
1. `Counter`:
    1. TODO 
1. [`Flow`](https://perfetto.dev/docs/instrumentation/track-events#flows):
    1. Only supported by the Perfetto API, not androidx
    1. Connects/links 2+ slices (visually with an arrow)    


# Instrumentation
1. https://developer.android.com/jetpack/androidx/releases/tracing
1. [`Trace.beginAsyncSection(...)`](TODO)
    1. can (and should) be nested
    1. should Trace.endSection() in a `finally` block
1. Atrace forwards events up to the kernel ftrace ring-buffer and gets fetched together with the rest of scheduling data and other system-level trace data
1. [`Trace.traceBegin()`](TODO) and [`Trace.traceEnd()`](TODO) must be called on same thread
    1. Prefer [`Trace.beginAsyncSection((...)`](TODO) and [`Trace.endAsyncSection(...)`](TODO)




# Recording and Visualizing
1. Setup `adb`
1. Connect device
1. (on Device) Enable debugging
1. (on Desktop) Navigate to [ui.perfetto.dev](https://ui.perfetto.dev/)
1. TODO: Android apps & svcs
1. TODO: Recording Mode = Ring buffer
1. TODO: set Process/package
1. TODO: click "Start Recording"
1. Use the device in a way that hits your instrumentation
1. Tracing auto-stops after 10 seconds
1. TODO: interpreting results: https://perfetto.dev/docs/visualization/perfetto-ui



# --- Unorganized
1. TODO: SQL
1. ATrace = Application tracing
1. integrate with logcat 
1. integrate with logcat 

# Other resources
1. https://perfetto.dev/docs/getting-started/atrace
1. https://perfetto.dev/docs/getting-started/start-using-perfetto#android-understanding-system-behavior
1. https://cs.android.com/android/platform/superproject/main/+/main:frameworks/base/core/java/android/os/Trace.java?q=frameworks%2Fbase%2Fcore%2Fjava%2Fandroid%2Fos%2FTrace.java
