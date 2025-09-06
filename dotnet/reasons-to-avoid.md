# Overview
1. Reasons why someone may not enjoy professional C# development


# Cons & Worst parts
1. XML affinity
1. SOAP garbage
1. Azure affinity
1. EF Core (ORM)
1. weak Enums
1. C# > Java, but JVM > .Net
1. Slower than Rust
1. More memory overhead than Rust
1. windows-only or windows-heavy features
    1. windows logger
    1. wpf
    1. winforms
        1. Use Avalonia instead
    1. Universal Windows Platform (UWP)
    1. System.Security.Cryptography
    1. Microsoft.Win32.Registry
    1. System.Drawing.Common
        1. Use ImageSharp or SkiaSharp instead
    1. IIS or anything related    
    1. System.Diagnostics.PerformanceCounter
1. Dead/Legacy features (some windows-only or windows-heavy)
    1. COM+
    1. Silverlight
    1. XNA
    1. WebMatrix
    1. WebRequest/HttpWebRequest/WebClient
    1. ConfigurationManager
1. Collections
    1. Legacy collections
        1. CollectionBase
        1. DictionaryBase
    1. Non-generic collections create clutter
        1. only exist for COM interop
    1. Immutable collections have "mutability" methods (copy-on-write)
        1. That's why Frozen exists
    1. Slow collections
        1. ListDictionary
        1. HybridDictionary
        1. ImmutableList
        1. Most immutable collections are slower than their mutable counterparts (for both reading and writing)
1. Visual Studio is windows only
    1. Use rider or vscode instead
1. Capitalized method names (only golang)
    1. unlike java
    1. unlike rust
    1. unlike c
    1. unlike python
    1. unlike c++
