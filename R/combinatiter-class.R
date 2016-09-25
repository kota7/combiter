
#' Factory of cobinatrics iterators
#' @param nextFunc,prevFunc Function that takes iterator value
#' (and possibly other arguments) and returns the next or previous value
#' @param first,last  First and last value of the iterator
#' @keywords internal
#' @return \code{combinatiter} object
combinatiter <- function(nextFunc, prevFunc, first, last, ...)
{
  i <- NULL
  args <- list(...)

  hasNext <- function() { is.null(i) || !identical(i, last) }
  hasPrev <- function() { is.null(i) || !identical(i, first) }

  nextElem <- function()
  {
    if (is.null(i)) {
      i <<- first
    } else if (!hasNext()) {
      i <<- NULL
    } else {
      i <<- do.call(nextFunc, c(list(x = i), args))
    }
    return(i)
  }

  prevElem <- function()
  {
    if (is.null(i)) {
      i <<- last
    } else if (!hasPrev()) {
      i <<- NULL
    } else {
      i <<- do.call(prevFunc, c(list(x = i), args))
    }
    return(i)
  }

  self <- environment()
  class(self) <- "combinatiter"
  return(self)
}


## S3 methods

#' @export
nextElem.combinatiter <- function(obj, ...) { obj$nextElem() }

#' @export
prevElem.combinatiter <- function(obj, ...) { obj$prevElem() }

#' @export
hasNext.combinatiter <- function(obj, ...) { obj$hasNext() }

#' @export
hasPrev.combinatiter <- function(obj, ...) { obj$hasPrev() }

