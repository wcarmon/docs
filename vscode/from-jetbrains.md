# Overview
1. How to do typical things in vscode


# Motivation
1. Jetbrains has fallen behind on AI
1. Java is falling out of favor
1. They only really support IDEA, Goland and WebStorm well (Perhaps c++ in Clion).
    - RustRover is buggy and has font issues (they probably don't regression test)
    - Gateway is buggy alphaware
    - Gateway only has one guy supporting it
1. vscode supports remote development
1. neovim is comparatively lighter on memory & CPU
1. Jetbrains plugins are harder to write and to debug than for vscode


# Key Bindings
1. See [keymap doc](./from-jetbrains.keymap.md)


# Settings/Profile
- Export to github gist (easier), or local file
- Import using gist url on (eg. https://gist.github.com/<username>/...)

## Github

## Local file
|Scope|Path|
|---|---|
|Per user|`$HOME/.config/Code/User/settings.json` ([for mac & windows...](https://code.visualstudio.com/docs/configure/settings#_user-settingsjson-location))|
|Per project|`$PROJ_ROOT/.vscode/settings.json`|

- [More info](https://code.visualstudio.com/docs/configure/settings)


# Editor: Features
1. Change Line Height: `editor.lineHeight`


# Panels

1. Move terminal/console: [official docs](https://code.visualstudio.com/docs/editor/custom-layout#_panel)
1. Theme/Colors: [Dark/Light mode](https://code.visualstudio.com/docs/getstarted/themes) 


# Status Bar & Runtime Info
1. [Git: current branch](https://code.visualstudio.com/docs/sourcecontrol/overview#_git-status-bar-actions)
1. Memory usage: TODO


# VCS

- See [version control doc](./from-jetbrains.vcs.md)


# Debugger

- [Golang](./from-jetbrains.debugger.go.md)
- [Java](./from-jetbrains.debugger.java.md)
- [Rust](./from-jetbrains.debugger.rust.md)



--------
# TODO: migrate these
1. 010: Clipboard history (multi-clipboard)
1. 020: Local edit history (eg. local vcs)
1. 030: Sort json
1. 060: block comment
1. 065: Debugger with Breakpoint (Rust)
1. 066: Debugger with Breakpoint (Java)
1. 070: Conditional breakpoint
1. 075: Lines Sorter
1. 080: Ace jump
1. 085: CamelCase
1. 090: Json Sorter
1. 095: Shifter
1. 100: String Manipulation
1. 105: yaml sorter
1. 110: InnerBuilder
1. 115: Key promoter
1. 120: Change font in file explorer  <-- zoomlevel?
1. 130: Caps lock indicator
1. 140: View Productivity guide (personal usage stats)
1. open project in **new window** - https://stackoverflow.com/questions/43362133/visual-studio-code-open-tab-in-new-window-on-another-screen-floating
1. Port non-conflicting JetBrains keybindings to vscode
1. See https://gist.github.com/bradtraversy/b28a0a361880141af928ada800a671d9
1. See https://github.com/JetBrains/intellij-community/blob/master/platform/platform-resources/src/keymaps/Default%20for%20XWin.xml
1. See https://marketplace.visualstudio.com/items?itemName=isudox.vscode-jetbrains-keybindings
1. TODO: https://code.visualstudio.com/docs/editor/refactoring
1. Directory specific extensions


## TODO: Keyboard shortcuts
1. 100: Editor: Reformat code
1. 110: Navigate: Go to declaration
1. 120: Editor: Refactor: comment/uncomment line
1. 130: Editor: show context actions
1. 140: Editor: smart complete line (CTRL+ENTER) (eg. semicolon for java, rust, ts)
1. 150: Navigate: Search by symbol
1. 160: Editor: Completion: by camel case
1. 170: Editor: Refactor: Rename symbol - https://code.visualstudio.com/docs/editor/refactoring#_rename-symbol
1. 180: Editor: camel to snake case (rust/python)
1. 190: Editor: Postfix completion
1. 200: Navigate: go to class
1. 210: VCS: git commit <--- CTRL+K
1. 220: Navigate: show/hide file explorer (project view)
1. 230: Editor: replace in all "project" files
1. 240: Run inspections
1. 250: Navigate: Show usages of symbol
1. 260: Show file structure (methods/variables summary)
1. 270: Directory diff
1. 280: Editor: Refactor: Introduce variable - https://code.visualstudio.com/docs/editor/refactoring#_extract-variable
1. 290: Editor: Refactor: inline variable - https://code.visualstudio.com/docs/java/java-refactoring#_inline-local-variable
1. 300: Editor: Refactor: extract fn/method - https://code.visualstudio.com/docs/editor/refactoring#_extract-method
1. 310: Move method/fn up/down - 
1. 320: Java: var to explicit type - https://code.visualstudio.com/docs/java/java-refactoring#_change-var-type-to-resolved-type
1. 330: Override method (on interface) - https://code.visualstudio.com/docs/java/java-refactoring#_overrideimplement-methods
1. 340: Search Explorer view by letters (Speed search in trees)
1. 350: Generate getters/accessors - https://code.visualstudio.com/docs/java/java-refactoring#_generate-getters-and-setters
1. 360: Java: refactor stream to loop
1. 370: Live template
1. 380: invert boolean - https://code.visualstudio.com/docs/java/java-refactoring#_invert-conditions
1. 390: Fold selection (fn, method, block, rust module, java class, java record, ...)
1. 400: Expand folded selection
1. 410: adjust font size with mouse wheel - `editor.fontSize`
1. x: ace jump:
    1. https://github.com/DavidLGoldberg/jumpy2
    1. https://github.com/metaseed/metaGo


# TODO
1. Debugger: arbitrary expression at breakpoint
1. Debugger: remote debug (another process)
1. Debugger: remove all breakpoints
1. Debugger: see changed variables on loops/iteration
1. Debugger: view variable contents at breakpoint
1. Decompile source for dependency
1. Editor: Calculate math expression, inline result  (eg. "1+1" ... replace with 2)
1. Editor: Java: override defaulted methods on implemented interface (CTRL+O)
1. Editor: new scratch file (java)
1. Editor: new scratch file (json)
1. Editor: new scratch file (rust)
1. Editor: new scratch file (text)
1. Editor: organize/optimize imports
1. Editor: Run specific test in current file
1. Editor: rust: override defaulted trait methods
1. Editor: show param info for fn/method
1. Inspect all files in a directory
1. Inspect: find duplicate code blocks
1. Intention: change fn parameters to match what I actually pass
1. Intention: change return type signature to match what I actually return
1. Intention: Java: Get sources for decompiled local jar
1. Intention: Rust: add missing fields for new struct initialization
1. Intention: Rust: attach *.rs file to parent lib.rs or main.rs
1. Navigate: Find text across files
1. Navigate: Fuzzy find across files
1. Navigate: Open file based on fuzzy name
1. Run: set environment vars for run/debug
1. Run: set JVM args for run/debug
1. SQL Editor: execute selected sql statement
1. View: compare editor to file in tree view
1. View: compare editor to file to external file
1. View: compare file in tree view to another file "in project"
1. View: compare file in tree view to external file
1. View: Show/Hide tree view of file system


1. Keyboard shortcut: git commit & push:
    1. https://tecadmin.net/shortcuts-for-git-integration-in-visual-studio-code/
    1. https://stackoverflow.com/questions/46382883/shortcut-to-push-code-to-git-in-vscode
1. consider https://marketplace.visualstudio.com/items?itemName=wmaurer.change-case



