
<!-- README.md is generated from README.Rmd. Please edit that file -->

# polymiss

<!-- badges: start -->

<!-- badges: end -->

The polymiss package provides a vector class, `vctrs_polymiss`, that
allows for representing different types of missing values.

## Installation

You can install from GitHub:

``` r
devtools::install_github("ngriffiths21/polymiss")
```

## Example

Regular `double()` vectors can be wrapped in a `polymiss()` in order to
create more useful missing values.

Currently missing value types are represented as integers:

| `miss` | Value        | Explanation                              |
| ------ | ------------ | ---------------------------------------- |
| 1L     | Non-missing  | Known value                              |
| 2L     | Unknown      | Missing, but a “true” value should exist |
| 3L     | Non-existent | Missing, and no “true” value is possible |

To create a `polymiss()` vector:

``` r
library(polymiss)
p1 <- polymiss(c(7, NA, NA), miss = c(1L, 2L, 3L))
p1
#> <vctrs_polymiss[3]>
#> [1] 7      <UNK>  <NONE>
```

Math will automatically discard non-existent values, but retain
unknowns:

``` r
sum(p1)
#> [1] NA

p1[-2]
#> <vctrs_polymiss[2]>
#> [1] 7      <NONE>
sum(p1[-2])
#> [1] 7
```

## License

[MIT](https://choosealicense.com/licenses/mit/)
