# Overview
1. Key concepts around Actions


# Key concepts
1. Actions are the entry point for most activity in the IDE
1. Actions can be triggered in many ways (controllable by their groups)
1. Actions have full access to java/kotlin
1. Actions can be stateful
1. An action can be in one of many groups
1. New/Custom actions extend [`com.intellij.openapi.actionSystem.AnAction`](https://github.com/JetBrains/intellij-community/blob/master/platform/editor-ui-api/src/com/intellij/openapi/actionSystem/AnAction.java)


# Action Registration
1. You can reach any registered action from double SHIFT
1. When editing `src/main/resources/META-INF/plugin.xml`, `add-to-group.group-id` has auto-completion
```xml
<idea-plugin>
    ...

    <actions>
        <action
            id="com.foo.bar.MyAction"
            class="com.foo.bar.MyAction"
            text="Whatever u23905829405"
            description="...">

            <add-to-group
                group-id="ConsoleEditorPopupMenu"
                anchor="last"/>

            <add-to-group
                group-id="EditorPopupMenu"
                anchor="first"/>
        </action>
    </actions>
</idea-plugin>
```

# Action Groups
- Groups determine where actions are triggered (visually)
- [All predefined action groups](https://github.com/JetBrains/intellij-community/blob/master/platform/ide-core/src/com/intellij/openapi/actionSystem/IdeActions.java)
- `EditorPopupMenu`: Adds to context menu (right click) in editor
- `ToolsMenu`: Adds to "Tools" menu (at the top)
- `ConsoleEditorPopupMenu`: TODO: seems to do nothing

# [`DataContext`](https://github.com/JetBrains/intellij-community/blob/master/platform/core-ui/src/openapi/actionSystem/DataContext.java)
1. Gives an action info on how it was invoked (context info)


# TODO: organize
- TODO: action parameters
- TODO: AnActionEvent: https://github.com/JetBrains/intellij-community/blob/master/platform/editor-ui-api/src/com/intellij/openapi/actionSystem/AnActionEvent.java
- TODO: ActionPlaces: https://github.com/JetBrains/intellij-community/blob/master/platform/ide-core/src/com/intellij/openapi/actionSystem/ActionPlaces.java


# Other resources
1. TODO