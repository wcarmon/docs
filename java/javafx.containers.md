# Overview

1. [`Nodes`](https://javadoc.io/static/org.openjfx/javafx-fxml/19/javafx.graphics/javafx/scene/Node.html) which contain other Nodes
1. Nodes which implement [`Parent`](https://javadoc.io/static/org.openjfx/javafx-fxml/19/javafx.graphics/javafx/scene/Parent.html)
1. See high-level [nodes doc](./javafx.nodes.md)

# [`AnchorPane`](https://openjfx.io/javadoc/20/javafx.graphics/javafx/scene/layout/AnchorPane.html)

1. Children anchored to one or more edges
1. Useful for stretching children on resize

# [`BorderPane`](https://openjfx.io/javadoc/20/javafx.graphics/javafx/scene/layout/BorderPane.html)

1. 5-regions: top, left, right, bottom, and center

# [`DialogPane`](https://openjfx.io/javadoc/20/javafx.controls/javafx/scene/control/DialogPane.html)

1. TODO

# [`FlowPane`](https://openjfx.io/javadoc/20/javafx.graphics/javafx/scene/layout/FlowPane.html)

1. Horizontal or Vertical
1. **Wraps** children at specified width (or height)

# [`GridPane`](https://openjfx.io/javadoc/20/javafx.graphics/javafx/scene/layout/GridPane.html)

1. a "Grid"
1. rows can have different heights (columns can have different widths)
1. children can span rows or columns
1. children can overlap (z-order determined by [`getChildren()`](https://openjfx.io/javadoc/20/javafx.graphics/javafx/scene/layout/Pane.html#getChildren()) index)
1. Similar to HTML table
1. Stores row/col/span attributes in [`Node.getProperties()`](https://openjfx.io/javadoc/20/javafx.graphics/javafx/scene/Node.html#getProperties())
    1. This works because a [`Node`](https://openjfx.io/javadoc/20/javafx.graphics/javafx/scene/Node.html) can only appear in the Scene graph at-most once

# [`Group`](https://openjfx.io/javadoc/20/javafx.graphics/javafx/scene/Group.html)

1. TODO

# [`HBox`](https://openjfx.io/javadoc/20/javafx.graphics/javafx/scene/layout/HBox.html)

1. Single (horizontal) row

# [`Pane`](https://openjfx.io/javadoc/20/javafx.graphics/javafx/scene/layout/Pane.html)

1. Absolute positioning

# [`SplitPane`](https://openjfx.io/javadoc/20/javafx.controls/javafx/scene/control/SplitPane.html)

1. Two or more sides, separated by divider
1. Can drag dividers or position programmatically
1. Horizontal or Vertical
1. GOTCHA: add nodes to [`getItems()`](https://openjfx.io/javadoc/20/javafx.controls/javafx/scene/control/SplitPane.html#getItems()) not ~~`getChildren()`~~

# [`StackPane`](https://openjfx.io/javadoc/20/javafx.graphics/javafx/scene/layout/StackPane.html)

1. Arranges children back-to-front (overlapping)
1. z-order determined by [`getChildren()`](https://openjfx.io/javadoc/20/javafx.graphics/javafx/scene/layout/Pane.html#getChildren()) index)
1. first child on bottom, last child on top

# [`TextFlow`](https://openjfx.io/javadoc/20/javafx.graphics/javafx/scene/text/TextFlow.html)

1. For rich text
1. Can contain multiple text nodes
1. Supports multiple fonts
1. Wraps text

# [`TilePane`](https://openjfx.io/javadoc/20/javafx.graphics/javafx/scene/layout/TilePane.html)

1. a "Grid"
1. All children same size (uniform size)
1. **Wraps** children at specified width (or height)

# [`Toolbar`](https://openjfx.io/javadoc/19/javafx.controls/javafx/scene/control/ToolBar.html)

1. A fancy [`HBox`](https://javadoc.io/static/org.openjfx/javafx-fxml/19/javafx.graphics/javafx/scene/layout/HBox.html) or a [`VBox`](https://javadoc.io/static/org.openjfx/javafx-fxml/19/javafx.graphics/javafx/scene/layout/VBox.html) with buttons and separators
1. When there are too many, Toobar provides an overflow button

# [`VBox`](https://openjfx.io/javadoc/20/javafx.graphics/javafx/scene/layout/VBox.html)

1. Single (vertical) column

# Debugging layout

1. [https://github.com/JonathanGiles/scenic-view](https://github.com/JonathanGiles/scenic-view)
