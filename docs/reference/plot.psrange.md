# Plots densities and ranges for the propensity scores.

Plots densities and ranges for the propensity scores.

## Usage

``` r
# S3 method for class 'psrange'
plot(
  x,
  xlab = NULL,
  ylab = NULL,
  labels = c("Comparison", "Treatment"),
  text.ratio.size = 4,
  text.ncontrol.size = 3,
  point.size = 1,
  point.alpha = 0.6,
  line.width = 6,
  density.alpha = 0.2,
  rect.color = "green",
  rect.alpha = 0.2,
  ...
)
```

## Arguments

- x:

  the result of psrange.

- xlab:

  label for x-axis.

- ylab:

  label for y-axis.

- labels:

  labels for the comparison and treatment legend.

- text.ratio.size:

  size of the text for the ratio.

- text.ncontrol.size:

  size of the text for the number of control units.

- point.size:

  size of the points for the minimum and maximum ranges for each model.

- point.alpha:

  the alpha (transparency) level for the points.

- line.width:

  the width of the line between the median of the minimum and maximum
  ranges.

- density.alpha:

  the alpha (transparency) level of the density curves.

- rect.color:

  the color of the rectangle surrounding the range of minimum and
  maximum ranges.

- rect.alpha:

  the alpha (transparency) level of the rectangle.

- ...:

  currently unused.

## Value

a ggplot2 object
