# Nicer list of objects in memory. Particularly useful for analysis of large data. https://stackoverflow.com/questions/1358003/tricks-to-manage-the-available-memory-in-an-r-session

Nicer list of objects in memory. Particularly useful for analysis of
large data.
https://stackoverflow.com/questions/1358003/tricks-to-manage-the-available-memory-in-an-r-session

## Usage

``` r
lsos(..., n = 10)
```

## Arguments

- ...:

  not used.

- n:

  the number of objects to return.

## Value

a list of objects loaded sorted by size.
