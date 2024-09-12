# Overview
1. TODO


# Scope
1. Plugins can provide ...
    1. Build: Artifact creation
    1. Build: compilation
    1. Build: gradle integration
    1. Build: Reload project config (build.gradle.kts, Cargo.toml, etc)
    1. Dependencies: Conflict resolution
    1. Dependencies: Dependency resolution
    1. Dependencies: Dependency version updates
    1. Editor: [Compare files](https://www.jetbrains.com/help/idea/comparing-files-and-folders.html)
    1. Editor: Auto-completion
    1. Editor: [Code folding](https://www.jetbrains.com/help/idea/code-folding-settings.html)
    1. Editor: Code formatting
    1. Editor: Detect file system changes
    1. Editor: Errors & Warnings integration (Inspections?)
    1. Editor: [Live templates](https://www.jetbrains.com/help/idea/using-live-templates.html)
    1. Editor: New file & code templates
    1. Editor: [Postfix completion templates](https://www.jetbrains.com/help/idea/settings-postfix-completion.html)
    1. Editor: Refactoring: [Change fn/method signature](https://www.jetbrains.com/help/idea/change-signature.html)
    1. Editor: Refactoring: [Extract constant](https://www.jetbrains.com/help/idea/extract-constant.html)
    1. Editor: Refactoring: [Extract fn/method](https://www.jetbrains.com/help/idea/extract-method.html)
    1. Editor: Refactoring: [Extract interface](https://www.jetbrains.com/help/idea/extract-interface.html)
    1. Editor: Refactoring: [Extract parameter](https://www.jetbrains.com/help/idea/extract-parameter.html?_gl=1*hizb6r*_gcl_au*MTA1ODk0OTc3Ny4xNzI0MzUxMTc5*_ga*MTY0MzkxNjc5NC4xNzI0MzUxMTc3*_ga_9J976DJZ68*MTcyNjE1MTc5MC4xOS4xLjE3MjYxNTI3MTQuNTIuMC4w)
    1. Editor: Refactoring: [Extract variable](https://www.jetbrains.com/help/idea/extract-variable.html)
    1. Editor: Refactoring: [Inline fn/method](https://www.jetbrains.com/help/idea/inline.html)
    1. Editor: Refactoring: [Move type to another file](https://www.jetbrains.com/help/idea/move-refactorings.html#instance_method_example)
    1. Editor: Refactoring: [Rearrange members](https://www.jetbrains.com/help/idea/rearrange-code.html#rearrange_code)
    1. Editor: Refactoring: Auto-add imports
    1. Editor: Refactoring: Move statement/fn/method/block up/down
    1. Editor: Refactoring: [Rename](https://www.jetbrains.com/help/idea/rename-refactorings.html#Rename_Refactorings.topic)
    1. Editor: Refactoring: Rewrite imports (canonicalize)
    1. Editor: Reload changes
    1. Editor: Syntax highlighting
    1. Editor: Type sensitive suggestions (Smart completion)
    1. Execution: debugger breakpoints, step, show variables
    1. Execution: Green arrow in the gutter
    1. Execution: [Run & Debug configurations](https://www.jetbrains.com/help/idea/run-debug-gradle.html)
    1. Execution: Terminate process
    1. Execution: Test: Code coverage
    1. Execution: Test: Debugging
    1. Execution: Test: Runner w/results integration
    1. Integrated Documentation: Inlay hints (types, usage counts, ...)
    1. Integrated Documentation: show fn/method documentation inline (Quick definition)
    1. Integrated Documentation: show fn/method parameters
    1. Navigation: Between logically related code (definition, usages, interface implementations)
    1. Navigation: Find anything integration (Double SHIFT)
    1. Refactoring: Find duplicate code
    1. Static analysis (Inspections)
    1. UI: "Generate" menu integration
    1. UI: New buttons
    1. UI: New menu items
    1. UI: New tool windows
    1. UI: Notifications/Toasts
    1. UI: Provide new Themes (color schemes)
    1. UI: Quick fix integration
    1. UI: Status bar integration
    1. VCS: Conflict resolution
    1. VCS: Git integration
    1. TODO: Language server integration (pro only)


# Prereqs
- Java or Kotlin
- Swing for UI
-

# Foundation
1. All based on [`intellij-community`](https://github.com/JetBrains/intellij-community) project




# TODO: parse
1. https://plugins.jetbrains.com/docs/intellij/fundamentals.html
3. Thread model: https://plugins.jetbrains.com/docs/intellij/threading-model.html
3. https://plugins.jetbrains.com/docs/intellij/documents.html


5. http://alblue.bandlem.com/2011/08/intellij-plugin-development.html
5. http://confluence.jetbrains.com/display/IDEADEV/External+Builder+API+and+Plugins
5. http://confluence.jetbrains.com/display/IDEADEV/External+system+integration
5. http://confluence.jetbrains.com/display/IDEADEV/IntelliJ+IDEA+Action+System
5. http://confluence.jetbrains.com/display/IDEADEV/Plugin+Development+FAQ
5. http://confluence.jetbrains.com/display/IDEADEV/PluginDevelopment
5. http://confluence.jetbrains.com/display/IDEADEV/PSI+Cookbook
5. http://confluence.jetbrains.com/display/IDEADEV/Run+Configurations
5. http://confluence.jetbrains.com/display/IntelliJIDEA/PSI+Helpers+and+Utilities
5. https://blog.jetbrains.com/platform/2020/01/webinar-recording-how-we-built-comma-the-raku-ide-on-the-intellij-platform/
5. https://blog.jetbrains.com/rust/
5. https://blog.jetbrains.com/rust/2024/02/14/q4-2023-features-retrospective/
5. https://plugins.jetbrains.com/docs/intellij/basic-action-system.html
5. https://plugins.jetbrains.com/docs/intellij/custom-language-support-tutorial.html
5. https://plugins.jetbrains.com/docs/intellij/custom-language-support.html#tutorial
5. https://plugins.jetbrains.com/docs/intellij/developing-plugins.html#alternatives
5. https://plugins.jetbrains.com/docs/intellij/editors.html
5. https://plugins.jetbrains.com/docs/intellij/execution.html
5. https://plugins.jetbrains.com/docs/intellij/explore-api.html#12-use-autocompletion-information
5. https://plugins.jetbrains.com/docs/intellij/language-server-protocol.html
5. https://plugins.jetbrains.com/docs/intellij/plugin-extension-points.html
5. https://plugins.jetbrains.com/docs/intellij/plugin-extensions.html
5. https://plugins.jetbrains.com/docs/intellij/plugin-types.html#framework-integration
5. https://plugins.jetbrains.com/docs/intellij/project-model.html
5. https://plugins.jetbrains.com/docs/intellij/psi.html
5. https://plugins.jetbrains.com/docs/intellij/virtual-file-system.html
5. https://plugins.jetbrains.com/docs/intellij/welcome.html
5. https://plugins.jetbrains.com/plugin/16815-thread-access-info (Debugging threads)
5. https://www.jetbrains.com/help/idea/getting-started.html
5. https://www.jetbrains.com/help/idea/managing-plugins.html
5. https://www.jetbrains.com/help/idea/rust-plugin.html


# Other resources
1. TODO
