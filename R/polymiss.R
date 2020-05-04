#' @import vctrs
new_polymiss <- function(x = double(), miss = integer()) {
  vec_assert(miss, ptype = integer())
  if(!all(miss %in% 1L:3L)) stop("The `miss` field must contain integers between 1 and 3.")

  new_rcrd(list(x = x, miss = miss), class = "vctrs_polymiss")
}

#' @export
polymiss <- function(x = double(), miss = integer()) {
  new_polymiss(x, miss)
}

#' @export
format.vctrs_polymiss <- function(x, ...) {
  x2 <- field(x, "x")
  miss <- field(x, "miss")

  dplyr::case_when(
    miss == 1 ~ as.character(x2),
    miss == 2 ~ "<UNK>",
    miss == 3 ~ "<NONE>"
  )
}

#' @export
vec_ptype2.vctrs_polymiss.vctrs_num_miss <- function(x, y, ...) polymiss()
#' @export
vec_ptype2.vctrs_polymiss.double <- function(x, y, ...) double()
#' @export
vec_ptype2.double.vctrs_polymiss <- function(x, y, ...) double()

#' @export
vec_cast.vctrs_polymiss.vctrs_num_miss <- function(x, to, ...) x
#' @export
vec_cast.vctrs_polymiss.double <- function(x, to, ...) {
  miss <- ifelse(is.na(x), 2L, 1L)
  polymiss(x, miss)
}

#' @export
vec_cast.double.vctrs_polymiss <- function(x, to, ...) {
  x2 <- field(x, "x")
  miss <- field(x, "miss")

  ifelse(miss == 1, x2, NA)
}

#' @export
relev <- function (x) {
  x2 <- field(x, "x")
  miss <- field(x, "miss")

  x[miss != 3]
}

#' @export
vec_math.vctrs_polymiss <- function(fn, x, ...) {
  x2 <- relev(x)
  x3 <- vec_cast(x2, double())

  vec_math_base(fn, x3)
}
