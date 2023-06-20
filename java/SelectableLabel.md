# Overview
1. Users cannot select text on a [JavaFx Label](https://openjfx.io/javadoc/20/javafx.controls/javafx/scene/control/Label.html)
1. Solution below


# Example SelectableLabel class
```java
/**
 * Behaves like a javafx.scene.control.Label, but user can select the.
 *
 * <p>User experience is more like text in a browser
 */
public class SelectableLabel extends TextField {

    public SelectableLabel() {
        super();
        actLikeLabel();
    }

    public SelectableLabel(String text) {
        super(text);
        actLikeLabel();
    }

    private void actLikeLabel() {
        // -- No mutation
        setEditable(false);

        // -- Tab traversal skips this
        //    (same as javafx.scene.control.Label)
        setFocusTraversable(false);

        // -- Look like a javafx.scene.control.Label
        getStyleClass().add("label");

        // -- Stop looking like a javafx.scene.control.TextField :-)
        getStyleClass().remove("text-input");
    }
}
```


# Other resources
1. https://openjfx.io/javadoc/19/javafx.graphics/javafx/scene/doc-files/cssref.html
1. https://github.com/openjdk/jfx/blob/jfx20/modules/javafx.controls/src/main/resources/com/sun/javafx/scene/control/skin/caspian/caspian.css
