# Returns a heat map graphic representing missingness of variables grouped by the given grouping vector.

NOTE: This is an experimental function and the results may vary
depending on the nature of the dataset.

## Usage

``` r
missing.plot(
  x,
  grouping,
  grid = FALSE,
  widths = c(ggplot2::unit(3, "null"), ggplot2::unit(1, "inches")),
  heights = c(ggplot2::unit(1, "inches"), ggplot2::unit(3, "null")),
  color = "red",
  ...
)
```

## Arguments

- x:

  a data frame containing the variables to visualize missingness

- grouping:

  a vector of length nrow(vars) corresponding to how missing will be
  grouped by

- grid:

  whether to draw a grid between tiles

- widths:

  the ratio of the widths of the heatmap and histogram.

- heights:

  the ratio of the heights of the heatmap and histogram.

- color:

  the color used for indicating missingness.

- ...:

  currently unused.

## Value

a ggplot2 expression

## See also

plot.mlpsa
