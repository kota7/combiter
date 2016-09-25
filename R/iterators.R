## constructors of iterator objects


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

  obj <- combinatiter(NextPerm, PrevPerm, 1:n, n:1)
  class(obj) <- c("iperm", class(obj))
  obj
}


#' Combination Iterator
#' @description Create an iterator for all combinations k integers out of 1 through n.
#' @param n positive integer
#' @param k positive integer no greater than n
#' @return iterator object
#' @export
#' @examples
#' x <- icomb(5, 3)
#' ct <- 0
#' while (hasNext(x))
#' {
#'   ct <- ct + 1
#'   i <- nextElem(x)
#'   cat(sprintf("%3d : %s\n", ct, paste0(i, collapse = " ")))
#' }
icomb <- function(n, k)
{
  stopifnot(length(n) == 1L)
  stopifnot(n > 0L)
  stopifnot((n %% 1) == 0)

  stopifnot(length(k) == 1L)
  stopifnot(k > 0L)
  stopifnot((k %% 1) == 0)
  stopifnot(k <= n)


  obj <- combinatiter(nextFunc = NextComb, prevFunc = PrevComb,
                     first = 1:k, last = (n-k+1):n,
                     n = n)
  class(obj) <- c("icomb", class(obj))
  obj
}



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

  obj <- combinatiter(nextFunc = NextSubset, prevFunc = PrevSubset,
                     first = integer(0), last = 1:n,
                     n = n)
  class(obj) <- c("isubset", class(obj))
  obj
}



# Hard coded version
#
# iperm <- function(n)
# {
#   # make sure that n is scalar and positive integer
#   stopifnot(length(n) == 1L)
#   stopifnot(n > 0L)
#   stopifnot((n %% 1) == 0)
#
#   i <- NULL
#
#   hasNext <- function() { is.null(i) || !identical(i, n:1) }
#   hasPrev <- function() { is.null(i) || !identical(i, 1:n) }
#
#   nextElem <- function()
#   {
#     if (is.null(i)) {
#       i <<- 1:n
#     } else if (!hasNext()) {
#       i <<- NULL
#     } else {
#       i <<- NextPerm(i)
#     }
#     return(i)
#   }
#
#   prevElem <- function()
#   {
#     if (is.null(i)) {
#       i <<- n:1
#     } else if (!hasPrev()) {
#       i <<- NULL
#     } else {
#       i <<- PrevPerm(i)
#     }
#     return(i)
#   }
#
#   self <- environment()
#   class(self) <- c("iperm", "combinatiter")
#   return(self)
#}




