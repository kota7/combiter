#' Permutation Iterator
#' @description Create an iterator for all permutations of integers 1 through n.
#' @param n positive integer
#' @param k positive integer
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
iperm <- function(n, k = n)
{
  stopifnot(length(n) == 1L)
  stopifnot(n > 0L)
  stopifnot((n %% 1) == 0)

  obj <- incrementaliter(nextFunc = function(i, n, k) NextPerm(i, n),
                         prevFunc = function(i, n, k) PrevPerm(i, n),
                         firstFunc = function(n, k) 1:k,
                         lastFunc = function(n, k) n:(n-k+1),
                         n = n, k = k)
  class(obj) <- c("iperm", class(obj))
  obj
}
