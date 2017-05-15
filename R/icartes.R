#' Cartesean Product Iterator
#'
#' @param nvec integer vector of number of items
#' @return iterator object
#' @export
#' @examples
#' x <- icartes(c(3, 2, 4))
#' ct <- 0
#' while (hasNext(x))
#' {
#'   ct <- ct + 1
#'   i <- nextElem(x)
#'   cat(sprintf("%3d : %s\n", ct, paste0(i, collapse = " ")))
#' }
icartes <- function(nvec)
{
  stopifnot(is.numeric(nvec) > 0)
  nvec <- as.integer(nvec)
  stopifnot(length(nvec) > 0)
  stopifnot(all(nvec >= 1))

  obj <- incrementaliter(nextFunc = function(i, nvec) NextCartes(i, nvec),
                         prevFunc = function(i, nvec) PrevCartes(i, nvec),
                         firstFunc = function(nvec) rep(1L, length(nvec)),
                         lastFunc = function(nvec) nvec,
                         nvec = nvec)
  class(obj) <- c("icartes", class(obj))
  obj
}