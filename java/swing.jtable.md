# Overview
1. Notes on [`JTable`](https://docs.oracle.com/en/java/javase/20/docs/api/java.desktop/javax/swing/JTable.html)


# [`JTable`](https://docs.oracle.com/en/java/javase/20/docs/api/java.desktop/javax/swing/JTable.html)
1. Does not store its own data, uses [`TableModel`](https://docs.oracle.com/en/java/javase/20/docs/api/java.desktop/javax/swing/table/TableModel.html) (see below)
1. Supports sorting & filtering via [`RowSorter`](https://docs.oracle.com/en/java/javase/20/docs/api/java.desktop/javax/swing/RowSorter.html)
1. Supports headers
1. Supports column resizing
1. Supports custom header rendering
1. Supports custom cell rendering
1. Supports editing values in cells
1. `JTable` address rows and columns only by `int`, zero based
1. Column rearranging does *NOT* affect the model
1. Layout: https://docs.oracle.com/en/java/javase/20/docs/api/java.desktop/javax/swing/JTable.html#doLayout()
    1. Columns resize to respond to change in containing parent
1. When you put `JTable` into a `JScrollPane`, the header stays on top
    1. If you don’t wrap the `JTable` in a `JScrollPane`, you must explicitly add the header
1. Managing rows is very different from managing columns

## Relationships
1. `JTable` -> [`TableColumnModel`](https://docs.oracle.com/en/java/javase/20/docs/api/java.desktop/javax/swing/table/TableColumnModel.html) -> [`TableColumn`](https://docs.oracle.com/en/java/javase/20/docs/api/java.desktop/javax/swing/table/TableColumn.html) -> [`TableCellRenderer`](https://docs.oracle.com/en/java/javase/20/docs/api/java.desktop/javax/swing/table/TableCellRenderer.html)
1. `JTable` -> [`TableModel`](https://docs.oracle.com/en/java/javase/20/docs/api/java.desktop/javax/swing/table/TableModel.html)


## Rows
1. Resizing: [`setRowHeight(...)`](https://docs.oracle.com/en/java/javase/20/docs/api/java.desktop/javax/swing/JTable.html#setRowHeight(int)) and [row specific version](https://docs.oracle.com/en/java/javase/20/docs/api/java.desktop/javax/swing/JTable.html#setRowHeight(int,int))
1. Space between rows: [`setRowMargin(margin)`](https://docs.oracle.com/en/java/javase/20/docs/api/java.desktop/javax/swing/JTable.html#setRowMargin(int))


## Columns
1. Resizing
    1. See [`setAutoResizeMode(...)`](https://docs.oracle.com/en/java/javase/20/docs/api/java.desktop/javax/swing/JTable.html#setAutoResizeMode(int))
        1. [`AUTO_RESIZE_SUBSEQUENT_COLUMNS`](https://docs.oracle.com/en/java/javase/20/docs/api/java.desktop/javax/swing/JTable.html#AUTO_RESIZE_SUBSEQUENT_COLUMNS): (default) Resize all subsequent columns equally, preserve total width
        1. [`AUTO_RESIZE_OFF`](https://docs.oracle.com/en/java/javase/20/docs/api/java.desktop/javax/swing/JTable.html#AUTO_RESIZE_OFF): Don’t resize columns; change the table width when parent size changes
        1. ... other options aren't as useful
1. Space between columns
    1. TODO ...


## Width: `JTable` adjusts its own width to fit into container
1. See [`AUTO_RESIZE_OFF`](https://docs.oracle.com/en/java/javase/20/docs/api/java.desktop/javax/swing/JTable.html#AUTO_RESIZE_OFF)
1. GOTCHA: You cannot set just one column width, you must set **all** [`getColumnModel().getColumn(i).setPreferredWidth(...)`](https://docs.oracle.com/en/java/javase/20/docs/api/java.desktop/javax/swing/table/TableColumn.html#setPreferredWidth(int))
1. GOTCHA: ~~`col.setWidth`~~ does NOT work
```java
    public static void setColumnWidths(
            JTable table,
            int totalTableWidth,
            int... percentages) {

        Objects.requireNonNull(table, "table is required and null.");
        Objects.requireNonNull(percentages, "percentages is required and null.");
        checkArgument(totalTableWidth > 0, "totalTableWidth must be positive > 0");
        checkArgument(percentages.length == table.getColumnCount(),
                "percentages must have the same length as the table columns");
        Arrays.stream(percentages).forEach(p -> {
            checkArgument(p >= 0, "percentages must be positive > 0");
            checkArgument(p <= 100, "percentages must be <= 100");
        });

        final var pctSum = Arrays.stream(percentages).sum();

        for (int i = 0; i < table.getColumnModel().getColumnCount(); i++) {
            var w = (percentages[i] / pctSum) * totalTableWidth;
            table.getColumnModel()
                    .getColumn(i)
                    .setPreferredWidth(w);
        }
    }
```



# Idioms
1. Put the [`JTable`](https://docs.oracle.com/en/java/javase/20/docs/api/java.desktop/javax/swing/JTable.html) into a [`JScrollPane`](https://docs.oracle.com/en/java/javase/20/docs/api/java.desktop/javax/swing/JScrollPane.html)
1. You can display the Header separately from the Body (see [`getTableHeader()`](https://docs.oracle.com/en/java/javase/20/docs/api/java.desktop/javax/swing/JTable.html#getTableHeader())


# [`TableModel`](https://docs.oracle.com/en/java/javase/20/docs/api/java.desktop/javax/swing/table/TableModel.html)
1. Extend [`AbstractTableModel`](https://docs.oracle.com/en/java/javase/20/docs/api/java.desktop/javax/swing/table/AbstractTableModel.html), using a [`java.util.List`](https://docs.oracle.com/en/java/javase/20/docs/api/java.base/java/util/List.html) of your own row type
1. Manages contents/data/values in each cell
1. NOT for presentation, just data
1. Use [`Lock`](https://docs.oracle.com/en/java/javase/20/docs/api/java.base/java/util/concurrent/locks/package-summary.html) for synchronization
1. Don't use [~~`DefaultTableModel`~~](TODO) because it uses Vector and does some unnecessary lookups
1. Your model should be mutable (to avoid reconnecting the model to Table & Sorter repeatedly)
    1. Allow replacement, adding, clearing of `Collection<YourRowType>`
    1. [`fireTableDataChanged();`](https://docs.oracle.com/en/java/javase/20/docs/api/java.desktop/javax/swing/table/AbstractTableModel.html#fireTableDataChanged()) after changing data
        1. GOTCHA: [`fireTableStructureChanged();`](https://docs.oracle.com/en/java/javase/20/docs/api/java.desktop/javax/swing/table/AbstractTableModel.html#fireTableStructureChanged()) replaces `TableColumn`s  and `TableCellRenderer`s
1. Column rearranging does *NOT* affect the model
    1. Only a view/presentation trick
    1. [No need to listen for column reorder events](https://docs.oracle.com/en/java/javase/20/docs/api/java.desktop/javax/swing/JTable.html)
1. `RowSorter` sorting & filtering does *NOT* affect the model


# [`TableColumnModel`](https://docs.oracle.com/en/java/javase/20/docs/api/java.desktop/javax/swing/table/TableColumnModel.html)
1. Manages column count, total width, selectability, etc
1. Useful for dynamically adding/removing columns
1. [`TableColumns`](https://docs.oracle.com/en/java/javase/20/docs/api/java.desktop/javax/swing/table/TableColumn.html) belong to the [ColumnModel](https://docs.oracle.com/en/java/javase/20/docs/api/java.desktop/javax/swing/table/TableColumnModel.html) (not the `JTable`)
1. Column gaps defined here


# [`RowSorter`](https://docs.oracle.com/en/java/javase/20/docs/api/java.desktop/javax/swing/RowSorter.html)
1. Maps between "coordinates" of rows in the model and rows in the UI
1. to programmatically sort (eg. default sort on init), call [`sort()`](https://docs.oracle.com/en/java/javase/20/docs/api/java.desktop/javax/swing/DefaultRowSorter.html#sort())
1. Apply sorter to table via [`table.setRowSorter(...)`](https://docs.oracle.com/en/java/javase/20/docs/api/java.desktop/javax/swing/JTable.html#setRowSorter(javax.swing.RowSorter))
1. Row Selection uses the visible index, so convert using [`convertRowIndexToView(...)`](https://docs.oracle.com/en/java/javase/20/docs/api/java.desktop/javax/swing/DefaultRowSorter.html#convertRowIndexToView(int)) or [`convertRowIndexToModel(...)`](https://docs.oracle.com/en/java/javase/20/docs/api/java.desktop/javax/swing/DefaultRowSorter.html#convertRowIndexToModel(int))


# Cell Renderer
1. TODO: more here


# Other resources
1. [Official usage guide](https://docs.oracle.com/javase/tutorial/uiswing/components/table.html)
