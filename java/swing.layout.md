# Overview
1. TODO


# General notes
1. Only some [`LayoutManagers`](https://docs.oracle.com/en/java/javase/20/docs/api/java.desktop/java/awt/LayoutManager2.html) respect preferred/min/max sizes
1. Almost all respect [`setPreferredSize(...)`](https://docs.oracle.com/en/java/javase/20/docs/api/java.desktop/java/awt/Component.html#setPreferredSize(java.awt.Dimension))


# [`GroupLayout`](https://docs.oracle.com/en/java/javase/20/docs/api/java.desktop/javax/swing/GroupLayout.html)
1. TODO


# [`SpringLayout`](https://docs.oracle.com/en/java/javase/20/docs/api/java.desktop/javax/swing/SpringLayout.html)
1. Reactive
1. Similar to [Android Constraint layout](https://developer.android.com/develop/ui/views/layout/constraint-layout)


# [MigLayout](https://www.miglayout.com/)
1. [Quickstart guide](http://www.miglayout.com/QuickStart.pdf)
1. TODO


# [`CardLayout`](https://docs.oracle.com/en/java/javase/20/docs/api/java.desktop/java/awt/CardLayout.html)
1. TODO


# [`BorderLayout`](https://docs.oracle.com/en/java/javase/20/docs/api/java.desktop/java/awt/BorderLayout.html)
1. Useful only for making (CENTER) child fully expand to parent
1. For all other use cases, Use Mig or [`SpringLayout`](https://docs.oracle.com/en/java/javase/20/docs/api/java.desktop/javax/swing/SpringLayout.html) instead
1. **`NORTH` & `SOUTH` don't respect preferred/min sizes**


# Rejected
1. ~~`GridBag`~~:
    1. Code bloat
    1. Too complex
    1. Too little power
    1. Unmaintainable
    1. Use Mig instead
1. ~~`GridLayout`~~:
    1. Everything must be same size
    1. Narrow usefulness
    1. Use Mig instead


# Other resources
1. TODO
