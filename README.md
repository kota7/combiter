
<!-- README.md is generated from README.Rmd. Please edit that file -->
combiter: Combinatrics Iterators for R
======================================

This package provides iterators for combinations, permutations, and subsets, which allow you to go through all elements without creating a huge set of all possible values.

Installation and import
-----------------------

Install by

``` r
devtools::install_github("kota7/combiter")
```

Use by

``` r
library(combiter)
```

Iterators
---------

This package provides three iterator objects: `iperm`, `icomb`, and `isubset`.

-   `iperm(n)` goes through all permutation of integers 1 to `n`.
-   `icomb(n, k)` goes through all combinations of `k` integers out of 1 to `n`.
-   `isubset(n)` goes through all subsets of integers 1 to `n`.

The iterators do not store all possible values inside the object. Instead, they compute the next or previous element on spot. This implementation would be more memory efficient with a large `n`, since the number of possible cases grows exponentially or faster for these combinatrics operations.

Examples
--------

``` r
x <- iperm(3)
ct <- 0
while (hasNext(x))
{
  ct <- ct + 1
  i <- nextElem(x)
  cat(sprintf("%3d : %s\n", ct, paste0(i, collapse = " ")))
}
#>   1 : 1 2 3
#>   2 : 1 3 2
#>   3 : 2 1 3
#>   4 : 2 3 1
#>   5 : 3 1 2
#>   6 : 3 2 1
```

``` r
x <- icomb(5, 3)
ct <- 0
while (hasNext(x))
{
  ct <- ct + 1
  i <- nextElem(x)
  cat(sprintf("%3d : %s\n", ct, paste0(i, collapse = " ")))
}
#>   1 : 1 2 3
#>   2 : 1 2 4
#>   3 : 1 2 5
#>   4 : 1 3 4
#>   5 : 1 3 5
#>   6 : 1 4 5
#>   7 : 2 3 4
#>   8 : 2 3 5
#>   9 : 2 4 5
#>  10 : 3 4 5
```

``` r
x <- isubset(3)
ct <- 0
while (hasNext(x))
{
  ct <- ct + 1
  i <- nextElem(x)
  cat(sprintf("%3d : %s\n", ct, paste0(i, collapse = " ")))
}
#>   1 : 
#>   2 : 1
#>   3 : 2
#>   4 : 3
#>   5 : 1 2
#>   6 : 1 3
#>   7 : 2 3
#>   8 : 1 2 3
```
