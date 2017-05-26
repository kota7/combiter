combiter: Combinatorics Iterators for R
================

[![Build Status](https://travis-ci.org/kota7/combiter.svg?branch=master)](https://travis-ci.org/kota7/combiter) [![CRAN Status](https://www.r-pkg.org/badges/version/combiter)](https://www.r-pkg.org/badges/version/combiter) [![](https://cranlogs.r-pkg.org/badges/combiter)](https://cran.r-project.org/package=combiter)

Overview
--------

This package provides iterators for combinations, permutations, subsets, and cartesian product, with which one can go through the elements without creating a huge set of all possible values.

Since `v1.0.2`, the iterator objects of the package inherit the `iter` class from [iterators](https://cran.r-project.org/package=iterators) package. As a result, the objects are also compatible with [foreach](https://cran.r-project.org/package=foreach) library.

Installation and Import
-----------------------

Install from CRAN:

``` r
install.packages("combiter")
```

Install development version:

``` r
devtools::install_github("kota7/combiter")
```

Import:

``` r
library(combiter)
```

Basic Iterators
---------------

This package provides four iterator classes for integer vectors: `icomb`, `iperm`, `isubset`, and `icartes`.

-   `icomb(n, k)` goes through all combinations of k integers out of `1` to `n`.
-   `iperm(n, k)` goes through all permutations of size `k` consisting of integers `1` to `n` of size `k`.
-   `isubset(n)` goes through all subsets of integers `1` to `n`.
-   `icartes(c(n1, n2, ...))`, available for `v1.0.2+`, goes through cartesian products of `1` to `n1`, `1` to `n2` ....

The iterators do not store all possible values inside the object. Instead, they compute the next or previous element on spot. This implementation would be more memory efficient with a large `n`, since the number of possible cases grows exponentially or even faster for these Combinatorics operations.

### Examples

``` r
x <- icomb(5, 3)
ct <- 0
while (hasNext(x))
{
  ct <- ct + 1
  i <- nextElem(x)
  cat(sprintf("%3d : %s\n", ct, paste0(i, collapse = " ")))
}
```

    ##   1 : 1 2 3
    ##   2 : 1 2 4
    ##   3 : 1 2 5
    ##   4 : 1 3 4
    ##   5 : 1 3 5
    ##   6 : 1 4 5
    ##   7 : 2 3 4
    ##   8 : 2 3 5
    ##   9 : 2 4 5
    ##  10 : 3 4 5

``` r
x <- iperm(4, 2)
ct <- 0
while (hasNext(x))
{
  ct <- ct + 1
  i <- nextElem(x)
  cat(sprintf("%3d : %s\n", ct, paste0(i, collapse = " ")))
}
```

    ##   1 : 1 2
    ##   2 : 1 3
    ##   3 : 1 4
    ##   4 : 2 1
    ##   5 : 2 3
    ##   6 : 2 4
    ##   7 : 3 1
    ##   8 : 3 2
    ##   9 : 3 4
    ##  10 : 4 1
    ##  11 : 4 2
    ##  12 : 4 3

``` r
x <- isubset(3)
ct <- 0
while (hasNext(x))
{
  ct <- ct + 1
  i <- nextElem(x)
  cat(sprintf("%3d : %s\n", ct, paste0(i, collapse = " ")))
}
```

    ##   1 : 
    ##   2 : 1
    ##   3 : 2
    ##   4 : 3
    ##   5 : 1 2
    ##   6 : 1 3
    ##   7 : 2 3
    ##   8 : 1 2 3

``` r
x <- icartes(c(3, 4))
ct <- 0
while (hasNext(x))
{
  ct <- ct + 1
  i <- nextElem(x)
  cat(sprintf("%3d : %s\n", ct, paste0(i, collapse = " ")))
}
```

    ##   1 : 1 1
    ##   2 : 1 2
    ##   3 : 1 3
    ##   4 : 1 4
    ##   5 : 2 1
    ##   6 : 2 2
    ##   7 : 2 3
    ##   8 : 2 4
    ##   9 : 3 1
    ##  10 : 3 2
    ##  11 : 3 3
    ##  12 : 3 4

Iterate through Values (v1.0.2+)
--------------------------------

Each iterator shown above has its `value` counterpart. For example, `ipermv`, the value version of `iperm`, iterates through all permutations of `k` elements from `n` values.

``` r
x <- ipermv(c("A", "G", "C"), 2)
ct <- 0
while (hasNext(x))
{
  ct <- ct + 1
  i <- nextElem(x)
  cat(sprintf("%3d : %s\n", ct, paste0(i, collapse = " ")))
}
```

    ##   1 : A G
    ##   2 : A C
    ##   3 : G A
    ##   4 : G C
    ##   5 : C A
    ##   6 : C G

`icombv`, `isubsetv`, and `icartesv` are also defined analogously.

Use with `foreach` (v1.0.2+)
----------------------------

Since `v1.0.2`, the iterator objects can be used with `foreach` function from [foreach](https://cran.r-project.org/web/packages/foreach/index.html).

``` r
library(foreach)
foreach(i = icomb(3, 2)) %do% sum(i)
```

    ## [[1]]
    ## [1] 3
    ## 
    ## [[2]]
    ## [1] 4
    ## 
    ## [[3]]
    ## [1] 5

Links
-----

-   [combiter (GitHub repository)](https://github.com/kota7/combiter)
