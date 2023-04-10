# Overview
1. Key ideas in [Pandas](https://pandas.pydata.org/) 
1. Read about [numpy](./numpy.md) first


# What
1. A convenience layer over [numpy](./numpy.md)


# Why
1. Simplifies working with Spreadsheets, SQL, ...
1. Helps with timeseries & window functions
1. Simplifies `NaN` handling


# Key Concepts

## Series
1. 1D **labeled** array
    - Can hold same types as [numpy supports](https://numpy.org/doc/stable/user/basics.types.html#array-types-and-conversions-between-types)
    - Implemented as two associated/parallel np.arrays, one for labels, one for data 
1. Behaves like Python dictionary (or golang `map` or Java `Map` or rust `HashMap`)


## DataFrame
1. 2D structure, like a spreadsheet (columns and rows)


# Usage (Mostly DataFrame) 
1. TODO

## Print
```python
df.dtypes
df.describe(include='all')
```

## Create

### [`pd.read_excel`](TODO)
1. TODO

### [`pd.read_csv`](TODO)
1. TODO

### [`pd.read_sql`](TODO)
1. TODO


## Update
1. TODO: map

### Rename columns
1. TODO

## Dedupe
```python
df.drop_duplicates(['col_1', 'col_2'], inplace=True)
```

## Delete

## Add column
- TODO

## Remove column
- TODO

## Get Duplicates
```python
duplicates = df[df.duplicated(keep=False)]
```

## Filter
1. TODO

### head (first n-rows)
- TODO

### Missing values
1. TODO: `df.isnull(...)`
1. TODO: `df.dropna(...)`
1. TODO: `df.fillna(...)`


## Join


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



- TODO: SELECT
- TODO: AS (rename)
- TODO: JOIN
- TODO: ORDER BY
- TODO: LIMIT
- TODO: GROUP BY
- TODO: HAVING
- TODO: IN
- TODO: Window functions
- TODO: AND
- TODO: OR
- TODO: UNION
