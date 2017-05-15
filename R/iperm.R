#' Permutation Iterator
#' @description Create an iterator for all permutations of integers 1 through n.
#' @param n positive integer
#' @return iterator object
#' @export
#' @examples
#' x <- iperm(3)
#' ct <- 0
#' while (hasNext(x))
#' {
#'   ct <- ct + 1
#'   i <- nextElem(x)
#'   cat(sprintf("%3d : %s\n", ct, paste0(i, collapse = " ")))
#' }
iperm <- function(n)
{
  stopifnot(length(n) == 1L)
  stopifnot(n > 0L)
  stopifnot((n %% 1) == 0)

  obj <- incrementaliter(nextFunc = function(i, n) NextPerm(i),
                         prevFunc = function(i, n) PrevPerm(i),
                         firstFunc = function(n) 1:n ,
                         lastFunc = function(n) n:1 ,
                         n = n)
  class(obj) <- c("iperm", class(obj))
  obj
}
