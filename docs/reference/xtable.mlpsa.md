# Prints the results of \[mlpsa()\] as a LaTeX table.

This function implements the \[xtable::xtable()\] method for
\[mlpsa()\].

## Usage

``` r
# S3 method for class 'mlpsa'
xtable(
  x,
  caption,
  label,
  align,
  digits = 2,
  display = NULL,
  auto = FALSE,
  include.note = TRUE,
  ...
)
```

## Arguments

- x:

  results of \[mlpsa()\]

- caption:

  passed through to \[xtable::xtable()\].

- label:

  passed through to \[xtable::xtable()\].

- align:

  Not used.

- digits:

  number of digits to print.

- display:

  passed through to \[xtable::xtable()\].

- auto:

  passed through to \[xtable::xtable()\].

- include.note:

  include a table note indicating how many rows were removed due to
  insufficient data within a strata.

- ...:

  other parameters passed to \[summary.mlpsa()\]
