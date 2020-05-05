#' @export
relev <- function (x) {
  x2 <- field(x, "x")
  miss <- field(x, "miss")

  x2[!is.na(miss)]
}

#' @export
reduce <- function (x, fn, ..., init) {
  x <- relev(x)
  purrr::reduce(x, fn, ..., .init = init)
}
