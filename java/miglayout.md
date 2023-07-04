# Overview
1. MigLayout notes


# General
1. Can handle Grid-based, Flow layout, docking layout, Absolute positioning, and Relative positioning
1. String based config is more compact
    1. Invalid strings throw RuntimeException
1. API based config is more typesafe
1. Unlike [`SpringLayout`](https://docs.oracle.com/en/java/javase/20/docs/api/java.desktop/javax/swing/SpringLayout.html) and [`GroupLayout`](https://docs.oracle.com/en/java/javase/20/docs/api/java.desktop/javax/swing/GroupLayout.html), component constraints are set using [`.add(component, ...)`](https://docs.oracle.com/en/java/javase/20/docs/api/java.desktop/java/awt/Container.html#add(java.awt.Component,java.lang.Object))
    1. Layout constraints are set when constructing the [`MigLayout`](http://www.migcalendar.com/miglayout/mavensite/apidocs/net/miginfocom/swing/MigLayout.html)
1. Replace `BorderLayout` using [Docking](http://www.migcalendar.com/miglayout/mavensite/apidocs/net/miginfocom/layout/CC.html#dockEast())
1. comes with helpful debug features


# Constraint types
1. [`LC`](http://www.migcalendar.com/miglayout/mavensite/apidocs/net/miginfocom/layout/LC.html) means component layout constraint (highest level)
    1. see [debug](TODO)
1. [`AC`](http://www.migcalendar.com/miglayout/mavensite/apidocs/net/miginfocom/layout/AC.html) means component axis constraint (either column or row)
1. [`CC`](http://www.migcalendar.com/miglayout/mavensite/apidocs/net/miginfocom/layout/CC.html) means component constraint (lowest level)
    1. Useful for overriding minimum/preferred/maximum constraints
    1. Useful for alignment when spanning/splitting cells


# Gotchas
1. Centering a [`JLabel`](https://docs.oracle.com/en/java/javase/20/docs/api/java.desktop/javax/swing/JLabel.html) or [`JTextField`](https://docs.oracle.com/en/java/javase/20/docs/api/java.desktop/javax/swing/JTextField.html) requires [`setHorizontalAlignment(SwingConstants.CENTER)`](https://docs.oracle.com/en/java/javase/20/docs/api/java.desktop/javax/swing/JTextField.html#setHorizontalAlignment(int))


# Other resources
1. TODO
