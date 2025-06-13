# Overview
1. How to do typical things in vscode


# Motivation
1. JetBrains has fallen behind on AI
1. Java is falling out of favor
1. They only really support IDEA, Goland and WebStorm well (Perhaps c++ in Clion).
    - RustRover is buggy and has font issues (they probably don't regression test)
    - Gateway is buggy alphaware
    - Gateway only has one guy supporting it
1. vscode supports remote development
1. neovim is comparatively lighter on memory & CPU
1. JetBrains plugins are harder to write and to debug than for vscode


# Key Bindings
1. See [keymap doc](./from-jetbrains.keymap.md)


# [Settings/Profile](https://code.visualstudio.com/docs/configure/settings)
- User (scoped) Settings
    - Applies to all projects
    - lives in `$HOME` ([Path is OS specific](https://code.visualstudio.com/docs/configure/settings#_user-settingsjson-location))
- Workspace (scoped) settings
    - Applies to current project
    - lives in the workspace (`$PROJ_ROOT/.vscode/settings.json`)
- Export to github gist (easier), or local file
- Import using gist url on (eg. https://gist.github.com/<username>/...)

## Github

## Local file
|Scope|Path|
|---|---|
|Per user|`$HOME/.config/Code/User/settings.json` ([for mac & windows...](https://code.visualstudio.com/docs/configure/settings#_user-settingsjson-location))|
|Per project|`$PROJ_ROOT/.vscode/settings.json`|

- `keybindings.json` is in the same directory
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


# Terminology
|JetBrains|vscode|
|---|---|
|Action|Command|
|Plugin|Extension|
