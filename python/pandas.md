# Overview
1. Key ideas in [Pandas](https://pandas.pydata.org/) 
1. Read about [numpy](./numpy.md) first


# What
1. A convenience layer over [numpy](./numpy.md)


# Why
1. Simplifies working with Spreadsheets, SQL, ...


# Key Concepts

## Series
1. 1D **labeled** array
    - Can hold same types as [numpy supports](https://numpy.org/doc/stable/user/basics.types.html#array-types-and-conversions-between-types)
    - Implemented as two associated/parallel np.arrays, one for labels, one for data 
1. Behaves like Python dictionary (or golang `map` or Java `Map` or rust `HashMap`)


## DataFrame
1. 2D structure, like a spreadsheet (columns and rows)

# Usage
1. TODO

## Create

### [`pd.read_excel`](TODO)
1. TODO

### [`pd.read_csv`](TODO)
1. TODO

### [`pd.read_sql`](TODO)
1. TODO


## Update

### Rename columns
1. TODO

## Delete

## Get

### head (first n-rows)
- TODO

## Filter
1. TODO


## Export/Save

### [`pd.to_excel`](TODO)
1. TODO

### [`pd.to_csv`](TODO)
1. TODO

### [`pd.to_sql`](TODO)
1. TODO


# Relation to other tools
1. Relies on [numpy](./numpy.md)


# Other resources
1. https://pandas.pydata.org/docs/user_guide/index.html#user-guide
