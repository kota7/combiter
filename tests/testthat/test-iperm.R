library(testthat)
library(combIter)
library(fastmatch)
context("permutation iterator")

test_that("iperm goes through n! values", {
  for (n in 1:5)
  {
    x <- iperm(n)
    ct <- 0
    while (hasNext(x))
    {
      ct <- ct + 1
      nextElem(x)
    }
    expect_equal(ct, factorial(n))

    # backward
    x <- iperm(n)
    ct <- 0
    while (hasPrev(x))
    {
      ct <- ct + 1
      prevElem(x)
    }
    expect_equal(ct, factorial(n))
  }
})


test_that("iperm covers all permutations", {
  for (n in 1:5)
  {
    x <- iperm(n)
    allPerms <- combinat::permn(n)
    while (hasNext(x))
    {
      i <- nextElem(x)
      expect_false(is.na(fmatch(list(i), allPerms)))
    }

    # do the same for backward
    x <- iperm(n)
    while (hasPrev(x))
    {
      i <- prevElem(x)
      expect_false(is.na(fmatch(list(i), allPerms)))
    }
  }
})


test_that("iperm elements are ordered lexicographically", {
  lexico_smaller <- function(a, b)
  {
    # check if a < b lexicograpically
    # assumes that a and b are vectors of the same length
    index <- c(which(a > b), which(a < b))
    if (length(index) == 0L) return(FALSE) # all elements are equal
    return(a[min(index)] < b[min(index)])
  }

  for (n in 1:5)
  {
    x <- iperm(n)
    i <- NULL
    while (hasNext(x))
    {
      j <- nextElem(x)
      # requires i < j, but check only when i is not NULL
      if (!is.null(i)) {
        expect_true(lexico_smaller(i, j))
      }
      i <- j
    }

    # backward
    x <- iperm(n)
    i <- NULL
    while (hasPrev(x))
    {
      j <- prevElem(x)
      # requires j < i
      if (!is.null(i)) {
        expect_true(lexico_smaller(j, i))
      }
      i <- j
    }
  }
})


test_that("iperm rejects invalid elements", {
  expect_error(iperm(0))
  expect_error(iperm(-3))
  expect_error(iperm(1:2))
  expect_error(iperm(1.5))
  expect_error(iperm(3.0000000001))
})


