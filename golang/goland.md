# Overview
1. An [IDE](https://en.wikipedia.org/wiki/Integrated_development_environment) from [Jetbrains](https://www.jetbrains.com/)
1. Alternative to [VSCode](https://code.visualstudio.com/)


# Idioms
1. Add [Postfix Completion templates](https://www.jetbrains.com/help/go/settings-postfix-completion.html) for anything you regularly type by accident
    1. Eg. all the methods in [strings](./strings.md) doc (they would be methods in java, but are in [`strings`](https://pkg.go.dev/strings) package for go)
    1. Linux: `$HOME/.config/JetBrains/GoLand<version>/options/postfixTemplates.xml`
    1. MacOS: `~/Library/Application Support/JetBrains/GoLand<version>/options/postfixTemplates.xml`
    1. windows: `%APPDATA%\JetBrains\GoLand<version>\options\postfixTemplates.xml`
1. Add LiveTemplates for code snippets you use more than once
    1. Linux: `$HOME/.config/JetBrains/GoLand<version>/jba_config/templates/<your-group-name>.xml`
    1. MacOS: `~/Library/Application Support/JetBrains/GoLand<version>/jba_config/templates/<your-group-name>.xml`
    1. windows: `%APPDATA%\JetBrains\GoLand<version>\jba_config\templates\<your-group-name>.xml`


# My Favorite plugins
1. [Ace jump](https://plugins.jetbrains.com/plugin/7086-acejump)
1. [CamelCase](https://plugins.jetbrains.com/plugin/7160-camelcase)
1. [Json Sorter](https://plugins.jetbrains.com/plugin/11104-json-sorter)
1. [Lines Sorter](https://plugins.jetbrains.com/plugin/5919-lines-sorter)


## Bundled plugins
1. [Diagrams](https://www.jetbrains.com/help/go/diagrams.html)
1. [Git](https://plugins.jetbrains.com/plugin/13173-git)
1. [Go Template](https://www.jetbrains.com/help/go/integration-with-go-templates.html)
1. [gRPC](https://plugins.jetbrains.com/plugin/16889-grpc)
1. [HTTP Client](https://www.jetbrains.com/help/go/http-client-in-product-code-editor.html)
1. [IntelliLang](https://plugins.jetbrains.com/plugin/13374-intellilang)
1. [Protocol buffers](https://plugins.jetbrains.com/plugin/8277-protobuf-support)
1. [Shell script](https://plugins.jetbrains.com/plugin/13122-shell-script)
1. [XWin Keymap](https://plugins.jetbrains.com/plugin/13094-xwin-keymap) - if you switch between mac/linux/windows frequently
1. [Yaml](https://plugins.jetbrains.com/plugin/13126-yaml)


# IDE Config files
## Linux
1. `$HOME/.config/JetBrains/GoLand<version>/`
    1. eg. `$HOME/.config/JetBrains/GoLand2022.1/`

## MacOS
1. `~/Library/Application Support/JetBrains/GoLand<version>/`

## windows
1. `%APPDATA%\JetBrains\GoLand<version>\`


# Show compilation errors
- [`ALT+6` for Problems view](https://www.jetbrains.com/help/go/problems-tool-window.html)


# Running & Debugging
1. See [running](./running.md) and [debugging](./debugging.md) docs


# Keymap: Jetbrains shortcuts
- See [jetbrains-shortcuts](../macos/jetbrains-shortcuts.md) doc

# Import Live templates
1. Export from "source" Goland, copy into path below
    1. Linux: TODO
    1. MacOS: `~/Library/Application Support/JetBrains/GoLand2022.1/templates/foo.xml`
    1. windows: TODO
1. Open "receiving" Goland/Pycharm
1. Disable synchronization
    1. Check `Copy actual/last settings from account to this IDE`
    1. Click `Disable Settings Sync` button
1. Move templates xml to ...
    1. `~/Library/Application Support/JetBrains/GoLand<version>/templates/*.xml`
1. Restart GoLand (or PyCharm)
1. Enable Sync ...
    1. Click **`Keep and Sync Local Settings`**
    1. This will automatically write files to `~/Library/Application Support/JetBrains/<product><version>/jba_config/...`
1. Settings/Preferences > Live templates


# Other optional settings/preferences
1. Disable smart quotes


# onCommit "hook"
- TODO: gofmt on commit


# Other resources
1. TODO ...
