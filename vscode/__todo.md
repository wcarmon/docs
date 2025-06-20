# Migrate these
1. Change font of file explorer (like Jetbrains mono sans - Ubuntu mono, DejaVu Sans Mono)
1. Debugger: 600: Conditional breakpoint
1. Debugger: 700: Go: use breakpoints
1. Debugger: 700: Java: Use breakpoints
1. Debugger: 700: Rust: use breakpoints
1. Debugger: arbitrary expression at breakpoint
1. Debugger: remote debug (another process)
1. Debugger: remove all breakpoints
1. Debugger: see changed variables on loops/iteration
1. Debugger: view variable contents at breakpoint
1. Editor: 010: Clipboard history (multi-clipboard)
1. Editor: 200: Navigate to next error/warning
1. Editor: 030: Sort json
1. Editor: 060: block comment
1. Editor: 075: Lines Sorter
1. Editor: 100: Run specific test in current file
1. Editor: 200: move line up/down
1. Editor: 200: multiple clipboards
1. Editor: 300: Calculate math expression, inline result  (eg. "1+1" ... replace with 2)
1. Editor: 300: new scratch file (java)
1. Editor: 300: new scratch file (json)
1. Editor: 300: new scratch file (text)
1. Editor: 400: Java: InnerBuilder
1. Editor: 700: Go Live templates
1. Editor: 700: Go: Format code
1. Editor: 700: Java Live templates
1. Editor: 700: Java: Format code
1. Editor: 700: Quick intentions (like ALT+Insert)
1. Editor: 700: Refactor: Rename method/function
1. Editor: 700: Refactor: Rename variable
1. Editor: 700: Rust Live templates
1. Editor: 700: Rust: Format code
1. Editor: 700: Syntax highlighting for embedded HTML (in strings)
1. Editor: 700: Syntax highlighting for embedded SQL (in strings)
1. Editor: 700: cut line
1. Editor: 700: duplicate line
1. Editor: 700: show method params (like CTRL+P)
1. Editor: 700: split view
1. Editor: 900: new scratch file (rust)
1. GIT: 030: keymap: commit
1. GIT: 040: git status
1. GIT: 050: git push
1. GIT: 060: keymap: push
1. GIT: 070: revert file to some commit
1. GIT: 080: compare file in another revision
1. GIT: 090: git pull
1. GIT: 100: git merge
1. GIT: 110: signing commits
1. GIT: 120: generate helpful commit message based on changes <-- copilot?, (tabnine does not support yet)
1. GIT: 130: checkout another branch
1. GIT: 140: git fetch
1. GIT: 150: amend commit
1. GIT: 160: git tag
1. GIT: 200: Local edit history (eg. local vcs)
1. Keymap: 000: Go to definition (IDEA: CTRL + B) <--- remap
1. Keymap: 010: Reformat code
1. Keymap: 020: Basic code completion
1. Keymap: 025: Show/Hide tree view of file system <-- CTRL+B
1. Keymap: 030: Open terminal
1. Keymap: 030: Syntax aware selection
1. Keymap: 040: Copy absolute path of current file to clipboard
1. Keymap: 040: Delete line in editor
1. Keymap: 050: Comment/uncomment line
1. Keymap: 060: Find in files
1. Keymap: 100: Editor: Reformat code
1. Keymap: 100: Find in current file
1. Keymap: 110: Navigate: Go to declaration
1. Keymap: 120: Editor: Refactor: comment/uncomment line
1. Keymap: 120: Go to file
1. Keymap: 120: Navigate to next method
1. Keymap: 120: Navigate to previous method
1. Keymap: 130: Editor: show context actions
1. Keymap: 140: Editor: smart complete line (CTRL+ENTER) (eg. semicolon for java, rust, ts)
1. Keymap: 150: Navigate: Search by symbol
1. Keymap: 160: Context actions
1. Keymap: 160: Editor: Completion: by camel case
1. Keymap: 170: Editor: Refactor: Rename symbol - https://code.visualstudio.com/docs/editor/refactoring#_rename-symbol
1. Keymap: 180: Editor: camel to snake case (rust/python)
1. Keymap: 180: Rename refactor
1. Keymap: 190: Editor: Postfix completion
1. Keymap: 200: Navigate: go to class
1. Keymap: 200: Search everywhere
1. Keymap: 210: VCS: git commit <--- CTRL+K
1. Keymap: 220: Go to symbol
1. Keymap: 220: Navigate: show/hide file explorer (project view)
1. Keymap: 230: Editor: replace in all "project" files
1. Keymap: 240: Run inspections
1. Keymap: 250: Navigate: Show usages of symbol
1. Keymap: 260: Reload after cargo.toml or build.gradle change
1. Editor: 100: Vertical split editor group
1. Keymap: 260: Show file structure (methods/variables summary)
1. Keymap: 270: Directory diff
1. Keymap: 280: Editor: Refactor: Introduce variable - https://code.visualstudio.com/docs/editor/refactoring#_extract-variable
1. Keymap: 280: Parameter info
1. Keymap: 290: Editor: Refactor: inline variable - https://code.visualstudio.com/docs/java/java-refactoring#_inline-local-variable
1. Keymap: 300: Editor: Refactor: extract fn/method - https://code.visualstudio.com/docs/editor/refactoring#_extract-method
1. Keymap: 310: Move method/fn up/down -
1. Keymap: 310: toggle: show/hide type hints
1. Keymap: 320: Java: var to explicit type - https://code.visualstudio.com/docs/java/java-refactoring#_change-var-type-to-resolved-type
1. Keymap: 320: Replace (CTRL+R)
1. Keymap: 330: Override method (on interface) - https://code.visualstudio.com/docs/java/java-refactoring#_overrideimplement-methods
1. Keymap: 340: File structure popup
1. Keymap: 340: Search Explorer view by letters (Speed search in trees)
1. Keymap: 350: Generate getters/accessors - https://code.visualstudio.com/docs/java/java-refactoring#_generate-getters-and-setters
1. Keymap: 360: Java: refactor stream to loop
1. Keymap: 360: Live templates
1. Keymap: 370: Live template
1. Keymap: 380: Directory Diff
1. Keymap: 380: invert boolean - https://code.visualstudio.com/docs/java/java-refactoring#_invert-conditions
1. Keymap: 390: Fold selection (fn, method, block, rust module, java class, java record, ...)
1. Keymap: 400: Expand folded selection
1. Keymap: 400: Switch keymap
1. Keymap: 410: adjust font size with mouse wheel - `editor.fontSize`
1. Settings: 200: export keymap (json)
1. Settings: 200: export user settings (not workspace settings)
1. Settings: 200: import keymap (json)
1. Settings: 200: import user settings (not workspace settings)
1. Settings: Rust: toggle inlay hints for obvious cases
1. Tabnine: 300: auto review code before commit
1. Tabnine: 300: generate tests for selected method
1. Terminal: 700: Show/hide built-in terminal
1. Windsurf: 500: auto review code before commit
1. Windsurf: 500: generate tests for selected method



# Unorganized

1. Run/Debug: 700: Java: set env vars
1. 700: Rust: Reload after changing dependencies (Cargo.toml)
1. 700: Java: Reload after changing dependencies (build.gradle, pom.xml)
1. 700: Go: Reload after changing dependencies (go.mod?)
1. 700: Navigation: Find usages of symbol at cursor
1. 700: Navigate to previous cursor position
1. 700: Navigate to previous edit position
1. 700: Complete line (like CTRL+Enter)
1. 700: Java: setup multiple JDKs
1. 700: Show recently edited files
1. 080: Ace jump
1. 085: CamelCase
1. 095: Shifter
1. 100: String Manipulation
1. 105: yaml sorter
1. 115: Key promoter <-- evaluate source code on plugin
1. 120: Change font in file explorer  <-- zoomlevel?
1. 130: Caps lock indicator
1. 140: View Productivity guide (personal usage stats)
1. Port non-conflicting JetBrains keybindings to vscode
1. See https://gist.github.com/bradtraversy/b28a0a361880141af928ada800a671d9
1. See https://github.com/JetBrains/intellij-community/blob/master/platform/platform-resources/src/keymaps/Default%20for%20XWin.xml
1. open project in **new window** - https://stackoverflow.com/questions/43362133/visual-studio-code-open-tab-in-new-window-on-another-screen-floating
1. See https://marketplace.visualstudio.com/items?itemName=isudox.vscode-jetbrains-keybindings
1. TODO: https://code.visualstudio.com/docs/editor/refactoring
1. Directory specific extensions
1. Show local file edit history
1. Keyboard shortcut: git commit & push:
    1. https://tecadmin.net/shortcuts-for-git-integration-in-visual-studio-code/
    1. https://stackoverflow.com/questions/46382883/shortcut-to-push-code-to-git-in-vscode
1. consider https://marketplace.visualstudio.com/items?itemName=wmaurer.change-case
1. ace jump:
    1. https://github.com/DavidLGoldberg/jumpy2
    1. https://github.com/metaseed/metaGo
1. Java: Decompile source for dependency
1. Editor: Java: override defaulted methods on implemented interface (CTRL+O)
1. Editor: organize/optimize imports
1. Editor: rust: override defaulted trait methods
1. Editor: show param info for fn/method
1. Inspect all files in a directory
1. Inspect: find duplicate code blocks
1. Intention: Java: Get sources for decompiled local jar
1. Intention: Rust: add missing fields for new struct initialization
1. Intention: Rust: attach *.rs file to parent lib.rs or main.rs
1. Intention: change fn parameters to match what I actually pass
1. Intention: change return type signature to match what I actually return
1. Navigate: Find text across files
1. Navigate: Fuzzy find across files
1. Navigate: Open file based on fuzzy name
1. Run: set JVM args for run/debug
1. Run: set environment vars for run/debug
1. SQL Editor: execute selected sql statement
1. View: compare editor to file in tree view
1. View: compare editor to file to external file
1. View: compare file in tree view to another file "in project"
1. View: compare file in tree view to external file
1. 900: Java: Generate diagram from types

