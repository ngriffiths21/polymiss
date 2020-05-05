
<!-- README.md is generated from README.Rmd. Please edit that file -->

# polymiss

<!-- badges: start -->

<!-- badges: end -->

The polymiss package provides a vector class, `polymiss`, that allows
for representing different types of missing values.

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
| NA     | Non-existent | Missing, and no “true” value is possible |

To create a `polymiss()` vector:

``` r
library(polymiss)
p1 <- polymiss(c(7, NA, NA), miss = c(1L, 2L, NA))
p1
#> <polymiss[3]>
#> [1] 7      <UNK>  <NONE>
```

To discard `<NONE>`, use `reduce()`:

``` r
sum(p1)
#> [1] NA

p1[-2]
#> <polymiss[2]>
#> [1] 7      <NONE>
reduce(p1[-2], `+`)
#> [1] 7
```

## License

[MIT](https://choosealicense.com/licenses/mit/)
