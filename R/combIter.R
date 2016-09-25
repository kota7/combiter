#' @useDynLib combIter
#' @importFrom Rcpp sourceCpp
NULL


## definition of generic functions
### nextElem ... from iterators
### hasNext  ... from itertools
### prevElem, hasPrev ... defined here

#' @importFrom iterators nextElem
#' @export
iterators::nextElem

#' @importFrom itertools hasNext
#' @export
itertools::hasNext

#' Get Previous Element of Iterator
#' @description \code{prevElem} is a generic funcion to move an
#' iterator object one step backward.
#' @param obj an iterator object
#' @param ... additional arguments
#' @return iterator value
#' @export
prevElem <- function(obj, ...)
{
  UseMethod("prevElem")
}

#' Does This Iterator Have A Previous Element
#' @description \code{hasPrev} is a generic function that indicates if the
#' iterator has another element backward.
#' @param obj an iterator object
#' @param ... additional arguments
#' @return Logical value indicating whether the iterator has a previous element.
#' @export
hasPrev <- function(obj, ...)
{
  UseMethod("hasPrev")
}
