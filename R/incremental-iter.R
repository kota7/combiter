
#' Factory of Iterators with Incremental Operations
#'
#' @param nextFunc,prevFunc Functions that take iterator value
#' (and possibly other arguments) and returns the next or previous value
#' @param firstFunc,lastFunc  Functions that take parameters given by `...`
#' and returns the first or last values of the iteration
#' @param ... parameters that characterize the iterator
#' @export
#' @return \code{combinatiter} object
incrementaliter <- function(nextFunc, prevFunc, firstFunc, lastFunc, ...)
{
  i <- NULL

  hasNext <- function() { is.null(i) || !identical(i, lastFunc(...)) }
  hasPrev <- function() { is.null(i) || !identical(i, firstFunc(...)) }

  nextElem <- function()
  {
    if (is.null(i)) {
      i <<- firstFunc(...)
    } else if (!hasNext()) {
      stop("StopIteration")
    } else {
      i <<- nextFunc(i, ...)
    }
    return(i)
  }

  prevElem <- function()
  {
    if (is.null(i)) {
      i <<- lastFunc(...)
    } else if (!hasPrev()) {
      stop("StopIteration")
    } else {
      i <<- prevFunc(i, ...)
    }
    return(i)
  }

  getFirst <- function() firstFunc(...)
  getLast  <- function() lastFunc(...)

  #self <- environment()
  #class(self) <- "combinatiter"
  #return(self)
  out <- list(nextElem=nextElem, prevElem=prevElem,
              hasNext=hasNext, hasPrev=hasPrev,
              getFirst=getFirst, getLast=getLast)
  class(out) <- c("incrementaliter", "abstractiter", "iter")
  out
}


## S3 methods

#' @export
nextElem.incrementaliter <- function(obj, ...) { obj$nextElem() }

#' @export
prevElem.incrementaliter <- function(obj, ...) { obj$prevElem() }

#' @export
hasNext.incrementaliter <- function(obj, ...) { obj$hasNext() }

#' @export
hasPrev.incrementaliter <- function(obj, ...) { obj$hasPrev() }

#' @export
getFirst.incrementaliter <- function(obj, ...) { obj$getFirst() }

#' @export
getLast.incrementaliter <- function(obj, ...) { obj$getLast() }
