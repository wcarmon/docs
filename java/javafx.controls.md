# Overview
1. TODO


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
1. [javadoc](TODO)


# Definitions
1. [`Scene`](https://openjfx.io/javadoc/19/javafx.graphics/javafx/scene/package-summary.html): a window
1. [`Stage`](https://openjfx.io/javadoc/19/javafx.graphics/javafx/stage/Stage.html): TODO
    1. [Modality](https://openjfx.io/javadoc/19/javafx.graphics/javafx/stage/Modality.html) managed here
1. [`Popup`](https://openjfx.io/javadoc/19/javafx.graphics/javafx/stage/Popup.html): TODO


# Gotchas
1. Avoid dialogs unless they fit your use case perfectly.
    1. Alternative: just make another [`Scene`](https://openjfx.io/javadoc/19/javafx.graphics/javafx/scene/package-summary.html), you'll have much more control over behavior, modality, etc
1. ControlsFX [`SearchableComboBox`](https://controlsfx.github.io/javadoc/11.0.3/org.controlsfx.controls/org/controlsfx/control/SearchableComboBox.html) barely has any value over the core [`ComboBox`](https://openjfx.io/javadoc/19/javafx.controls/javafx/scene/control/ComboBox.html)
    1. [Proof](https://github.com/controlsfx/controlsfx/blob/master/controlsfx/src/main/java/org/controlsfx/control/SearchableComboBox.java)


# Other resources
