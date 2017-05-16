#' Subset Iterator
#' @description Create an iterator for all subsets of integers 1 through n.
#' @param n positive integer
#' @return iterator object
#' @export
#' @examples
#' x <- isubset(3)
#' ct <- 0
#' while (hasNext(x))
#' {
#'   ct <- ct + 1
#'   i <- nextElem(x)
#'   cat(sprintf("%3d : %s\n", ct, paste0(i, collapse = " ")))
#' }
isubset <- function(n)
{
  stopifnot(length(n) == 1L)
  stopifnot(n > 0L)
  stopifnot((n %% 1) == 0)
  n <- as.integer(n)

  obj <- incrementaliter(nextFunc = function(i, n) NextSubset(i, n),
                         prevFunc = function(i, n) PrevSubset(i, n),
                         firstFunc = function(n) integer(0),
                         lastFunc = function(n) 1:n,
                         n = n)
  class(obj) <- c("isubset", class(obj))
  obj
}


