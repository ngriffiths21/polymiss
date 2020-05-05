#' @export
recode.polymiss <- function (.x, ...) {
  miss <- field(.x, "miss")
  x <- field(.x, "x")

  polymiss(dplyr::recode(x, ...), miss = miss)
}
