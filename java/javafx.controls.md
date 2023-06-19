# Overview
1. TODO


# High level nodes guide
1. See [nodes doc](./javafx.nodes.md)


# Containers
1. See [containers doc](./javafx.containers.md) doc


# Core controls
1. [visual guide](https://docs.oracle.com/javafx/2/ui_controls/overview.htm)


# [ControlsFX](https://controlsfx.github.io/)
1. [Officially hosted control guide](https://controlsfx.github.io/features/searchablecombobox/)
1. [javadocs](https://controlsfx.github.io/javadoc/11.1.2/org.controlsfx.controls/module-summary.html)
1. [Visual guide on github](https://github.com/controlsfx/controlsfx/wiki/ControlsFX-Features) from (2019)


## ControlsFX Sampler (kitchen sink)
1. https://mvnrepository.com/artifact/org.controlsfx/controlsfx-samples/11.1.2
1. https://mvnrepository.com/artifact/org.controlsfx/fxsampler/1.0.11


# [MaterialFX](https://github.com/palexdev/MaterialFX/tree/main)
1. [Visual guide](https://github.com/palexdev/MaterialFX/wiki)
1. [Maven repo](https://mvnrepository.com/artifact/io.github.palexdev/materialfx/11.16.1)
1. [javadoc](https://javadoc.io/doc/io.github.palexdev/materialfx/latest/MaterialFX/module-summary.html)


# Debugging layout
1. [https://github.com/JonathanGiles/scenic-view](https://github.com/JonathanGiles/scenic-view)


# Gotchas
1. Avoid dialogs unless they fit your use case perfectly.
    1. Alternative: just make another [`Scene`](https://openjfx.io/javadoc/19/javafx.graphics/javafx/scene/package-summary.html), you'll have much more control over behavior, modality, etc
1. ControlsFX [`SearchableComboBox`](https://controlsfx.github.io/javadoc/11.0.3/org.controlsfx.controls/org/controlsfx/control/SearchableComboBox.html) barely has any value over the core [`ComboBox`](https://openjfx.io/javadoc/19/javafx.controls/javafx/scene/control/ComboBox.html)
    1. [Proof](https://github.com/controlsfx/controlsfx/blob/master/controlsfx/src/main/java/org/controlsfx/control/SearchableComboBox.java)
1. Use [`MOUSE_PRESSED`](https://openjfx.io/javadoc/19/javafx.graphics/javafx/scene/input/MouseEvent.html#MOUSE_PRESSED), not ~~[`MOUSE_CLICKED`](https://openjfx.io/javadoc/19/javafx.graphics/javafx/scene/input/MouseEvent.html#MOUSE_CLICKED)~~
1. Use [`addEventFilter`](https://openjfx.io/javadoc/18/javafx.graphics/javafx/scene/Node.html#addEventFilter(javafx.event.EventType,javafx.event.EventHandler)) or [`addEventHandler`](https://openjfx.io/javadoc/18/javafx.graphics/javafx/scene/Node.html#addEventHandler(javafx.event.EventType,javafx.event.EventHandler)), Not ~~[`setOnMouseClicked`](https://openjfx.io/javadoc/18/javafx.graphics/javafx/scene/Node.html#setOnMouseClicked(javafx.event.EventHandler))~~
