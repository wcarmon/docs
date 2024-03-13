# Overview
1. How to do typical things in vscode


--------
# Editor
|Action|Jetbrains|vscode|Destructive in vsc|Destructive in JB|
|---:|---:|---:|:---:|:---:|
|Column select|`ALT+SHIFT+INS`|`ALT+SHIFT+DOWN`|TODO|TODO|
|Change font size (Change zoom level)|`CTRL+Mouse wheel`|`CTRL+ +`, `CTRL+ -`|TODO|TODO|
|Copy line|`CTRL+C` (without selection)|TODO|TODO|TODO|
|Extend selection|`CTRL+W`|`ALT+SHIFT+RIGHT`|**Yes**|no|
|Move line|`CTRL+SHIFT+DOWN`|`ALT+DOWN`|TODO|TODO|
|Toggle case on selection|`CTRL+SHIFT+U`|`transform` action|TODO|TODO|


## Change Line Height
1. `editor.lineHeight`


# Navigation
|Action|Jetbrains|vscode|Destructive in vsc|Destructive in JB|
|---:|---:|---:|:---:|:---:|
|Ace Jump|(custom)|TODO|TODO|TODO|
|Center editor group|TODO|`CTRL+2`|TODO|TODO|
|Close active editor|TODO|`CTRL+W`|TODO|no|
|First editor group|TODO|`CTRL+1`|TODO|TODO|
|Run anything|`CTRL+SHIFT+A`|`CTRL+SHIFT+P`|TODO|Type info|
|Settings|`ALT+CTRL+S`|`CTRL+,`|no|TODO|
|Switch tab|TODO|TODO|TODO|TODO|
|Un-close active editor|TODO|TODO|TODO|TODO|


# Ported to vscode
|Action|vscode binding(s)|
|---:|---:|
|Delete line|`CTRL+Y`, `CTRL+SHIFT+K`|
|Duplicate line|`CTRL+D`|
|Last edit location|`CTRL+SHIFT+Backspace`, `CTRL+K CTRL+Q` <br>`navigateToLastEditLocation`|
|Recently opened files|`CTRL+E`|
|Replace in file|`CTRL+R`|
|Sort lines|`ALT+SHIFT+L`|


# Same Default Key Binding
|Action|Jetbrains & vscode|Custom|
|---:|---:|:---:|
|Find in file|`CTRL+F`|--|
|Go to line|`CTRL+G`|--|
|Move editor into next group|`ALT+S`|yes|
|Redo|`CTRL+SHIFT+Z`|--|
|Switch tabs|`CTRL+Tab`|--|
|Toggle line comment|`CTRL+/`|--|
|Undo|`CTRL+Z`|--|


--------
# Panels
## Move terminal/console:
- https://code.visualstudio.com/docs/editor/custom-layout#_panel


# Status Bar & Runtime Info
1. [Git: current branch](https://code.visualstudio.com/docs/sourcecontrol/overview#_git-status-bar-actions)

## Memory usage
1. TODO

# Theme/Colors
1. [Dark/Light mode](https://code.visualstudio.com/docs/getstarted/themes)


--------
# VCS

## Git: commit
1. [View: source control](TODO)
1. TODO: Default commit message
1. `CTRL+K` -> TODO (no default)

## Git: Merge
1. TODO

## Conflict resolution
1. https://code.visualstudio.com/docs/sourcecontrol/overview#_resolving-conflicts

## View diffs
1. https://code.visualstudio.com/docs/sourcecontrol/overview#_viewing-diffs

## Log
1. TODO


--------
# Settings/Profile
1. Export to github gist (easier), or local file
1. Import using gist url on (eg. https://gist.github.com/<username>/...)



--------
# TODO: 
1. 010: Clipboard history (multi-clipboard)
1. 020: Local edit history (eg. local vcs)
1. 030: Sort json
1. 060: block comment
1. 070: Conditional breakpoint
1. 080: Key promoter
1. 090: Change font in file explorer  <-- zoomlevel?
1. 100: Caps lock indicator
1. 120: View Productivity guide (personal usage stats)
1. open project in **new window** - https://stackoverflow.com/questions/43362133/visual-studio-code-open-tab-in-new-window-on-another-screen-floating
1. Port non-conflicting JetBrains keybindings to vscode
1. See https://gist.github.com/bradtraversy/b28a0a361880141af928ada800a671d9
1. See https://github.com/JetBrains/intellij-community/blob/master/platform/platform-resources/src/keymaps/Default%20for%20XWin.xml
1. See https://marketplace.visualstudio.com/items?itemName=isudox.vscode-jetbrains-keybindings
1. TODO: https://code.visualstudio.com/docs/editor/refactoring


## TODO: Keyboard shortcuts
1. 100: Editor: Reformat code
1. 110: Navigate: Go to declaration
1. 120: Editor: Refactor: comment/uncomment line
1. 130: Editor: show context actions
1. 140: Editor: smart complete line (CTRL+ENTER)
1. 150: Navigate: Search by symbol
1. 160: Editor: Completion: by camel case
1. 170: Editor: Refactor: Rename - https://code.visualstudio.com/docs/editor/refactoring#_rename-symbol
1. 180: Editor: camel to snake case (rust/python)
1. 190: Editor: Postfix completion
1. 200: Navigate: go to class
1. 210: VCS: git commit <--- CTRL+K
1. 220: Navigate: show/hide file explorer (project view)
1. 230: Editor: replace in all files
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
1. 360: Java: stream to loop
1. 370: Live template
1. 380: invert boolean - https://code.visualstudio.com/docs/java/java-refactoring#_invert-conditions
1. 390: Fold selection
1. 400: Expand folded selection
1. 410: adjust font size with mouse wheel - `editor.fontSize`
1. x: ace jump:
    1. https://github.com/DavidLGoldberg/jumpy2
    1. https://github.com/metaseed/metaGo

1. keyboard shortcut: git commit & push: 
    1. https://tecadmin.net/shortcuts-for-git-integration-in-visual-studio-code/
    1. https://stackoverflow.com/questions/46382883/shortcut-to-push-code-to-git-in-vscode
1. consider https://marketplace.visualstudio.com/items?itemName=wmaurer.change-case