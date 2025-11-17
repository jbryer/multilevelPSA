# Returns a data frame with two columns corresponding to the level 2 variable and the leaves from the conditional inference trees.

Returns a data frame with two columns corresponding to the level 2
variable and the leaves from the conditional inference trees.

## Usage

``` r
getStrata(party.results, data, level2)
```

## Arguments

- party.results:

  the results of \[mlpsa.ctree()\]

- data:

  the data frame to merge results to

- level2:

  the name of the level 2 variable.

## Value

a data frame

## See also

mlpsa.ctree
