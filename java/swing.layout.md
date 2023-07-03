# Overview
1. TODO


# General notes
1. Only some [`LayoutManagers`](https://docs.oracle.com/en/java/javase/20/docs/api/java.desktop/java/awt/LayoutManager2.html) respect preferred/min/max sizes
1. Almost all respect [`setPreferredSize(...)`](https://docs.oracle.com/en/java/javase/20/docs/api/java.desktop/java/awt/Component.html#setPreferredSize(java.awt.Dimension))



# [`SpringLayout`](https://docs.oracle.com/en/java/javase/20/docs/api/java.desktop/javax/swing/SpringLayout.html)
1. Reactive, can think in one dimension at a time
1. Supports configurable spacing
1. Respects [min](https://docs.oracle.com/en/java/javase/20/docs/api/java.desktop/javax/swing/JComponent.html#setMinimumSize(java.awt.Dimension))/[preferred](https://docs.oracle.com/en/java/javase/20/docs/api/java.desktop/javax/swing/JComponent.html#setPreferredSize(java.awt.Dimension))/[max](https://docs.oracle.com/en/java/javase/20/docs/api/java.desktop/javax/swing/JComponent.html#setMaximumSize(java.awt.Dimension)) sizes
1. Supports gaps/spacing between components
1. Similar to [Android Constraint layout](https://developer.android.com/develop/ui/views/layout/constraint-layout)
1. [Official guide](https://docs.oracle.com/javase/tutorial/uiswing/layout/spring.html)
1. Con: If you replace a component, you must redefine some constraints
1. Can make grids:
    1. [Official example 1](https://docs.oracle.com/javase/tutorial/displayCode.html?code=https://docs.oracle.com/javase/tutorial/uiswing/examples/layout/SpringGridProject/src/layout/SpringUtilities.java)
    1. [Official example 2](https://docs.oracle.com/javase/tutorial/uiswing/examples/layout/SpringGridProject/src/layout/SpringUtilities.java)


# [`GroupLayout`](https://docs.oracle.com/en/java/javase/20/docs/api/java.desktop/javax/swing/GroupLayout.html)
1. TODO
1. Respects [min](https://docs.oracle.com/en/java/javase/20/docs/api/java.desktop/javax/swing/JComponent.html#setMinimumSize(java.awt.Dimension))/[preferred](https://docs.oracle.com/en/java/javase/20/docs/api/java.desktop/javax/swing/JComponent.html#setPreferredSize(java.awt.Dimension))/[max](https://docs.oracle.com/en/java/javase/20/docs/api/java.desktop/javax/swing/JComponent.html#setMaximumSize(java.awt.Dimension)) sizes
1. Supports gaps/spacing between components
1. TODO


# [MigLayout](https://www.miglayout.com/)
1. [Quickstart guide](http://www.miglayout.com/QuickStart.pdf)
1. TODO
1. Respects [min](https://docs.oracle.com/en/java/javase/20/docs/api/java.desktop/javax/swing/JComponent.html#setMinimumSize(java.awt.Dimension))/[preferred](https://docs.oracle.com/en/java/javase/20/docs/api/java.desktop/javax/swing/JComponent.html#setPreferredSize(java.awt.Dimension))/[max](https://docs.oracle.com/en/java/javase/20/docs/api/java.desktop/javax/swing/JComponent.html#setMaximumSize(java.awt.Dimension)) sizes
1. Supports gaps/spacing between components


# [`CardLayout`](https://docs.oracle.com/en/java/javase/20/docs/api/java.desktop/java/awt/CardLayout.html)
1. TODO


--------
# Rejected/obsoleted
1. ~~`BoxLayout`~~:
    1. Use MigLayout or `GridLayout` or `SpringLayout`
1. ~~`BorderLayout`~~:
    1. Use MigLayout or `SpringLayout`
    1. Ignores min/preferred/max sizes for NORTH/SOUTH/EAST/WEST (cropping/truncation)
    1. Useful only for making (CENTER) child fully expand to parent
1. ~~`GridBag`~~:
    1. Use MigLayout instead
    1. Code bloat
    1. Overly complex
    1. Too little power
    1. Unmaintainable
1. ~~`GridLayout`~~:
    1. Use MigLayout instead
    1. All components must be same size
    1. Ignores min/preferred/max sizes
    1. Narrow usefulness


# Other resources
1. TODO
