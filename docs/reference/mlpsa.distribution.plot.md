# Plots distribution for either the treatment or comparison group.

Plots distribution for either the treatment or comparison group.

## Usage

``` r
mlpsa.distribution.plot(
  x,
  treat,
  fill.colours = NULL,
  flip = TRUE,
  label = treat,
  level2.label = NULL,
  legendlab = NULL,
  axis.text.size = 8,
  fill.colors = NULL,
  ...
)
```

## Arguments

- x:

  the results of \[mlpsa()\].

- treat:

  the group to plot. This must be one of the two levels of the treatment
  variable.

- fill.colours:

  if specified, the colors to use for level 2 points.

- flip:

  if TRUE, the level 2 clusters will be on the y-axis and the outcome
  variable on the x-axis. Otherwise reversed.

- label:

  the label to use for the axis.

- level2.label:

  the axis label for the level 2 indicators.

- legendlab:

  the label for the legend, or NULL to exclude a legend.

- axis.text.size:

  the size of the axis text

- fill.colors:

  if specified, the colors to use for level 2 points.

- ...:

  currently unused.

## See also

plot.mlpsa
